import 'package:flutter/widgets.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/resources/assets.gen.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.onTryAgain, this.topBar});

  final VoidCallback onTryAgain;
  final Widget? topBar;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    return AppScaffold(
      topBar: topBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.errorState.svg(),
          AppSpacings.s24.verticalSpace,
          AppText(s.errorState_title, style: AppTextStyles.headlineMedium),
          AppSpacings.s16.verticalSpace,
          AppText(s.errorState_message, style: AppTextStyles.bodyDefault),
          AppSpacings.s24.verticalSpace,
          AppButton(
            caption: s.errorState_tryAgain,
            type: AppButtonType.primary,
            analyticsId: AnalyticsIds.errorStateTryAgainButton,
            onTap: onTryAgain,
          ),
        ],
      ),
    );
  }
}
