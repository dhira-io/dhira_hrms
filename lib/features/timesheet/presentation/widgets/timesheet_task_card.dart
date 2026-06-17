import 'package:dhira_hrms/core/constants/api_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
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
    final isRejected = status == TimesheetStatus.rejected;
    final isPending = status == TimesheetStatus.pending;

    final Color statusColor;
    final Color statusBorderColor;

    if (isApproved) {
      statusColor = AppColors.colorGreen600;
      statusBorderColor = AppColors.colorGreen300;
    } else if (isRejected) {
      statusColor = AppColors.colorRed600;
      statusBorderColor = AppColors.colorRed300;
    } else if (isPending) {
      statusColor = AppColors.colorOrange500;
      statusBorderColor = AppColors.colorOrange300;
    } else {
      statusColor = AppColors.of(context).textSecondary;
      statusBorderColor = AppColors.colorNeutral400;
    }

    final l10n = AppLocalizations.of(context)!;
    final double variance = task.spentHours - task.expectedHours;
    final String varianceSign = variance >= 0 ? '+' : '';
    final String varianceText =
        '$varianceSign${variance.toStringAsFixed(variance % 1 == 0 ? 0 : 1)}h variance';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
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
                        fontSize: 12.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
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
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(80.r),
                  border: Border.all(color: statusBorderColor),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Icon(
                Icons.access_time_outlined,
                size: 12.sp,
                color: AppColors.of(context).textSecondary,
              ),
              SizedBox(width: 4.w),
              Text(
                '${task.spentHours}h ${l10n.logged}',
                style: TextStyle(
                  color: AppColors.of(context).textSecondary,
                  fontSize: 9.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (task.expectedHours > 0) ...[
                SizedBox(width: 24.w),
                Text(
                  varianceText,
                  style: TextStyle(
                    color: variance >= 0
                        ? AppColors.colorEmerald500
                        : AppColors.of(context).error,
                    fontSize: 9.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.description,
            style: TextStyle(
              color: AppColors.of(context).textPrimary,
              fontSize: 11.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColors.of(context).surfaceContainerLowest,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.slate200),
            ),
            child: Text(
              task.description ?? '',
              style: TextStyle(
                color: AppColors.of(context).textSecondary,
                fontSize: 11.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ),
          SizedBox(height: 6.h),
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.attach_file,
                          size: 16.sp,
                          color: AppColors.of(context).primaryContainer,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'View Attach',
                          style: TextStyle(
                            color: AppColors.of(context).primaryContainer,
                            fontSize: 12.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
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
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Icon(
                        Icons.edit_outlined,
                        size: 16.sp,
                        color: AppColors.of(context).textSecondary,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () => onDelete(task),
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Icon(
                        Icons.delete_outline,
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
