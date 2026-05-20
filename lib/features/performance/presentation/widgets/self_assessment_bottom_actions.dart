import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/self_assessment/self_assessment_cubit.dart';
import 'package:dhira_hrms/features/performance/presentation/dialogs/submit_self_assessment_dialog.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelfAssessmentBottomActions extends StatelessWidget {
  final bool? isSaving;
  final bool? isSubmitting;
  final VoidCallback? onSave;
  final VoidCallback? onSubmit;

  const SelfAssessmentBottomActions({
    super.key,
    this.isSaving,
    this.isSubmitting,
    this.onSave,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final bool resolvedIsSaving = isSaving ??
        context.select((SelfAssessmentCubit cubit) =>
            cubit.state.actionStatus == SelfAssessmentActionStatus.saving);

    final bool resolvedIsSubmitting = isSubmitting ??
        context.select((SelfAssessmentCubit cubit) =>
            cubit.state.actionStatus == SelfAssessmentActionStatus.submitting);

    final resolvedOnSave = onSave ??
        () => context.read<SelfAssessmentCubit>().saveSelfAssessment();

    final resolvedOnSubmit = onSubmit ??
        () => context.read<SelfAssessmentCubit>().submitSelfAssessment();

    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).black.withValues(alpha: 0.1),
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
              onPressed: resolvedIsSaving || resolvedIsSubmitting ? null : resolvedOnSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.of(context).secondaryContainer,
                foregroundColor: AppColors.of(context).primary,
                padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                ),
                elevation: 0,
              ),
              child: resolvedIsSaving
                  ? SizedBox(
                      height: AppConstants.p20,
                      width: AppConstants.p20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.of(context).primary,
                        ),
                      ),
                    )
                  : Text(
                      l10n.saveDraft,
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
                gradient: LinearGradient(
                  colors: [
                    AppColors.of(context).primary,
                    AppColors.of(context).primaryContainer,
                  ],
                ),
                borderRadius: BorderRadius.circular(AppConstants.r12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.of(context).primary.withValues(alpha: 0.2),
                    blurRadius: AppConstants.r20,
                    offset: const Offset(0, AppConstants.p10),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: resolvedIsSubmitting || resolvedIsSaving
                    ? null
                    : () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) =>
                              SubmitSelfAssessmentDialog(onConfirm: resolvedOnSubmit),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.of(context).transparent,
                  foregroundColor: AppColors.of(context).white,
                  shadowColor: AppColors.of(context).transparent,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.p16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                ),
                child: resolvedIsSubmitting
                  ? SizedBox(
                      height: AppConstants.p20,
                      width: AppConstants.p20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.of(context).white,
                        ),
                      ),
                    )
                  : Text(
                      l10n.submitReview,
                      style: AppTextStyle.labelMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.of(context).white,
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
