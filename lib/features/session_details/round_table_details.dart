import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/common/util/spaced.dart';
import 'package:fts/features/agenda/models/round_table.dart';
import 'package:fts/features/agenda/models/session.dart';
import 'package:fts/features/agenda/models/speaker.dart';
import 'package:fts/features/agenda/speakers_section.dart';
import 'package:fts/features/session_details/session_details_header.dart';
import 'package:fts/resources/strings.dart';

class RoundTableDetails extends StatelessWidget {
  const RoundTableDetails({
    super.key,
    required this.session,
    required this.onSpeakerTap,
  });

  final RoundTablesSession session;
  final ValueChanged<Speaker> onSpeakerTap;

  @override
  Widget build(BuildContext context) {
    return AppScaffold.widgets(
      topBar: const AppTopBar(divider: false),
      children: [
        SessionDetailsHeader(session: session),
        AppSpacings.s24.verticalSpace,
        ...[
          for (final roundTable in session.roundTables)
            _RoundTableSection(
              roundTable: roundTable,
              onSpeakerTap: onSpeakerTap,
            ),
        ].spacedWith(
          Padding(
            padding: AppSpacings.s24.vertical,
            child: const AppDivider.horizontal(),
          ),
        ),
      ],
    );
  }
}

class _RoundTableSection extends StatelessWidget {
  const _RoundTableSection({
    required this.roundTable,
    required this.onSpeakerTap,
  });

  final RoundTable roundTable;
  final ValueChanged<Speaker> onSpeakerTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = l10n(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBadge(
          caption: s.roundTableDetails_badge(tableNumber: roundTable.index),
          type: AppBadgeType.info,
        ),
        AppText(
          roundTable.title,
          style: AppTextStyles.bodyStrong,
          color: colors.foregroundDefaultPrimary,
        ),
        if (roundTable.description case final description?)
          AppText(description, style: AppTextStyles.bodyDefault),
        AppText(
          s.roundTableDetails_moderator,
          style: AppTextStyles.bodyStrong,
          color: colors.foregroundDefaultPrimary,
        ),
        SpeakersSection(
          speakers: [roundTable.moderator],
          avatarDimension: 56,
          titleTextStyle: AppTextStyles.bodyStrong,
          extendedSubtitle: true,
          onSpeakerTap: onSpeakerTap,
        ),
      ].spaced(AppSpacings.s8),
    );
  }
}
