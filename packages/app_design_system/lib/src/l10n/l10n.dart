import 'package:app_design_system/src/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

export 'app_localizations.dart';

/// An extension for the [AppDesignSystemLocalizations] to use with context.
extension AppDesignSystemLocalizationsExtension on BuildContext {
  /// Get current [AppDesignSystemLocalizations] with context.
  AppDesignSystemLocalizations get l10n =>
      AppDesignSystemLocalizations.of(this);
}
