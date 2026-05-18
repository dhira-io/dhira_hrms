import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_state.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LeaveActionButtons extends StatelessWidget {
  final AppLocalizations l10n;
  final LeaveApprovalState state;
  final VoidCallback onSubmit;
  final bool disableSubmit;

  const LeaveActionButtons({
    super.key,
    required this.l10n,
    required this.state,
    required this.onSubmit,
    required this.disableSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.cancel,
              style: AppTextStyle.button.copyWith(
                color: AppColors.of(context).onSurfaceVariant,
                fontSize: AppConstants.fs14,
              ),
            ),
          ),
        ),
        SizedBox(width: AppConstants.p16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: (state.isLoading || state.isUploading || disableSubmit) ? null : onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.of(context).primary,
              foregroundColor: AppColors.of(context).white,
              padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.r12),
              ),
              elevation: 0,
              disabledBackgroundColor: AppColors.of(context).primary.withValues(alpha: 0.3),
            ),
            child: state.isLoading
                ? SizedBox(
              width: AppConstants.iconMedium,
              height: AppConstants.iconMedium,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.of(context).white),
              ),
            )
                : Text(
              l10n.update,
              style: AppTextStyle.button.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.of(context).white,
                fontSize: AppConstants.fs16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
