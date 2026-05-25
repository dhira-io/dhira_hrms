import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';
import 'timesheet_day_bubble.dart';
import 'timesheet_weekly_total_card.dart';
import '../../domain/entities/timesheet_entities.dart';

class WeeklyTimesheetOverview {
  final List<ProjectAssignmentEntity> assignments;
  final Set<DateTime> holidayDays;
  final Set<DateTime> taskDays;
  final double totalWeeklyHours;
  final String rangeText;

  const WeeklyTimesheetOverview({
    required this.assignments,
    this.holidayDays = const {},
    this.taskDays = const {},
    this.totalWeeklyHours = 0.0,
    this.rangeText = "",
  });
}

class TimesheetWeekSelector extends StatelessWidget {
  final DateTime selectedDate;
  final WeeklyTimesheetOverview overview;
  final Function(DateTime) onDateSelected;
  final Function() onPreviousWeek;
  final Function() onNextWeek;

  const TimesheetWeekSelector({
    super.key,
    required this.selectedDate,
    required this.overview,
    required this.onDateSelected,
    required this.onPreviousWeek,
    required this.onNextWeek,
  });

  @override
  Widget build(BuildContext context) {
    final startOfWeek = DateTimeUtils.getStartOfWeek(selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TimesheetWeeklyTotalCard(totalWeeklyHours: overview.totalWeeklyHours),
        const SizedBox(height: AppConstants.p20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _ChevronButton(
              icon: Icons.chevron_left,
              onTap: DateTimeUtils.isWeekAllowed(
                startOfWeek.subtract(const Duration(days: 7)),
              ) ? onPreviousWeek
                  : null,
              isEnabled: DateTimeUtils.isWeekAllowed(
                startOfWeek.subtract(const Duration(days: 7)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                overview.rangeText,
                style: AppTextStyle.h3.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.of(context).slate600,
                ),
              ),
            ),
            _ChevronButton(
              icon: Icons.chevron_right,
              onTap: DateTimeUtils.isWeekAllowed(
                startOfWeek.add(const Duration(days: 7)),
              ) ? onNextWeek
                  : null,
              isEnabled: DateTimeUtils.isWeekAllowed(
                startOfWeek.add(const Duration(days: 7)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 72,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) {
              final date = startOfWeek.add(Duration(days: index));
              final dateOnly = DateTime(date.year, date.month, date.day);

              return TimesheetDayBubble(
                date: date,
                hours: getHoursForDate(date),
                config: DayBubbleConfig(
                  isSelected: dateOnly == DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
                  hasTask: overview.taskDays.contains(dateOnly),
                  isHoliday: overview.holidayDays.contains(dateOnly),
                  isWeekend: date.weekday == DateTime.saturday || date.weekday == DateTime.sunday,
                ),
                onTap: () => onDateSelected(date),
              );
            },
          ),
        ),
      ],
    );
  }

  double getHoursForDate(DateTime date) {
    return overview.assignments
        .where((task) {
      if (task.date == null) return false;

      final taskDate = DateTime.parse(task.date!);

      return taskDate.year == date.year &&
          taskDate.month == date.month &&
          taskDate.day == date.day;
    })
        .fold(0.0, (sum, task) => sum + task.spentHours);
  }
}

class _ChevronButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool isEnabled;

  const _ChevronButton({
    required this.icon,
    required this.onTap,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = AppColors.of(context);
    return Material(
      color: themeColors.transparent,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(99),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            icon,
            size: 20,
            color: isEnabled
                ? themeColors.textSecondary.withValues(alpha: 0.5)
                : themeColors.placeholdergrey.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}
