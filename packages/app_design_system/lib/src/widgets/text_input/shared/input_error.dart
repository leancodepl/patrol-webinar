import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/widgets/text/text_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class InputError extends StatelessWidget {
  const InputError({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: AppText(
        text,
        style: AppTextStyles.captionDefault,
        color: colors.foregroundDangerPrimary,
      ),
    );
  }
}
