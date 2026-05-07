import 'package:app_design_system/src/package_name.dart';
import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/widgets/icon/data.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

enum AppIllustrationIconSize implements AppIconSize {
  s32(32);

  const AppIllustrationIconSize(this._side);

  final double _side;

  @override
  Size get size => Size.square(_side);
}

sealed class AppIllustrationIconData
    extends AppIconData<AppIllustrationIconSize> {}

enum AppIllustrationIcons implements AppIllustrationIconData {
  alertCircle,
  checkCircle,
  checkCircleBroken,
  download03,
  phoneCall01;

  String _getAssetName(AppIllustrationIconSize size) {
    final sizeSuffix = size.name.substring(1);
    return 'assets/icons/illustration/${name}_$sizeSuffix.svg';
  }

  @override
  Widget buildWidget(
    AppIllustrationIconSize size, {
    required BuildContext context,
    AppColor? color,
    required String? semanticsLabel,
    bool applyTextScaling = false,
  }) {
    final side = size.size.width;
    final effectiveSide = switch (applyTextScaling) {
      true => MediaQuery.textScalerOf(context).scale(side),
      false => side,
    };

    final icon = SvgPicture(
      AssetBytesLoader(
        _getAssetName(size),
        packageName: appDesignSystemPackage,
      ),
      width: effectiveSide,
      height: effectiveSide,
      semanticsLabel: semanticsLabel,
      colorFilter: switch (color) {
        final color? => ColorFilter.mode(color, BlendMode.srcIn),
        _ => null,
      },
    );

    if (semanticsLabel == null) {
      return ExcludeSemantics(child: icon);
    }

    return icon;
  }
}
