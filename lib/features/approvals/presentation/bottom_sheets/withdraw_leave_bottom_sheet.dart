import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/widgets/common_confirmation_bottom_sheet.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

class WithdrawLeaveBottomSheet extends StatelessWidget {
  final ApprovalRequestEntity data;
  final VoidCallback onConfirm;

  const WithdrawLeaveBottomSheet({
    super.key,
    required this.data,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    return CommonConfirmationBottomSheet(
      title: l10n.withdraw,
      subtitle: l10n.withdrawConfirmation,
      icon: Icon(Icons.cancel_outlined, color: colors.error),
      iconBackgroundColor: colors.error.withOpacity(0.1),
      confirmAction: ConfirmationAction(
        label: l10n.yes,
        onTap: () {
          Navigator.pop(context);
          onConfirm();
        },
      ),
      cancelAction: ConfirmationAction(
        label: l10n.no,
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
