import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_state.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/leave_form_utils.dart';

class LeaveReviewStep extends StatelessWidget {
  final LeaveState state;
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  final String reason;
  final String approverName;

  const LeaveReviewStep({
    super.key,
    required this.state,
    required this.onSubmit,
    required this.onBack,
    required this.reason,
    required this.approverName,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final totalDays = LeaveFormUtils.computeTotalDays(
      fromDate: state.fromDate,
      toDate: state.toDate,
      isHalfDay: state.isHalfDay,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReviewDetailCard(
          title: l10n.leaveDetails,
          child: Column(
            children: [
              ReviewDetailRow(label: l10n.leaveType, value: state.selectedLeaveType ?? ""),
              const ReviewDetailDivider(),
              ReviewDetailRow(label: l10n.fromDate, value: state.fromDate?.format() ?? ""),
              const ReviewDetailDivider(),
              if (!state.isHalfDay)
                ...[
                  ReviewDetailRow(label: l10n.toDate, value: state.toDate?.format() ?? ""),
                  const ReviewDetailDivider(),
                ],
              ReviewDetailRow(label: l10n.duration, value: "$totalDays ${l10n.daysLabel}"),

              if (state.uploadedFileUrl != null || state.selectedFileName != null)
                ...[
                  const ReviewDetailDivider(),
                  ReviewDetailRow(
                    label: l10n.supportingDocuments, 
                    value: state.selectedFileName ?? l10n.fileAttached,
                    isLink: true,
                  ),
                ]
            ],
          ),
        ),
        
        SizedBox(height: AppConstants.p16.h),
        ReviewDetailCard(
          title: l10n.leaveReason,
          child: Text(
            reason.isNotEmpty ? reason : l10n.notAvailable,
            style: AppTextStyle.bodyMedium.copyWith(
              color: AppColors.of(context).onSurface,
            ),
          ),
        ),
        
        SizedBox(height: AppConstants.p16.h),
        ReviewDetailCard(
          title: l10n.approvalDetails,
          child: ReviewDetailRow(label: l10n.reportingManager, value: approverName),
        ),
        
        SizedBox(height: AppConstants.p32.h),
        SizedBox(
          width: double.infinity,
          child: CommonButton(
            text: l10n.editDetails,
            variant: ButtonVariant.outlined,
            textStyle: AppTextStyle.bodyMedium.copyWith(
              color: AppColors.darkText,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            onPressed: onBack,
          ),
        ),
        SizedBox(height: AppConstants.p16.h),
        SizedBox(
          width: double.infinity,
          child: CommonButton(
            text: l10n.submitRequest,
            onPressed: onSubmit,
            isLoading: state.isLoading,
          ),
        ),
      ],
    );
  }
}

class ReviewDetailCard extends StatelessWidget {
  final String title;
  final Widget child;

  const ReviewDetailCard({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.r16.r),
        border: Border.all(color: AppColors.of(context).outlineVariant.withValues(alpha: 0.5)),
      ),
      padding: EdgeInsets.all(AppConstants.p16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.of(context).onSurface,
            ),
          ),
          SizedBox(height: AppConstants.p16.h),
          child,
        ],
      ),
    );
  }
}

class ReviewDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLink;

  const ReviewDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.isLink = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.of(context).outline,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTextStyle.bodyMedium.copyWith(
              color: isLink ? AppColors.of(context).primary : AppColors.of(context).onSurface,
              fontWeight: isLink ? FontWeight.bold : FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class ReviewDetailDivider extends StatelessWidget {
  const ReviewDetailDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppConstants.p12.h),
      child: const Divider(height: 1, thickness: 1),
    );
  }
}
