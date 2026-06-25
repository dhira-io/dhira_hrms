import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

class CalendarViewWidget extends StatelessWidget {
  final DateTime focusedMonth;
  final Map<String, String> events;
  final DateTime? selectedDay;
  final ValueChanged<DateTime> onMonthChanged;
  final ValueChanged<DateTime> onDaySelected;

  const CalendarViewWidget({
    super.key,
    required this.focusedMonth,
    required this.events,
    required this.selectedDay,
    required this.onMonthChanged,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MonthSelectorHeader(
          focusedMonth: focusedMonth,
          onMonthChanged: onMonthChanged,
        ),
        SizedBox(height: 12.h),
        _CalendarGridCard(
          focusedMonth: focusedMonth,
          events: events,
          selectedDay: selectedDay,
          onDaySelected: onDaySelected,
        ),
      ],
    );
  }
}

class _MonthSelectorHeader extends StatelessWidget {
  final DateTime focusedMonth;
  final ValueChanged<DateTime> onMonthChanged;

  const _MonthSelectorHeader({
    required this.focusedMonth,
    required this.onMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    final monthLabel = DateTimeUtils.formatDate(
      focusedMonth,
      pattern: DateTimeUtils.patternMonthYear,
    );

    return Container(
      width: double.infinity,
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: AppConstants.p10, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.of(context).surface,
        borderRadius: BorderRadius.circular(AppConstants.r32),
        border: Border.all(
          color: AppColors.of(context).outlineVariant,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              onMonthChanged(DateTime(focusedMonth.year, focusedMonth.month - 1));
            },
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.of(context).surfaceContainerHigh,
                border: Border.all(
                  color: AppColors.of(context).outlineVariant,
                ),
              ),
              child: Icon(
                Icons.chevron_left,
                size: AppConstants.iconSmall,
                color: AppColors.of(context).onSurface,
              ),
            ),
          ),
          Text(
            monthLabel,
            style: AppTextStyle.bodyMedium.copyWith(
              color: AppColors.of(context).onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              onMonthChanged(DateTime(focusedMonth.year, focusedMonth.month + 1));
            },
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.of(context).surfaceContainerHigh,
                border: Border.all(
                  color: AppColors.of(context).outlineVariant,
                ),
              ),
              child: Icon(
                Icons.chevron_right,
                size: AppConstants.iconSmall,
                color: AppColors.of(context).onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarGridCard extends StatelessWidget {
  final DateTime focusedMonth;
  final Map<String, String> events;
  final DateTime? selectedDay;
  final ValueChanged<DateTime> onDaySelected;

  const _CalendarGridCard({
    required this.focusedMonth,
    required this.events,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    // Generate week days header SUN, MON...
    final weekdays = [
      DateTime(2026, 6, 7), // Sunday
      DateTime(2026, 6, 8), // Monday
      DateTime(2026, 6, 9), // Tuesday
      DateTime(2026, 6, 10), // Wednesday
      DateTime(2026, 6, 11), // Thursday
      DateTime(2026, 6, 12), // Friday
      DateTime(2026, 6, 13), // Saturday
    ].map((d) => DateTimeUtils.formatToDayAbbrFull(d)).toList();

    // Days calculation
    final firstDay = DateTime(focusedMonth.year, focusedMonth.month, 1);
    final lastDay = DateTime(focusedMonth.year, focusedMonth.month + 1, 0);
    
    // Offset relative to Sunday (SUN = 0, MON = 1...)
    final int startOffset = firstDay.weekday % 7;
    final int totalDays = lastDay.day;
    final int totalCells = startOffset + totalDays;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.p10),
      decoration: BoxDecoration(
        color: AppColors.of(context).surface,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(
          color: AppColors.of(context).outlineVariant,
        ),
      ),
      child: Column(
        children: [
          // Weekdays Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: weekdays.map((dayName) {
                return SizedBox(
                  width: 36.w,
                  child: Text(
                    dayName,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.labelSmall.copyWith(
                      color: AppColors.of(context).onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 10.h),
          // Calendar Days Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 13,
              mainAxisSpacing: 16,
            ),
            itemCount: totalCells,
            itemBuilder: (context, index) {
              if (index < startOffset) {
                return const SizedBox.shrink();
              }
              
              final dayNumber = index - startOffset + 1;
              final currentDay = DateTime(focusedMonth.year, focusedMonth.month, dayNumber);
              final dateKey = DateTimeUtils.formatToYMD(currentDay);
              final status = events[dateKey];
              final isSelected = selectedDay != null && DateTimeUtils.isSameDay(currentDay, selectedDay!);

              return _CalendarDayCell(
                day: currentDay,
                status: status,
                isSelected: isSelected,
                onTap: () => onDaySelected(currentDay),
              );
            },
          ),
          SizedBox(height: 16.h),
          Divider(color: AppColors.of(context).outlineVariant, height: 1.h),
          SizedBox(height: 12.h),
          const _HorizontalLegendsRow(),
        ],
      ),
    );
  }
}

class _CalendarDayCell extends StatelessWidget {
  final DateTime day;
  final String? status;
  final bool isSelected;
  final VoidCallback onTap;

  const _CalendarDayCell({
    required this.day,
    required this.status,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isToday = DateTimeUtils.isToday(day);
    
    // Style configurations based on status
    Color backgroundColor = AppColors.of(context).surface;
    Color textColor = AppColors.of(context).onSurface;
    Color borderColor = AppColors.of(context).outlineVariant;
    Color? dotColor;

    if (status != null) {
      final s = status!.toLowerCase();
      if (s == 'present') {
        backgroundColor = AppColors.of(context).presentBg;
        textColor = AppColors.of(context).presentText;
        borderColor = AppColors.of(context).presentText;
        dotColor = AppColors.of(context).presentText;
      } else if (s == 'absent') {
        backgroundColor = AppColors.of(context).absentBg;
        textColor = AppColors.of(context).absentText;
        borderColor = AppColors.of(context).absentText;
        dotColor = AppColors.of(context).absentText;
      } else if (s == 'on leave' || s == 'leave') {
        backgroundColor = AppColors.of(context).leaveBg;
        textColor = AppColors.of(context).leaveText;
        borderColor = AppColors.of(context).leaveText;
        dotColor = AppColors.of(context).leaveText;
      } else if (s == 'holiday') {
        backgroundColor = AppColors.of(context).holidayBg;
        textColor = AppColors.of(context).holidayText;
        borderColor = AppColors.of(context).holidayText;
        dotColor = AppColors.of(context).holidayText;
      } else if (s == 'weekend' || s == 'weekly off') {
        backgroundColor = AppColors.of(context).weekendBg;
        textColor = AppColors.of(context).weekendText;
        borderColor = AppColors.of(context).weekendText;
        dotColor = AppColors.of(context).weekendText;
      } else if (s == 'half day' || s == 'half-day') {
        backgroundColor = AppColors.of(context).halfDayBg;
        textColor = AppColors.of(context).halfDayText;
        borderColor = AppColors.of(context).halfDayText;
        dotColor = AppColors.of(context).halfDayText;
      }
    } else if (DateTimeUtils.isWeekend(day)) {
      backgroundColor = AppColors.of(context).weekendBg;
      textColor = AppColors.of(context).weekendText;
      borderColor = AppColors.of(context).weekendText;
      dotColor = AppColors.of(context).weekendText;
    }

    if (isToday) {
      borderColor = AppColors.of(context).calendarTodayBorder;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppConstants.r8),
          border: isSelected 
              ? Border.all(color: AppColors.of(context).primary, width: 2.w)
              : Border.all(color: borderColor, width: 1.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day.day.toString(),
              style: AppTextStyle.bodyMedium.copyWith(
                color: textColor,
                fontWeight: isToday || isSelected ? FontWeight.bold : FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
            if (dotColor != null) ...[
              const SizedBox(height: 2),
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HorizontalLegendsRow extends StatelessWidget {
  const _HorizontalLegendsRow();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = AppColors.of(context);

    return Wrap(
      spacing: 10.w,
      runSpacing: 8.h,
      alignment: WrapAlignment.center,
      children: [
        _LegendItem(color: themeColors.presentText, label: l10n.present),
        _LegendItem(color: themeColors.leaveText, label: l10n.leave),
        _LegendItem(color: themeColors.absentText, label: l10n.absent),
        _LegendItem(color: themeColors.halfDayText, label: l10n.halfDay),
        _LegendItem(color: themeColors.weekendText, label: l10n.weekend),
        _LegendItem(color: themeColors.holidayText, label: l10n.holiday),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.of(context).onSurfaceVariant,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
