import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class LeaveActionButtons extends StatelessWidget {
  final bool isLoading;
  final bool isEdit;
  final VoidCallback onSubmit;

  const LeaveActionButtons({
    super.key,
    required this.isLoading,
    required this.isEdit,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.bordergrey,
                foregroundColor: AppColors.textPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r12)),
              ),
              child: Text(l10n.cancel, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ),
        const SizedBox(width: AppConstants.p16),
        Expanded(
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: isLoading ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r12)),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: AppColors.white)
                  : Text(
                      isEdit ? l10n.updateApplication : l10n.submitApplication,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: AppConstants.p16, color: AppColors.white),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
