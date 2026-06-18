import 'package:dhira_hrms/core/constants/api_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/string_utils.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_assignment_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/core/widgets/common_pdf_viewer.dart';
import 'package:dhira_hrms/core/widgets/common_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bottomsheet/add_task_bottom_sheet.dart';
import 'package:dhira_hrms/core/widgets/common_confirmation_bottom_sheet.dart';

class TimesheetTaskCard extends StatelessWidget {
  final ProjectAssignmentEntity task;
  final int index;

  const TimesheetTaskCard({
    super.key,
    required this.task,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor;
    final Color statusBorderColor;

    if (task.isApproved) {
      statusColor = AppColors.colorGreen600;
      statusBorderColor = AppColors.colorGreen300;
    } else if (task.isRejected) {
      statusColor = AppColors.colorRed600;
      statusBorderColor = AppColors.colorRed300;
    } else if (task.isPending) {
      statusColor = AppColors.colorOrange500;
      statusBorderColor = AppColors.colorOrange300;
    } else {
      statusColor = AppColors.of(context).textSecondary;
      statusBorderColor = AppColors.colorNeutral400;
    }

    final l10n = AppLocalizations.of(context)!;
    final String varianceText =
        '${task.varianceSign}${l10n.hoursVariance(task.variance.abs().toStringAsFixed(task.variance % 1 == 0 ? 0 : 1))}';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.of(context).tableBorder),
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
                      style: AppTextStyle.labelLarge.copyWith(
                        color: AppColors.of(context).textPrimary,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      task.taskData ?? '',
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.of(context).textSecondary,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(80.r),
                  border: Border.all(color: statusBorderColor),
                ),
                child: Text(
                  task.status ?? AppConstants.placeholderText,
                  style: AppTextStyle.labelMedium.copyWith(
                    color: statusColor,
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
                style: AppTextStyle.bodySmall.copyWith(
                  fontSize: 9.sp,
                  color: AppColors.of(context).textSecondary,
                ),
              ),
              if (task.expectedHours > 0) ...[
                SizedBox(width: 24.w),
                Text(
                  varianceText,
                  style: AppTextStyle.bodySmall.copyWith(
                    fontSize: 9.sp,
                    color: task.variance >= 0
                        ? AppColors.colorEmerald500
                        : AppColors.of(context).error,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.description,
            style: AppTextStyle.labelMedium.copyWith(
              color: AppColors.of(context).textPrimary,
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
              border: Border.all(color: AppColors.of(context).tableBorder),
            ),
            child: Text(
              task.description ?? '',
              style: AppTextStyle.bodyMedium.copyWith(
                fontSize: 11.sp,
                color: AppColors.of(context).textSecondary,
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
                    final path = uri.path.toLowerCase();
                    final isPdfOrDoc =
                        path.endsWith('.pdf') ||
                        path.endsWith('.docx') ||
                        path.endsWith('.doc') ||
                        path.endsWith('.xlsx') ||
                        path.endsWith('.xls') ||
                        path.endsWith('.pptx') ||
                        path.endsWith('.ppt');
                    final isImage =
                        path.endsWith('.png') ||
                        path.endsWith('.jpg') ||
                        path.endsWith('.jpeg') ||
                        path.endsWith('.gif') ||
                        path.endsWith('.webp');

                    if (isPdfOrDoc) {
                      if (context.mounted) {
                        CommonPdfViewer.show(
                          context: context,
                          title: l10n.attachmentsLabel,
                          fileUrl: attachmentUrl,
                        );
                      }
                    } else if (isImage) {
                      if (context.mounted) {
                        CommonImageViewer.show(
                          context: context,
                          title: l10n.attachmentsLabel,
                          imageUrl: attachmentUrl,
                        );
                      }
                    } else {
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      }
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
                          l10n.viewAttach,
                          style: AppTextStyle.labelLarge.copyWith(
                            color: AppColors.of(context).primaryContainer,
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
                    onTap: () {
                      final bloc = context.read<TimesheetBloc>();
                      final realIndex = bloc.state.editAssignments.indexOf(task);
                      bloc.add(
                        TimesheetEvent.editTaskRequested(
                          task: task,
                          index: realIndex,
                        ),
                      );
                      AddTaskBottomSheet.show(
                        context,
                        timesheetId: bloc.state.activeTimesheetIdOrDefault,
                        editingTask: task,
                        editingIndex: realIndex,
                      );
                    },
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
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      final confirmed = await showModalBottomSheet<bool>(
                        context: context,
                        backgroundColor: AppColors.transparent,
                        isScrollControlled: true,
                        builder: (context) => CommonConfirmationBottomSheet(
                          icon: Icon(
                            Icons.error_outline,
                            color: AppColors.of(context).absentText,
                            size: 20.w,
                          ),
                          iconBackgroundColor: AppColors.confirmationRedBg,
                          title: l10n.confirmDeletion,
                          subtitle: l10n.deleteTaskConfirmationSubtitle,
                          cancelAction: ConfirmationAction(
                            label: l10n.cancel,
                            onTap: () => Navigator.of(context).pop(false),
                          ),
                          confirmAction: ConfirmationAction(
                            label: l10n.delete,
                            onTap: () => Navigator.of(context).pop(true),
                          ),
                        ),
                      );

                      if (confirmed == true && context.mounted) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.read<TimesheetBloc>().add(
                          TimesheetEvent.deleteTaskRequested(task: task),
                        );
                      }
                    },
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
