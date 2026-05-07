// We need Material ColorScheme here
// ignore_for_file: app_lint/use_design_system_item_AppColors
import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:flutter/material.dart'
    show
        AppBarTheme,
        ColorScheme,
        PageTransitionsBuilder,
        PageTransitionsTheme,
        ThemeData;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

extension AppColorsMaterialThemeExtension on AppColors {
  /// A [ThemeData] based on a Material [ThemeData].
  ThemeData getMaterialTheme({TransitionBuilder? pageBuilder}) {
    var theme = ThemeData(
      useMaterial3: true,
      splashColor: transparent,
      scaffoldBackgroundColor: backgroundDefaultPrimary,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: backgroundAccentPrimary,
        onPrimary: foregroundActivePrimary,
        secondary: backgroundAccentSecondary,
        onSecondary: foregroundActiveSecondary,
        error: backgroundDangerPrimary,
        onError: foregroundActivePrimary,
        surface: backgroundDefaultSecondary,
        onSurface: foregroundDefaultSecondary,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
    );

    if (pageBuilder != null) {
      Widget effectivePageBuilder(BuildContext context, Widget? child) {
        final effectiveChild = child ?? const SizedBox.shrink();
        return pageBuilder.call(context, effectiveChild);
      }

      theme = theme.copyWith(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {...theme.pageTransitionsTheme.builders}
            ..updateAll(
              (key, pageTransitionsBuilder) => _ProxyPageTransitionsBuilder(
                parent: pageTransitionsBuilder,
                pageBuilder: effectivePageBuilder,
              ),
            ),
        ),
      );
    }

    return theme;
  }
}

class _ProxyPageTransitionsBuilder extends PageTransitionsBuilder {
  const _ProxyPageTransitionsBuilder({
    required this.parent,
    required this.pageBuilder,
  });

  final PageTransitionsBuilder parent;
  final TransitionBuilder pageBuilder;

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return parent.buildTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      Builder(builder: (context) => pageBuilder.call(context, child)),
    );
  }
}
