import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_assignment_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/shared/components/mandatory_label.dart';
import 'package:flutter/material.dart';

class TimesheetAssignmentList extends StatelessWidget {
  final List<ProjectAssignmentEntity> assignments;
  final VoidCallback onAdd;
  final Function(int, ProjectAssignmentEntity) onEdit;
  final Function(int) onDelete;

  const TimesheetAssignmentList({
    super.key,
    required this.assignments,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MandatoryLabel(labelText: l10n.projectAssignments),
            OutlinedButton.icon(
              onPressed: onAdd,
              icon: Icon(
                Icons.add,
                size: 18,
                color: AppColors.of(context).primary,
              ),
              label: Text(
                l10n.addProject,
                style: AppTextStyle.bodyMedium.copyWith(
                  color: AppColors.of(context).primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.of(context).border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.r8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.p12),
        if (assignments.isEmpty)
          Container(
            padding: const EdgeInsets.all(AppConstants.p24),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.of(context).surface,
              borderRadius: BorderRadius.circular(AppConstants.r12),
              border: Border.all(
                color: AppColors.of(context).border,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.assignment_outlined,
                  size: 40,
                  color: AppColors.of(
                    context,
                  ).textSecondary.withValues(alpha: 0.5),
                ),
                const SizedBox(height: AppConstants.p12),
                Text(
                  l10n.noProjectsAdded,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.of(context).textSecondary,
                  ),
                ),
              ],
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: assignments.length,
            itemBuilder: (context, index) {
              final item = assignments[index];
              return _AssignmentCard(
                item: item,
                onEdit: () => onEdit(index, item),
                onDelete: () => onDelete(index),
              );
            },
          ),
      ],
    );
  }
}

class _AssignmentCard extends StatelessWidget {
  final ProjectAssignmentEntity item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _AssignmentCard({
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.p12),
      decoration: BoxDecoration(
        color: AppColors.of(context).surface,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.p16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.project,
                    style: AppTextStyle.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (item.date != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      DateTimeUtils.formatDateString(item.date),
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.of(context).primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              onPressed: onEdit,
              icon: Icon(
                Icons.edit_outlined,
                size: 20,
                color: AppColors.of(context).textSecondary,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: onDelete,
              icon: Icon(
                Icons.delete_outline,
                size: 20,
                color: AppColors.of(context).error,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
