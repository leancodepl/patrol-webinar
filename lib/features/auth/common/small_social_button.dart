import 'package:flutter/material.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/resources/assets.gen.dart';
import 'package:fts/widgets/widgets.dart';

class _SmallSocialButton extends StatelessWidget {
  const _SmallSocialButton({
    required this.icon,
    required this.onTap,
    required this.analyticsId,
    this.analyticsParams = const {},
  });

  final Widget icon;
  final VoidCallback onTap;
  final AnalyticsId analyticsId;
  final Map<String, Object> analyticsParams;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.colors.backgroundActiveTertiary,
        ),
        child: Padding(padding: AppSpacings.s12.all, child: icon),
      ),
    );
  }
}

class SmallAppleButton extends StatelessWidget {
  const SmallAppleButton({
    super.key,
    required this.onTap,
    required this.analyticsId,
    this.analyticsParams = const {},
  });
  final VoidCallback onTap;
  final AnalyticsId analyticsId;
  final Map<String, Object> analyticsParams;

  @override
  Widget build(BuildContext context) {
    return _SmallSocialButton(
      icon: Assets.social.apple.svg(
        height: 24,
        width: 24,
        colorFilter: ColorFilter.mode(
          context.colors.appleButtonColor,
          BlendMode.srcIn,
        ),
      ),
      onTap: onTap,
      analyticsId: analyticsId,
      analyticsParams: analyticsParams,
    );
  }
}

class SmallGoogleButton extends StatelessWidget {
  const SmallGoogleButton({
    super.key,
    required this.onTap,
    required this.analyticsId,
    this.analyticsParams = const {},
  });

  final VoidCallback onTap;
  final AnalyticsId analyticsId;
  final Map<String, Object> analyticsParams;

  @override
  Widget build(BuildContext context) {
    return _SmallSocialButton(
      icon: Assets.social.google.svg(height: 24, width: 24),
      onTap: onTap,
      analyticsId: analyticsId,
      analyticsParams: analyticsParams,
    );
  }
}

class SmallPasskeyButton extends StatelessWidget {
  const SmallPasskeyButton({
    super.key,
    required this.onTap,
    required this.analyticsId,
    this.analyticsParams = const {},
  });

  final VoidCallback onTap;
  final AnalyticsId analyticsId;
  final Map<String, Object> analyticsParams;
  @override
  Widget build(BuildContext context) {
    return _SmallSocialButton(
      icon: Assets.social.passkeyIcon.svg(height: 24, width: 24),
      onTap: onTap,
      analyticsId: analyticsId,
      analyticsParams: analyticsParams,
    );
  }
}
