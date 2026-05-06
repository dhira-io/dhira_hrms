import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';
import 'timesheet_day_bubble.dart';
import 'timesheet_weekly_total_card.dart';
import '../../domain/entities/timesheet_entities.dart';

class TimesheetWeekSelector extends StatelessWidget {
  final DateTime selectedDate;
  final List<ProjectAssignmentEntity> assignments;
  final Set<DateTime> holidayDays;
  final Set<DateTime> taskDays;
  final double totalWeeklyHours;
  final String rangeText;
  final Function(DateTime) onDateSelected;
  final Function() onPreviousWeek;
  final Function() onNextWeek;

  const TimesheetWeekSelector({
    super.key,
    required this.selectedDate,
    required this.assignments,
    this.holidayDays = const {},
    this.taskDays = const {},
    this.totalWeeklyHours = 0.0,
    this.rangeText = "",
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
        TimesheetWeeklyTotalCard(totalWeeklyHours: totalWeeklyHours),
        const SizedBox(height: AppConstants.p20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildChevronButton(Icons.chevron_left, onPreviousWeek),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(rangeText,
                  style: AppTextStyle.h3.copyWith(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.slate600)),
            ),
            _buildChevronButton(Icons.chevron_right, onNextWeek),
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
                isSelected: dateOnly == DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
                hasTask: taskDays.contains(dateOnly),
                isHoliday: holidayDays.contains(dateOnly),
                isWeekend: date.weekday == DateTime.saturday || date.weekday == DateTime.sunday,
                onTap: () => onDateSelected(date),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChevronButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(99),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, size: 20, color: AppColors.textSecondary.withValues(alpha: 0.5)),
        ),
      ),
    );
  }
}
