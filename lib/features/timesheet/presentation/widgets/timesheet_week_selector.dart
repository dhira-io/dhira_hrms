import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';
import 'timesheet_day_bubble.dart';
import 'timesheet_weekly_total_card.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimesheetWeekSelector extends StatelessWidget {
  const TimesheetWeekSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimesheetBloc, TimesheetState>(
      buildWhen: (previous, current) {
        if (previous.runtimeType != current.runtimeType) return true;
        if (previous.selectedDate != current.selectedDate) return true;
        if (previous.editAssignments != current.editAssignments) return true;
        if (previous.holidayDays != current.holidayDays) return true;
        if (previous.taskDays != current.taskDays) return true;
        return false;
      },
      builder: (context, state) {
        final selectedDate = state.selectedDate ?? DateTime.now();
        final startOfWeek = DateTimeUtils.getStartOfWeek(selectedDate);
        final rangeText = state.currentWeekRangeText;
        final totalWeeklyHours = state.weeklyTotalHours;
        final taskDays = state.taskDays;
        final holidayDays = state.holidayDays;
        final assignments = state.editAssignments;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TimesheetWeeklyTotalCard(totalWeeklyHours: totalWeeklyHours),
            const SizedBox(height: AppConstants.p20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildChevronButton(
                  Icons.chevron_left,
                  DateTimeUtils.isWeekAllowed(
                    startOfWeek.subtract(const Duration(days: 7)),
                  ) ? () => _onPreviousWeek(context, selectedDate)
                      : null,
                  isEnabled: DateTimeUtils.isWeekAllowed(
                    startOfWeek.subtract(const Duration(days: 7)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(rangeText,
                      style: AppTextStyle.h3.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.slate600)),
                ),
                _buildChevronButton(
                  Icons.chevron_right,
                  DateTimeUtils.isWeekAllowed(
                    startOfWeek.add(const Duration(days: 7)),
                  ) ? () => _onNextWeek(context, selectedDate)
                      : null,
                  isEnabled:  DateTimeUtils.isWeekAllowed(
                    startOfWeek.add(const Duration(days: 7)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 85,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  final date = startOfWeek.add(Duration(days: index));
                  final dateOnly = DateTime(date.year, date.month, date.day);

                  return TimesheetDayBubble(
                    date: date,
                    hours: getHoursForDate(date, assignments),
                    isSelected: dateOnly == DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
                    hasTask: taskDays.contains(dateOnly),
                    isHoliday: holidayDays.contains(dateOnly),
                    isWeekend: date.weekday == DateTime.saturday || date.weekday == DateTime.sunday,
                    onTap: () => context.read<TimesheetBloc>().add(TimesheetEvent.daySelected(date)),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildChevronButton(
      IconData icon,
      VoidCallback? onTap, {
        bool isEnabled = true,
      }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(99),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            icon,
            size: 20,
            color: isEnabled
                ? AppColors.textSecondary.withValues(alpha: 0.5)
                : Colors.grey.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }

  double getHoursForDate(DateTime date, List<ProjectAssignmentEntity> assignments) {
    return assignments
        .where((task) {
      if (task.date == null) return false;

      final taskDate = DateTime.parse(task.date!);

      return taskDate.year == date.year &&
          taskDate.month == date.month &&
          taskDate.day == date.day;
    })
        .fold(0.0, (sum, task) => sum + task.spentHours);
  }

  void _onPreviousWeek(BuildContext context, DateTime current) {
    final prevWeekDate = current.subtract(const Duration(days: 7));
    final startOfWeek = prevWeekDate.subtract(Duration(days: prevWeekDate.weekday - 1));
    final dominantMonth = DateTimeUtils.getDominantMonthOfWeek(startOfWeek);
    final dominantYear = DateTimeUtils.getDominantYearOfWeek(startOfWeek);
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    context.read<TimesheetBloc>().add(TimesheetEvent.daySelected(prevWeekDate));
    context.read<TimesheetBloc>().add(TimesheetEvent.fromDateChanged(startOfWeek));
    context.read<TimesheetBloc>().add(TimesheetEvent.toDateChanged(endOfWeek));

    context.read<TimesheetBloc>().add(
        TimesheetEvent.fetchMonthWiseRequested(
            month: dominantMonth, year: dominantYear));

    context.read<TimesheetBloc>().add(
      TimesheetEvent.fetchOverviewRequested(
        month: dominantMonth,
        year: dominantYear,
      ),
    );
  }

  void _onNextWeek(BuildContext context, DateTime current) {
    final nextWeekDate = current.add(const Duration(days: 7));
    final startOfWeek = nextWeekDate.subtract(Duration(days: nextWeekDate.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final dominantMonth = DateTimeUtils.getDominantMonthOfWeek(startOfWeek);
    final dominantYear = DateTimeUtils.getDominantYearOfWeek(startOfWeek);
    
    context.read<TimesheetBloc>().add(TimesheetEvent.daySelected(nextWeekDate));
    context.read<TimesheetBloc>().add(TimesheetEvent.fromDateChanged(startOfWeek));
    context.read<TimesheetBloc>().add(TimesheetEvent.toDateChanged(endOfWeek));

    context.read<TimesheetBloc>().add(
        TimesheetEvent.fetchMonthWiseRequested(
            month: dominantMonth, year: dominantYear));

    context.read<TimesheetBloc>().add(
      TimesheetEvent.fetchOverviewRequested(
        month: dominantMonth,
        year: dominantYear,
      ),
    );
  }
}
