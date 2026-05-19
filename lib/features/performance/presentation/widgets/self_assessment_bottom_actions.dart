import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/performance/presentation/dialogs/submit_self_assessment_dialog.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SelfAssessmentBottomActions extends StatelessWidget {
  final bool isSaving;
  final bool isSubmitting;
  final VoidCallback onSave;
  final VoidCallback onSubmit;

  const SelfAssessmentBottomActions({
    super.key,
    required this.isSaving,
    required this.isSubmitting,
    required this.onSave,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: AppConstants.r10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: isSaving || isSubmitting ? null : onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryContainer,
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                ),
                elevation: 0,
              ),
              child: isSaving
                  ? const SizedBox(
                      height: AppConstants.p20,
                      width: AppConstants.p20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    )
                  : Text(
                      isSaving ? l10n.saving : l10n.saveDraft,
                      style: AppTextStyle.labelMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: AppConstants.p16),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryContainer],
                ),
                borderRadius: BorderRadius.circular(AppConstants.r12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: AppConstants.r20,
                    offset: const Offset(0, AppConstants.p10),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: isSubmitting || isSaving
                    ? null
                    : () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) =>
                              SubmitSelfAssessmentDialog(onConfirm: onSubmit),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.transparent,
                  foregroundColor: AppColors.white,
                  shadowColor: AppColors.transparent,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.p16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                ),
                child: isSubmitting
                    ? const SizedBox(
                        height: AppConstants.p20,
                        width: AppConstants.p20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.white,
                          ),
                        ),
                      )
                    : Text(
                        isSubmitting ? l10n.submitting : l10n.submitReview,
                        style: AppTextStyle.labelMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
