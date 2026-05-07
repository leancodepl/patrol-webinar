import 'package:boxy/boxy.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Shifts child widget to match provided baseline.
///
/// For some reason, the baseline of the Material TextInput widget shifts
/// slightly, making it difficult to align side-by-side text widgets. As a
/// result, it's challenging to ensure that the text within the TextInput
/// shares the same baseline as other text in the row.
@internal
class NormalizeInputBaseline extends StatelessWidget {
  const NormalizeInputBaseline({
    super.key,
    required this.baseline,
    required this.child,
  });

  final double baseline;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomBoxy(
      delegate: _LayoutDelegate(baseline: baseline),
      children: [child],
    );
  }
}

class _LayoutDelegate extends BoxyDelegate {
  _LayoutDelegate({required this.baseline});

  final double baseline;

  BoxyChild get textField => children.first;

  @override
  Size layout() {
    textField.layout(constraints);

    final textFieldBaseline =
        textField.render.getDistanceToBaseline(TextBaseline.alphabetic) ??
        baseline;

    final offset = Offset(0, baseline - textFieldBaseline);

    textField.position(offset);

    return textField.size;
  }

  @override
  double minIntrinsicHeight(double width) {
    return textField.render.getMinIntrinsicHeight(width);
  }

  @override
  double maxIntrinsicHeight(double width) {
    return minIntrinsicHeight(width);
  }

  @override
  double minIntrinsicWidth(double height) {
    return textField.render.getMinIntrinsicWidth(height);
  }

  @override
  double maxIntrinsicWidth(double height) {
    return minIntrinsicWidth(height);
  }
}
