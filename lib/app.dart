import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/common/config/app_config.dart';
import 'package:fts/common/config/app_global_keys.dart';
import 'package:fts/common/widgets/keyboard_dismisser.dart';
import 'package:fts/features/force_update/app_force_update_screen.dart';
import 'package:fts/features/force_update/app_suggest_update_dialog.dart';
import 'package:fts/features/localization/localization_notifier.dart';
import 'package:fts/keys.dart';
import 'package:fts/navigation/router.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/l10n/app_localizations.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:leancode_app_rating/leancode_app_rating.dart';
import 'package:leancode_debug_page/leancode_debug_page.dart';
import 'package:leancode_force_update/leancode_force_update.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:provider/provider.dart';

class App extends HookWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final showDebugOverlay = context.select<AppConfig, bool>(
      (config) => config.showDebugOverlay,
    );

    final debugPageController = useMemoized(
      () => showDebugOverlay
          ? DebugPageController(
              loggingHttpClient: context.read(),
              navigatorKey: context.read<AppGlobalKeys>().navigatorKey,
            )
          : null,
    );

    Widget app = const AppSnackbarTheater(
      child: KeyboardDismisser(child: _RouterApp()),
    );

    if (!kIsWeb) {
      final forceUpdateController = context.watch<ForceUpdateController>();

      app = ForceUpdateGuard(
        cqrs: context.watch(),
        controller: forceUpdateController,
        forceUpdateScreen: AppForceUpdateScreen(
          forceUpdateController: forceUpdateController,
        ),
        suggestUpdateDialog: AppSuggestUpdateDialog(
          key: keys.appSuggestUpdateDialog.dialog,
          forceUpdateController: forceUpdateController,
        ),
        child: app,
      );
    }

    if (debugPageController != null && showDebugOverlay) {
      app = DebugPageOverlay(controller: debugPageController, child: app);
    }

    return app;
  }
}

class _RouterApp extends HookWidget {
  const _RouterApp();

  @override
  Widget build(BuildContext context) {
    final router = useGoRouter(
      globalKeys: context.read(),
      authCubit: context.read(),
      initialLocation: const SplashScreenRoute().location,
      observers: [
        AppSnackbarNavigatorObserver(
          messenger: AppSnackbarTheater.messengerOf(context),
        ),
      ],
    );

    return AppCore.router(
      routerConfig: router,
      colors: context.colors,
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        ...AppDesignSystemLocalizations.localizationsDelegates,
        ...AppRatingLocalizations.localizationsDelegates,
      ],
      locale: context.watch<LocalizationNotifier>().currentLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) =>
          AppSnackbarScene(child: child ?? const SizedBox.shrink()),
    );
  }
}
