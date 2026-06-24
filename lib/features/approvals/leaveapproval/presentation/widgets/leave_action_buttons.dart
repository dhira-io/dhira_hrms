import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
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
    final bool isActionDisabled =
        state.isLoading || state.isUploading || disableSubmit;

    return Row(
      children: [
        Expanded(
          child: CommonButton(
            text: l10n.cancel,
            onPressed: () => Navigator.pop(context),
            variant: ButtonVariant.outlined,
          ),
        ),
        const SizedBox(width: AppConstants.p16),
        Expanded(
          child: CommonButton(
            text: l10n.update,
            onPressed: isActionDisabled ? null : onSubmit,
            isLoading: state.isLoading,
            variant: ButtonVariant.primary,
          ),
        ),
      ],
    );
  }
}
