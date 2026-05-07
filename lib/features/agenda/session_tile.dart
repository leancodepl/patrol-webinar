import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/material.dart' show CircleAvatar;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fts/common/hooks/use_minute_timer.dart';
import 'package:fts/features/agenda/models/session.dart';
import 'package:fts/features/agenda/speakers_section.dart';
import 'package:fts/features/widgets/live_badge.dart';
import 'package:fts/features/widgets/rate_talk_button.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';

class SessionTile extends HookWidget {
  const SessionTile({super.key, required this.session, required this.onTap});

  final Session session;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = l10n(context);

    final Session(:title, :startTime, :endTime) = session;
    final now = useMinuteTimer();
    final ended = session.hasEnded(now);

    final speakers = switch (session) {
      TalkSession(:final speakers) => speakers,
      RoundTableSlotSession(:final moderator) => [moderator],
      _ => null,
    };

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppSpacings.s16.all,
        decoration: BoxDecoration(
          color: switch (ended) {
            false => colors.backgroundDefaultPrimary,
            true => colors.backgroundActiveTertiary,
          },
          border: Border.all(color: context.colors.foregroundDefaultQuaternary),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (session.isLive(now)) const LiveBadge(),
            if (session case RoundTableSlotSession(:final tableIndex)) ...[
              AppSpacings.s4.verticalSpace,
              AppBadge(
                caption: s.roundTableDetails_badge(tableNumber: tableIndex),
                type: AppBadgeType.info,
              ),
            ],
            if (session.track != null) ...[
              AppSpacings.s4.verticalSpace,
              Row(
                children: [
                  AppBadge(
                    caption: session.track!.name,
                    type: AppBadgeType.success,
                  ),
                  const Spacer(),
                ],
              ),
            ],
            AppSpacings.s4.verticalSpace,
            AppText(
              title,
              style: AppTextStyles.bodyStrong,
              color: switch (ended) {
                true => colors.foregroundDefaultSecondary,
                false => colors.foregroundDefaultPrimary,
              },
            ),
            AppSpacings.s8.verticalSpace,
            Row(
              children: [
                AppIcon(
                  AppStandardIcons.clock,
                  color: context.colors.foregroundDefaultSecondary,
                  size: AppStandardIconSize.s24,
                  semanticsLabel: s.sessionTile_duration,
                ),
                AppSpacings.s12.horizontalSpace,
                Flexible(
                  child: AppText(
                    s.sessionTile_durationSpan(start: startTime, end: endTime),
                    style: AppTextStyles.captionDefault,
                    color: colors.foregroundDefaultSecondary,
                  ),
                ),
                AppSpacings.s12.horizontalSpace,
                CircleAvatar(
                  radius: 2,
                  backgroundColor: colors.foregroundDefaultSecondary,
                ),
                AppSpacings.s12.horizontalSpace,
                Flexible(
                  child: AppText(
                    endTime
                        .difference(startTime)
                        .pretty(
                          abbreviated: true,
                          delimiter: ' ',
                          locale:
                              DurationLocale.fromLanguageCode(s.localeName) ??
                              const EnglishDurationLocale(),
                        ),
                    style: AppTextStyles.captionDefault,
                    color: colors.foregroundDefaultSecondary,
                  ),
                ),
                AppSpacings.s12.verticalSpace,
              ],
            ),
            if (speakers != null) ...[
              AppSpacings.s12.verticalSpace,
              SpeakersSection(
                speakers: speakers,
                ended: ended,
                avatarDimension: 40,
                titleTextStyle: AppTextStyles.captionStrong,
                extendedSubtitle: false,
              ),
            ],
            if (session case final TalkSession talk when ended) ...[
              AppSpacings.s12.verticalSpace,
              RateTalkButton(talk: talk),
            ],
          ],
        ),
      ),
    );
  }
}
