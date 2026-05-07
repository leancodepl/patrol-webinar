import 'package:app_design_system/app_design_system.dart';
import 'package:app_design_system/src/l10n/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meta/meta.dart';
import 'package:vector_graphics/vector_graphics.dart';

@internal
class RequiredAsterisk extends StatelessWidget {
  const RequiredAsterisk({super.key, required this.color});

  final AppColor color;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SvgPicture(
      const AssetBytesLoader(
        'assets/misc/required_field_asterisk.svg',
        packageName: appDesignSystemPackage,
      ),
      width: 8,
      height: 8,
      semanticsLabel: l10n.field_required,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
