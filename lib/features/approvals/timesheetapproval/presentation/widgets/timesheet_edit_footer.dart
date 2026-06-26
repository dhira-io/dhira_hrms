import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimesheetEditFooter extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onCancel;
  final VoidCallback onUpdate;
  final bool isLoading;

  const TimesheetEditFooter({
    super.key,
    required this.selectedCount,
    required this.onCancel,
    required this.onUpdate,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.p20,
        AppConstants.p16,
        AppConstants.p20,
        AppConstants.p24,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: Row(
        children: [
          Text(
            l10n.selectedRows(selectedCount),
            style: AppTextStyle.bodySmall.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: onCancel,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.p24,
                vertical: AppConstants.p12,
              ),
              side: BorderSide(color: colors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.r20),
              ),
              backgroundColor: colors.surfaceContainerLow,
            ),
            child: Text(
              l10n.cancel,
              style: AppTextStyle.bodyMedium.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: AppConstants.p12),
          ElevatedButton(
            onPressed: isLoading ? null : onUpdate,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.p24,
                vertical: AppConstants.p12,
              ),
              backgroundColor: colors.primary,
              foregroundColor: colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.r20),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(colors.white),
                    ),
                  )
                : Text(
                    l10n.update,
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.white,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
