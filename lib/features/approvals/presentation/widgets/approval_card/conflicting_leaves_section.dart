import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ConflictingLeavesSection extends StatelessWidget {
  final List<ConflictingLeaveEntity> conflictingLeaves;

  const ConflictingLeavesSection({super.key, required this.conflictingLeaves});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(AppConstants.p12),
      decoration: BoxDecoration(
        color: AppColors.of(context).errorContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(
          color: AppColors.of(context).error.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppColors.of(context).error,
                size: 16,
              ),
                    SizedBox(width: 8.w),
              Text(
                l10n.conflictingLeaves,
                style: AppTextStyle.labelMedium.copyWith(
                  color: AppColors.of(context).error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
                SizedBox(height: 8.h),
          ...conflictingLeaves.map(
            (leave) => Padding(
              padding:       EdgeInsets.only(bottom: 4.h),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 4,
                    color: AppColors.of(context).error,
                  ),
                        SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      "${leave.employeeName}: ${leave.leaveType} (${leave.fromDate} ${l10n.to} ${leave.toDate})",
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.of(context).onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
