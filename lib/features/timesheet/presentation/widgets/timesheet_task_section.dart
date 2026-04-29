import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../l10n/app_localizations.dart';

class TimesheetTaskSection extends StatefulWidget {
  final List<ProjectAssignmentEntity> assignments;
  final DateTime? selectedDate;
  final Function(ProjectAssignmentEntity, int) onEdit;
  final Function(ProjectAssignmentEntity) onDelete;

  const TimesheetTaskSection({
    super.key,
    required this.assignments,
    this.selectedDate,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<TimesheetTaskSection> createState() => _TimesheetTaskSectionState();
}

class _TimesheetTaskSectionState extends State<TimesheetTaskSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final title = (widget.selectedDate != null &&
        !DateTimeUtils.isToday(widget.selectedDate!))
        ? l10n.timesheetDateTasks(
      widget.selectedDate!.format('EEEE, MMM d'),
    )
        : l10n.timesheetTodaysTasks;

    final displayCount = _isExpanded
        ? widget.assignments.length
        : min(2, widget.assignments.length);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: AppTextStyle.h3.copyWith(fontSize: 14)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryFixed,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                widget.assignments.length.toString(),
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.onPrimaryFixedVariant,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (widget.assignments.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                l10n.timesheetNoTasksForDay,
                style: AppTextStyle.bodySmall,
              ),
            ),
          )
        else ...[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayCount,
            itemBuilder: (context, index) {
              final task = widget.assignments[index];
              return _buildTaskCard(task, index);
            },
          ),
          if (widget.assignments.length > 2)
            Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? l10n.showLess : l10n.showMore,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ],
    );
  }

  Widget _buildTaskCard(ProjectAssignmentEntity task, int index) {
    final status = task.status ?? "Draft";
    final isApproved = status == "Approved";

    final statusBg = isApproved ? AppColors.successBg : AppColors.warningLight;
    final statusText = isApproved ? AppColors.successDark : AppColors.warningDark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.1)),
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
              color: AppColors.primaryFixed,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.task_alt,
              color: AppColors.onPrimaryFixedVariant,
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
                    Expanded(
                      child: Text(
                        task.taskData?.isNotEmpty == true ? task.taskData! : task.project,
                        style: AppTextStyle.h3.copyWith(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
                            style: AppTextStyle.bodySmall.copyWith(
                              color: statusText,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => widget.onEdit(task, index),
                            borderRadius: BorderRadius.circular(99),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.edit, size: 18, color: AppColors.primary),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => widget.onDelete(task),
                            borderRadius: BorderRadius.circular(99),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.delete, size: 18, color: AppColors.error),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(task.description ?? "", style: AppTextStyle.bodySmall.copyWith(fontSize: 12)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      "${task.spentHours}h",
                      style: AppTextStyle.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
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
