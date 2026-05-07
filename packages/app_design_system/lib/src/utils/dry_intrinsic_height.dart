import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Same as `IntrinsicWidth` except that when this widget is instructed
/// to `computeDryLayout()`, it doesn't invoke that on its child, instead
/// it computes the child's intrinsic height.
///
/// This widget is useful in situations where the `child` does not
/// support dry layout, e.g., `TextField` as of 01/02/2021.
@internal
class DryIntrinsicHeight extends SingleChildRenderObjectWidget {
  const DryIntrinsicHeight({super.key, super.child});

  @override
  RenderDryIntrinsicHeightProxy createRenderObject(BuildContext context) =>
      RenderDryIntrinsicHeightProxy();
}

@internal
class RenderDryIntrinsicHeightProxy extends RenderProxyBox {
  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child case final child?) {
      final width = constraints.maxWidth;
      final height = child.computeMinIntrinsicHeight(constraints.maxWidth);
      return Size(width, height);
    } else {
      return Size.zero;
    }
  }
}
