import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/timesheet_entities.dart';

class TimesheetTaskCard extends StatelessWidget {
  final ProjectAssignmentEntity task;
  final int index;
  final Function(ProjectAssignmentEntity, int) onEdit;
  final Function(ProjectAssignmentEntity) onDelete;

  const TimesheetTaskCard({
    super.key,
    required this.task,
    required this.index,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final status = task.status ?? TimesheetStatus.draft;
    final isApproved = status == TimesheetStatus.approved;

    final statusBg = isApproved ? AppColors.successBg : AppColors.warningLight;
    final statusText = isApproved ? AppColors.successDark : AppColors.warningDark;

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.p12),
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
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
            padding: const EdgeInsets.all(AppConstants.p10),
            decoration: BoxDecoration(
              color: AppColors.primaryFixed,
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
            child: const Icon(
              Icons.task_alt,
              color: AppColors.onPrimaryFixedVariant,
              size: 20,
            ),
          ),
          const SizedBox(width: AppConstants.p16),
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
                        style: AppTextStyle.h3.copyWith(fontSize: AppConstants.fs14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.p8,
                            vertical: AppConstants.p4,
                          ),
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            status,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: statusText,
                              fontWeight: FontWeight.bold,
                              fontSize: AppConstants.fs10,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppConstants.p8),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => onEdit(task, index),
                            borderRadius: BorderRadius.circular(99),
                            child: const Padding(
                              padding: EdgeInsets.all(AppConstants.p4),
                              child: Icon(Icons.edit, size: 18, color: AppColors.primary),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppConstants.p4),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => onDelete(task),
                            borderRadius: BorderRadius.circular(99),
                            child: const Padding(
                              padding: EdgeInsets.all(AppConstants.p4),
                              child: Icon(Icons.delete, size: 18, color: AppColors.error),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  task.description ?? "",
                  style: AppTextStyle.bodySmall.copyWith(fontSize: AppConstants.fs12),
                ),
                const SizedBox(height: AppConstants.p12),
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: AppConstants.p4),
                    Text(
                      "${task.spentHours}h",
                      style: AppTextStyle.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontSize: AppConstants.fs10,
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
