import 'package:duration/duration.dart';
import 'package:flutter/material.dart' show CircleAvatar;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fts/common/hooks/use_minute_timer.dart';
import 'package:fts/features/agenda/models/session.dart';
import 'package:fts/features/widgets/live_badge.dart';
import 'package:fts/keys.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';

class SessionDetailsHeader extends HookWidget {
  const SessionDetailsHeader({super.key, required this.session});

  final Session session;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = l10n(context);

    final now = useMinuteTimer();

    return Column(
      key: keys.sessionDetails.header,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: AppSpacings.s8.value,
          spacing: AppSpacings.s12.value,
          children: [
            AppText(
              session.title,
              style: AppTextStyles.headlineMedium,
              color: colors.foregroundDefaultPrimary,
            ),
            if (session.isLive(now)) const LiveBadge(),
          ],
        ),
        AppSpacings.s16.verticalSpace,
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: AppSpacings.s8.value,
          children: [
            AppIcon(
              AppStandardIcons.clock,
              size: AppStandardIconSize.s24,
              color: colors.foregroundDefaultSecondary,
              semanticsLabel: s.sessionDetails_clockSemanticsLabel,
            ),
            AppSpacings.s8.horizontalSpace,
            AppText(
              s.sessionDetails_timeSpan(
                startDate: session.startTime,
                startHour: session.startTime,
                endHour: session.endTime,
              ),
              style: AppTextStyles.bodyDefault,
              color: colors.foregroundDefaultSecondary,
            ),
            AppSpacings.s12.horizontalSpace,
            CircleAvatar(
              radius: 2,
              backgroundColor: colors.foregroundDefaultSecondary,
            ),
            AppSpacings.s12.horizontalSpace,
            AppText(
              session.endTime
                  .difference(session.startTime)
                  .pretty(abbreviated: true, delimiter: ' '),
              style: AppTextStyles.bodyDefault,
              color: colors.foregroundDefaultSecondary,
            ),
          ],
        ),
        if (session.description case final description?
            when description.isNotEmpty) ...[
          AppSpacings.s24.verticalSpace,
          AppText(
            description,
            style: AppTextStyles.bodyDefault,
            color: context.colors.foregroundDefaultSecondary,
          ),
        ],
      ],
    );
  }
}
