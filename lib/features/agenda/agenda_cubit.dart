import 'dart:async';

import 'package:bloc_dispose_scope/bloc_dispose_scope.dart';
import 'package:fts/data/contracts/contracts.dart';
import 'package:fts/features/agenda/models/session.dart';
import 'package:fts/features/agenda/models/speaker.dart';
import 'package:fts/features/agenda/models/track.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/features/rating/rate_cubit.dart';
import 'package:leancode_contracts/leancode_contracts.dart';
import 'package:leancode_cubit_utils_cqrs/leancode_cubit_utils_cqrs.dart';

class AgendaCubit extends QueryCubit<AgendaDtos, AgendaState>
    with BlocBaseDisposeScopeMixin {
  AgendaCubit({
    required this.cqrs,
    required this.rateEventStream,
    required this.authEventStream,
  }) : super('SpeakersCubit') {
    rateEventStream
        .listen((event) {
          if (event == RateEvent.success) {
            refresh();
          }
        })
        .disposedBy(scope);

    authEventStream
        .listen((event) {
          refresh();
        })
        .disposedBy(scope);

    Timer.periodic(_refreshInterval, (_) => refresh()).disposedBy(scope);
  }

  final Cqrs cqrs;
  final Stream<RateEvent> rateEventStream;
  final Stream<AuthState> authEventStream;

  static const _refreshInterval = Duration(minutes: 1);

  @override
  Future<QueryResult<AgendaDtos>> request() async {
    final (agenda, speakers, moderators) = await (
      cqrs.get(Agenda()),
      cqrs.get(AllSpeakers()),
      cqrs.get(AllModerators()),
    ).wait;

    return switch ((agenda, speakers, moderators)) {
      (
        QuerySuccess(data: final agendaData),
        QuerySuccess(data: final speakersData),
        QuerySuccess(data: final moderatorsData),
      ) =>
        QuerySuccess(
          AgendaDtos(
            sessions: agendaData,
            speakers: speakersData,
            moderators: moderatorsData,
          ),
        ),
      (QueryFailure(:final error), _, _) => QueryFailure(error),
      (_, QueryFailure(:final error), _) => QueryFailure(error),
      (_, _, QueryFailure(:final error)) => QueryFailure(error),
    };
  }

  @override
  AgendaState map(AgendaDtos data) {
    final speakers = data.speakers;
    final moderators = data.moderators;

    final intersection = speakers
        .toSet()
        .intersection(moderators.toSet())
        .map(
          (speaker) => Speaker.fromDto(
            speaker,
            flags: {SpeakerFlag.moderator, SpeakerFlag.speaker},
          ),
        );
    final speakersOnly = speakers
        .map(
          (speaker) => Speaker.fromDto(speaker, flags: {SpeakerFlag.speaker}),
        )
        .where((speaker) => !intersection.contains(speaker));
    final moderatorsOnly = moderators
        .map(
          (speaker) => Speaker.fromDto(speaker, flags: {SpeakerFlag.moderator}),
        )
        .where((speaker) => !intersection.contains(speaker));
    final all = [...intersection, ...speakersOnly, ...moderatorsOnly];

    final sessions = data.sessions
        .map((dto) => Session.fromDto(dto: dto, allSpeakers: all))
        .toList();

    // Determine selected day - earliest day in sessions, or current date if no sessions
    final selectedDay = _getSelectedDay(sessions);

    // Filter sessions by selected day and track (if any)
    final filteredSessions = _filterSessions(sessions, selectedDay, null);

    return AgendaState(
      sessions: sessions,
      speakers: speakers
          .map((dto) => all.firstWhere((speaker) => speaker.id == dto.id))
          .toList(),
      moderators: moderators
          .map((dto) => all.firstWhere((speaker) => speaker.id == dto.id))
          .toList(),
      selectedDay: selectedDay,
      filteredSessions: filteredSessions,
    );
  }

  DateOnly _getSelectedDay(List<Session> sessions) {
    if (sessions.isEmpty) {
      return DateOnly.fromDateTime(DateTime.now());
    }

    // Find the earliest day using compareTo
    return sessions
        .map((session) => session.day)
        .reduce(
          (earliest, current) =>
              current.compareTo(earliest) < 0 ? current : earliest,
        );
  }

  /// Filter sessions by day and optionally by track
  List<Session> _filterSessions(
    List<Session> sessions,
    DateOnly selectedDay,
    Track? selectedTrack,
  ) {
    return sessions.where((session) {
      // Filter by day
      if (session.day != selectedDay) {
        return false;
      }

      // Filter by track if selected
      if (selectedTrack != null && session.track?.id != selectedTrack.id) {
        return false;
      }

      return true;
    }).toList();
  }

  /// Changes the selected day and updates filtered sessions
  void changeSelectedDay(DateOnly newDay) {
    final currentState = state;
    if (currentState is! RequestSuccessState<AgendaState, QueryError>) {
      return;
    }

    final agendaState = currentState.data;
    final filteredSessions = _filterSessions(
      agendaState.sessions,
      newDay,
      agendaState.selectedTrack,
    );

    final newAgendaState = AgendaState(
      sessions: agendaState.sessions,
      speakers: agendaState.speakers,
      moderators: agendaState.moderators,
      selectedDay: newDay,
      filteredSessions: filteredSessions,
      selectedTrack: agendaState.selectedTrack,
    );

    emit(RequestSuccessState(newAgendaState));
  }

  /// Changes the selected track and updates filtered sessions
  void changeSelectedTrack(Track? newTrack) {
    final currentState = state;
    if (currentState is! RequestSuccessState<AgendaState, QueryError>) {
      return;
    }

    final agendaState = currentState.data;
    final filteredSessions = _filterSessions(
      agendaState.sessions,
      agendaState.selectedDay,
      newTrack,
    );

    final newAgendaState = AgendaState(
      sessions: agendaState.sessions,
      speakers: agendaState.speakers,
      moderators: agendaState.moderators,
      selectedDay: agendaState.selectedDay,
      filteredSessions: filteredSessions,
      selectedTrack: newTrack,
    );

    emit(RequestSuccessState(newAgendaState));
  }
}

class AgendaDtos {
  const AgendaDtos({
    required this.sessions,
    required this.speakers,
    required this.moderators,
  });

  final List<SessionDTO> sessions;
  final List<SpeakerDTO> speakers;
  final List<SpeakerDTO> moderators;
}

class AgendaState with EquatableMixin {
  const AgendaState({
    required this.sessions,
    required this.speakers,
    required this.moderators,
    required this.selectedDay,
    required this.filteredSessions,
    this.selectedTrack,
  });

  final List<Session> sessions;
  final List<Speaker> speakers;
  final List<Speaker> moderators;
  final DateOnly selectedDay;
  final List<Session> filteredSessions;
  final Track? selectedTrack;

  @override
  List<Object?> get props => [
    sessions,
    speakers,
    moderators,
    selectedDay,
    filteredSessions,
    selectedTrack,
  ];
}
