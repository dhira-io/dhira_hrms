import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class TimesheetDayBubble extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool hasTask;
  final bool isHoliday;
  final bool isWeekend;
  final VoidCallback? onTap;

  const TimesheetDayBubble({
    super.key,
    required this.date,
    required this.isSelected,
    required this.hasTask,
    required this.isHoliday,
    required this.isWeekend,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = AppColors.surfaceContainerHigh;
    Color textColor = AppColors.textPrimary;
    Color subTextColor = AppColors.textSecondary;

    if (isSelected) {
      bgColor = AppColors.primary;
      textColor = Colors.white;
      subTextColor = Colors.white.withValues(alpha: 0.8);
    } else if (hasTask) {
      bgColor = AppColors.success;
      textColor = Colors.white;
      subTextColor = Colors.white.withValues(alpha: 0.8);
    } else if (isHoliday) {
      bgColor = AppColors.error;
      textColor = Colors.white;
      subTextColor = Colors.white.withValues(alpha: 0.8);
    } else if (isWeekend) {
      bgColor = AppColors.slate300;
      textColor = AppColors.textPrimary;
      subTextColor = AppColors.textSecondary;
    }

    return Container(
      width: 56,
      margin: const EdgeInsets.only(right: 8),
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('E').format(date).toUpperCase(),
                style: AppTextStyle.dateDay.copyWith(
                  color: subTextColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date.day.toString(),
                style: AppTextStyle.dateNumber.copyWith(
                  color: textColor,
                ),
              ),
              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
