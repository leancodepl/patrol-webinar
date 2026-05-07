import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/widgets/icon/data.dart';
import 'package:flutter/widgets.dart';

export 'data.dart';
export 'illustration.dart';
export 'standard.dart';

class AppIcon<TSize extends AppIconSize> extends StatelessWidget
    implements PreferredSizeWidget {
  const AppIcon(
    this.data, {
    super.key,
    required this.size,
    this.color,
    required this.semanticsLabel,
    this.applyTextScaling = false,
  });

  final AppIconData<TSize> data;
  final TSize size;
  final AppColor? color;
  final String? semanticsLabel;
  final bool applyTextScaling;

  @override
  Widget build(BuildContext context) {
    return data.buildWidget(
      size,
      context: context,
      color: color,
      semanticsLabel: semanticsLabel,
      applyTextScaling: applyTextScaling,
    );
  }

  @override
  Size get preferredSize => size.size;
}
