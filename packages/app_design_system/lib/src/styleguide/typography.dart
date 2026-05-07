// We need Material TextTheme here as parent class of AppTextStyle. We also need
// to override its fields in order to get rid of their original nullability in
// Material TextStyle.
// ignore_for_file: app_lint/use_design_system_item_AppTextStyle, overridden_fields

import 'package:app_design_system/src/package_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

enum AppTextTransform {
  none,
  uppercase;

  String transform(String text) => switch (this) {
    uppercase => text.toUpperCase(),
    _ => text,
  };
}

final class AppTextStyle extends TextStyle {
  const AppTextStyle._({
    required this.styleName,
    required this.fontFamilyName,
    required this.fontSize,
    required double height,
    required this.fontWeight,
    required this.letterSpacing,
    this.textTransform = AppTextTransform.none,
    this.fontStyle = FontStyle.normal,
  }) : height = height / fontSize,
       super(
         fontFamily: fontFamilyName,
         package: appDesignSystemPackage,
         fontFeatures: const [FontFeature.tabularFigures()],
         leadingDistribution: TextLeadingDistribution.even,
         decorationColor: null,
         decoration: TextDecoration.none,
       );

  final String styleName;
  final AppTextTransform textTransform;
  final String fontFamilyName;

  @override
  final double fontSize;

  @override
  final double height;

  @override
  final FontWeight fontWeight;

  @override
  final double letterSpacing;

  @override
  final FontStyle fontStyle;

  @override
  String toStringShort() => 'AppTextStyle.$styleName';

  @override
  void debugFillProperties(
    DiagnosticPropertiesBuilder properties, {
    String prefix = '',
  }) {
    super.debugFillProperties(properties, prefix: prefix);
    properties.add(
      DiagnosticsProperty<AppTextTransform>('textTransform', textTransform),
    );
  }

  @override
  int get hashCode => Object.hash(super.hashCode, styleName, textTransform);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is AppTextStyle &&
        super == other &&
        other.styleName == styleName &&
        other.textTransform == textTransform;
  }

  double getEffectiveHeight(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);
    return textScaler.scale(fontSize) * height;
  }
}

abstract final class AppTextStyles {
  static const display = AppTextStyle._(
    styleName: 'display',
    fontFamilyName: 'Switzer',
    fontWeight: FontWeight.w700,
    fontSize: 40,
    height: 56,
    letterSpacing: -0.022,
  );

  static const headlineLarge = AppTextStyle._(
    styleName: 'headlineLarge',
    fontFamilyName: 'Switzer',
    fontWeight: FontWeight.w700,
    fontSize: 32,
    height: 40,
    letterSpacing: -0.021,
  );

  static const headlineMedium = AppTextStyle._(
    styleName: 'headlineMedium',
    fontFamilyName: 'Switzer',
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 32,
    letterSpacing: -0.021,
  );

  static const headlineSmall = AppTextStyle._(
    styleName: 'headlineSmall',
    fontFamilyName: 'Switzer',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 24,
    letterSpacing: -0.021,
  );

  static const subtitle = AppTextStyle._(
    styleName: 'subtitle',
    fontFamilyName: 'Switzer',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 24,
    letterSpacing: -0.011,
  );

  static const bodyDefault = AppTextStyle._(
    styleName: 'bodyDefault',
    fontFamilyName: 'Switzer',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 24,
    letterSpacing: -0.011,
  );

  static const bodyStrong = AppTextStyle._(
    styleName: 'bodyStrong',
    fontFamilyName: 'Switzer',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 24,
    letterSpacing: -0.011,
  );

  static const bodyItalic = AppTextStyle._(
    styleName: 'bodyItalic',
    fontFamilyName: 'Switzer',
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 24,
    letterSpacing: -0.011,
  );

  static const button = AppTextStyle._(
    styleName: 'button',
    fontFamilyName: 'Switzer',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 24,
    letterSpacing: -0.011,
  );

  static const captionDefault = AppTextStyle._(
    styleName: 'captionDefault',
    fontFamilyName: 'Switzer',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 16,
    letterSpacing: 0,
  );

  static const captionStrong = AppTextStyle._(
    styleName: 'captionStrong',
    fontFamilyName: 'Switzer',
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 16,
    letterSpacing: 0,
  );

  static const overline = AppTextStyle._(
    styleName: 'overline',
    fontFamilyName: 'Switzer',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    textTransform: AppTextTransform.uppercase,
    height: 16,
    letterSpacing: 0,
  );

  static const values = [
    display,
    headlineLarge,
    headlineMedium,
    headlineSmall,
    subtitle,
    bodyDefault,
    bodyStrong,
    bodyItalic,
    button,
    captionDefault,
    captionStrong,
    overline,
  ];
}
