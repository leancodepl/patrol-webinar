// We need these Material classes as base classes for our custom DS classes
// ignore_for_file: app_lint/use_design_system_item_AppTextStyle, app_lint/use_design_system_item_AppTextSpan, app_lint/use_design_system_item_AppWidgetSpan, app_lint/use_design_system_item_AppDefaultTextStyle

import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/widgets/text/inline_span.dart';
import 'package:flutter/material.dart' show SelectableText;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// A selectable text widget that uses material's `SelectableText` under the
/// hood.
///
/// Text selection is achieved via underlying readonly `EditableText` widget.
/// This unfortunately may create a few shortcomings. One of which is the
/// fact that effective text height and baseline are modified. Hence
/// `AppSelectableText` will not correspond visually to `AppText`. This needs
/// to be taken into account when using these two widgets, especially
/// where one is next to the other.
class AppSelectableText extends StatefulWidget {
  const AppSelectableText(
    String this.text, {
    super.key,
    required this.style,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : data = const [];

  const AppSelectableText.rich(
    this.data, {
    super.key,
    required this.style,
    this.color,
    this.textAlign,
    this.maxLines,
  }) : text = null;

  final String? text;
  final List<AppTextSpan> data;
  final AppTextStyle style;
  final AppColor? color;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  _AppSelectableTextState createState() => _AppSelectableTextState();
}

class _AppSelectableTextState extends State<AppSelectableText> {
  @override
  void initState() {
    super.initState();
    for (final span in widget.data) {
      span.init();
    }
  }

  @override
  void didUpdateWidget(AppSelectableText oldWidget) {
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

  double _getBaseline(BuildContext context) {
    final painter = TextPainter(
      text: TextSpan(text: 'Example Text', style: widget.style),
      textScaler: MediaQuery.textScalerOf(context),
      textDirection: TextDirection.ltr,
    )..layout();

    return painter.computeDistanceToActualBaseline(TextBaseline.alphabetic);
  }

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    final span = _mapToStandardTree(context);
    final effectiveMaxLines = widget.maxLines ?? defaultTextStyle.maxLines;

    return _NormalizeBaseline(
      baseline: _getBaseline(context),
      child: SelectableText.rich(
        span,
        textAlign: widget.textAlign,
        maxLines: effectiveMaxLines,
      ),
    );
  }

  TextSpan _mapToStandardTree(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    final effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    final boldText = MediaQuery.boldTextOf(context);
    final children = widget.data
        .map((span) => span.buildSpan(widget.style.textTransform))
        .toList();
    const boldWeight = FontWeight.bold;

    return TextSpan(
      text: switch (widget.text) {
        final text? => widget.style.textTransform.transform(text),
        _ => null,
      },
      style: effectiveTextStyle.copyWith(
        color: widget.color,
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
}

class _NormalizeBaseline extends SingleChildRenderObjectWidget {
  const _NormalizeBaseline({required this.baseline, super.child});

  final double baseline;

  @override
  _RenderNormalizeBaseline createRenderObject(BuildContext context) {
    return _RenderNormalizeBaseline(baseline: baseline);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderNormalizeBaseline renderObject,
  ) {
    renderObject.baseline = baseline;
  }
}

class _RenderNormalizeBaseline extends RenderShiftedBox {
  _RenderNormalizeBaseline({RenderBox? child, required double baseline})
    : _baseline = baseline,
      super(child);

  double get baseline => _baseline;
  double _baseline;

  set baseline(double value) {
    if (_baseline == value) {
      return;
    }
    _baseline = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final size = (child?..layout(constraints, parentUsesSize: true))?.size;

    if (size == null) {
      this.size = constraints.smallest;
      return;
    }

    this.size = size;

    final childBaseline =
        child?.getDistanceToBaseline(TextBaseline.alphabetic) ?? baseline;
    final baselineCorrection = baseline - childBaseline;
    (child!.parentData! as BoxParentData).offset = Offset(
      0,
      baselineCorrection,
    );

    return;
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    return this.baseline;
  }
}
