import 'package:app_design_system/app_design_system.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../test_app.dart';

final _surface = Surface.canvas(width: 2200, height: 650);

void main() {
  testGoldens('AppColors', (tester) async {
    final rowNames = [
      'Accent',
      'Active',
      'Info',
      'Danger',
      'Success',
      'Warning',
      'Default',
      'Inverse',
      'Disabled',
    ];

    final columns = [
      (tokens: {'background', 'Primary'}, displayName: 'Bg/Primary'),
      (
        tokens: {'background', 'PrimaryHover'},
        displayName: 'Bg/Primary \n(hover)',
      ),
      (
        tokens: {'background', 'PrimaryPressed'},
        displayName: 'Bg/Primary \n(pressed)',
      ),
      (tokens: {'background', 'Secondary'}, displayName: 'Bg/Secondary'),
      (
        tokens: {'background', 'SecondaryHover'},
        displayName: 'Bg/Secondary \n(hover)',
      ),
      (
        tokens: {'background', 'SecondaryPressed'},
        displayName: 'Bg/Secondary \n(pressed)',
      ),
      (tokens: {'background', 'Tertiary'}, displayName: 'Bg/Tertiary'),
      (
        tokens: {'background', 'TertiaryHover'},
        displayName: 'Bg/Tertiary \n(hover)',
      ),
      (
        tokens: {'background', 'TertiaryPressed'},
        displayName: 'Bg/Tertiary \n(pressed)',
      ),
      (tokens: {'background', 'Scrim'}, displayName: 'Bg/Scrim'),
      (tokens: {'foreground', 'Primary'}, displayName: 'Fg/Primary'),
      (
        tokens: {'foreground', 'PrimaryHover'},
        displayName: 'Fg/Primary \n(hover)',
      ),
      (
        tokens: {'foreground', 'PrimaryPressed'},
        displayName: 'Fg/Primary \n(pressed)',
      ),
      (tokens: {'foreground', 'Secondary'}, displayName: 'Fg/Secondary'),
      (
        tokens: {'foreground', 'SecondaryHover'},
        displayName: 'Fg/Secondary \n(hover)',
      ),
      (
        tokens: {'foreground', 'SecondaryPressed'},
        displayName: 'Fg/Secondary \n(pressed)',
      ),
      (tokens: {'foreground', 'Tertiary'}, displayName: 'Fg/Tertiary'),
      (tokens: {'foreground', 'Quaternary'}, displayName: 'Fg/Quaternary'),
    ];

    await pumpWidgetBuilder(
      tester,
      Builder(
        builder: (context) {
          final colors = context.colors;

          final colorSet = {
            colors.transparent,
            colors.backgroundAccentPrimary,
            colors.backgroundAccentPrimaryHover,
            colors.backgroundAccentPrimaryPressed,
            colors.backgroundAccentSecondary,
            colors.backgroundAccentSecondaryHover,
            colors.backgroundAccentSecondaryPressed,
            colors.backgroundAccentTertiary,
            colors.backgroundAccentTertiaryHover,
            colors.backgroundAccentTertiaryPressed,
            colors.backgroundActivePrimary,
            colors.backgroundActivePrimaryHover,
            colors.backgroundActivePrimaryPressed,
            colors.backgroundActiveSecondary,
            colors.backgroundActiveSecondaryHover,
            colors.backgroundActiveSecondaryPressed,
            colors.backgroundActiveTertiary,
            colors.backgroundActiveTertiaryHover,
            colors.backgroundActiveTertiaryPressed,
            colors.backgroundInfoPrimary,
            colors.backgroundInfoPrimaryHover,
            colors.backgroundInfoPrimaryPressed,
            colors.backgroundInfoSecondary,
            colors.backgroundInfoSecondaryHover,
            colors.backgroundInfoSecondaryPressed,
            colors.backgroundInfoTertiary,
            colors.backgroundInfoTertiaryHover,
            colors.backgroundInfoTertiaryPressed,
            colors.backgroundDangerPrimary,
            colors.backgroundDangerPrimaryHover,
            colors.backgroundDangerPrimaryPressed,
            colors.backgroundDangerSecondary,
            colors.backgroundDangerSecondaryHover,
            colors.backgroundDangerSecondaryPressed,
            colors.backgroundDangerTertiary,
            colors.backgroundDangerTertiaryHover,
            colors.backgroundDangerTertiaryPressed,
            colors.backgroundSuccessPrimary,
            colors.backgroundSuccessPrimaryHover,
            colors.backgroundSuccessPrimaryPressed,
            colors.backgroundSuccessSecondary,
            colors.backgroundSuccessSecondaryHover,
            colors.backgroundSuccessSecondaryPressed,
            colors.backgroundSuccessTertiary,
            colors.backgroundSuccessTertiaryHover,
            colors.backgroundSuccessTertiaryPressed,
            colors.backgroundWarningPrimary,
            colors.backgroundWarningPrimaryHover,
            colors.backgroundWarningPrimaryPressed,
            colors.backgroundWarningSecondary,
            colors.backgroundWarningSecondaryHover,
            colors.backgroundWarningSecondaryPressed,
            colors.backgroundWarningTertiary,
            colors.backgroundWarningTertiaryHover,
            colors.backgroundWarningTertiaryPressed,
            colors.backgroundDefaultPrimary,
            colors.backgroundDefaultPrimaryHover,
            colors.backgroundDefaultPrimaryPressed,
            colors.backgroundDefaultSecondary,
            colors.backgroundDefaultSecondaryHover,
            colors.backgroundDefaultSecondaryPressed,
            colors.backgroundDefaultTertiary,
            colors.backgroundDefaultTertiaryHover,
            colors.backgroundDefaultTertiaryPressed,
            colors.backgroundDefaultScrim,
            colors.backgroundInversePrimary,
            colors.backgroundInversePrimaryHover,
            colors.backgroundInversePrimaryPressed,
            colors.backgroundDisabledPrimary,
            colors.backgroundDisabledSecondary,
            colors.backgroundDisabledTertiary,
            colors.backgroundMapBarBadge,
            colors.backgroundMapBarPin,
            colors.backgroundMapCulturalBadge,
            colors.backgroundMapCulturalPin,
            colors.backgroundMapFoodBadge,
            colors.backgroundMapFoodPin,
            colors.backgroundMapLeancodeBadge,
            colors.backgroundMapLeancodePin,
            colors.backgroundMapMainEventBadge,
            colors.backgroundMapMainEventPin,
            colors.backgroundMapMuseumBadge,
            colors.backgroundMapMuseumPin,
            colors.backgroundMapOtherBadge,
            colors.backgroundMapOtherPin,
            colors.backgroundMapParkBadge,
            colors.backgroundMapParkPin,
            colors.backgroundMapSideEventBadge,
            colors.backgroundMapSideEventPin,
            colors.foregroundAccentPrimary,
            colors.foregroundAccentPrimaryHover,
            colors.foregroundAccentPrimaryPressed,
            colors.foregroundAccentSecondary,
            colors.foregroundAccentSecondaryHover,
            colors.foregroundAccentSecondaryPressed,
            colors.foregroundAccentTertiary,
            colors.foregroundAccentQuaternary,
            colors.foregroundActivePrimary,
            colors.foregroundActivePrimaryHover,
            colors.foregroundActivePrimaryPressed,
            colors.foregroundActiveSecondary,
            colors.foregroundActiveSecondaryHover,
            colors.foregroundActiveSecondaryPressed,
            colors.foregroundActiveTertiary,
            colors.foregroundActiveQuaternary,
            colors.foregroundInfoPrimary,
            colors.foregroundInfoPrimaryHover,
            colors.foregroundInfoPrimaryPressed,
            colors.foregroundInfoSecondary,
            colors.foregroundInfoSecondaryHover,
            colors.foregroundInfoSecondaryPressed,
            colors.foregroundInfoTertiary,
            colors.foregroundInfoQuaternary,
            colors.foregroundDangerPrimary,
            colors.foregroundDangerPrimaryHover,
            colors.foregroundDangerPrimaryPressed,
            colors.foregroundDangerSecondary,
            colors.foregroundDangerSecondaryHover,
            colors.foregroundDangerSecondaryPressed,
            colors.foregroundDangerTertiary,
            colors.foregroundDangerQuaternary,
            colors.foregroundSuccessPrimary,
            colors.foregroundSuccessPrimaryHover,
            colors.foregroundSuccessPrimaryPressed,
            colors.foregroundSuccessSecondary,
            colors.foregroundSuccessSecondaryHover,
            colors.foregroundSuccessSecondaryPressed,
            colors.foregroundSuccessTertiary,
            colors.foregroundSuccessQuaternary,
            colors.foregroundWarningPrimary,
            colors.foregroundWarningPrimaryHover,
            colors.foregroundWarningPrimaryPressed,
            colors.foregroundWarningSecondary,
            colors.foregroundWarningSecondaryHover,
            colors.foregroundWarningSecondaryPressed,
            colors.foregroundWarningTertiary,
            colors.foregroundWarningQuaternary,
            colors.foregroundDefaultPrimary,
            colors.foregroundDefaultPrimaryHover,
            colors.foregroundDefaultPrimaryPressed,
            colors.foregroundDefaultSecondary,
            colors.foregroundDefaultSecondaryHover,
            colors.foregroundDefaultSecondaryPressed,
            colors.foregroundDefaultTertiary,
            colors.foregroundDefaultQuaternary,
            colors.foregroundInversePrimary,
            colors.foregroundInversePrimaryHover,
            colors.foregroundInversePrimaryPressed,
            colors.foregroundDisabledPrimary,
            colors.foregroundDisabledSecondary,
            colors.foregroundDisabledTertiary,
            colors.foregroundMapBar,
            colors.foregroundMapCultural,
            colors.foregroundMapFood,
            colors.foregroundMapLeancode,
            colors.foregroundMapMainEvent,
            colors.foregroundMapMuseum,
            colors.foregroundMapOther,
            colors.foregroundMapPark,
            colors.foregroundMapSideEvent,
          };

          return GoldenTable(
            cellAlignment: GoldenTableCellAlignment.stretch,
            header: GoldenTableHeader(
              headerName: 'Type',
              cellNames: columns.map((column) => column.displayName).toList(),
            ),
            rows: rowNames.map((rowName) {
              final rowColors = colorSet.where(
                (color) => color.name.contains(rowName),
              );

              return GoldenTableRow(
                details: rowName,
                cells: columns.map((column) {
                  final color = rowColors.firstWhereOrNull((color) {
                    for (final token in column.tokens) {
                      if (!color.name.contains(token)) {
                        return false;
                      }
                    }
                    return true;
                  });

                  return switch (color) {
                    final color? => SizedBox(
                      height: 50,
                      child: ClipRect(
                        child: OpacityCheckboard(
                          child: Transform.scale(
                            scale: 1.1,
                            child: SizedBox.expand(
                              child: ColoredBox(color: color),
                            ),
                          ),
                        ),
                      ),
                    ),
                    _ => const SizedBox(),
                  };
                }).toList(),
              );
            }).toList(),
          );
        },
      ),
      surface: _surface,
    );

    await tester.pumpAndSettle();

    await widgetsMatchGoldensSingle(tester, 'colors', surface: _surface);
  });
}

class OpacityCheckboard extends StatelessWidget {
  const OpacityCheckboard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(painter: _OpacityCheckboardPainter(), child: child),
    );
  }
}

class _OpacityCheckboardPainter extends CustomPainter {
  static const rectSide = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    final blackPaint = Paint()
      // We need non-semantic, absolute black color here
      // ignore: app_lint/use_design_system_item_AppColor
      ..color = const Color(0xFF000000)
      ..style = PaintingStyle.fill;
    final whitePaint = Paint()
      // We need non-semantic, absolute white color here
      // ignore: app_lint/use_design_system_item_AppColor
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;

    canvas.drawRect(Offset.zero & size, whitePaint);

    for (var x = 0.0; x < size.width; x += rectSide * 2) {
      for (var y = 0.0; y < size.height; y += rectSide * 2) {
        canvas.drawRect(Offset(x, y) & const Size.square(rectSide), blackPaint);
      }
      for (var y = rectSide; y < size.height; y += rectSide * 2) {
        canvas.drawRect(
          Offset(x + rectSide, y) & const Size.square(rectSide),
          blackPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_OpacityCheckboardPainter oldDelegate) => false;
}
