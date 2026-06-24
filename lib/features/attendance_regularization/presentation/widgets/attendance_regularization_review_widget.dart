import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/bloc/attendance_regularization_state.dart';
import 'package:dhira_hrms/features/attendance_regularization/domain/entities/attendance_regularization_constants.dart';

class AttendanceRegularizationReviewWidget extends StatelessWidget {
  final AttendanceRegularizationFormData formData;
  final String managerName;

  const AttendanceRegularizationReviewWidget({
    super.key,
    required this.formData,
    required this.managerName,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = AppColors.of(context);

    return Column(
      children: [
        // Card 1: Attendance Details
        AttendanceRegularizationReviewCard(
          title: l10n.attendanceDetails,
          children: [
            AttendanceRegularizationReviewRow(
              label: l10n.date,
              value: formData.getFormattedDate,
            ),
            AttendanceRegularizationReviewRow(
              label: l10n.reasonType,
              value: _getRequestTypeLabel(l10n, formData.requestType),
            ),
            AttendanceRegularizationReviewRow(
              label: l10n.clockInTime.replaceAll('Time', '').trim(),
              value: formData.inTime?.format(context) ?? '',
            ),
            AttendanceRegularizationReviewRow(
              label: l10n.clockOutTime.replaceAll('Time', '').trim(),
              value: formData.outTime?.format(context) ?? '',
            ),
            AttendanceRegularizationReviewRow(
              label: l10n.duration,
              value: formData.getFormattedDuration(l10n.hours),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // Card 2: Reason
        AttendanceRegularizationReviewCard(
          title: l10n.reason,
          children: [
            Text(
              formData.reason,
              style: AppTextStyle.bodyMedium.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: themeColors.textPrimary,
                height: 1.4,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // Card 3: Attachment
        AttendanceRegularizationReviewCard(
          title: l10n.attachment,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/paperclip.svg',
                  width: 14.r,
                  height: 14.r,
                  colorFilter: ColorFilter.mode(
                    themeColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    formData.selectedFileName ?? l10n.none,
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: formData.uploadedFileUrl != null
                          ? themeColors.primary
                          : themeColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // Card 4: Approval Details
        AttendanceRegularizationReviewCard(
          title: l10n.approvalDetails,
          children: [
            AttendanceRegularizationReviewRow(
              label: l10n.reportingManager,
              value: managerName,
            ),
          ],
        ),
      ],
    );
  }

  String _getRequestTypeLabel(
    AppLocalizations l10n,
    AttendanceRegularizationRequestType type,
  ) {
    switch (type) {
      case AttendanceRegularizationRequestType.missedPunch:
        return l10n.missedPunch;
      case AttendanceRegularizationRequestType.systemError:
        return l10n.systemError;
      case AttendanceRegularizationRequestType.networkIssues:
        return l10n.networkIssues;
      case AttendanceRegularizationRequestType.onFieldDuty:
        return l10n.onFieldDuty;
    }
  }
}

class AttendanceRegularizationReviewCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const AttendanceRegularizationReviewCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = AppColors.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: themeColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: themeColors.tableBorder, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.bodyMedium.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: themeColors.textPrimary,
            ),
          ),
          SizedBox(height: 6.h),
          ...children,
        ],
      ),
    );
  }
}

class AttendanceRegularizationReviewRow extends StatelessWidget {
  final String label;
  final String value;

  const AttendanceRegularizationReviewRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = AppColors.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyle.bodyMedium.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: themeColors.slate550,
            ),
          ),
          Text(
            value,
            style: AppTextStyle.bodyMedium.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: themeColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
