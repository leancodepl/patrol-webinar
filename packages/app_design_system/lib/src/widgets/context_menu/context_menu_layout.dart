part of 'context_menu.dart';

const _maxContextMenuWidthFactor = 0.6;

class _RangeOnAxis {
  const _RangeOnAxis({required this.start, required this.end});

  final double start;
  final double end;

  double get length => end - start;
}

/// A class used to calculate context menu container constraint on one axis
/// based on several parameters.
class _ContextMenuContainerAxisAnchorData {
  const _ContextMenuContainerAxisAnchorData({
    required this.viewbox,
    required this.target,
    required this.targetAxisAlignment,
    required this.menuAxisAlignment,
  });

  /// Scene for the context menu containers that takes safe area into account
  final _RangeOnAxis viewbox;

  /// Target rect side on given axis
  final _RangeOnAxis target;

  /// The reference point on the target element on given axis
  final double targetAxisAlignment;

  /// The reference point on the menu element on given axis
  final double menuAxisAlignment;

  _ContextMenuContainerAxisAnchorData get opposite =>
      _ContextMenuContainerAxisAnchorData(
        viewbox: viewbox,
        target: target,
        targetAxisAlignment: -targetAxisAlignment,
        menuAxisAlignment: -menuAxisAlignment,
      );

  bool get shouldCalculateFromStart {
    return target.start + (targetAxisAlignment + 1) * target.length / 2 <
        viewbox.length * (menuAxisAlignment + 1);
  }

  /// Calculates target's max length on given axis
  double targetMaxLength() {
    if (shouldCalculateFromStart) {
      final fromStartToAnchor =
          target.start -
          viewbox.start +
          (targetAxisAlignment + 1) * target.length / 2;

      if (menuAxisAlignment == -1) {
        return viewbox.length;
      }

      final targetAbsDifference =
          2 * fromStartToAnchor / (menuAxisAlignment + 1);

      return targetAbsDifference;
    } else {
      final fromEndToAnchor =
          viewbox.end -
          target.end +
          (1 - targetAxisAlignment) * target.length / 2;

      if (menuAxisAlignment == 1) {
        return viewbox.length;
      }

      final targetAbsDifference = 2 * fromEndToAnchor / (1 - menuAxisAlignment);

      return targetAbsDifference;
    }
  }
}

class _ContextMenuLayoutDelegate extends BoxyDelegate {
  _ContextMenuLayoutDelegate({
    required this.anchor,
    required this.scaleAnimationAlignment,
    required this.safeAreaPadding,
    required this.targetRect,
  });

  final _ContextMenuAnchor anchor;
  final ValueNotifier<Alignment> scaleAnimationAlignment;
  final EdgeInsets safeAreaPadding;
  final Rect targetRect;

  final _contextMenuAdditionalPadding = EdgeInsets.symmetric(
    horizontal: AppSpacings.s16.value,
  );

  @override
  Size layout() {
    final child = children.first;
    final viewbox = (safeAreaPadding + _contextMenuAdditionalPadding)
        .deflateRect(Offset.zero & constraints.biggest);

    var maxChildSizeBasedOnViewbox = Size(
      constraints.maxWidth * _maxContextMenuWidthFactor,
      constraints.maxHeight,
    );

    maxChildSizeBasedOnViewbox = Size(
      min(maxChildSizeBasedOnViewbox.width, viewbox.width),
      min(maxChildSizeBasedOnViewbox.height, viewbox.height),
    );

    final dataHorizontal = _ContextMenuContainerAxisAnchorData(
      viewbox: _RangeOnAxis(start: viewbox.left, end: viewbox.right),
      target: _RangeOnAxis(start: targetRect.left, end: targetRect.right),
      targetAxisAlignment: anchor.target.x,
      menuAxisAlignment: anchor.menu.x,
    );

    final dataVertical = _ContextMenuContainerAxisAnchorData(
      viewbox: _RangeOnAxis(start: viewbox.top, end: viewbox.bottom),
      target: _RangeOnAxis(start: targetRect.top, end: targetRect.bottom),
      targetAxisAlignment: anchor.target.y,
      menuAxisAlignment: anchor.menu.y,
    );

    final intrinsicChildWidth = child.render.getMinIntrinsicWidth(
      constraints.maxHeight,
    );

    final intrinsicChildHeight = child.render
        .getDryLayout(BoxConstraints(maxWidth: intrinsicChildWidth))
        .height;

    final maxWidthFromPreferred = dataHorizontal.targetMaxLength();
    final maxWidthFromOpposite = dataHorizontal.opposite.targetMaxLength();

    final maxHeightFromPreferred = dataVertical.targetMaxLength();
    final maxHeightFromOpposite = dataVertical.opposite.targetMaxLength();

    var targetX = anchor.target.x;
    var menuX = anchor.menu.x;

    var targetY = anchor.target.y;
    var menuY = anchor.menu.y;

    var maxChildWidth = maxWidthFromPreferred;
    var maxChildHeight = maxHeightFromPreferred;

    if (maxWidthFromPreferred < intrinsicChildWidth &&
            maxWidthFromPreferred < maxWidthFromOpposite ||
        maxWidthFromPreferred <= 0) {
      targetX = -targetX;
      menuX = -menuX;
      maxChildWidth = maxWidthFromOpposite;
    }

    if (maxHeightFromPreferred < intrinsicChildHeight &&
            maxHeightFromPreferred < maxHeightFromOpposite ||
        maxHeightFromPreferred <= 0) {
      targetY = -targetY;
      menuY = -menuY;
      maxChildHeight = maxHeightFromOpposite;
    }

    if (maxChildWidth <= 0 ||
        maxChildWidth < intrinsicChildWidth ||
        maxChildWidth > maxChildSizeBasedOnViewbox.width) {
      maxChildWidth = maxChildSizeBasedOnViewbox.width;
    }

    if (maxChildHeight <= 0 ||
        maxChildHeight > maxChildSizeBasedOnViewbox.height) {
      maxChildHeight = maxChildSizeBasedOnViewbox.height;
    }

    scaleAnimationAlignment.value = Alignment(menuX, menuY);

    child.layout(
      BoxConstraints(maxWidth: maxChildWidth, maxHeight: maxChildHeight),
    );

    final anchorPosition =
        targetRect.center +
        Offset(
              targetRect.size.width * targetX,
              targetRect.size.height * targetY,
            ) /
            2;

    var childPosition =
        anchorPosition -
        Offset(
              child.size.width * (1 + menuX),
              child.size.height * (1 + menuY),
            ) /
            2;

    final childPositionContainingRect = EdgeInsets.only(
      bottom: child.size.height,
      right: child.size.width,
    ).deflateRect(viewbox);

    childPosition = Offset(
      max(childPosition.dx, childPositionContainingRect.left),
      max(childPosition.dy, childPositionContainingRect.top),
    );

    childPosition = Offset(
      min(childPosition.dx, childPositionContainingRect.right),
      min(childPosition.dy, childPositionContainingRect.bottom),
    );

    child.position(childPosition);

    return constraints.biggest;
  }

  @override
  bool shouldRelayout(_ContextMenuLayoutDelegate oldDelegate) {
    return anchor != oldDelegate.anchor ||
        scaleAnimationAlignment != oldDelegate.scaleAnimationAlignment ||
        safeAreaPadding != oldDelegate.safeAreaPadding ||
        targetRect != oldDelegate.targetRect;
  }
}
