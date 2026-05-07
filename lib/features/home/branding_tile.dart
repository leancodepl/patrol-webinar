// Branding title uses color values separate from the DS
// ignore_for_file: app_lint/use_design_system_item_AppColor, app_lint/use_design_system_item_AppText, app_lint/use_design_system_item_AppTextStyle
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/navigation/routes.dart';
import 'package:fts/resources/strings.dart';

class BrandingTile extends StatelessWidget {
  const BrandingTile({super.key});

  static const height = 150.0;

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    const white = Color(0xFFFFFFFF);
    const black = Color(0xFF000000);

    return GestureDetector(
      onTap: () => const OnboardingRoute().go(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              const Align(alignment: Alignment.bottomLeft, child: _Gradient()),
              Align(
                alignment: Alignment.bottomRight,
                child: Transform.flip(flipX: true, child: const _Gradient()),
              ),
              Positioned.fill(
                top: 16,
                bottom: 16,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: white),
                      ),
                      child: Text(
                        s.home_brandingTileDate,
                        style: const TextStyle(
                          fontFamily: 'Switzer',
                          package: 'app_design_system',
                          fontSize: 12,
                          height: 1.5,
                          color: white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      s.home_brandingTileTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        height: 1.1,
                        fontWeight: FontWeight.w400,
                        color: white,
                        fontFamily: 'Monoska',
                        package: 'app_design_system',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      s.home_brandingTileSubtitle,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        letterSpacing: -0.01,
                        fontWeight: FontWeight.w500,
                        color: white,
                        fontFamily: 'Switzer',
                        package: 'app_design_system',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Gradient extends StatelessWidget {
  const _Gradient();

  @override
  Widget build(BuildContext context) {
    const side = BrandingTile.height / 2;
    final diagonal = side * sqrt(2);

    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaY: 10),
      child: Transform.rotate(
        angle: pi / 4,
        child: Transform.translate(
          offset: const Offset(0, side),
          child: Container(
            width: diagonal,
            height: diagonal,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                stops: [0, 0.9],
                colors: [Color(0xFFF0FF00), Color(0x00000000)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
