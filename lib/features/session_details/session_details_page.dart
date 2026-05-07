import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/features/agenda/agenda_cubit.dart';
import 'package:fts/features/agenda/models/session.dart';
import 'package:fts/features/agenda/models/speaker.dart';
import 'package:fts/features/error_page/error_page.dart';
import 'package:fts/features/loading_page/loading_page.dart';
import 'package:fts/features/session_details/event_details.dart';
import 'package:fts/features/session_details/round_table_details.dart';
import 'package:fts/features/session_details/talk_details.dart';
import 'package:leancode_cubit_utils/leancode_cubit_utils.dart';
import 'package:provider/provider.dart';

class SessionDetailsPage extends StatelessWidget {
  const SessionDetailsPage({
    super.key,
    required this.id,
    required this.onSpeakerTap,
  });

  final String id;
  final ValueChanged<Speaker> onSpeakerTap;

  @override
  Widget build(BuildContext context) {
    return RequestCubitBuilder(
      cubit: context.read<AgendaCubit>(),
      onInitial: (context) => const LoadingPage(),
      onLoading: (context) => const LoadingPage(),
      onError: (context, error, retry) => ErrorPage(onTryAgain: retry),
      onSuccess: (context, data) {
        final session = data.sessions.firstWhereOrNull(
          (session) => session.id == id,
        );

        return switch (session) {
          final TalkSession talk => TalkDetails(
            talk: talk,
            onSpeakerTap: onSpeakerTap,
          ),
          final RoundTablesSession roundTables => RoundTableDetails(
            session: roundTables,
            onSpeakerTap: onSpeakerTap,
          ),
          final EventSession event => EventDetails(session: event),
          RoundTableSlotSession() => throw ArgumentError.value(
            session,
            'session',
            'Invalid session type',
          ),
          null => ErrorPage(onTryAgain: context.read<AgendaCubit>().run),
        };
      },
    );
  }
}
