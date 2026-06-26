import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/data/constants/approvals_api_constants.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MiniStatusBadge extends StatelessWidget {
  final String status;

  const MiniStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    final String normStatus = status.toLowerCase();

    Color bgColor = colors.surfaceContainerLow;
    Color textColor = colors.onSurfaceVariant;
    Color borderColor = colors.onSurfaceVariant;
    String displayStatus = status;

    if (normStatus == ApprovalStatus.approved.toLowerCase()) {
      bgColor = colors.approvedBg;
      textColor = AppColors.colorGreen600;
      borderColor = AppColors.colorGreen300;
      displayStatus = l10n.approved;
    } else if (normStatus == ApprovalStatus.rejected.toLowerCase()) {
      bgColor = colors.rejectedBg;
      textColor = colors.rejectedText;
      borderColor = textColor;
      displayStatus = l10n.rejected;
    } else if (normStatus == ApprovalStatus.cancelled.toLowerCase()) {
      bgColor = colors.rejectedBg;
      textColor = colors.rejectedText;
      borderColor = textColor;
      displayStatus = l10n.cancelledLabel;
    } else if (normStatus.contains(ApprovalsApiConstants.statusPending) ||
        normStatus == ApprovalsApiConstants.statusOpen) {
      bgColor = colors.pendingStatusBg;
      textColor = colors.punchBreak;
      borderColor = colors.punchBreak.withValues(alpha: 0.5);
      if (normStatus == ApprovalStatus.pending.toLowerCase() ||
          normStatus == ApprovalsApiConstants.statusOpen) {
        displayStatus = l10n.pending;
      }
    } else if (normStatus == ApprovalsApiConstants.statusDraft) {
      displayStatus = l10n.draft;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p8,
        vertical: AppConstants.p4,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(AppConstants.r12),
      ),
      child: Text(
        displayStatus,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle.labelSmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
