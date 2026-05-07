import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:leancode_contracts/leancode_contracts.dart';

class DayTabSelector extends StatelessWidget {
  const DayTabSelector({
    super.key,
    required this.availableDays,
    required this.selectedDay,
    required this.onDaySelected,
  });

  final List<DateOnly> availableDays;
  final DateOnly selectedDay;
  final ValueChanged<DateOnly> onDaySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.colors.backgroundDefaultPrimary,
      child: Row(
        children: availableDays
            .map(
              (day) => Expanded(
                child: _DayTab(
                  day: day,
                  isSelected: day == selectedDay,
                  onTap: () => onDaySelected(day),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _DayTab extends StatelessWidget {
  const _DayTab({
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  final DateOnly day;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dateTime = day.toDateTimeLocal();

    // Format day like "Thu 5.06"
    final dayName = DateFormat('EEE').format(dateTime);
    final dayNumber = DateFormat('d.MM').format(dateTime);
    final displayText = '$dayName $dayNumber';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected
                  ? context.colors.foregroundActivePrimary
                  : context.colors.foregroundDefaultQuaternary,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: AppText(
            displayText,
            style: AppTextStyles.bodyDefault,
            color: isSelected
                ? context.colors.foregroundActivePrimary
                : context.colors.foregroundDefaultSecondary,
          ),
        ),
      ),
    );
  }
}
