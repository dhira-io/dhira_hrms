import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';

class TimesheetDayBubble extends StatelessWidget {

  final DateTime date;
  final double hours;
  final bool isSelected;
  final bool hasTask;
  final bool isHoliday;
  final bool isWeekend;
  final VoidCallback? onTap;

  const TimesheetDayBubble({
    super.key,
    required this.date,
    required this.hours,
    required this.isSelected,
    required this.hasTask,
    required this.isHoliday,
    required this.isWeekend,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = AppColors.of(context).surfaceContainerHigh;
    Color textColor = AppColors.of(context).textPrimary;
    Color subTextColor = AppColors.of(context).textSecondary;

    if (isSelected) {
      bgColor = AppColors.of(context).primary;
      textColor = Colors.white;
      subTextColor = Colors.white.withValues(alpha: 0.8);
    } else if (hasTask) {
      bgColor = AppColors.of(context).success;
      textColor = Colors.white;
      subTextColor = Colors.white.withValues(alpha: 0.8);
    } else if (isHoliday) {
      bgColor = AppColors.of(context).error;
      textColor = Colors.white;
      subTextColor = Colors.white.withValues(alpha: 0.8);
    } else if (isWeekend) {
      bgColor = AppColors.of(context).slate300;
      textColor = AppColors.of(context).textPrimary;
      subTextColor = AppColors.of(context).textSecondary;
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
                DateTimeUtils.formatToDayAbbrFull(
                  date,
                  Localizations.localeOf(context).languageCode,
                ),
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


              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  hours > 0
                      ? "${hours.toStringAsFixed(hours % 1 == 0 ? 0 : 1)}h"
                      : "Empty",
                  style: AppTextStyle.bodySmall.copyWith(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: isSelected || hasTask || isHoliday
                        ? Colors.white.withValues(alpha: 0.9)
                        : hours > 0
                        ? AppColors.of(context).success
                        : AppColors.of(context).textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
