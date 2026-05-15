import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../l10n/app_localizations.dart';

class LeaveFormActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback? onSubmit;
  final bool isLoading;
  final bool isSubmitDisabled;

  const LeaveFormActionButtons({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    required this.isLoading,
    required this.isSubmitDisabled,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onCancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryContainer,
              foregroundColor: AppColors.onSecondaryContainer,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.r12)),
            ),
            child: Text(l10n.cancel,
                style: AppTextStyle.button.copyWith(color: AppColors.onSecondaryContainer)),
          ),
        ),
        const SizedBox(width: AppConstants.p16),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: isSubmitDisabled
                  ? null
                  : const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryContainer],
                    ),
              color: isSubmitDisabled ? AppColors.secondaryContainer : null,
              borderRadius: BorderRadius.circular(AppConstants.r12),
              boxShadow: isSubmitDisabled
                  ? null
                  : [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: ElevatedButton(
              onPressed: isSubmitDisabled ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.transparent,
                disabledForegroundColor: AppColors.onSecondaryContainer,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r12)),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                  : Text(l10n.submitRequest,
                      style: AppTextStyle.button),
            ),
          ),
        ),
      ],
    );
  }
}
