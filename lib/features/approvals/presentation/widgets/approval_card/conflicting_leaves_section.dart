import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ConflictingLeavesSection extends StatelessWidget {
  final List<ConflictingLeaveEntity> conflictingLeaves;

  const ConflictingLeavesSection({
    super.key,
    required this.conflictingLeaves,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      padding: const EdgeInsets.all(AppConstants.p12),
      decoration: BoxDecoration(
        color: AppColors.errorContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 16),
              SizedBox(width: 8),
              Text(
                l10n.conflictingLeaves,
                style: AppTextStyle.labelMedium.copyWith(color: AppColors.error, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8),
          ...conflictingLeaves.map((leave) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Icon(Icons.circle, size: 4, color: AppColors.error),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "${leave.employeeName}: ${leave.leaveType} (${leave.fromDate} ${l10n.to} ${leave.toDate})",
                    style: AppTextStyle.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
