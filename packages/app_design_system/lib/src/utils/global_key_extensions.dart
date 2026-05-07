import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
extension GlobalKeyExtension on GlobalKey {
  /// Returns the result of [getGlobalRect]. If any exception is thrown by
  /// [getGlobalRect], it will be caught and `null` will be returned.
  Rect? tryGetGlobalRect({RenderObject? ancestor}) {
    try {
      return getGlobalRect(ancestor: ancestor);
    } catch (_) {
      return null;
    }
  }

  /// Returns the global rect of the widget represented by this global key.
  ///
  /// For RenderBox case returns laid out rect.
  ///
  /// For RenderSliver case returns only the visible portion of rect with
  /// paintOffset applied.
  ///
  /// Will return `null` if the widget is not yet laid out or if the widget is
  /// not a [RenderBox] or [RenderSliver].
  ///
  /// Will throw an error is the render object is accessed at the wrong time.
  Rect? getGlobalRect({RenderObject? ancestor}) {
    final context = currentContext;
    final renderObject = context?.findRenderObject();

    return switch (renderObject) {
      final RenderBox box => _getGlobalRectForRenderBox(
        box,
        ancestor: ancestor,
      ),
      final RenderSliver sliver => _getGlobalRectForRenderSliver(
        sliver,
        ancestor: ancestor,
      ),
      _ => throw UnsupportedError(
        'Unsupported render object of type ${renderObject.runtimeType} '
        'passed to getGlobalRect',
      ),
    };
  }

  Rect? _getGlobalRectForRenderBox(
    RenderBox renderBox, {
    RenderObject? ancestor,
  }) {
    if (!renderBox.hasSize) {
      return null;
    }

    final topLeft = renderBox.localToGlobal(Offset.zero, ancestor: ancestor);
    final bottomRight = renderBox.size.bottomRight(topLeft);

    final rect = Rect.fromPoints(topLeft, bottomRight);

    return rect;
  }

  Rect? _getGlobalRectForRenderSliver(
    RenderSliver renderSliver, {
    RenderObject? ancestor,
  }) {
    final context = currentContext;
    final renderViewport = context!
        .findAncestorRenderObjectOfType<RenderViewport>();
    final renderObjectParentData = renderSliver.parentData;

    if (renderViewport == null ||
        renderObjectParentData is! SliverPhysicalParentData) {
      return null;
    }

    final topLeft = renderViewport.localToGlobal(
      renderObjectParentData.paintOffset,
      ancestor: ancestor,
    );

    return topLeft & renderSliver.paintBounds.size;
  }
}
