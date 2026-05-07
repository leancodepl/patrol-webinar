import 'package:collection/collection.dart';
import 'package:fts/data/contracts/contracts.dart';
import 'package:fts/features/agenda/models/round_table.dart';
import 'package:fts/features/agenda/models/speaker.dart';
import 'package:fts/features/agenda/models/track.dart';
import 'package:leancode_contracts/leancode_contracts.dart';

sealed class Session with EquatableMixin {
  const Session({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.day,
    this.track,
  });

  factory Session.fromDto({
    required SessionDTO dto,
    required Iterable<Speaker> allSpeakers,
  }) => switch (dto.type) {
    SessionTypeDTO.talk => TalkSession.fromDto(
      dto: dto,
      allSpeakers: allSpeakers,
    ),
    SessionTypeDTO.roundtable => RoundTablesSession.fromDto(
      dto: dto,
      allSpeakers: allSpeakers,
    ),
    SessionTypeDTO.other => EventSession.fromDto(dto),
  };

  final String id;
  final String title;
  final String? description;
  final DateTime startTime;
  final DateTime endTime;
  final DateOnly day;
  final Track? track;

  bool isLive(DateTime now) => startTime.isBefore(now) && endTime.isAfter(now);
  bool hasEnded(DateTime now) => now.isAfter(endTime);

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    startTime,
    endTime,
    day,
    track,
  ];

  static Track? _getFirstTrack(List<SessionTrackDTO> tracks) {
    return tracks.isNotEmpty ? Track.fromDto(tracks.first) : null;
  }
}

class EventSession extends Session {
  const EventSession({
    required super.id,
    required super.title,
    required super.description,
    required super.startTime,
    required super.endTime,
    required super.day,
    super.track,
    this.site,
  });

  factory EventSession.fromDto(SessionDTO dto) => EventSession(
    id: dto.id,
    title: dto.title,
    description: dto.description,
    startTime: dto.startDate.localDateTime,
    endTime: dto.endDate.localDateTime,
    day: dto.day,
    track: Session._getFirstTrack(dto.tracks),
    site: dto.site,
  );

  final SiteDTO? site;

  @override
  List<Object?> get props => [...super.props, site];
}

class TalkSession extends Session {
  const TalkSession({
    required super.id,
    required super.title,
    required super.description,
    required super.startTime,
    required super.endTime,
    required super.day,
    super.track,
    required this.speakers,
    this.userRating,
  });

  factory TalkSession.fromDto({
    required SessionDTO dto,
    required Iterable<Speaker> allSpeakers,
  }) => TalkSession(
    id: dto.id,
    title: dto.title,
    description: dto.description,
    startTime: dto.startDate.localDateTime,
    endTime: dto.endDate.localDateTime,
    day: dto.day,
    track: Session._getFirstTrack(dto.tracks),
    speakers: dto.speakers
        .map(
          (speakerDto) =>
              allSpeakers.firstWhere((speaker) => speaker.id == speakerDto.id),
        )
        .toList(),
    userRating: dto.userRating?.rating,
  );

  final List<Speaker> speakers;
  final int? userRating;

  @override
  List<Object?> get props => [...super.props, speakers, userRating];
}

class RoundTablesSession extends Session {
  const RoundTablesSession({
    required super.id,
    required super.title,
    required super.description,
    required super.startTime,
    required super.endTime,
    required super.day,
    super.track,
    required this.roundTables,
  });

  factory RoundTablesSession.fromDto({
    required SessionDTO dto,
    required Iterable<Speaker> allSpeakers,
  }) => RoundTablesSession(
    id: dto.id,
    title: dto.title,
    description: dto.description,
    startTime: dto.startDate.localDateTime,
    endTime: dto.endDate.localDateTime,
    day: dto.day,
    track: Session._getFirstTrack(dto.tracks),
    roundTables: (dto.roundtableSlots ?? [])
        .mapIndexed(
          (index, slot) => RoundTable(
            index: index + 1,
            title: slot.topic,
            description: slot.description,
            moderator: allSpeakers.firstWhere(
              (speaker) => speaker.id == slot.moderator.id,
            ),
          ),
        )
        .toList(),
  );

  final List<RoundTable> roundTables;

  @override
  List<Object?> get props => [...super.props, roundTables];
}

class RoundTableSlotSession extends Session {
  const RoundTableSlotSession({
    required super.id,
    required super.title,
    required super.description,
    required super.startTime,
    required super.endTime,
    required super.day,
    super.track,
    required this.tableIndex,
    required this.moderator,
  });

  final int tableIndex;
  final Speaker moderator;

  @override
  List<Object?> get props => [...super.props, tableIndex, moderator];
}

extension SessionIterableExtension on Iterable<Session> {
  Map<DateOnly, List<Session>> get groupedByDate =>
      groupListsBy((session) => DateOnly.fromDateTime(session.startTime));
}
