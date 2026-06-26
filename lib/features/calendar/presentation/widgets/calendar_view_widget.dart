import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/constants/app_assets.dart';
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
    final themeColors = AppColors.of(context);
    return Container(
      width: double.infinity,
      height: 45.h,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.p10,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: themeColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.r32),
        border: Border.all(color: themeColors.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              onMonthChanged(
                DateTime(focusedMonth.year, focusedMonth.month - 1),
              );
            },
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeColors.calendarChevronBg,
                border: Border.all(color: themeColors.calendarChevronBorder),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.chevronLeft,
                  width: 14.w,
                  height: 14.w,
                  colorFilter: ColorFilter.mode(
                    themeColors.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          Text(
            monthLabel,
            style: AppTextStyle.headingSmallTwoBold.copyWith(
              color: themeColors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              onMonthChanged(
                DateTime(focusedMonth.year, focusedMonth.month + 1),
              );
            },
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeColors.calendarChevronBg,
                border: Border.all(color: themeColors.calendarChevronBorder),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.chevronRight,
                  width: 14.w,
                  height: 14.w,
                  colorFilter: ColorFilter.mode(
                    themeColors.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
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
    final themeColors = AppColors.of(context);
    // Generate week days header SUN, MON...
    final weekdays = List.generate(7, (index) {
      // 2024-01-07 was a Sunday
      final date = DateTime(2024, 1, 7 + index);
      return DateTimeUtils.formatToDayAbbrFull(date);
    });

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
        color: themeColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(color: themeColors.outlineVariant),
      ),
      child: Column(
        children: [
          // Weekdays Row
          Row(
            children: [
              for (int i = 0; i < weekdays.length; i++) ...[
                Expanded(
                  child: Text(
                    weekdays[i],
                    textAlign: TextAlign.center,
                    style: AppTextStyle.labelMediumOne.copyWith(
                      color: themeColors.onSurfaceVariant,

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (i < weekdays.length - 1) const SizedBox(width: 13),
              ],
            ],
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
              final currentDay = DateTime(
                focusedMonth.year,
                focusedMonth.month,
                dayNumber,
              );
              final dateKey = DateTimeUtils.formatToYMD(currentDay);
              final status = events[dateKey];
              final isSelected =
                  selectedDay != null &&
                  DateTimeUtils.isSameDay(currentDay, selectedDay!);

              return _CalendarDayCell(
                day: currentDay,
                status: status,
                isSelected: isSelected,
                onTap: () => onDaySelected(currentDay),
              );
            },
          ),
          SizedBox(height: 16.h),
          Divider(color: themeColors.outlineVariant, height: 1.h),
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
    final themeColors = AppColors.of(context);
    // Style configurations based on status
    Color backgroundColor = themeColors.surface;
    Color borderColor = themeColors.outlineVariant;
    Color? dotColor;
    bool hasStatus = false;

    final isWeekend = DateTimeUtils.isWeekend(day);
    String? resolvedStatus = status;

    if (isWeekend) {
      if (status != null && status!.isNotEmpty) {
        final s = status!.toLowerCase();
        if (s == AttendanceStatus.present ||
            s == AttendanceStatus.halfDay ||
            s == AttendanceStatus.halfDayAlt) {
          resolvedStatus = status;
        } else {
          resolvedStatus = AttendanceStatus.weekend;
        }
      } else {
        resolvedStatus = AttendanceStatus.weekend;
      }
    }

    if (resolvedStatus != null && resolvedStatus!.isNotEmpty) {
      final s = resolvedStatus!.toLowerCase();
      if (s == AttendanceStatus.present) {
        backgroundColor = themeColors.presentBg;
        borderColor = themeColors.presentText;
        dotColor = themeColors.presentText;
        hasStatus = true;
      } else if (s == AttendanceStatus.absent) {
        backgroundColor = themeColors.absentBg;
        borderColor = themeColors.absentText;
        dotColor = themeColors.absentText;
        hasStatus = true;
      } else if (s == AttendanceStatus.leave || s == AttendanceStatus.onLeave) {
        backgroundColor = themeColors.leaveBg;
        borderColor = themeColors.leaveText;
        dotColor = themeColors.leaveText;
        hasStatus = true;
      } else if (s == AttendanceStatus.holiday) {
        backgroundColor = themeColors.holidayBg;
        borderColor = themeColors.holidayText;
        dotColor = themeColors.holidayText;
        hasStatus = true;
      } else if (s == AttendanceStatus.weekend || s == AttendanceStatus.weeklyOff) {
        backgroundColor = themeColors.weekendBg;
        borderColor = themeColors.weekendText;
        dotColor = themeColors.weekendText;
        hasStatus = true;
      } else if (s == AttendanceStatus.halfDay || s == AttendanceStatus.halfDayAlt) {
        backgroundColor = themeColors.halfDayBg;
        borderColor = themeColors.halfDayText;
        dotColor = themeColors.halfDayText;
        hasStatus = true;
      }
    }

    if (isToday) {
      borderColor = themeColors.calendarTodayBorder;
    }

    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: 35.h,
          height: 35.h,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppConstants.r8),
            border: Border.all(color: borderColor, width: 1.w),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day.day.toString(),
                style: AppTextStyle.bodyMedium.copyWith(
                  color: hasStatus
                      ? themeColors.onSurface
                      : themeColors.onSurfaceVariant,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
                ),
              ),
              if (dotColor != null) ...[
                const SizedBox(height: 2),
                Container(
                  width: 5.w,
                  height: 5.w,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
        },
        children: [
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: _LegendItem(
                  color: themeColors.presentText,
                  label: l10n.present,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: _LegendItem(
                  color: themeColors.leaveText,
                  label: l10n.leave,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: _LegendItem(
                  color: themeColors.absentText,
                  label: l10n.absent,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: _LegendItem(
                  color: themeColors.halfDayText,
                  label: l10n.halfDay,
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              _LegendItem(color: themeColors.weekendText, label: l10n.weekend),
              _LegendItem(color: themeColors.holidayText, label: l10n.holiday),
              const SizedBox.shrink(),
              const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    final themeColors = AppColors.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6.w),
        Text(
          label,
          style: AppTextStyle.bodyMediumOne.copyWith(
            color: themeColors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
