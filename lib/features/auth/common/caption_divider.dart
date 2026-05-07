import 'package:flutter/material.dart';
import 'package:fts/widgets/widgets.dart';

class CaptionDivider extends StatelessWidget {
  const CaptionDivider({super.key, required this.caption});

  final String caption;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        AppSpacings.s16.horizontalSpace,
        AppText(caption, style: AppTextStyles.bodyDefault),
        AppSpacings.s16.horizontalSpace,
        const Expanded(child: Divider()),
      ],
    );
  }
}
