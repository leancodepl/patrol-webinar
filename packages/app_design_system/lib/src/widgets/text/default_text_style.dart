// We need Material DefaultTextStyle here as parent class of AppDefaultTextStyle
// ignore_for_file: app_lint/use_design_system_item_AppDefaultTextStyle
import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:flutter/widgets.dart';

class AppDefaultTextStyle extends StatelessWidget {
  const AppDefaultTextStyle({
    super.key,
    required this.child,
    this.style,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final Widget child;
  final AppTextStyle? style;
  final AppColor? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: style?.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      child: child,
    );
  }
}
