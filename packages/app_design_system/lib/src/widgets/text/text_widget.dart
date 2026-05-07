// We need these Material classes as base classes for our custom DS classes
// ignore_for_file: app_lint/use_design_system_item_AppText, app_lint/use_design_system_item_AppTextStyle, app_lint/use_design_system_item_AppTextSpan, app_lint/use_design_system_item_AppWidgetSpan, app_lint/use_design_system_item_AppDefaultTextStyle

import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/widgets/text/inline_span.dart';
import 'package:flutter/widgets.dart';

const _ellipsisThreeDots = '\u2026';

class AppText extends StatefulWidget {
  const AppText(
    String this.text, {
    super.key,
    required this.style,
    this.color,
    this.textAlign,
    this.maxLines,
    this.ellipsis = true,
    this.textWidthBasis = TextWidthBasis.parent,
  }) : data = const [];

  const AppText.rich(
    this.data, {
    super.key,
    required this.style,
    this.color,
    this.textAlign,
    this.maxLines,
    this.ellipsis = true,
    this.textWidthBasis = TextWidthBasis.parent,
  }) : text = null;

  final String? text;
  final List<AppInlineSpan> data;
  final AppTextStyle style;
  final AppColor? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool ellipsis;
  final TextWidthBasis textWidthBasis;

  TextPainter painterOf(BuildContext context) {
    final textOverflow = _getTextOverflow(
      context,
      maxLines: maxLines,
      ellipsis: ellipsis,
    );

    return TextPainter(
      text: _mapToStandardTree(
        context,
        text: text,
        data: data,
        style: style,
        color: color,
      ),
      ellipsis: switch (textOverflow) {
        TextOverflow.ellipsis => _ellipsisThreeDots,
        _ => null,
      },
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      textScaler: MediaQuery.textScalerOf(context),
      textDirection: Directionality.of(context),
      textWidthBasis: textWidthBasis,
    );
  }

  static TextSpan _mapToStandardTree(
    BuildContext context, {
    required String? text,
    required List<AppInlineSpan> data,
    required AppTextStyle style,
    required AppColor? color,
  }) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    final effectiveTextStyle = defaultTextStyle.style.merge(style);
    final boldText = MediaQuery.boldTextOf(context);

    final children = data
        .map((span) => span.buildSpan(style.textTransform))
        .toList();

    const boldWeight = FontWeight.bold;

    return TextSpan(
      text: switch (text) {
        final text? => style.textTransform.transform(text),
        _ => null,
      },
      style: effectiveTextStyle.copyWith(
        color: color,
        fontWeight: boldText
            ? switch (effectiveTextStyle.fontWeight) {
                final weight? when weight.value >= boldWeight.value => weight,
                _ => boldWeight,
              }
            : null,
      ),
      children: switch (children.length) {
        > 0 => children,
        _ => null,
      },
    );
  }

  static TextOverflow? _getTextOverflow(
    BuildContext context, {
    required int? maxLines,
    required bool ellipsis,
  }) {
    final defaultTextStyle = DefaultTextStyle.of(context);

    final effectiveMaxLines = maxLines ?? defaultTextStyle.maxLines;
    return switch (ellipsis) {
      true => switch (effectiveMaxLines) {
        final _? => TextOverflow.ellipsis,
        null => null,
      },
      false => TextOverflow.clip,
    };
  }

  @override
  _AppTextState createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  @override
  void initState() {
    super.initState();
    for (final span in widget.data) {
      span.init();
    }
  }

  @override
  void didUpdateWidget(AppText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      for (final span in oldWidget.data) {
        span.dispose();
      }
      for (final span in widget.data) {
        span.init();
      }
    }
  }

  @override
  void dispose() {
    for (final span in widget.data) {
      span.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    final span = AppText._mapToStandardTree(
      context,
      text: widget.text,
      data: widget.data,
      style: widget.style,
      color: widget.color,
    );
    final effectiveMaxLines = widget.maxLines ?? defaultTextStyle.maxLines;

    final textOverflow = AppText._getTextOverflow(
      context,
      maxLines: widget.maxLines,
      ellipsis: widget.ellipsis,
    );

    return Text.rich(
      span,
      textAlign: widget.textAlign,
      maxLines: effectiveMaxLines,
      overflow: textOverflow,
      textWidthBasis: widget.textWidthBasis,
    );
  }
}
