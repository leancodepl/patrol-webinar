import 'dart:math' as math;
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Rotates given `point` around `origin` by `angle` in radians.
@internal
Offset rotatePoint(Offset point, double angle, Offset origin) {
  final radians = angle;
  final cos = math.cos(radians);
  final sin = math.sin(radians);

  return Offset(
    cos * (point.dx - origin.dx) - sin * (point.dy - origin.dy) + origin.dx,
    sin * (point.dx - origin.dx) + cos * (point.dy - origin.dy) + origin.dy,
  );
}

extension RectGeometryExtension on Rect {
  /// Returns a rect that is translated to be contained within another rect.
  Rect constrainWithin(Rect rect) {
    var constrainedRect = this;
    if (left < rect.left) {
      final dx = rect.left - left;
      constrainedRect = constrainedRect.translate(dx, 0);
    }

    if (right > rect.right) {
      final dx = rect.right - right;
      constrainedRect = constrainedRect.translate(dx, 0);
    }

    if (top < rect.top) {
      final dy = rect.top - top;
      constrainedRect = constrainedRect.translate(0, dy);
    }

    if (bottom > rect.bottom) {
      final dy = rect.bottom - bottom;
      constrainedRect = constrainedRect.translate(0, dy);
    }

    return constrainedRect;
  }

  /// Returns true if this rect contains the given rect.
  bool containsRect(Rect rect) {
    return left <= rect.left &&
        right >= rect.right &&
        top <= rect.top &&
        bottom >= rect.bottom;
  }

  /// Returns true if this rect intersects with the given rect.
  bool intersectsRect(Rect rect) {
    return left <= rect.right &&
        right >= rect.left &&
        top <= rect.bottom &&
        bottom >= rect.top;
  }
}

@internal
class LineSegment1 with EquatableMixin {
  LineSegment1(this.start, this.end);

  factory LineSegment1.fromCenter(double center, double length) {
    return LineSegment1(center - length / 2, center + length / 2);
  }

  final double start;
  final double end;

  double get length => end - start;

  double get center => (start + end) / 2;

  @override
  List<Object?> get props => [start, end];

  @override
  String toString() => '($start, $end)';
}
