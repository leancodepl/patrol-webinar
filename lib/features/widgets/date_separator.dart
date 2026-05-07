import 'package:flutter/widgets.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:intl/intl.dart';

class DateSeparator extends StatelessWidget {
  const DateSeparator({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final dateFormat = DateFormat.MMMMEEEEd();

    return Row(
      children: [
        AppText(
          dateFormat.format(date),
          style: AppTextStyles.bodyDefault,
          color: colors.foregroundDefaultSecondary,
        ),
        AppSpacings.s8.horizontalSpace,
        const Expanded(child: AppDivider.horizontal()),
      ],
    );
  }
}
