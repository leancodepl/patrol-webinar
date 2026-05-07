import 'package:flutter/widgets.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/common/keys/page_ids.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';

class AppErrorView extends StatelessWidget {
  const AppErrorView({super.key, required this.pageId, this.onRetry});

  final PageId pageId;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    return Padding(
      padding: AppSpacings.s16.all,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            s.app_error_view_title,
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineMedium,
          ),
          AppText(
            s.app_error_view_subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyDefault,
          ),
          AppSpacings.s64.verticalSpace,
          if (onRetry case final onRetry?)
            AppButton(
              analyticsId: AnalyticsIds.retryButton(pageId),
              caption: s.app_error_view_retry_button,
              onTap: onRetry,
              type: AppButtonType.primary,
            ),
        ],
      ),
    );
  }
}
