import 'package:app_design_system/app_design_system.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/util/spaced.dart';
import 'package:fts/features/agenda/agenda_cubit.dart';
import 'package:fts/features/agenda/models/round_table.dart';
import 'package:fts/features/agenda/models/session.dart';
import 'package:fts/features/agenda/models/speaker.dart';
import 'package:fts/features/agenda/session_tile.dart';
import 'package:fts/features/error_page/error_page.dart';
import 'package:fts/features/loading_page/loading_page.dart';
import 'package:fts/keys.dart';
import 'package:fts/resources/assets.gen.dart';
import 'package:fts/resources/strings.dart';
import 'package:leancode_cubit_utils_cqrs/leancode_cubit_utils_cqrs.dart';
import 'package:url_launcher/url_launcher.dart';

class SpeakerDetailsPage extends StatelessWidget {
  const SpeakerDetailsPage({
    super.key,
    required this.id,
    required this.onSessionTap,
  });

  final String id;
  final ValueChanged<Session> onSessionTap;

  @override
  Widget build(BuildContext context) {
    return RequestCubitBuilder(
      cubit: context.read<AgendaCubit>(),
      onLoading: (context) => const LoadingPage(),
      onError: (context, error, retry) => ErrorPage(onTryAgain: retry),
      onSuccess: (context, data) {
        final agenda = data.sessions;
        final speakers = data.speakers;
        final moderators = data.moderators;

        final speaker = speakers
            .followedBy(moderators)
            .firstWhereOrNull((speaker) => speaker.id == id);
        final talks = agenda.whereType<TalkSession>().where(
          (talk) => talk.speakers.contains(speaker),
        );
        final roundTables = agenda
            .whereType<RoundTablesSession>()
            .expand(
              (session) => session.roundTables.map(
                (roundTable) => (session: session, table: roundTable),
              ),
            )
            .where(
              (roundTableData) => roundTableData.table.moderator == speaker,
            );

        return switch (speaker) {
          final speaker? => _SpeakerDetails(
            speaker: speaker,
            talks: talks,
            roundTables: roundTables,
            onSessionTap: onSessionTap,
          ),
          null => ErrorPage(onTryAgain: context.read<AgendaCubit>().run),
        };
      },
    );
  }
}

typedef _RoundTableData = ({RoundTablesSession session, RoundTable table});

class _SpeakerDetails extends StatelessWidget {
  const _SpeakerDetails({
    required this.speaker,
    required this.talks,
    required this.roundTables,
    required this.onSessionTap,
  });

  final Speaker speaker;
  final Iterable<TalkSession> talks;
  final Iterable<_RoundTableData> roundTables;
  final ValueChanged<Session> onSessionTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = l10n(context);

    final Speaker(:jobTitle, :companyName, :linkedInUrl, :bio, :photoUrl) =
        speaker;

    return AppScaffold.widgets(
      topBar: const AppTopBar(divider: false),
      footerBehavior: AppScaffoldFooterBehavior.bottomPushed,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: AppSpacings.s8.bottom,
              child: Container(
                width: 152,
                height: 152,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: context.colors.foregroundDefaultQuaternary,
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImage(
                  imageUrl: photoUrl.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Row(
                children: [
                  for (final flag in speaker.flags)
                    AppBadge(
                      caption: flag.getLabel(context),
                      type: AppBadgeType.info,
                    ),
                ],
              ),
            ),
          ],
        ),
        AppSpacings.s12.verticalSpace,
        AppText(
          key: keys.speakerDetails.speakerName,
          speaker.fullName,
          style: AppTextStyles.headlineMedium,
          color: colors.foregroundDefaultPrimary,
          textAlign: TextAlign.center,
        ),
        if (jobTitle != null) ...[
          AppSpacings.s4.verticalSpace,
          AppText(
            jobTitle,
            style: AppTextStyles.bodyDefault,
            textAlign: TextAlign.center,
          ),
        ],
        if (companyName != null) ...[
          AppSpacings.s4.verticalSpace,
          AppText(
            companyName,
            style: AppTextStyles.bodyDefault,
            textAlign: TextAlign.center,
          ),
        ],
        if (linkedInUrl != null) ...[
          AppSpacings.s16.verticalSpace,
          _LinkedInButton(url: linkedInUrl),
        ],
        if (bio != null) ...[
          AppSpacings.s24.verticalSpace,
          AppText(
            s.speakerDetails_aboutMe,
            style: AppTextStyles.bodyStrong,
            color: colors.foregroundDefaultPrimary,
          ),
          AppSpacings.s12.verticalSpace,
          AppText(bio, style: AppTextStyles.bodyDefault),
        ],
        if (speaker.isSpeaker) ...[
          AppSpacings.s24.verticalSpace,
          AppText(
            s.speakerDetails_myTalks,
            style: AppTextStyles.bodyStrong,
            color: colors.foregroundDefaultPrimary,
          ),
          AppSpacings.s12.verticalSpace,
          ...[
            for (final talk in talks)
              SessionTile(session: talk, onTap: () => onSessionTap(talk)),
          ].spaced(AppSpacings.s8),
        ],
        if (speaker.isModerator) ...[
          AppSpacings.s24.verticalSpace,
          AppText(
            s.speakerDetails_myTables,
            style: AppTextStyles.bodyStrong,
            color: colors.foregroundDefaultPrimary,
          ),
          AppSpacings.s12.verticalSpace,
          ...[
            for (final roundTable in roundTables)
              SessionTile(
                session: RoundTableSlotSession(
                  id: roundTable.session.id,
                  tableIndex: roundTable.table.index,
                  title: roundTable.table.title,
                  description: roundTable.session.description,
                  startTime: roundTable.session.startTime,
                  endTime: roundTable.session.endTime,
                  moderator: roundTable.table.moderator,
                  day: roundTable.session.day,
                ),
                onTap: () => onSessionTap(roundTable.session),
              ),
          ].spaced(AppSpacings.s8),
        ],
      ],
    );
  }
}

class _LinkedInButton extends StatelessWidget {
  const _LinkedInButton({required this.url});

  final Uri url;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = l10n(context);

    return GestureDetector(
      onTap: () => launchUrl(url),
      child: Semantics(
        button: true,
        label: s.speakerDetails_linkedInButtonSemantics,
        child: Container(
          width: double.infinity,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: colors.linkedInButtonColor,
          ),
          child: Assets.social.linkedin.svg(width: 28, height: 28),
        ),
      ),
    );
  }
}
