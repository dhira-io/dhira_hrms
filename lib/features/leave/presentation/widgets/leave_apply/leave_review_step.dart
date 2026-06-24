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
  final Future<void> Function() onRefresh;

  const LeaveReviewStep({
    super.key,
    required this.state,
    required this.onSubmit,
    required this.onBack,
    required this.reason,
    required this.approverName,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);

    final totalDays = LeaveFormUtils.computeTotalDays(
      fromDate: state.fromDate,
      toDate: state.toDate,
      isHalfDay: state.isHalfDay,
    );

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.all(AppConstants.p20),
                child: Column(
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
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.p16.h),
                    ReviewDetailCard(
                      title: l10n.approvalDetails,
                      child: ReviewDetailRow(label: l10n.reportingManager, value: approverName),
                    ),
                  ],
                ),
              ),
            ),
          ),
        Container(
          padding: const EdgeInsets.all(AppConstants.p20),
          decoration: BoxDecoration(
            color: colors.surface,
            boxShadow: [
              BoxShadow(
                color: colors.outline.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: CommonButton(
                    text: l10n.editDetails,
                    variant: ButtonVariant.outlined,
                    textStyle: AppTextStyle.bodyLarge.copyWith(
                      color: colors.onSurface,
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
            ),
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
    final colors = AppColors.of(context);
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppConstants.r16.r),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.5)),
      ),
      padding: EdgeInsets.all(AppConstants.p16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.onSurface,
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
    final colors = AppColors.of(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyMedium.copyWith(
            color: colors.outline,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTextStyle.bodyMedium.copyWith(
              color: isLink ? colors.primary : colors.onSurface,
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
