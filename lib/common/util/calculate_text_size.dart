// Text styles used for calculating size values, not display in the UI
// ignore_for_file: app_lint/use_design_system_item_AppTextStyle, app_lint/use_design_system_item_AppTextSpan
import 'package:flutter/material.dart';

Size calculateTextSize({
  required BuildContext context,
  required String text,
  required TextStyle style,
  int? maxLines,
  double availableWidth = double.infinity,
}) {
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: Directionality.of(context),
    textScaler: MediaQuery.textScalerOf(context),
    maxLines: maxLines,
  )..layout(maxWidth: availableWidth);

  return textPainter.size;
}
