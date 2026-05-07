// We need Color class as base of AppColor here
// ignore_for_file: app_lint/use_design_system_item_AppColor

import 'package:enhanced_gradients/enhanced_gradients.dart';
import 'package:flutter/widgets.dart';

part 'colors.g.dart';

/// Applies [AppColors] to descendant widgets.
class AppColorTheme extends InheritedWidget {
  /// Applies the given AppColors [colors] to [child].
  const AppColorTheme({super.key, required this.colors, required super.child});

  /// Specifies the colors for descendant widgets.
  final AppColors colors;

  /// The data from the closest [AppColorTheme] instance that encloses the given
  /// context.
  static AppColors of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppColorTheme>()!.colors;

  static AppColors? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppColorTheme>()?.colors;

  @override
  bool updateShouldNotify(AppColorTheme oldWidget) =>
      colors != oldWidget.colors;
}

/// An extension for the [AppColorTheme] to use with context.
extension AppColorsExtension on BuildContext {
  /// Get current [AppColors] with context.
  AppColors get colors => AppColorTheme.of(this);
}

final class AppColor extends Color {
  /// Construct a color from the lower 32 bits of an [int] in similar way as
  /// [Color] constructor. We use [name] and [designName] to make it easier to
  /// identify the color while debugging.
  AppColor._color(
    super.value, {
    required this.name,
    required String this.designName,
  });

  AppColor._nonstandard(super.value, {required this.name, this.designName});

  final String name;
  final String? designName;

  @override
  int get value => _calculateValue(a, r, g, b);

  static int _calculateValue(double a, double r, double g, double b) =>
      _floatToInt8(a) << 24 |
      _floatToInt8(r) << 16 |
      _floatToInt8(g) << 8 |
      _floatToInt8(b) << 0;

  static int _floatToInt8(double x) => (x * 255.0).round() & 0xff;

  /// Returns transparent variant of this [AppColor].
  AppColor get transparent => AppColor._nonstandard(
    _calculateValue(0, r, g, b),
    name: 'transparent($name)',
  );

  /// Interpolate between two [AppColor] colors using HCT. Additionally
  /// applies correction to colors when either of them is transparent
  /// (0x00RRGGBB). In case when color [first] is transparent we ignore it's
  /// RRGGBB part and override it with RRGGBB part from color [second]. If not
  /// then if [second] color is transparent we override its RRGGBB part with
  /// RRGGBB part from color [first].
  static AppColor? lerp(AppColor? first, AppColor? second, double t) {
    var firstCorrected = first;
    var secondCorrected = second;

    if (first?.a == 0 && second != null) {
      firstCorrected = second.transparent;
    } else if (second?.a == 0 && first != null) {
      secondCorrected = first.transparent;
    }

    final lerpResult = lerpHct(firstCorrected, secondCorrected, t);

    return switch (lerpResult) {
      final color? => switch (t) {
        == 0 => AppColor._nonstandard(
          _calculateValue(color.a, color.r, color.g, color.b),
          name: '${first?.name}',
          designName: first?.designName,
        ),
        == 1 => AppColor._nonstandard(
          _calculateValue(color.a, color.r, color.g, color.b),
          name: '${second?.name}',
          designName: second?.designName,
        ),
        _ => AppColor._nonstandard(
          _calculateValue(color.a, color.r, color.g, color.b),
          name: 'lerp(${first?.name}, ${second?.name}, $t)',
        ),
      },
      _ => null,
    };
  }

  @override
  String toString() {
    final hex = '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';
    final opacity = '${(a * 100).toInt()}%';
    final name = this.name;

    return 'AppColor($hex $opacity, $name)';
  }

  @override
  int get hashCode => Object.hash(value, name, designName);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return switch (other) {
      final AppColor other =>
        other.a == a &&
            other.r == r &&
            other.g == g &&
            other.b == b &&
            other.name == name &&
            other.designName == designName,
      _ => false,
    };
  }
}

final class AppColorTween extends Tween<AppColor> {
  AppColorTween({super.begin, super.end});

  AppColorTween.uniform(AppColor color) : super(begin: color, end: color);

  @override
  AppColor lerp(double t) => AppColor.lerp(begin, end, t)!;
}

abstract class AppColors {
  const AppColors._();

  /// Brightness of the theme.
  Brightness get brightness;

  // Background
  // Accent
  AppColor get backgroundAccentPrimary;
  AppColor get backgroundAccentPrimaryHover;
  AppColor get backgroundAccentPrimaryPressed;
  AppColor get backgroundAccentSecondary;
  AppColor get backgroundAccentSecondaryHover;
  AppColor get backgroundAccentSecondaryPressed;
  AppColor get backgroundAccentTertiary;
  AppColor get backgroundAccentTertiaryHover;
  AppColor get backgroundAccentTertiaryPressed;
  // Active
  AppColor get backgroundActivePrimary;
  AppColor get backgroundActivePrimaryHover;
  AppColor get backgroundActivePrimaryPressed;
  AppColor get backgroundActiveSecondary;
  AppColor get backgroundActiveSecondaryHover;
  AppColor get backgroundActiveSecondaryPressed;
  AppColor get backgroundActiveTertiary;
  AppColor get backgroundActiveTertiaryHover;
  AppColor get backgroundActiveTertiaryPressed;
  // Info
  AppColor get backgroundInfoPrimary;
  AppColor get backgroundInfoPrimaryHover;
  AppColor get backgroundInfoPrimaryPressed;
  AppColor get backgroundInfoSecondary;
  AppColor get backgroundInfoSecondaryHover;
  AppColor get backgroundInfoSecondaryPressed;
  AppColor get backgroundInfoTertiary;
  AppColor get backgroundInfoTertiaryHover;
  AppColor get backgroundInfoTertiaryPressed;
  // Danger
  AppColor get backgroundDangerPrimary;
  AppColor get backgroundDangerPrimaryHover;
  AppColor get backgroundDangerPrimaryPressed;
  AppColor get backgroundDangerSecondary;
  AppColor get backgroundDangerSecondaryHover;
  AppColor get backgroundDangerSecondaryPressed;
  AppColor get backgroundDangerTertiary;
  AppColor get backgroundDangerTertiaryHover;
  AppColor get backgroundDangerTertiaryPressed;
  // Success
  AppColor get backgroundSuccessPrimary;
  AppColor get backgroundSuccessPrimaryHover;
  AppColor get backgroundSuccessPrimaryPressed;
  AppColor get backgroundSuccessSecondary;
  AppColor get backgroundSuccessSecondaryHover;
  AppColor get backgroundSuccessSecondaryPressed;
  AppColor get backgroundSuccessTertiary;
  AppColor get backgroundSuccessTertiaryHover;
  AppColor get backgroundSuccessTertiaryPressed;
  // Warning
  AppColor get backgroundWarningPrimary;
  AppColor get backgroundWarningPrimaryHover;
  AppColor get backgroundWarningPrimaryPressed;
  AppColor get backgroundWarningSecondary;
  AppColor get backgroundWarningSecondaryHover;
  AppColor get backgroundWarningSecondaryPressed;
  AppColor get backgroundWarningTertiary;
  AppColor get backgroundWarningTertiaryHover;
  AppColor get backgroundWarningTertiaryPressed;
  // Default
  AppColor get backgroundDefaultPrimary;
  AppColor get backgroundDefaultPrimaryHover;
  AppColor get backgroundDefaultPrimaryPressed;
  AppColor get backgroundDefaultSecondary;
  AppColor get backgroundDefaultSecondaryHover;
  AppColor get backgroundDefaultSecondaryPressed;
  AppColor get backgroundDefaultTertiary;
  AppColor get backgroundDefaultTertiaryHover;
  AppColor get backgroundDefaultTertiaryPressed;
  AppColor get backgroundDefaultScrim;
  // Inverse
  AppColor get backgroundInversePrimary;
  AppColor get backgroundInversePrimaryHover;
  AppColor get backgroundInversePrimaryPressed;
  // Disabled
  AppColor get backgroundDisabledPrimary;
  AppColor get backgroundDisabledSecondary;
  AppColor get backgroundDisabledTertiary;

  // Map
  AppColor get backgroundMapBarBadge;
  AppColor get backgroundMapBarPin;
  AppColor get backgroundMapCulturalBadge;
  AppColor get backgroundMapCulturalPin;
  AppColor get backgroundMapFoodBadge;
  AppColor get backgroundMapFoodPin;
  AppColor get backgroundMapLeancodeBadge;
  AppColor get backgroundMapLeancodePin;
  AppColor get backgroundMapMainEventBadge;
  AppColor get backgroundMapMainEventPin;
  AppColor get backgroundMapMuseumBadge;
  AppColor get backgroundMapMuseumPin;
  AppColor get backgroundMapOtherBadge;
  AppColor get backgroundMapOtherPin;
  AppColor get backgroundMapParkBadge;
  AppColor get backgroundMapParkPin;
  AppColor get backgroundMapSideEventBadge;
  AppColor get backgroundMapSideEventPin;

  // Foreground
  // Accent
  AppColor get foregroundAccentPrimary;
  AppColor get foregroundAccentPrimaryHover;
  AppColor get foregroundAccentPrimaryPressed;
  AppColor get foregroundAccentSecondary;
  AppColor get foregroundAccentSecondaryHover;
  AppColor get foregroundAccentSecondaryPressed;
  AppColor get foregroundAccentTertiary;
  AppColor get foregroundAccentQuaternary;
  // Active
  AppColor get foregroundActivePrimary;
  AppColor get foregroundActivePrimaryHover;
  AppColor get foregroundActivePrimaryPressed;
  AppColor get foregroundActiveSecondary;
  AppColor get foregroundActiveSecondaryHover;
  AppColor get foregroundActiveSecondaryPressed;
  AppColor get foregroundActiveTertiary;
  AppColor get foregroundActiveQuaternary;
  // Info
  AppColor get foregroundInfoPrimary;
  AppColor get foregroundInfoPrimaryHover;
  AppColor get foregroundInfoPrimaryPressed;
  AppColor get foregroundInfoSecondary;
  AppColor get foregroundInfoSecondaryHover;
  AppColor get foregroundInfoSecondaryPressed;
  AppColor get foregroundInfoTertiary;
  AppColor get foregroundInfoQuaternary;
  // Danger
  AppColor get foregroundDangerPrimary;
  AppColor get foregroundDangerPrimaryHover;
  AppColor get foregroundDangerPrimaryPressed;
  AppColor get foregroundDangerSecondary;
  AppColor get foregroundDangerSecondaryHover;
  AppColor get foregroundDangerSecondaryPressed;
  AppColor get foregroundDangerTertiary;
  AppColor get foregroundDangerQuaternary;
  // Success
  AppColor get foregroundSuccessPrimary;
  AppColor get foregroundSuccessPrimaryHover;
  AppColor get foregroundSuccessPrimaryPressed;
  AppColor get foregroundSuccessSecondary;
  AppColor get foregroundSuccessSecondaryHover;
  AppColor get foregroundSuccessSecondaryPressed;
  AppColor get foregroundSuccessTertiary;
  AppColor get foregroundSuccessQuaternary;
  // Warning
  AppColor get foregroundWarningPrimary;
  AppColor get foregroundWarningPrimaryHover;
  AppColor get foregroundWarningPrimaryPressed;
  AppColor get foregroundWarningSecondary;
  AppColor get foregroundWarningSecondaryHover;
  AppColor get foregroundWarningSecondaryPressed;
  AppColor get foregroundWarningTertiary;
  AppColor get foregroundWarningQuaternary;
  // Default
  AppColor get foregroundDefaultPrimary;
  AppColor get foregroundDefaultPrimaryHover;
  AppColor get foregroundDefaultPrimaryPressed;
  AppColor get foregroundDefaultSecondary;
  AppColor get foregroundDefaultSecondaryHover;
  AppColor get foregroundDefaultSecondaryPressed;
  AppColor get foregroundDefaultTertiary;
  AppColor get foregroundDefaultQuaternary;
  // Inverse
  AppColor get foregroundInversePrimary;
  AppColor get foregroundInversePrimaryHover;
  AppColor get foregroundInversePrimaryPressed;
  // Disabled
  AppColor get foregroundDisabledPrimary;
  AppColor get foregroundDisabledSecondary;
  AppColor get foregroundDisabledTertiary;
  // Map
  AppColor get foregroundMapBar;
  AppColor get foregroundMapCultural;
  AppColor get foregroundMapFood;
  AppColor get foregroundMapLeancode;
  AppColor get foregroundMapMainEvent;
  AppColor get foregroundMapMuseum;
  AppColor get foregroundMapOther;
  AppColor get foregroundMapPark;
  AppColor get foregroundMapSideEvent;

  // Custom
  AppColor get appleButtonColor => AppColor._color(
    0xFF000000,
    name: 'appleButtonColor',
    designName: 'Apple Button Color',
  );

  AppColor get linkedInButtonColor => AppColor._color(
    0xFF0077B5,
    name: 'linkedinButtonColor',
    designName: 'LinkedIn Button Color',
  );

  /// Static transparent color, does not change depending on the theme.
  AppColor get transparent => AppColor._color(
    0x00000000,
    name: 'transparent',
    designName: 'Transparent',
  );
}

final class _LightModeColors extends AppColors with _LightModeColorsMixin {
  const _LightModeColors() : super._();

  @override
  Brightness get brightness => Brightness.light;
}

abstract final class AppColorThemes {
  static const light = _LightModeColors();
}
