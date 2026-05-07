import 'dart:math';

import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/geometry.dart';

import 'package:app_design_system/src/utils/global_key_extensions.dart';
import 'package:app_design_system/src/widgets/text/text_widget.dart';
import 'package:app_design_system/src/widgets/tooltip/tooltip_context_extension.dart';
import 'package:app_design_system/src/widgets/tooltip/tooltip_controller.dart';
import 'package:app_design_system/src/widgets/tooltip/tooltip_registry_controller.dart';
import 'package:boxy/boxy.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_portal/enhanced_composited_transform.dart';
import 'package:flutter_portal/flutter_portal.dart';

part 'tooltip_arrow.dart';
part 'tooltip_balloon.dart';
part 'tooltip_registry.dart';
part 'tooltip_gesture_detector.dart';
part 'tooltip_transition.dart';
part 'tooltip_render_controller.dart';

const _arrowSize = Size.square(6);

const _defaultMargin = EdgeInsetsDirectional.all(16);
const _defaultSpacing = 8.0;

/// Directionally-aware alignment of the tooltip in relation to the target.
enum AppTooltipAlignmentDirectional {
  start,
  top,
  end,
  bottom;

  _TooltipAlignment _resolve(TextDirection textDirection) {
    return switch (this) {
      start => switch (textDirection) {
        TextDirection.ltr => _TooltipAlignment.left,
        TextDirection.rtl => _TooltipAlignment.right,
      },
      top => _TooltipAlignment.top,
      end => switch (textDirection) {
        TextDirection.ltr => _TooltipAlignment.right,
        TextDirection.rtl => _TooltipAlignment.left,
      },
      bottom => _TooltipAlignment.bottom,
    };
  }
}

/// Alignment of the tooltip in relation to the target.
enum _TooltipAlignment {
  left,
  top,
  right,
  bottom;

  _TooltipAlignment get opposite {
    return switch (this) {
      left => right,
      top => bottom,
      right => left,
      bottom => top,
    };
  }

  double get angle {
    return switch (this) {
      left => pi * 3 / 2,
      top => 0,
      right => pi / 2,
      bottom => pi,
    };
  }

  Anchor getAnchor(TextDirection textDirection) {
    final follower = switch (this) {
      left => Alignment.centerRight,
      top => Alignment.bottomCenter,
      right => Alignment.centerLeft,
      bottom => Alignment.topCenter,
    };

    final target = switch (this) {
      left => Alignment.centerLeft,
      top => Alignment.topCenter,
      right => Alignment.centerRight,
      bottom => Alignment.bottomCenter,
    };

    return Aligned(
      shiftToWithinBound: AxisFlag(x: target.x == 0, y: target.y == 0),
      follower: follower,
      target: target,
    );
  }

  Alignment toAlignment() => switch (this) {
    left => Alignment.centerLeft,
    top => Alignment.topCenter,
    right => Alignment.centerRight,
    bottom => Alignment.bottomCenter,
  };

  bool get isHorizontal => [left, right].contains(this);

  bool get isVertical => [top, bottom].contains(this);
}

enum AppTooltipType {
  info,
  success,
  warning,
  danger,
  inverse;

  AppColor getBorderColor(AppColors colors) {
    return switch (this) {
      AppTooltipType.info => colors.foregroundInfoQuaternary,
      AppTooltipType.success => colors.foregroundSuccessQuaternary,
      AppTooltipType.warning => colors.foregroundWarningQuaternary,
      AppTooltipType.danger => colors.foregroundDangerQuaternary,
      AppTooltipType.inverse => colors.foregroundDefaultQuaternary,
    };
  }

  AppColor getBackgroundColor(AppColors colors) {
    return switch (this) {
      AppTooltipType.info => colors.backgroundInfoTertiary,
      AppTooltipType.success => colors.backgroundSuccessTertiary,
      AppTooltipType.warning => colors.backgroundWarningTertiary,
      AppTooltipType.danger => colors.backgroundDangerTertiary,
      AppTooltipType.inverse => colors.backgroundInversePrimary,
    };
  }

  AppColor getTextColor(AppColors colors) {
    return switch (this) {
      AppTooltipType.info => colors.foregroundInfoPrimary,
      AppTooltipType.success => colors.foregroundSuccessPrimary,
      AppTooltipType.warning => colors.foregroundWarningPrimary,
      AppTooltipType.danger => colors.foregroundDangerPrimary,
      AppTooltipType.inverse => colors.foregroundInversePrimary,
    };
  }
}

/// Constraints that mirror the target in order to keep the tooltip centered
/// in relation to the target.
class _MirrorConstraints extends EnhancedCompositedTransformAligned
    implements Anchor, EnhancedCompositedTransformAnchor {
  const _MirrorConstraints()
    : super(follower: Alignment.center, target: Alignment.center);

  @override
  BoxConstraints getFollowerConstraints({
    required Size targetSize,
    required BoxConstraints theaterConstraints,
  }) {
    return BoxConstraints.loose(targetSize);
  }

  @override
  Offset getFollowerOffset({
    required Size followerSize,
    required Size targetSize,
    required Rect theaterRect,
  }) {
    return Offset.zero;
  }
}

/// Behavior of the declarative tooltip which tells which gesture should be
/// used to show/hide the tooltip.
enum AppTooltipBehavior { tap, longPress }

/// A tooltip that displays a message in relation to a target.
///
/// Must be the descendant of [AppTooltipRegistry].
///
/// There's a lot happening in this widget, which is complicated. It is mostly
/// because we have to rely on post frame callback to update the metrics.
///
/// We need the global position of the target and the ancestor
/// `AppTooltipRegistry` to calculate everything needed to layout and position
/// the tooltip correctly. We have to do this with a post frame callback
/// because the position of the target and the registry cannot be read during
/// the layout of the registry (thx flutter). We save required rects in
/// `TooltipMetrics` which we pass further to the layout delegate.
class AppTooltip extends StatefulWidget {
  /// Creates a tooltip without a specific tag.
  ///
  /// This is useful when you want to show/hide with a tap/long press without
  /// having to work with tag and imperatively calling tooltip methods such as
  /// `context.showTooltip`.
  const AppTooltip({
    super.key,
    required this.text,
    this.alignment = AppTooltipAlignmentDirectional.top,
    required this.child,
    required this.type,
    this.margin = _defaultMargin,
    this.gap = _defaultSpacing,
    AppTooltipBehavior this.behavior = AppTooltipBehavior.tap,
    this.hideByOutsideGesture = true,
    this.enabled = true,
  }) : tag = null;

  /// Creates a tooltip with a specific tag.
  ///
  /// This is useful when you want to show/hide a tooltip with a specific
  /// button. You can display a tooltip by calling `context.showTooltip(...)`
  /// method provided that the tooltip with the given tag is registered in the
  /// `AppTooltipRegistry` that is an ancestor of given context. This will
  /// show the tooltip with the given tag.
  const AppTooltip.tag({
    super.key,
    required Object this.tag,
    required this.text,
    this.alignment = AppTooltipAlignmentDirectional.top,
    required this.child,
    required this.type,
    this.margin = _defaultMargin,
    this.gap = _defaultSpacing,
    this.hideByOutsideGesture = true,
  }) : behavior = null,
       enabled = true;

  static const _arrowPortalLabel = PortalLabel('tooltipArrowLabel');
  static const _balloonPortalLabel = PortalLabel('tooltipBalloonLabel');

  /// Unique identifier used to register the tooltip that is a descendant of
  /// the [AppTooltipRegistry]. Used to show/hide the tooltip imperatively with
  /// `context.showTooltip(...)` and `context.hideTooltip(...)` methods.
  final Object? tag;

  /// Text to display in the tooltip.
  final String text;

  /// Widget that is the target of the tooltip.
  final Widget child;

  /// Determines the text direction-aware alignment of the tooltip in relation
  /// to the target.
  final AppTooltipAlignmentDirectional alignment;

  /// Type of the tooltip.
  final AppTooltipType type;

  /// Margin around the tooltip ballon which separates the tooltip from the
  /// edges of the screen (or more precisely tooltip registry).
  final EdgeInsetsDirectional margin;

  /// Gap between the tooltip and the target.
  final double gap;

  /// Behavior of the tooltip which tells which gesture should be used to
  /// show/hide the tooltip.
  final AppTooltipBehavior? behavior;

  /// Whether the tooltip should be hidden by tapping outside of it.
  final bool hideByOutsideGesture;

  /// Whether the tooltip can be shown.
  final bool enabled;

  @override
  State<AppTooltip> createState() => _AppTooltipState();
}

class _AppTooltipState extends State<AppTooltip> {
  Object get _effectiveTag => widget.tag ?? _fallbackTag;

  Object? _oldTag;
  final _fallbackTag = Object();

  final _targetKey = GlobalKey();
  final _controller = TooltipController();

  TooltipRegistryController? _registryController;

  ScrollNotificationObserverState? _scrollNotificationObserver;

  final _renderController = _TooltipRenderController();

  var _metricsDirty = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(AppTooltip oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateOldTag();
    if (_oldTag != _effectiveTag) {
      if (_oldTag case final oldTag?) {
        _registryController?.unregister(oldTag);
      }
      _registryController?.register(_effectiveTag, _controller);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final registryController = TooltipRegistryController.of(context);

    if (_registryController != registryController) {
      _registryController?.unregister(_effectiveTag);
      _registryController = registryController
        ..register(_effectiveTag, _controller);
    }

    final scrollNotificationObserver = ScrollNotificationObserver.of(context);

    if (_scrollNotificationObserver != scrollNotificationObserver) {
      _scrollNotificationObserver?.removeListener(_onScrollNotification);
      _scrollNotificationObserver = scrollNotificationObserver
        ..addListener(_onScrollNotification);
    }

    _metricsDirty = true;
  }

  @override
  void dispose() {
    _renderController.dispose();
    _registryController?.unregister(_effectiveTag);
    _scrollNotificationObserver?.removeListener(_onScrollNotification);
    _controller
      ..removeListener(_onControllerChanged)
      ..dispose();
    super.dispose();
  }

  void _updateOldTag() {
    _oldTag = _effectiveTag;
  }

  void _updateMetrics() {
    final registryRect = _registryController?.registryKey.tryGetGlobalRect();
    final targetRect = _targetKey.tryGetGlobalRect();

    if (registryRect == null || targetRect == null) {
      return;
    }

    final metrics = TooltipMetrics(
      registryRect: registryRect,
      targetRect: targetRect,
    );

    _controller.updateMetrics(metrics);
  }

  void _scheduleUpdateMetrics() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateMetrics();
    });
  }

  void _onControllerChanged() {
    setState(() {});
  }

  void _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      _updateMetrics();
      _metricsDirty = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    final alignment = widget.alignment._resolve(textDirection);

    if (_metricsDirty) {
      _scheduleUpdateMetrics();
      _metricsDirty = false;
    }

    final child = KeyedSubtree(
      key: _targetKey,
      child: _TooltipGestureDetector(
        tag: _effectiveTag,
        behavior: widget.behavior,
        showByInsideGesture: widget.enabled,
        hideByOutsideGesture: widget.hideByOutsideGesture,
        child: widget.child,
      ),
    );

    return CustomBoxy(
      delegate: _TooltipBalloonDelegate(
        alignment: alignment,
        metrics: _controller.metrics,
        renderController: _renderController,
      ),
      children: [
        BoxyId(
          id: _arrowId,
          child: _TooltipArrow(
            type: widget.type,
            gap: widget.gap,
            margin: widget.margin,
            renderController: _renderController,
            visible: _controller.isVisible,
            tooltipAlignment: alignment,
          ),
        ),
        BoxyId(
          id: _balloonId,
          child: _TooltipBalloon(
            tag: _effectiveTag,
            text: widget.text,
            type: widget.type,
            margin: widget.margin,
            gap: widget.gap,
            tooltipAlignment: _renderController.alignment.value ?? alignment,
            renderController: _renderController,
            visible: _controller.isVisible,
            hideByOutsideTap: widget.hideByOutsideGesture,
          ),
        ),
        BoxyId(id: _targetId, child: child),
      ],
    );
  }
}

const _targetId = #tooltipTarget;
const _balloonId = #tooltipBalloon;
const _arrowId = #tooltipArrow;

class _TooltipBalloonDelegate extends BoxyDelegate {
  _TooltipBalloonDelegate({
    required this.alignment,
    required this.metrics,
    required this.renderController,
  });

  final _TooltipAlignment alignment;
  final TooltipMetrics? metrics;
  final _TooltipRenderController renderController;

  void _updatePostFrame(VoidCallback callback) =>
      WidgetsBinding.instance.addPostFrameCallback((_) => callback());

  @override
  Size layout() {
    final target = getChild(_targetId);
    final balloon = getChild(_balloonId);
    final arrow = getChild(_arrowId);

    target
      ..layout(constraints)
      ..position(Offset.zero);

    // If we have metrics, we can calculate the optimal alignment and layout
    // the balloon and arrow.
    if (metrics case final metrics?) {
      final drySize = balloon.render.getDryLayout(
        BoxConstraints.loose(metrics.registryRect.size),
      );

      // Calculate the optimal alignment of the tooltip in relation to the
      // target. If preferred alignment doesn't fit, we choose the one that
      // gives the most area to the balloon.
      final optimalAlignment = _getOptimalAlignment(
        preferredAlignment: alignment,
        targetRect: metrics.shiftedTargetRect,
        registryRect: metrics.registryRect,
        balloonDrySize: drySize,
      );

      // Notify the listeners about the optimal alignment so that we can update
      // the direction of the arrow.
      _updatePostFrame(() {
        renderController
          ..updateAlignment(optimalAlignment)
          ..updateArrowAlignment(-optimalAlignment.toAlignment());
      });

      // Calculate the constraints for the balloon based on the optimal
      // alignment.
      final balloonConstraints = _getConstraints(
        alignment: optimalAlignment,
        targetRect: metrics.shiftedTargetRect,
        registryRect: metrics.registryRect,
      );

      // Layout the balloon and arrow.
      balloon.layout(balloonConstraints);
      arrow.layout(constraints);

      // Calculate the offset of the arrow in relation to the balloon.
      final arrowOffset = _getOffset(
        alignment: optimalAlignment,
        targetSize: target.size,
        followerSize: arrow.size,
      );

      // Position the arrow.
      arrow.position(arrowOffset);

      // Calculate the relative position of the portal in relation to the
      // target. This essentially means we calculate position of
      // `AppTooltipRegistry` in relation to the target.
      final relativePortalRect = metrics.registryRect.translate(
        -metrics.targetRect.left,
        -metrics.targetRect.top,
      );

      // Calculate the shifted offset of the balloon in relation to the portal.
      final shiftedOffset = _getShiftedOffset(
        registryRect: relativePortalRect,
        balloonSize: balloon.size,
        offset: _getOffset(
          alignment: optimalAlignment,
          targetSize: target.size,
          followerSize: balloon.size,
        ),
      );

      balloon.position(shiftedOffset);

      final shiftedArrowOffset = _getShiftedArrowOffset(
        arrowRect: arrow.rect,
        balloonRect: balloon.rect,
      );

      arrow.position(shiftedArrowOffset);

      // Notify the listeners about the alignment of the toggle animation so
      // that we can update the direction of the arrow.
      final vector =
          arrow.rect.center +
          Offset(
            -optimalAlignment.toAlignment().x * arrow.size.width / 2,
            -optimalAlignment.toAlignment().y * arrow.size.height / 2,
          ) -
          balloon.rect.topLeft;

      final animationAlignment = Alignment(
        -1 + 2 * vector.dx / balloon.size.width,
        -1 + 2 * vector.dy / balloon.size.height,
      );

      final outOfBounds = _isOutOfBounds(
        arrowRect: arrow.rect,
        balloonRect: balloon.rect,
        targetRect: target.rect,
      );

      _updatePostFrame(() {
        renderController
          ..updateBalloonAlignment(animationAlignment)
          ..updateOutOfBounds(outOfBounds);
      });
    } else {
      _updatePostFrame(() {
        renderController
          ..updateAlignment(null)
          ..updateArrowAlignment(null)
          ..updateBalloonAlignment(null)
          ..updateOutOfBounds(false);
      });

      balloon
        ..layout(constraints)
        ..ignore();
      arrow
        ..layout(constraints)
        ..ignore();
    }

    return target.size;
  }

  Offset _getOffset({
    required _TooltipAlignment alignment,
    required Size targetSize,
    required Size followerSize,
  }) {
    return switch (alignment) {
      _TooltipAlignment.left => Offset(
        -followerSize.width,
        targetSize.height / 2 - followerSize.height / 2,
      ),
      _TooltipAlignment.top => Offset(
        targetSize.width / 2 - followerSize.width / 2,
        -followerSize.height,
      ),
      _TooltipAlignment.right => Offset(
        targetSize.width,
        targetSize.height / 2 - followerSize.height / 2,
      ),
      _TooltipAlignment.bottom => Offset(
        targetSize.width / 2 - followerSize.width / 2,
        targetSize.height,
      ),
    };
  }

  Offset _getShiftedOffset({
    required Offset offset,
    required Rect registryRect,
    required Size balloonSize,
  }) {
    final left = offset.dx;
    final top = offset.dy;
    final right = left + balloonSize.width;
    final bottom = top + balloonSize.height;

    var dx = offset.dx;
    var dy = offset.dy;

    if (alignment.isVertical) {
      if (left < registryRect.left) {
        dx += registryRect.left - left;
      } else if (right > registryRect.right) {
        dx -= right - registryRect.right;
      }
    }

    if (alignment.isHorizontal) {
      if (top < registryRect.top) {
        dy += registryRect.top - top;
      } else if (bottom > registryRect.bottom) {
        dy -= bottom - registryRect.bottom;
      }
    }

    return Offset(dx, dy);
  }

  _TooltipAlignment _getOptimalAlignment({
    required _TooltipAlignment preferredAlignment,
    required Rect targetRect,
    required Rect registryRect,
    required Size balloonDrySize,
  }) {
    final constraints = _getConstraints(
      alignment: preferredAlignment,
      targetRect: targetRect,
      registryRect: registryRect,
    );

    final oppositeConstraints = _getConstraints(
      alignment: preferredAlignment.opposite,
      targetRect: targetRect,
      registryRect: registryRect,
    );

    switch (preferredAlignment) {
      case _TooltipAlignment.left || _TooltipAlignment.right:
        final doesFit = balloonDrySize.width < constraints.maxWidth;
        if (doesFit) {
          return preferredAlignment;
        }

        final doesFitOpposite =
            balloonDrySize.width < oppositeConstraints.maxWidth;
        if (doesFitOpposite) {
          return preferredAlignment.opposite;
        }

        if (constraints.maxWidth >= oppositeConstraints.maxWidth) {
          return preferredAlignment;
        }

        return preferredAlignment.opposite;

      case _TooltipAlignment.top || _TooltipAlignment.bottom:
        final doesFit = balloonDrySize.height < constraints.maxHeight;
        if (doesFit) {
          return preferredAlignment;
        }

        final doesFitOpposite =
            balloonDrySize.height < oppositeConstraints.maxHeight;
        if (doesFitOpposite) {
          return preferredAlignment.opposite;
        }

        if (constraints.maxHeight >= oppositeConstraints.maxHeight) {
          return preferredAlignment;
        }

        return preferredAlignment.opposite;
    }
  }

  BoxConstraints _getConstraints({
    required _TooltipAlignment alignment,
    required Rect targetRect,
    required Rect registryRect,
  }) {
    return switch (alignment) {
      _TooltipAlignment.left => BoxConstraints(
        maxWidth: targetRect.left - registryRect.left,
        maxHeight: registryRect.height,
      ),
      _TooltipAlignment.top => BoxConstraints(
        maxWidth: registryRect.width,
        maxHeight: targetRect.top - registryRect.top,
      ),
      _TooltipAlignment.right => BoxConstraints(
        maxWidth: registryRect.right - targetRect.right,
        maxHeight: registryRect.height,
      ),
      _TooltipAlignment.bottom => BoxConstraints(
        maxWidth: registryRect.width,
        maxHeight: registryRect.bottom - targetRect.bottom,
      ),
    };
  }

  Offset _getShiftedArrowOffset({
    required Rect arrowRect,
    required Rect balloonRect,
  }) {
    return arrowRect.constrainWithin(balloonRect).topLeft;
  }

  bool _isOutOfBounds({
    required Rect targetRect,
    required Rect arrowRect,
    required Rect balloonRect,
  }) {
    late final LineSegment1 arrowSegment;
    late final LineSegment1 targetSegment;
    late final LineSegment1 balloonSegment;

    if (alignment.isVertical) {
      arrowSegment = LineSegment1(arrowRect.left, arrowRect.right);
      targetSegment = LineSegment1(targetRect.left, targetRect.right);
      balloonSegment = LineSegment1(balloonRect.left, balloonRect.right);
    } else {
      arrowSegment = LineSegment1(arrowRect.top, arrowRect.bottom);
      targetSegment = LineSegment1(targetRect.top, targetRect.bottom);
      balloonSegment = LineSegment1(balloonRect.top, balloonRect.bottom);
    }

    if (arrowSegment.length > targetSegment.length) {
      final centerArrow = LineSegment1.fromCenter(
        targetSegment.center,
        arrowSegment.length,
      );

      return centerArrow.start < balloonSegment.start ||
          centerArrow.end > balloonSegment.end;
    }

    return arrowSegment.start < targetSegment.start ||
        arrowSegment.end > targetSegment.end;
  }

  @override
  bool shouldRelayout(_TooltipBalloonDelegate oldDelegate) =>
      alignment != oldDelegate.alignment ||
      metrics != oldDelegate.metrics ||
      renderController != oldDelegate.renderController;
}
