import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class EditTimesheetErrorView extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onClose;

  const EditTimesheetErrorView({
    super.key,
    this.errorMessage,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: 16),
          Text(errorMessage ?? l10n.failedToLoadTimesheet, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onClose,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(l10n.close, style: const TextStyle(color: AppColors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
