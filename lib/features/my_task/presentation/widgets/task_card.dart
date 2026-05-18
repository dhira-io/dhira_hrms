import 'package:flutter/material.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/task_entity.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;

  const TaskCard({super.key, required this.task});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppColors.success;
      case 'in progress':
      case 'inprogress':
        return AppColors.warning;
      case 'pending':
        return AppColors.pending;
      case 'draft':
        return AppColors.draft;
      default:
        return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final statusColor = _getStatusColor(task.status);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r12)),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: AppTextStyle.h3.copyWith(fontSize: 16),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.p8, vertical: AppConstants.p4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppConstants.r8),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    task.status,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.p8),
            Text(
              task.description, 
              style: AppTextStyle.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppConstants.p12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${l10n.due}: ${task.dueDate.format('dd MMM, yyyy')}',
                  style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
                Text(
                  '${l10n.priority}: ${task.priority}',
                  style: AppTextStyle.label.copyWith(fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


