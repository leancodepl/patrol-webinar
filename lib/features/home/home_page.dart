import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fts/common/hooks/use_minute_timer.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/common/util/spaced.dart';
import 'package:fts/features/agenda/agenda_cubit.dart';
import 'package:fts/features/agenda/agenda_page.dart';
import 'package:fts/features/agenda/models/session.dart';
import 'package:fts/features/agenda/models/speaker.dart';
import 'package:fts/features/connectivity/connectivity_banner.dart';
import 'package:fts/features/error_page/error_page.dart';
import 'package:fts/features/home/branding_tile.dart';
import 'package:fts/features/home/circle_speaker_avatar.dart';
import 'package:fts/features/loading_page/loading_page.dart';
import 'package:fts/features/push_notifications/push_notifications_dispatcher.dart';
import 'package:fts/features/widgets/shell_top_bar.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/button/app_text_button.dart';
import 'package:leancode_cubit_utils/leancode_cubit_utils.dart';
import 'package:provider/provider.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    useEffect(() {
      context.read<PushNotificationsDispatcher>().init();

      return null;
    }, const []);

    return RequestCubitBuilder(
      cubit: context.read<AgendaCubit>(),
      onLoading: (context) => const LoadingPage(),
      onSuccess: (context, data) => _Content(
        agenda: data.sessions,
        speakers: data.speakers,
        moderators: data.moderators,
      ),
      onError: (context, error, retry) => ErrorPage(
        topBar: ShellTopBar(title: s.home_title),
        onTryAgain: retry,
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.agenda,
    required this.speakers,
    required this.moderators,
  });

  final List<Session> agenda;
  final List<Speaker> speakers;
  final List<Speaker> moderators;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = l10n(context);

    const padding = AppSpacings.s16;

    return AppScaffold.widgets(
      topBar: ShellTopBar(title: s.home_title),
      useBodyPadding: false,
      onRefresh: context.read<AgendaCubit>().refresh,
      children: [
        const ConnectivityBanner(),
        Padding(padding: padding.horizontal, child: const BrandingTile()),
        AppSpacings.s24.verticalSpace,
        Padding(
          padding: padding.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                s.home_whatsNext,
                style: AppTextStyles.subtitle,
                color: colors.foregroundDefaultPrimary,
              ),
              AppTextButton(
                caption: s.home_fullAgenda,
                type: AppTextButtonType.base,
                trailingIcon: AppStandardIcons.arrowNarrowRight,
                onTap: () => const AgendaRoute().go(context),
                analyticsId: AnalyticsIds.homePageViewAllButton,
              ),
            ],
          ),
        ),
        AppSpacings.s16.verticalSpace,
        Padding(
          padding: padding.horizontal,
          child: _AgendaPreview(agenda: agenda),
        ),
        AppSpacings.s24.verticalSpace,
        Padding(
          padding: padding.horizontal,
          child: AppText(
            s.home_speakersCarouselTitle,
            style: AppTextStyles.subtitle,
            color: colors.foregroundDefaultPrimary,
          ),
        ),
        AppSpacings.s16.verticalSpace,
        _SpeakersCarousel(speakers: speakers, padding: padding),
        AppSpacings.s24.verticalSpace,
        Padding(
          padding: padding.horizontal,
          child: AppText(
            s.home_moderatorsCarouselTitle,
            style: AppTextStyles.subtitle,
            color: colors.foregroundDefaultPrimary,
          ),
        ),
        AppSpacings.s16.verticalSpace,
        _SpeakersCarousel(speakers: moderators, padding: padding),
        AppSpacings.s16.verticalSpace,
      ],
    );
  }
}

class _SpeakersCarousel extends StatelessWidget {
  const _SpeakersCarousel({required this.speakers, required this.padding});

  final Iterable<Speaker> speakers;
  final AppSpacing padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          padding.horizontalSpace,
          ...[
            for (final speaker in speakers)
              CircleSpeakerAvatar(speaker: speaker),
          ].spaced(AppSpacings.s24, Axis.horizontal),
          padding.horizontalSpace,
        ],
      ),
    );
  }
}

class _AgendaPreview extends HookWidget {
  const _AgendaPreview({required this.agenda});

  final List<Session> agenda;

  @override
  Widget build(BuildContext context) {
    final Iterable<Session> relevantItems;

    final now = useMinuteTimer();

    if (agenda.first.startTime.isAfter(now)) {
      // The event has not started yet
      relevantItems = agenda.take(2);
    } else if (now.isAfter(agenda.last.endTime)) {
      // The event has ended
      relevantItems = agenda.sublist(agenda.length - 2);
    } else {
      final previousIndex = agenda.lastIndexWhere(
        (session) => session.endTime.isBefore(now),
      );
      if (previousIndex != -1) {
        // At least one session has already ended
        relevantItems = [agenda[previousIndex], agenda[previousIndex + 1]];
      } else {
        // The event has started but no session has ended yet
        relevantItems = agenda.take(2);
      }
    }

    return Column(
      children: [
        for (final sessions in relevantItems.groupedByDate.values)
          AgendaDay(
            sessions: sessions,
            onSessionTap: (session) =>
                HomeBranchSessionRoute(session.id).go(context),
          ),
      ].spaced(AppSpacings.s24),
    );
  }
}
