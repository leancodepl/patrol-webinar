import 'package:app_design_system/src/l10n/l10n.dart';
import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/material_theme.dart';
import 'package:flutter/material.dart' show MaterialApp;
import 'package:flutter/widgets.dart';

/// A core widget that provides a [MaterialApp] with a necessary configuration
/// for LeanCode design system.
///
/// Interface for this widgets was made following [MaterialApp] interface. If a
/// given parameter is not documented then it works the same way as
/// [MaterialApp].
///
/// The reason why we wrap [MaterialApp] instead of agnostic [WidgetsApp] is
/// that [MaterialApp] provides things necessary for some material.dart widgets
/// like theme, localizations, and some configurations. Even though we and to
/// limit usage of material.dart widgets, we can't get rid of it completely so
/// we need to provide some of the things that are necessary for some of the
/// material.dart widgets.
class AppCore extends StatelessWidget {
  const AppCore({
    super.key,
    this.navigatorKey,
    this.home,
    Map<String, WidgetBuilder> this.routes = const {},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.onNavigationNotification,
    List<NavigatorObserver> this.navigatorObservers = const [],
    this.builder,
    this.pageBuilder,
    this.title = '',
    this.onGenerateTitle,
    required this.colors,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const [Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
  }) : routeInformationProvider = null,
       routeInformationParser = null,
       routerDelegate = null,
       backButtonDispatcher = null,
       routerConfig = null;

  const AppCore.router({
    super.key,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.routerConfig,
    this.backButtonDispatcher,
    this.builder,
    this.pageBuilder,
    this.title = '',
    this.onGenerateTitle,
    this.onNavigationNotification,
    required this.colors,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
  }) : assert(routerDelegate != null || routerConfig != null),
       navigatorObservers = null,
       navigatorKey = null,
       onGenerateRoute = null,
       home = null,
       onGenerateInitialRoutes = null,
       onUnknownRoute = null,
       routes = null,
       initialRoute = null;

  final GlobalKey<NavigatorState>? navigatorKey;

  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final NotificationListenerCallback<NavigationNotification>?
  onNavigationNotification;
  final List<NavigatorObserver>? navigatorObservers;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;
  final RouterConfig<Object>? routerConfig;

  /// A builder that wraps the router delegate.
  final TransitionBuilder? builder;

  /// A builder that wraps each page individually.
  final TransitionBuilder? pageBuilder;

  final String title;
  final GenerateAppTitle? onGenerateTitle;

  /// Current colors theme. Set this parameter to apply color theme
  /// appropriate for current theme mode setting.
  final AppColors colors;

  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final bool debugShowMaterialGrid;

  bool get _usesRouter => routerDelegate != null || routerConfig != null;

  @override
  Widget build(BuildContext context) {
    final materialTheme = colors.getMaterialTheme(pageBuilder: pageBuilder);

    final localizationsDelegates = [
      ...?this.localizationsDelegates,
      ...AppDesignSystemLocalizations.localizationsDelegates,
    ];

    if (_usesRouter) {
      return AppColorTheme(
        colors: colors,
        child: MaterialApp.router(
          theme: materialTheme,
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
          routerConfig: routerConfig,
          builder: _routerBuilder,
          routeInformationProvider: routeInformationProvider,
          routeInformationParser: routeInformationParser,
          routerDelegate: routerDelegate,
          backButtonDispatcher: backButtonDispatcher,
          title: title,
          onGenerateTitle: onGenerateTitle,
          onNavigationNotification: onNavigationNotification,
          locale: locale,
          localeListResolutionCallback: localeListResolutionCallback,
          localeResolutionCallback: localeResolutionCallback,
          debugShowMaterialGrid: debugShowMaterialGrid,
          showPerformanceOverlay: showPerformanceOverlay,
          checkerboardRasterCacheImages: checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: checkerboardOffscreenLayers,
          showSemanticsDebugger: showSemanticsDebugger,
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,
          shortcuts: shortcuts,
          actions: actions,
          restorationScopeId: restorationScopeId,
          scrollBehavior: scrollBehavior,
        ),
      );
    }

    return AppColorTheme(
      colors: colors,
      child: MaterialApp(
        theme: materialTheme,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        builder: _routerBuilder,
        navigatorKey: navigatorKey,
        home: home,
        routes: {...?routes},
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
        onGenerateInitialRoutes: onGenerateInitialRoutes,
        onUnknownRoute: onUnknownRoute,
        onNavigationNotification: onNavigationNotification,
        navigatorObservers: [...?navigatorObservers],
        title: title,
        onGenerateTitle: onGenerateTitle,
        locale: locale,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        debugShowMaterialGrid: debugShowMaterialGrid,
        showPerformanceOverlay: showPerformanceOverlay,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        showSemanticsDebugger: showSemanticsDebugger,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        shortcuts: shortcuts,
        actions: actions,
        restorationScopeId: restorationScopeId,
        scrollBehavior: scrollBehavior,
      ),
    );
  }

  Widget _routerBuilder(BuildContext context, Widget? child) {
    return Builder(
      builder: (context) =>
          builder?.call(context, child) ?? child ?? const SizedBox.shrink(),
    );
  }
}
