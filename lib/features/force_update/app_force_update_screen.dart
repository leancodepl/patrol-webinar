import 'package:flutter/material.dart' show MaterialApp;
import 'package:flutter/widgets.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/keys.dart';
import 'package:fts/resources/l10n/app_localizations.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:leancode_force_update/leancode_force_update.dart';

class AppForceUpdateScreen extends StatelessWidget {
  const AppForceUpdateScreen({
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

          return AppScaffold(
            key: keys.appForceUpdateScreen.screen,
            useBodyPadding: false,
            body: AppDefaultTextStyle(
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyDefault,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (icon != null) ...[
                        SizedBox.square(dimension: 48, child: icon),
                        AppSpacings.s24.verticalSpace,
                      ],
                      AppText(
                        s.force_update_screen_title,
                        style: AppTextStyles.headlineMedium,
                      ),
                      AppSpacings.s8.verticalSpace,
                      AppText(
                        s.force_update_screen_subtitle,
                        color: colors.foregroundDefaultSecondary,
                        style: AppTextStyles.bodyDefault,
                      ),
                      AppSpacings.s32.verticalSpace,
                      AppButton(
                        key: keys.appForceUpdateScreen.updateButton,
                        onTap: forceUpdateController.openStore,
                        caption: s.force_update_screen_updateButton,
                        analyticsId: AnalyticsIds.openStorePageButton,
                        type: AppButtonType.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
