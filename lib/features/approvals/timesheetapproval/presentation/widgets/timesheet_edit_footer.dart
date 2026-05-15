import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimesheetEditFooter extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onCancel;
  final VoidCallback onUpdate;

  const TimesheetEditFooter({
    super.key,
    required this.selectedCount,
    required this.onCancel,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.fromLTRB(AppConstants.p20, AppConstants.p16, AppConstants.p20, AppConstants.p24),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.slate200)),
      ),
      child: Row(
        children: [
          Text(l10n.selectedRows(selectedCount), style: AppTextStyle.bodySmall.copyWith(color: AppColors.slate500)),
          Spacer(),
          OutlinedButton(
            onPressed: onCancel,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.p24, vertical: AppConstants.p12),
              side: BorderSide(color: AppColors.slate200),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r20)),
              backgroundColor: AppColors.slate100,
            ),
            child: Text(l10n.cancel, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.slate800, fontWeight: FontWeight.w600)),
          ),
          SizedBox(width: AppConstants.p12),
          ElevatedButton(
            onPressed: onUpdate,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.p24, vertical: AppConstants.p12),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r20)),
              elevation: 0,
            ),
            child: Text(l10n.update, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.white)),
          ),
        ],
      ),
    );
  }
}
