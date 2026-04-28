import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

import '../../domain/entities/timesheet_entities.dart';

class TimesheetWeekSelector extends StatelessWidget {
  final DateTime selectedDate;
  final List<ProjectAssignmentEntity> assignments;
  final List<DateTime> holidays;
  final double totalWeeklyHours;
  final Function(DateTime) onDateSelected;
  final Function() onPreviousWeek;
  final Function() onNextWeek;

  const TimesheetWeekSelector({
    super.key,
    required this.selectedDate,
    required this.assignments,
    this.holidays = const [],
    this.totalWeeklyHours = 0.0,
    required this.onDateSelected,
    required this.onPreviousWeek,
    required this.onNextWeek,
  });

  @override
  Widget build(BuildContext context) {
    final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final rangeText = "${DateFormat('MMM d').format(startOfWeek)} - ${DateFormat('MMM d, yyyy').format(endOfWeek)}";

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                _buildChevronButton(Icons.chevron_left, onPreviousWeek),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(rangeText, style: AppTextStyle.h3.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                _buildChevronButton(Icons.chevron_right, onNextWeek),
              ],
            ),
            Text(
              "Total: ${totalWeeklyHours.toStringAsFixed(1)} h",
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
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
              final isSelected = date.year == selectedDate.year &&
                  date.month == selectedDate.month &&
                  date.day == selectedDate.day;
              
              final hasTask = assignments.any((a) {
                final d = DateTime.tryParse(a.date ?? "");
                return d != null && d.year == date.year && d.month == date.month && d.day == date.day && (a.spentHours > 0);
              });

              final isHoliday = holidays.any((h) => h.year == date.year && h.month == date.month && h.day == date.day);

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
              }

              return Container(
                width: 56,
                margin: const EdgeInsets.only(right: 8),
                child: Material(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => onDateSelected(date),
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
