import 'package:flutter/widgets.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/widgets/widgets.dart';

abstract class AppTextButton extends StatelessWidget {
  const factory AppTextButton({
    Key? key,
    AppStandardIconData? leadingIcon,
    required String caption,
    AppStandardIconData? trailingIcon,
    required AppTextButtonType type,
    String? semanticsLabel,
    required VoidCallback onTap,
    bool enabled,
    bool loading,
    required AnalyticsId analyticsId,
    Map<String, Object> analyticsParams,
  }) = _AppTextButton;

  const factory AppTextButton.icon({
    Key? key,
    required AppStandardIconData icon,
    required AppTextButtonType type,
    required String semanticsLabel,
    required VoidCallback onTap,
    bool enabled,
    bool loading,
    required AnalyticsId analyticsId,
    Map<String, Object> analyticsParams,
  }) = _AppIconTextButton;

  const AppTextButton._({super.key});
}

class _AppTextButton extends AppTextButton {
  const _AppTextButton({
    super.key,
    this.leadingIcon,
    required this.caption,
    this.trailingIcon,
    required this.type,
    this.semanticsLabel,
    required this.onTap,
    this.enabled = true,
    this.loading = false,
    required this.analyticsId,
    this.analyticsParams = const {},
  }) : super._();

  final AppStandardIconData? leadingIcon;
  final String caption;
  final AppStandardIconData? trailingIcon;
  final AppTextButtonType type;
  final String? semanticsLabel;
  final VoidCallback onTap;
  final bool enabled;
  final bool loading;
  final AnalyticsId analyticsId;
  final Map<String, Object> analyticsParams;

  @override
  Widget build(BuildContext context) {
    return AppRawTextButton(
      leadingIcon: leadingIcon,
      caption: caption,
      trailingIcon: trailingIcon,
      type: type,
      semanticsLabel: semanticsLabel,
      onTap: onTap,
      enabled: enabled,
      loading: loading,
    );
  }
}

class _AppIconTextButton extends AppTextButton {
  const _AppIconTextButton({
    super.key,
    required this.icon,
    required this.type,
    required this.semanticsLabel,
    required this.onTap,
    this.enabled = true,
    this.loading = false,
    required this.analyticsId,
    this.analyticsParams = const {},
  }) : super._();

  final AppStandardIconData icon;
  final AppTextButtonType type;
  final String semanticsLabel;
  final VoidCallback onTap;
  final bool enabled;
  final bool loading;
  final AnalyticsId analyticsId;
  final Map<String, Object> analyticsParams;

  @override
  Widget build(BuildContext context) {
    return AppRawTextButton.icon(
      icon: icon,
      type: type,
      semanticsLabel: semanticsLabel,
      onTap: onTap,
      enabled: enabled,
      loading: loading,
    );
  }
}
