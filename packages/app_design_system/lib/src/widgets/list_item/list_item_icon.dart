import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:app_design_system/src/widgets/list_item/list_item_widget.dart';
import 'package:flutter/widgets.dart';

/// A widget that displays an icon in a [AppListItem]. It can receive either an
/// [AppIconData] icon through [AppListItemIcon.icon] constructor or a custom
/// [Widget] through [AppListItemIcon.widget] constructor.
class AppListItemIcon extends StatelessWidget {
  const AppListItemIcon.widget({super.key, required this.child});

  AppListItemIcon.icon({
    super.key,
    required AppIconData icon,
    required String? semanticsLabel,
  }) : child = Builder(
         builder: (context) => AppIcon(
           icon,
           size: AppStandardIconSize.s24,
           semanticsLabel: semanticsLabel,
           color: context.colors.foregroundDefaultSecondary,
         ),
       );

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
