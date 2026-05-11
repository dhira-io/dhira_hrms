import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class EditTimesheetFooter extends StatelessWidget {
  final int selectedCount;
  final int totalCount;
  final VoidCallback onUpdate;
  final VoidCallback onCancel;

  const EditTimesheetFooter({
    super.key,
    required this.selectedCount,
    required this.totalCount,
    required this.onUpdate,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final btnShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
    const btnSize = Size(100, 44);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                l10n.rowsSelected(selectedCount, totalCount),
                style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onUpdate,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: btnSize,
                shape: btnShape,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                elevation: 0,
              ),
              child: Text(
                l10n.update,
                style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                minimumSize: btnSize,
                shape: btnShape,
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text(
                l10n.cancel,
                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
