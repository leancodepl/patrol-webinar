import 'package:app_design_system/src/widgets/button/text_button.dart';
import 'package:app_design_system/src/widgets/icon/standard.dart';
import 'package:flutter/widgets.dart';

class AppListItemButton extends StatelessWidget {
  const AppListItemButton({
    super.key,
    required this.icon,
    required this.semanticsLabel,
    this.type = AppTextButtonType.base,
    required this.onTap,
  });

  final AppStandardIconData icon;
  final String semanticsLabel;
  final AppTextButtonType type;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppRawTextButton.icon(
      icon: icon,
      type: type,
      semanticsLabel: semanticsLabel,
      onTap: onTap,
    );
  }
}
