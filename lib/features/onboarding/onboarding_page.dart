import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/common/util/calculate_text_size.dart';
import 'package:fts/features/onboarding/onboarding_cubit.dart';
import 'package:fts/keys.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/assets.gen.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

class OnboardingPage extends HookWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    final controller = usePageController();
    final currentPage = useState<int?>(0);
    useEffect(() {
      void pageListener() {
        currentPage.value = controller.page?.round();
      }

      controller.addListener(pageListener);

      return () => controller.removeListener(pageListener);
    }, [controller]);

    final pages = [
      _Page(
        image: Assets.images.onboarding1,
        title: s.onboardingPage1_title,
        message: s.onboardingPage1_message,
      ),
      _Page(
        image: Assets.images.onboarding2,
        title: s.onboardingPage2_title,
        message: s.onboardingPage2_message,
      ),
      _Page(
        image: Assets.images.onboarding3,
        title: s.onboardingPage3_title,
        message: s.onboardingPage3_message,
        last: true,
      ),
    ];

    return AppScaffold(
      useBodyPadding: false,
      body: Stack(
        children: [
          PageView(controller: controller, children: pages),
          if (currentPage.value case final currentPage?)
            Positioned.fill(
              top: null,
              bottom: _paginationDotsSpacing,
              child: AppPaginationDots(
                current: currentPage,
                pages: pages.length,
              ),
            ),
        ],
      ),
    );
  }
}

const _paginationDotsSpacing = 112.0;

class _Page extends StatelessWidget {
  const _Page({
    required this.image,
    required this.title,
    required this.message,
    this.last = false,
  });

  final AssetGenImage image;
  final String title;
  final String message;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = l10n(context);

    return Padding(
      padding: AppSpacings.s16.horizontal,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const buttonSize = AppButtonSize.large;

          final totalHeight = constraints.maxHeight;
          const titleTextStyle = AppTextStyles.headlineMedium;
          const subtitleTextStyle = AppTextStyles.bodyDefault;
          const topSpacing = AppSpacings.s24;
          const imageBottomSpacing = AppSpacings.s48;
          final titleHeight = calculateTextSize(
            context: context,
            text: title,
            style: titleTextStyle,
            availableWidth: constraints.maxWidth,
          ).height;
          const titleSubtitleSpacing = AppSpacings.s16;
          final subtitleHeight = calculateTextSize(
            context: context,
            text: message,
            style: subtitleTextStyle,
            availableWidth: constraints.maxWidth,
          ).height;
          const subtitleBottomSpacing = AppSpacings.s64;
          final buttonHeight =
              AppTextStyles.button.getEffectiveHeight(context) +
              buttonSize.padding.vertical.vertical;
          const buttonBottomSpacing = AppSpacings.s32;

          final maxImageHeight =
              totalHeight -
              topSpacing.value -
              imageBottomSpacing.value -
              titleHeight -
              titleSubtitleSpacing.value -
              subtitleHeight -
              subtitleBottomSpacing.value -
              buttonHeight -
              buttonBottomSpacing.value;

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              topSpacing.verticalSpace,
              image.image(height: maxImageHeight),
              imageBottomSpacing.verticalSpace,
              AppText(
                title,
                style: titleTextStyle,
                textAlign: TextAlign.center,
                color: colors.foregroundDefaultPrimary,
              ),
              titleSubtitleSpacing.verticalSpace,
              AppText(
                message,
                style: subtitleTextStyle,
                textAlign: TextAlign.center,
              ),
              subtitleBottomSpacing.verticalSpace,
              Visibility.maintain(
                visible: last,
                child: IgnorePointer(
                  ignoring: !last,
                  child: AppButton(
                    key: keys.onboarding.continueToAppButton,
                    type: AppButtonType.primary,
                    fullWidth: true,
                    caption: s.onboarding_continueToApp,
                    onTap: () {
                      context.read<OnboardingCubit>().complete();
                      const HomeRoute().go(context);
                    },
                    semanticsLabel: s.onboarding_continueToApp,
                    analyticsId: AnalyticsIds.onboardingContinueToAppButton,
                  ),
                ),
              ),
              buttonBottomSpacing.verticalSpace,
            ],
          );
        },
      ),
    );
  }
}
