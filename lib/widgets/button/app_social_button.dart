import 'package:flutter/widgets.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/resources/assets.gen.dart';
import 'package:fts/widgets/widgets.dart';

const _borderRadius = BorderRadius.all(Radius.circular(8));
final _buttonHeight = _socialLogoHeight + AppSpacings.s12.value * 2;

const _socialLogoHeight = 24.0;

class AppleButton extends StatelessWidget {
  const AppleButton({
    super.key,
    required this.label,
    required this.analyticsId,
    required this.onPressed,
    this.analyticsParams = const {},
  });

  final String label;
  final AnalyticsId analyticsId;
  final VoidCallback? onPressed;
  final Map<String, Object> analyticsParams;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Container(
        height: _buttonHeight,
        decoration: BoxDecoration(
          color: context.colors.appleButtonColor,
          borderRadius: _borderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: AppSpacings.s8.end,
              child: Assets.social.apple.svg(height: _socialLogoHeight),
            ),
            AppText(
              label,
              color: context.colors.foregroundInversePrimary,
              style: AppTextStyles.button,
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
    required this.label,
    required this.analyticsId,
    required this.onPressed,
    this.analyticsParams = const {},
  });

  final String label;
  final AnalyticsId analyticsId;
  final VoidCallback? onPressed;
  final Map<String, Object> analyticsParams;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Container(
        height: _buttonHeight,
        decoration: BoxDecoration(
          color: context.colors.backgroundDefaultPrimary,
          borderRadius: _borderRadius,
          border: Border.all(
            color: context.colors.backgroundInversePrimaryPressed,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: AppSpacings.s12.end,
              child: Assets.social.google.svg(height: _socialLogoHeight),
            ),
            AppText(label, style: AppTextStyles.button),
          ],
        ),
      ),
    );
  }
}
