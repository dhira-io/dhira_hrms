import 'package:flutter/material.dart';
import '../../domain/entities/timesheet_entities.dart';
import 'timesheet_theme.dart';

class TimesheetTaskSection extends StatelessWidget {
  final List<ProjectAssignmentEntity> tasks;
  final Function(int) onEdit;
  final Function(int) onDelete;

  const TimesheetTaskSection({
    super.key,
    required this.tasks,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Today's Tasks", style: TimesheetStyles.h3.copyWith(fontSize: 14)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: TimesheetColors.primaryFixed,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                tasks.length.toString(),
                style: TimesheetStyles.bodySmall.copyWith(
                  color: TimesheetColors.onPrimaryFixedVariant,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (tasks.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "No tasks for this day",
                style: TimesheetStyles.bodySmall,
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return _buildTaskCard(task, index);
            },
          ),
      ],
    );
  }

  Widget _buildTaskCard(ProjectAssignmentEntity task, int index) {
    // Determine status (mocking for now as assignments don't have separate status in entity)
    // In a real app, this would come from the task entity
    final status = index % 2 == 0 ? "Approved" : "Pending";
    final statusBg = status == "Approved" ? TimesheetColors.green100 : TimesheetColors.orange100;
    final statusText = status == "Approved" ? TimesheetColors.green700 : TimesheetColors.orange700;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TimesheetColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TimesheetColors.border.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: index % 2 == 0 ? TimesheetColors.primaryFixed : TimesheetColors.tertiaryFixed,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              index % 2 == 0 ? Icons.code : Icons.palette,
              color: index % 2 == 0 ? TimesheetColors.primary : TimesheetColors.tertiary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(task.project, style: TimesheetStyles.h3.copyWith(fontSize: 14)),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            status,
                            style: TimesheetStyles.bodySmall.copyWith(
                              color: statusText,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => onEdit(index),
                          child: const Icon(Icons.edit, size: 18, color: TimesheetColors.primary),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => onDelete(index),
                          child: const Icon(Icons.delete, size: 18, color: TimesheetColors.error),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(task.description ?? "", style: TimesheetStyles.bodySmall.copyWith(fontSize: 12)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 14, color: TimesheetColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      "${task.spentHours}h",
                      style: TimesheetStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: TimesheetColors.textPrimary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
