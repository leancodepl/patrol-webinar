import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/utils/color_tween_builder.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class InputIcon extends StatelessWidget {
  const InputIcon({super.key, required this.icon, required this.enabled});

  final AppStandardIconData icon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final color = switch (enabled) {
      true => colors.foregroundDefaultSecondary,
      false => colors.foregroundDisabledSecondary,
    };

    return ColorTweenBuilder(
      color: color,
      builder: (context, color, _) => AppIcon(
        icon,
        size: AppStandardIconSize.s24,
        color: color,
        semanticsLabel: null,
      ),
    );
  }
}
