import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';
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
  const TimesheetWeekSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimesheetBloc, TimesheetState>(
      buildWhen: (previous, current) =>
          previous.selectedDate != current.selectedDate ||
          previous.editAssignments != current.editAssignments ||
          previous.weeklyTotalHours != current.weeklyTotalHours ||
          previous.taskDays != current.taskDays ||
          previous.holidayDays != current.holidayDays ||
          previous.currentWeekRangeText != current.currentWeekRangeText,
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        final selectedDate = state.selectedDate ?? DateTime.now();
        final startOfWeek = DateTimeUtils.getStartOfWeek(selectedDate);
        final assignments = state.editAssignments;
        final totalWeeklyHours = state.weeklyTotalHours;
        final taskDays = state.taskDays;
        final holidayDays = state.holidayDays;
        final rangeText = DateTimeUtils.getTimesheetWeekLabel(selectedDate, l10n: l10n);

        double getHoursForDate(DateTime date) {
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TimesheetWeeklyTotalCard(totalWeeklyHours: totalWeeklyHours),
            const SizedBox(height: AppConstants.p20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _ChevronButton(
                  icon: Icons.chevron_left,
                  onTap: DateTimeUtils.isWeekAllowed(
                    startOfWeek.subtract(const Duration(days: 7)),
                  ) ? () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.read<TimesheetBloc>().add(
                      const TimesheetEvent.previousWeekRequested(),
                    );
                  } : null,
                  isEnabled: DateTimeUtils.isWeekAllowed(
                    startOfWeek.subtract(const Duration(days: 7)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    rangeText,
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
                  ) ? () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.read<TimesheetBloc>().add(
                      const TimesheetEvent.nextWeekRequested(),
                    );
                  } : null,
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
                      hasTask: taskDays.contains(dateOnly),
                      isHoliday: holidayDays.contains(dateOnly),
                      isWeekend: date.weekday == DateTime.saturday || date.weekday == DateTime.sunday,
                    ),
                    onTap: () {
                      context.read<TimesheetBloc>().add(
                        TimesheetEvent.daySelected(date),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
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
