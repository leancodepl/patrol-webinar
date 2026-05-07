import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:flutter/widgets.dart';

abstract class AppIconSize {
  Size get size;
}

abstract class AppIconData<TSize extends AppIconSize> {
  Widget buildWidget(
    TSize size, {
    required BuildContext context,
    AppColor? color,
    required String? semanticsLabel,
    bool applyTextScaling = false,
  });
}
