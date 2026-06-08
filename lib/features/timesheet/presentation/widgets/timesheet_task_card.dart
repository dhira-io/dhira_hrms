import 'package:dhira_hrms/core/constants/api_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/string_utils.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_assignment_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

    final statusBg = isApproved
        ? AppColors.of(context).successBg
        : AppColors.of(context).warningLight;
    final statusText = isApproved
        ? AppColors.of(context).successDark
        : AppColors.of(context).warningDark;
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.p12),
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(
          color: AppColors.of(context).outlineVariant.withValues(alpha: 0.1),
        ),
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
              color: AppColors.of(context).primaryFixed,
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
            child: Icon(
              Icons.task_alt,
              color: AppColors.of(context).onPrimaryFixedVariant,
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
                        task.taskData?.isNotEmpty == true
                            ? task.taskData!
                            : task.project,
                        style: AppTextStyle.h3.copyWith(
                          fontSize: AppConstants.fs12.sp,
                        ),
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
                            borderRadius: BorderRadius.circular(99.r),
                          ),
                          child: Text(
                            status,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: statusText,
                              fontWeight: FontWeight.bold,
                              fontSize: AppConstants.fs9.sp,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppConstants.p8),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => onEdit(task, index),
                            borderRadius: BorderRadius.circular(99.r),
                            child: Padding(
                              padding: const EdgeInsets.all(AppConstants.p4),
                              child: Icon(
                                Icons.edit,
                                size: 18,
                                color: AppColors.of(context).primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppConstants.p4),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => onDelete(task),
                            borderRadius: BorderRadius.circular(99.r),
                            child: Padding(
                              padding: const EdgeInsets.all(AppConstants.p4),
                              child: Icon(
                                Icons.delete,
                                size: 18,
                                color: AppColors.of(context).error,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  task.description ?? "",
                  style: AppTextStyle.bodySmall.copyWith(
                    fontSize: AppConstants.fs11.sp,
                  ),
                ),
                const SizedBox(height: AppConstants.p12),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: AppColors.of(context).textSecondary,
                    ),

                    const SizedBox(width: AppConstants.p4),

                    Text(
                      "${task.spentHours}h",
                      style: AppTextStyle.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.of(context).textPrimary,
                        fontSize: AppConstants.fs9.sp,
                      ),
                    ),

                    const Spacer(),

                    if ((task.attachments ?? "").isNotEmpty)
                      GestureDetector(
                        onTap: () async {
                          final attachmentUrl = task.attachments!.isAbsoluteUrl
                              ? task.attachments!
                              : '${ApiConstants.baseUrl}${task.attachments!}';

                          final uri = Uri.parse(attachmentUrl);

                          if (await canLaunchUrl(uri)) {
                            await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.attach_file,
                              size: 16,
                              color: AppColors.of(context).primary,
                            ),

                            SizedBox(width: 4.w),

                            Text(
                              l10n.view,
                              style: AppTextStyle.bodySmall.copyWith(
                                color: AppColors.of(context).primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
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
