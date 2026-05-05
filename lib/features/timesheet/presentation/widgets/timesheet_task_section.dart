import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../l10n/app_localizations.dart';
import 'timesheet_task_card.dart';

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
              return TimesheetTaskCard(
                task: task,
                index: index,
                onEdit: widget.onEdit,
                onDelete: widget.onDelete,
              );
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
  }

