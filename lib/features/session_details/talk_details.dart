import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fts/common/hooks/use_minute_timer.dart';
import 'package:fts/features/agenda/models/session.dart';
import 'package:fts/features/agenda/models/speaker.dart';
import 'package:fts/features/agenda/speakers_section.dart';
import 'package:fts/features/session_details/session_details_header.dart';
import 'package:fts/features/widgets/rate_talk_button.dart';
import 'package:fts/resources/strings.dart';

class TalkDetails extends HookWidget {
  const TalkDetails({
    super.key,
    required this.talk,
    required this.onSpeakerTap,
  });

  final TalkSession talk;
  final ValueChanged<Speaker> onSpeakerTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = l10n(context);

    final now = useMinuteTimer();
    final ended = talk.hasEnded(now);

    return AppScaffold.widgets(
      topBar: const AppTopBar(divider: false),
      footerBehavior: AppScaffoldFooterBehavior.bottomPushed,
      footerBuilder: switch (ended) {
        false => null,
        true => (context, _, padding) => Padding(
          padding: padding,
          child: Padding(
            padding: AppSpacings.s16.horizontal + AppSpacings.s24.bottom,
            child: RateTalkButton(talk: talk),
          ),
        ),
      },
      children: [
        SessionDetailsHeader(session: talk),
        AppSpacings.s24.verticalSpace,
        AppText(
          s.talkDetails_speaker(count: talk.speakers.length),
          style: AppTextStyles.bodyStrong,
          color: colors.foregroundDefaultPrimary,
        ),
        AppSpacings.s12.verticalSpace,
        SpeakersSection(
          speakers: talk.speakers,
          avatarDimension: 56,
          titleTextStyle: AppTextStyles.bodyStrong,
          extendedSubtitle: true,
          axis: Axis.vertical,
          onSpeakerTap: onSpeakerTap,
        ),
      ],
    );
  }
}
