import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/util/spaced.dart';
import 'package:fts/features/agenda/agenda_cubit.dart';
import 'package:fts/features/agenda/models/session.dart';
import 'package:fts/features/agenda/session_tile.dart';
import 'package:fts/features/agenda/widgets/day_tab_selector.dart';
import 'package:fts/features/error_page/error_page.dart';
import 'package:fts/features/loading_page/loading_page.dart';
import 'package:fts/features/widgets/date_separator.dart';
import 'package:fts/features/widgets/shell_top_bar.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';
import 'package:leancode_cubit_utils_cqrs/leancode_cubit_utils_cqrs.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    return RequestCubitBuilder(
      cubit: context.read<AgendaCubit>(),
      onInitial: (context) => const LoadingPage(),
      onLoading: (context) => const LoadingPage(),
      onError: (context, error, retry) => ErrorPage(
        topBar: ShellTopBar(title: s.agenda_title),
        onTryAgain: retry,
      ),
      onSuccess: (context, data) => _Content(agendaState: data),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.agendaState});

  final AgendaState agendaState;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    // Get all unique days from sessions
    final availableDays =
        agendaState.sessions.map((session) => session.day).toSet().toList()
          ..sort();

    return AppScaffold.widgets(
      onRefresh: context.read<AgendaCubit>().refresh,
      topBar: ShellTopBar(title: s.agenda_title),
      children: [
        // Day tab selector
        DayTabSelector(
          availableDays: availableDays,
          selectedDay: agendaState.selectedDay,
          onDaySelected: context.read<AgendaCubit>().changeSelectedDay,
        ),
        AppSpacings.s16.verticalSpace,
        // Sessions for selected day and track
        ...agendaState.filteredSessions
            .map(
              (session) => SessionTile(
                session: session,
                onTap: () => AgendaBranchSessionRoute(session.id).go(context),
              ),
            )
            .toList()
            .spaced(AppSpacings.s8),
      ],
    );
  }
}

class AgendaDay extends StatelessWidget {
  const AgendaDay({
    super.key,
    required this.sessions,
    required this.onSessionTap,
  });

  final List<Session> sessions;
  final ValueChanged<Session> onSessionTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateSeparator(date: sessions.first.startTime),
        AppSpacings.s12.verticalSpace,
        ...[
          for (final session in sessions)
            SessionTile(session: session, onTap: () => onSessionTap(session)),
        ].spaced(AppSpacings.s8),
      ],
    );
  }
}
