import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/widgets/common_confirmation_bottom_sheet.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

class DeleteTimesheetBottomSheet extends StatelessWidget {
  final String requestId;
  final VoidCallback onDelete;

  const DeleteTimesheetBottomSheet({
    super.key,
    required this.requestId,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    return CommonConfirmationBottomSheet(
      title: l10n.deleteTimesheet,
      subtitle: "${l10n.areYouSureDelete} $requestId?\n\n${l10n.deleteTimesheetWarning}",
      icon: Icon(Icons.delete_outline, color: colors.error),
      iconBackgroundColor: colors.error.withOpacity(0.1),
      confirmAction: ConfirmationAction(
        label: l10n.delete,
        onTap: () {
          Navigator.pop(context);
          onDelete();
        },
      ),
      cancelAction: ConfirmationAction(
        label: l10n.cancel,
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
