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
    final isDraft = status == TimesheetStatus.draft;

    final statusColor = isApproved
        ? AppColors.of(context).success
        : isDraft 
            ? AppColors.of(context).textSecondary 
            : AppColors.colorOrange400;

    final statusBorderColor = isApproved
        ? AppColors.colorGreen300
        : isDraft
            ? AppColors.colorNeutral400
            : AppColors.colorOrange300;

    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(9.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.project,
                      style: TextStyle(
                        color: AppColors.of(context).textPrimary,
                        fontSize: 14.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      task.taskData ?? '',
                      style: TextStyle(
                        color: AppColors.of(context).textSecondary,
                        fontSize: 10.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.of(context).surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(99.r),
                  border: Border.all(color: statusBorderColor),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14.sp,
                color: AppColors.of(context).textSecondary,
              ),
              SizedBox(width: 4.w),
              Text(
                '${task.spentHours}h ${l10n.logged}',
                style: TextStyle(
                  color: AppColors.of(context).textSecondary,
                  fontSize: 11.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 35.w),
              if (task.expectedHours > 0)
                Text(
                  '${(task.spentHours) - task.expectedHours}h variance',
                  style: TextStyle(
                    color: AppColors.colorGreen700,
                    fontSize: 12.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            l10n.description,
            style: TextStyle(
              color: AppColors.of(context).textPrimary,
              fontSize: 12.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.of(context).surfaceContainerLowest,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: AppColors.slate200),
            ),
            child: Text(
              task.description ?? '',
              style: TextStyle(
                color: AppColors.of(context).textSecondary,
                fontSize: 10.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.attach_file,
                          size: 16.sp,
                          color: AppColors.of(context).primaryContainer,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          l10n.view,
                          style: TextStyle(
                            color: AppColors.of(context).primaryContainer,
                            fontSize: 14.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                const SizedBox.shrink(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => onEdit(task, index),
                    child: Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        color: AppColors.slate100,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 16.sp,
                        color: AppColors.slate500,
                      ),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  GestureDetector(
                    onTap: () => onDelete(task),
                    child: Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        color: AppColors.errorBg,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.delete,
                        size: 16.sp,
                        color: AppColors.of(context).error,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
