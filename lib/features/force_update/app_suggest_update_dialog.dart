import 'package:flutter/material.dart' show Dialog, MaterialApp;
import 'package:flutter/widgets.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/keys.dart';
import 'package:fts/resources/l10n/app_localizations.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:leancode_force_update/leancode_force_update.dart';

class AppSuggestUpdateDialog extends StatelessWidget {
  const AppSuggestUpdateDialog({
    super.key,
    required this.forceUpdateController,
    this.icon,
  });

  final ForceUpdateController forceUpdateController;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        ...AppDesignSystemLocalizations.localizationsDelegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) {
          final s = l10n(context);
          final colors = context.colors;
          final icon = this.icon;

          return ColoredBox(
            color: colors.foregroundDefaultPrimary.withValues(alpha: 0.5),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: forceUpdateController.hideSuggestDialog,
                  behavior: HitTestBehavior.translucent,
                ),
                Dialog(
                  key: keys.appSuggestUpdateDialog.dialog,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  insetPadding: const EdgeInsets.all(16),
                  elevation: 0,
                  child: Padding(
                    padding: AppSpacings.s24.all,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (icon != null) ...[
                          SizedBox.square(dimension: 48, child: icon),
                          AppSpacings.s24.verticalSpace,
                        ],
                        AppText(
                          s.suggest_update_dialog_title,
                          style: AppTextStyles.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        AppSpacings.s8.verticalSpace,
                        AppText(
                          s.suggest_update_dialog_subtitle,
                          style: AppTextStyles.bodyDefault,
                          color: colors.foregroundDefaultSecondary,
                          textAlign: TextAlign.center,
                        ),
                        AppSpacings.s16.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                key: keys.appSuggestUpdateDialog.cancelButton,
                                onTap: forceUpdateController.hideSuggestDialog,
                                caption: s.common_cancel,
                                analyticsId: AnalyticsIds.cancelDialogButton,
                                type: AppButtonType.secondary,
                              ),
                            ),
                            AppSpacings.s8.horizontalSpace,
                            Expanded(
                              child: AppButton(
                                key: keys.appSuggestUpdateDialog.updateButton,
                                onTap: forceUpdateController.openStore,
                                caption: s.suggest_update_dialog_updateButton,
                                analyticsId: AnalyticsIds.openStoreDialogButton,
                                type: AppButtonType.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
