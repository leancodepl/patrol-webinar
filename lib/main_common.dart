import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/app.dart';
import 'package:fts/common/config/app_config.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/common/keys/page_ids.dart';
import 'package:fts/common/widgets/global_providers.dart';
import 'package:fts/resources/l10n/app_localizations.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:leancode_cubit_utils/leancode_cubit_utils.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> mainCommon({required AppConfig config}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(await prepareApp(config: config));
}

Future<Widget> prepareApp({required AppConfig config}) async {
  LicenseRegistry.addLicense(designSystemLicenseCollector);
  Intl.defaultLocale = 'en';
  setupTimeagoLocales();

  final prefs = await SharedPreferences.getInstance();
  _setupLogger(config);

  return GlobalProviders(
    config: config,
    packageInfo: await PackageInfo.fromPlatform(),
    prefs: prefs,
    child: const AppColorTheme(
      colors: AppColorThemes.light,
      child: LeanCodeCubitUtilsConfigProvider(child: App()),
    ),
  );
}

/// Locales should match all locales from [AppLocalizations.supportedLocales]
void setupTimeagoLocales() {
  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('pl', timeago.PlMessages());
}

void _setupLogger(AppConfig config) {
  Logger.root.level = kDebugMode ? .ALL : .INFO;
  Logger.root.onRecord.listen((record) {
    log(
      record.message,
      time: record.time,
      sequenceNumber: record.sequenceNumber,
      level: record.level.value,
      name: record.loggerName,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });

  final flutterErrorLogger = Logger('FlutterError');
  FlutterError.onError = (details) {
    if (config.debugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      flutterErrorLogger.warning(
        details.summary.name,
        details.exception,
        details.stack,
      );
    }
  };
}

class LeanCodeCubitUtilsConfigProvider extends StatelessWidget {
  const LeanCodeCubitUtilsConfigProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PaginatedLayoutConfigProvider(
      onFirstPageLoading: (context) => const Center(child: AppSpinner()),
      onNextPageLoading: (context) => const Center(child: AppSpinner()),
      onFirstPageError: (context, error, retry) =>
          AppText(error.toString(), style: AppTextStyles.bodyDefault),
      onNextPageError: (context, error, retry) =>
          AppText(error.toString(), style: AppTextStyles.bodyDefault),
      onEmptyState: (context) => const Center(
        child: AppText('No data', style: AppTextStyles.bodyDefault),
      ),
      child: RequestLayoutConfigProvider(
        onLoading: (context) => const Center(child: AppSpinner()),
        onError: (context, error, retry) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(error.toString(), style: AppTextStyles.bodyDefault),
                AppButton(
                  analyticsId: AnalyticsIds.retryButton(PageId.homePage),
                  type: AppButtonType.primary,
                  caption: 'Retry',
                  onTap: retry,
                ),
              ],
            ),
          );
        },
        child: child,
      ),
    );
  }
}
