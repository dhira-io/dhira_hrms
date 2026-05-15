import 'package:flutter/material.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/components/mandatory_label.dart';
import '../../domain/entities/timesheet_entities.dart';

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
              icon: const Icon(Icons.add, size: 18, color: AppColors.primary),
              label: Text(l10n.addProject, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w500)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
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
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppConstants.r12),
              border: Border.all(color: AppColors.border, style: BorderStyle.solid),
            ),
            child: Column(
              children: [
                Icon(Icons.assignment_outlined, size: 40, color: AppColors.textSecondary.withValues(alpha: 0.5)),
                const SizedBox(height: AppConstants.p12),
                Text(
                  l10n.noProjectsAdded, 
                  style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
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
        color: AppColors.surface,
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
                    style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                  ),
                  if (item.date != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      DateTime.parse(item.date!).format('dd-MM-yyyy'),
                      style: AppTextStyle.bodySmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w500),
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.textSecondary),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline, size: 20, color: AppColors.error),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
