// Custom title style
// ignore_for_file: app_lint/use_design_system_item_AppTextStyle, app_lint/use_design_system_item_AppColor, app_lint/use_design_system_item_AppText, app_lint/use_design_system_item_AppScaffold

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fts/features/onboarding/onboarding_cubit.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/assets.gen.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';

class SplashScreenPage extends HookWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    const white = Color(0xFFFFFFFF);
    const black = Color(0xFF000000);

    final text = s.splashScreen_mainText;
    const textStyle = TextStyle(
      fontSize: 32,
      color: white,
      fontFamily: 'Monoska',
      package: 'app_design_system',
    );

    final logoOpacity = useState<double>(0);

    return Scaffold(
      backgroundColor: black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Visibility.maintain(
                visible: false,
                child: Text(text, style: textStyle),
              ),
              AnimatedTextKit(
                pause: Duration.zero,
                isRepeatingAnimation: false,
                onFinished: () => logoOpacity.value = 1.0,
                animatedTexts: [
                  TyperAnimatedText(
                    text,
                    textAlign: TextAlign.center,
                    textStyle: textStyle,
                  ),
                ],
              ),
            ],
          ),
          AppSpacings.s32.verticalSpace,
          AnimatedOpacity(
            opacity: logoOpacity.value,
            duration: const Duration(milliseconds: 200),
            onEnd: () {
              final onboardingState = context.read<OnboardingCubit>().state;
              if (onboardingState == OnboardingState.completed) {
                const HomeRoute().go(context);
              } else {
                const OnboardingRoute().go(context);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  s.splashScreen_by,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Monoska',
                    package: 'app_design_system',
                    color: white,
                  ),
                ),
                AppSpacings.s8.horizontalSpace,
                Assets.icons.standard.leancodeLogo.image(color: white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
