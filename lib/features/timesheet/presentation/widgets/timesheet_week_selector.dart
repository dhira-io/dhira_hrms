import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'timesheet_theme.dart';

class TimesheetWeekSelector extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final Function() onPreviousWeek;
  final Function() onNextWeek;

  const TimesheetWeekSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onPreviousWeek,
    required this.onNextWeek,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate start and end of the week for the range display
    final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final rangeText = "${DateFormat('MMM d').format(startOfWeek)} - ${DateFormat('MMM d, yyyy').format(endOfWeek)}";

    return Column(
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                _buildChevronButton(Icons.chevron_left, onPreviousWeek),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(rangeText, style: TimesheetStyles.h3.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                _buildChevronButton(Icons.chevron_right, onNextWeek),
              ],
            ),
            const Text(
              'This Week',
              style: TextStyle(
                color: TimesheetColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Day Selector
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

              return GestureDetector(
                onTap: () => onDateSelected(date),
                child: Container(
                  width: 56,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? TimesheetColors.primary : TimesheetColors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: TimesheetColors.primary.withValues(alpha: 0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('E').format(date).toUpperCase(),
                        style: TimesheetStyles.dateDay.copyWith(
                          color: isSelected ? Colors.white.withValues(alpha: 0.8) : TimesheetColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        date.day.toString(),
                        style: TimesheetStyles.dateNumber.copyWith(
                          color: isSelected ? Colors.white : TimesheetColors.textPrimary,
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
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChevronButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99),
        ),
        child: Icon(icon, size: 20, color: TimesheetColors.textSecondary.withValues(alpha: 0.5)),
      ),
    );
  }
}
