import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      height: 45.h,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.p10,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.of(context).surface,
        borderRadius: BorderRadius.circular(AppConstants.r32),
        border: Border.all(color: AppColors.of(context).outlineVariant),
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
                color: const Color(0xFFFAFAFA),
                border: Border.all(color: const Color(0xFFE5E5E5)),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/svg/chevron_left.svg',
                  width: 14.w,
                  height: 14.w,
                  colorFilter: ColorFilter.mode(
                    AppColors.of(context).onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          Text(
            monthLabel,
            style: AppTextStyle.headingSmallTwoBold.copyWith(
              color: AppColors.of(context).onSurface,
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
                color: const Color(0xFFFAFAFA),
                border: Border.all(color: const Color(0xFFE5E5E5)),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/svg/chevron_right.svg',
                  width: 14.w,
                  height: 14.w,
                  colorFilter: ColorFilter.mode(
                    AppColors.of(context).onSurface,
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
        border: Border.all(color: AppColors.of(context).outlineVariant),
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
                      color: const Color(0xFF62748E),

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
    Color backgroundColor = const Color(0xFFFFFFFF);
    Color borderColor = const Color(0xFFE5E5E5);
    Color? dotColor;
    bool hasStatus = false;

    if (status != null && status!.isNotEmpty) {
      final s = status!.toLowerCase();
      if (s == 'present') {
        backgroundColor = AppColors.of(context).presentBg;
        borderColor = AppColors.of(context).presentText;
        dotColor = AppColors.of(context).presentText;
        hasStatus = true;
      } else if (s == 'absent') {
        backgroundColor = AppColors.of(context).absentBg;
        borderColor = AppColors.of(context).absentText;
        dotColor = AppColors.of(context).absentText;
        hasStatus = true;
      } else if (s == 'on leave' || s == 'leave') {
        backgroundColor = AppColors.of(context).leaveBg;
        borderColor = AppColors.of(context).leaveText;
        dotColor = AppColors.of(context).leaveText;
        hasStatus = true;
      } else if (s == 'holiday') {
        backgroundColor = AppColors.of(context).holidayBg;
        borderColor = AppColors.of(context).holidayText;
        dotColor = AppColors.of(context).holidayText;
        hasStatus = true;
      } else if (s == 'weekend' || s == 'weekly off') {
        backgroundColor = AppColors.of(context).weekendBg;
        borderColor = AppColors.of(context).weekendText;
        dotColor = AppColors.of(context).weekendText;
        hasStatus = true;
      } else if (s == 'half day' || s == 'half-day') {
        backgroundColor = AppColors.of(context).halfDayBg;
        borderColor = AppColors.of(context).halfDayText;
        dotColor = AppColors.of(context).halfDayText;
        hasStatus = true;
      }
    }

    if (isToday) {
      borderColor = AppColors.of(context).calendarTodayBorder;
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
                  color: hasStatus ? const Color(0xFF020618) : const Color(0xFF62748E),
                  fontWeight: isToday
                      ? FontWeight.bold
                      : FontWeight.w600,
                  fontSize: 12.sp,
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
            color: const Color(0xFF314158),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
