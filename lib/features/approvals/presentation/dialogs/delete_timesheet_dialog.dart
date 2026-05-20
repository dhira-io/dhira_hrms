import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class DeleteTimesheetDialog extends StatelessWidget {
  final String requestId;
  final VoidCallback onDelete;

  const DeleteTimesheetDialog({
    super.key,
    required this.requestId,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: AppColors.of(context).surfaceContainerLowest,
      surfaceTintColor: AppColors.of(context).surfaceContainerLowest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r12)),
      title: Text(l10n.deleteTimesheet, style: AppTextStyle.h3.copyWith(fontSize: AppConstants.fs20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).textPrimary),
              children: [
                TextSpan(text: "${l10n.areYouSureDelete} "),
                TextSpan(
                  text: requestId,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    color: isDark ? AppColors.of(context).onSurface : AppColors.of(context).primary,
                  ),
                ),
                const TextSpan(text: "?"),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.p16),
          Text(
            l10n.deleteTimesheetWarning,
            textAlign: TextAlign.center,
            style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).textSecondary),
          ),
        ],
      ),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.of(context).border),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: const Size(0, AppConstants.p40),
                ),
                child: Text(l10n.cancel, style: TextStyle(color: AppColors.of(context).onSurface)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  onDelete();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.of(context).error,
                  foregroundColor: AppColors.of(context).white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(l10n.delete, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
