// We need these Material classes as base classes for our custom DS classes
// ignore_for_file: app_lint/use_design_system_item_AppTextStyle, app_lint/use_design_system_item_AppTextSpan, app_lint/use_design_system_item_AppWidgetSpan, app_lint/use_design_system_item_AppDefaultTextStyle

import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

sealed class AppInlineSpan {
  const AppInlineSpan();

  @mustCallSuper
  void init() {}

  @mustCallSuper
  void dispose() {}

  InlineSpan buildSpan(AppTextTransform textTransform);
}

final class AppWidgetSpan extends AppInlineSpan {
  AppWidgetSpan({
    required this.child,
    this.alignment = PlaceholderAlignment.bottom,
    this.baseline,
    this.style,
  });

  final Widget child;
  final PlaceholderAlignment alignment;
  final TextBaseline? baseline;
  final AppTextStyle? style;

  @override
  WidgetSpan buildSpan(AppTextTransform textTransform) {
    return WidgetSpan(
      child: child,
      alignment: alignment,
      baseline: baseline,
      style: style,
    );
  }
}

final class AppTextSpan extends AppInlineSpan {
  AppTextSpan({
    this.text,
    VoidCallback? onTap,
    this.style,
    this.color,
    this.children = const [],
  }) : _onTap = onTap;

  final String? text;
  final VoidCallback? _onTap;
  final AppTextStyle? style;
  final AppColor? color;
  final List<AppInlineSpan> children;

  TapGestureRecognizer? tapRecognizer;

  @override
  void init() {
    super.init();
    if (_onTap == null) {
      return;
    }

    tapRecognizer = TapGestureRecognizer()..onTap = _onTap;
  }

  @override
  void dispose() {
    tapRecognizer?.dispose();

    super.dispose();
  }

  @override
  TextSpan buildSpan(AppTextTransform textTransform) {
    final effectiveTextTrasform = style?.textTransform ?? textTransform;

    return TextSpan(
      text: switch (text) {
        final text? => effectiveTextTrasform.transform(text),
        _ => null,
      },
      recognizer: tapRecognizer,
      style: (style ?? const TextStyle()).copyWith(color: color),
      children: children
          .map((span) => span.buildSpan(effectiveTextTrasform))
          .toList(),
    );
  }
}
