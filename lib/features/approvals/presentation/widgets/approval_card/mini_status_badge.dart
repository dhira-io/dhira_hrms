import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MiniStatusBadge extends StatelessWidget {
  final String status;

  const MiniStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final String normStatus = status.toLowerCase();
    
    Color bgColor = AppColors.of(context).surfaceContainerLow;
    Color textColor = AppColors.of(context).onSurfaceVariant;
    String displayStatus = status;

    if (normStatus == ApprovalStatus.approved.toLowerCase()) {
      bgColor = AppColors.of(context).successContainer;
      textColor = AppColors.of(context).success;
      displayStatus = l10n.approved;
    } else if (normStatus == ApprovalStatus.rejected.toLowerCase()) {
      bgColor = AppColors.of(context).errorContainer;
      textColor = AppColors.of(context).error;
      displayStatus = l10n.rejected;
    } else if (normStatus == ApprovalStatus.cancelled.toLowerCase()) {
      bgColor = AppColors.of(context).errorContainer;
      textColor = AppColors.of(context).error;
      displayStatus = l10n.cancelledLabel;
    } else if (normStatus == ApprovalStatus.pending.toLowerCase() || 
               normStatus == 'open') {
      bgColor = AppColors.of(context).warningContainer;
      textColor = AppColors.of(context).warning;
      displayStatus = l10n.pending;
    } else if (normStatus == 'draft') {
      displayStatus = l10n.draft;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p8, vertical: AppConstants.p4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppConstants.r12),
      ),
      child: Text(
        displayStatus,
        style: AppTextStyle.labelSmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
