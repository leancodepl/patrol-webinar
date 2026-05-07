import 'dart:math' as math;
import 'dart:ui';

import 'package:app_design_system/src/utils/geometry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('rotatePoint', () {
    test('rotates point 90 degrees clockwise around origin', () {
      const point = Offset(1, 0);
      const origin = Offset.zero;
      const angle = -math.pi / 2; // -90 degrees

      final result = rotatePoint(point, angle, origin);

      expect(result.dx, closeTo(0, 0.000001));
      expect(result.dy, closeTo(-1, 0.000001));
    });

    test('rotates point 180 degrees around origin', () {
      const point = Offset(1, 1);
      const origin = Offset.zero;
      const angle = math.pi; // 180 degrees

      final result = rotatePoint(point, angle, origin);

      expect(result.dx, closeTo(-1, 0.000001));
      expect(result.dy, closeTo(-1, 0.000001));
    });

    test('rotates point 90 degrees counterclockwise around origin', () {
      const point = Offset(1, 0);
      const origin = Offset.zero;
      const angle = math.pi / 2; // 90 degrees

      final result = rotatePoint(point, angle, origin);

      expect(result.dx, closeTo(0, 0.000001));
      expect(result.dy, closeTo(1, 0.000001));
    });

    test('rotates point around non-zero origin', () {
      const point = Offset(2, 1);
      const origin = Offset(1, 1);
      const angle = math.pi / 2; // 90 degrees

      final result = rotatePoint(point, angle, origin);

      expect(result.dx, closeTo(1, 0.000001));
      expect(result.dy, closeTo(2, 0.000001));
    });

    test('returns same point when rotating 360 degrees', () {
      const point = Offset(3, 4);
      const origin = Offset(1, 1);
      const angle = math.pi * 2; // 360 degrees

      final result = rotatePoint(point, angle, origin);

      expect(result.dx, closeTo(point.dx, 0.000001));
      expect(result.dy, closeTo(point.dy, 0.000001));
    });

    test('returns same point when rotating 0 degrees', () {
      const point = Offset(3, 4);
      const origin = Offset(1, 1);
      const angle = 0.0;

      final result = rotatePoint(point, angle, origin);

      expect(result.dx, closeTo(point.dx, 0.000001));
      expect(result.dy, closeTo(point.dy, 0.000001));
    });
  });

  group('RectGeometryExtension', () {
    group('constrainWithin', () {
      test('returns same rect when already contained', () {
        const container = Rect.fromLTWH(0, 0, 100, 100);
        const rect = Rect.fromLTWH(25, 25, 50, 50);

        final result = rect.constrainWithin(container);

        expect(result, equals(rect));
      });

      test('constrains rect that extends beyond left boundary', () {
        const container = Rect.fromLTWH(0, 0, 100, 100);
        const rect = Rect.fromLTWH(-10, 25, 50, 50);

        final result = rect.constrainWithin(container);

        expect(result.left, equals(0));
        expect(result.top, equals(25));
        expect(result.width, equals(50));
        expect(result.height, equals(50));
      });

      test('constrains rect that extends beyond right boundary', () {
        const container = Rect.fromLTWH(0, 0, 100, 100);
        const rect = Rect.fromLTWH(60, 25, 50, 50);

        final result = rect.constrainWithin(container);

        expect(result.right, equals(100));
        expect(result.top, equals(25));
        expect(result.width, equals(50));
        expect(result.height, equals(50));
      });

      test('constrains rect that extends beyond top boundary', () {
        const container = Rect.fromLTWH(0, 0, 100, 100);
        const rect = Rect.fromLTWH(25, -10, 50, 50);

        final result = rect.constrainWithin(container);

        expect(result.left, equals(25));
        expect(result.top, equals(0));
        expect(result.width, equals(50));
        expect(result.height, equals(50));
      });

      test('constrains rect that extends beyond bottom boundary', () {
        const container = Rect.fromLTWH(0, 0, 100, 100);
        const rect = Rect.fromLTWH(25, 60, 50, 50);

        final result = rect.constrainWithin(container);

        expect(result.left, equals(25));
        expect(result.bottom, equals(100));
        expect(result.width, equals(50));
        expect(result.height, equals(50));
      });

      test('constrains rect that extends beyond multiple boundaries', () {
        const container = Rect.fromLTWH(0, 0, 100, 100);
        const rect = Rect.fromLTWH(-10, -10, 50, 50);

        final result = rect.constrainWithin(container);

        expect(result.left, equals(0));
        expect(result.top, equals(0));
        expect(result.width, equals(50));
        expect(result.height, equals(50));
      });
    });

    group('containsRect', () {
      test('returns true when rect is fully contained', () {
        const container = Rect.fromLTWH(0, 0, 100, 100);
        const rect = Rect.fromLTWH(25, 25, 50, 50);

        expect(container.containsRect(rect), isTrue);
      });

      test('returns true when rect is exactly the same', () {
        const container = Rect.fromLTWH(0, 0, 100, 100);

        expect(container.containsRect(container), isTrue);
      });

      test('returns false when rect extends beyond left boundary', () {
        const container = Rect.fromLTWH(0, 0, 100, 100);
        const rect = Rect.fromLTWH(-1, 25, 50, 50);

        expect(container.containsRect(rect), isFalse);
      });

      test('returns false when rect extends beyond right boundary', () {
        const container = Rect.fromLTWH(0, 0, 100, 100);
        const rect = Rect.fromLTWH(60, 25, 50, 50);

        expect(container.containsRect(rect), isFalse);
      });

      test('returns false when rect extends beyond top boundary', () {
        const container = Rect.fromLTWH(0, 0, 100, 100);
        const rect = Rect.fromLTWH(25, -1, 50, 50);

        expect(container.containsRect(rect), isFalse);
      });

      test('returns false when rect extends beyond bottom boundary', () {
        const container = Rect.fromLTWH(0, 0, 100, 100);
        const rect = Rect.fromLTWH(25, 60, 50, 50);

        expect(container.containsRect(rect), isFalse);
      });

      test('returns false when rect is larger than container', () {
        const container = Rect.fromLTWH(0, 0, 100, 100);
        const rect = Rect.fromLTWH(-10, -10, 120, 120);

        expect(container.containsRect(rect), isFalse);
      });
    });

    group('intersectsRect', () {
      test('returns true when rects overlap', () {
        const rect1 = Rect.fromLTWH(0, 0, 100, 100);
        const rect2 = Rect.fromLTWH(50, 50, 100, 100);

        expect(rect1.intersectsRect(rect2), isTrue);
        expect(rect2.intersectsRect(rect1), isTrue);
      });

      test('returns true when rect is fully contained', () {
        const rect1 = Rect.fromLTWH(0, 0, 100, 100);
        const rect2 = Rect.fromLTWH(25, 25, 50, 50);

        expect(rect1.intersectsRect(rect2), isTrue);
        expect(rect2.intersectsRect(rect1), isTrue);
      });

      test('returns true when rects share an edge', () {
        const rect1 = Rect.fromLTWH(0, 0, 100, 100);
        const rect2 = Rect.fromLTWH(100, 0, 100, 100);

        expect(rect1.intersectsRect(rect2), isTrue);
        expect(rect2.intersectsRect(rect1), isTrue);
      });

      test('returns false when rects do not intersect', () {
        const rect1 = Rect.fromLTWH(0, 0, 100, 100);
        const rect2 = Rect.fromLTWH(150, 150, 100, 100);

        expect(rect1.intersectsRect(rect2), isFalse);
        expect(rect2.intersectsRect(rect1), isFalse);
      });
    });
  });
}
