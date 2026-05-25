import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayBubbleConfig {
  final bool isSelected;
  final bool hasTask;
  final bool isHoliday;
  final bool isWeekend;

  const DayBubbleConfig({
    this.isSelected = false,
    this.hasTask = false,
    this.isHoliday = false,
    this.isWeekend = false,
  });
}

class TimesheetDayBubble extends StatelessWidget {
  final DateTime date;
  final double hours;
  final DayBubbleConfig config;
  final VoidCallback? onTap;

  const TimesheetDayBubble({
    super.key,
    required this.date,
    required this.hours,
    required this.config,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = AppColors.of(context);

    Color bgColor = themeColors.surfaceContainerHigh;
    Color textColor = themeColors.textPrimary;
    Color subTextColor = themeColors.textSecondary;

    if (config.isSelected) {
      bgColor = themeColors.primary;
      textColor = themeColors.white;
      subTextColor = themeColors.white.withValues(alpha: 0.8);
    } else if (config.hasTask) {
      bgColor = themeColors.success;
      textColor = themeColors.white;
      subTextColor = themeColors.white.withValues(alpha: 0.8);
    } else if (config.isHoliday) {
      bgColor = themeColors.error;
      textColor = themeColors.white;
      subTextColor = themeColors.white.withValues(alpha: 0.8);
    } else if (config.isWeekend) {
      bgColor = themeColors.slate300;
      textColor = themeColors.textPrimary;
      subTextColor = themeColors.textSecondary;
    }

    return Container(
      width: 48,
      margin: const EdgeInsets.only(right: 6),
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('E').format(date).toUpperCase(),
                style: AppTextStyle.dateDay.copyWith(
                  fontSize: 8.5,
                  color: subTextColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                date.day.toString(),
                style: AppTextStyle.dateNumber.copyWith(
                  fontSize: 14,
                  color: textColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  hours > 0
                      ? "${hours.toStringAsFixed(hours % 1 == 0 ? 0 : 1)}h"
                      : l10n.empty,
                  style: AppTextStyle.bodySmall.copyWith(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color:
                        config.isSelected || config.hasTask || config.isHoliday
                        ? themeColors.white.withValues(alpha: 0.9)
                        : hours > 0
                        ? themeColors.success
                        : themeColors.textSecondary,
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
