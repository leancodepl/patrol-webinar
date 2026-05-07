import 'package:flutter/widgets.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/widgets/widgets.dart';

abstract class AppButton extends StatelessWidget {
  const factory AppButton({
    Key? key,
    AppStandardIconData? leadingIcon,
    required String caption,
    AppStandardIconData? trailingIcon,
    AppButtonSize size,
    required AppButtonType type,
    String? semanticsLabel,
    required VoidCallback onTap,
    bool enabled,
    bool isLoading,
    bool fullWidth,
    required AnalyticsId analyticsId,
    Map<String, Object> analyticsParams,
  }) = _AppButton;

  const factory AppButton.icon({
    Key? key,
    required AppStandardIconData icon,
    AppButtonSize size,
    required AppButtonType type,
    required String semanticsLabel,
    required VoidCallback onTap,
    bool enabled,
    required AnalyticsId analyticsId,
    Map<String, Object> analyticsParams,
  }) = _AppIconButton;

  const AppButton._({super.key});
}

class _AppButton extends AppButton {
  const _AppButton({
    super.key,
    this.leadingIcon,
    required this.caption,
    this.trailingIcon,
    this.size = AppButtonSize.large,
    required this.type,
    required this.analyticsId,
    this.analyticsParams = const {},
    this.semanticsLabel,
    required this.onTap,
    this.enabled = true,
    this.isLoading = false,
    this.fullWidth = false,
  }) : super._();

  final AppStandardIconData? leadingIcon;
  final String caption;
  final AppStandardIconData? trailingIcon;
  final AppButtonSize size;
  final AppButtonType type;
  final String? semanticsLabel;
  final VoidCallback onTap;
  final bool enabled;
  final bool isLoading;
  final bool fullWidth;
  final AnalyticsId analyticsId;
  final Map<String, Object> analyticsParams;

  @override
  Widget build(BuildContext context) {
    return AppRawButton(
      loading: isLoading,
      caption: caption,
      size: size,
      type: type,
      onTap: onTap,
      enabled: enabled,
      leadingIcon: leadingIcon,
      semanticsLabel: semanticsLabel,
      trailingIcon: trailingIcon,
      fullWidth: fullWidth,
    );
  }
}

class _AppIconButton extends AppButton {
  const _AppIconButton({
    super.key,
    required this.icon,
    required this.type,
    required this.semanticsLabel,
    required this.onTap,
    required this.analyticsId,
    this.size = AppButtonSize.large,
    this.analyticsParams = const {},
    this.enabled = true,
  }) : super._();

  final AppStandardIconData icon;
  final AppButtonSize size;
  final AppButtonType type;
  final String semanticsLabel;
  final VoidCallback onTap;
  final bool enabled;
  final AnalyticsId analyticsId;
  final Map<String, Object> analyticsParams;

  @override
  Widget build(BuildContext context) {
    return AppRawButton.icon(
      icon: icon,
      size: size,
      type: type,
      semanticsLabel: semanticsLabel,
      onTap: onTap,
      enabled: enabled,
    );
  }
}
