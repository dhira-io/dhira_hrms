import 'package:flutter/material.dart';
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
            TextButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add, color: AppColors.primary),
              label: Text(l10n.addProject, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.primary)),
            ),
          ],
        ),
        if (assignments.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.p20), 
              child: Text(
                l10n.noProjectsAdded, 
                style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
              ),
            ),
          )
        else
          ...assignments.asMap().entries.map((entry) {
            final idx = entry.key;
            final item = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: AppConstants.p8),
              child: ListTile(
                title: Text(item.project, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  'Spent: ${item.spentHours}h | Expected: ${item.expectedHours}h',
                  style: AppTextStyle.bodySmall,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () => onEdit(idx, item)),
                    IconButton(icon: const Icon(Icons.delete, size: 18, color: AppColors.error), onPressed: () => onDelete(idx)),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }
}
