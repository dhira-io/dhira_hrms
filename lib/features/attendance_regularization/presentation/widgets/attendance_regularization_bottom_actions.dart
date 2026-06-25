import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import '../../data/constants/attendance_regularization_api_constants.dart';
import '../bloc/attendance_regularization_state.dart';

class AttendanceRegularizationBottomActions extends StatelessWidget {
  final AttendanceRegularizationState state;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onSubmit;

  const AttendanceRegularizationBottomActions({
    super.key,
    required this.state,
    required this.onNext,
    required this.onPrevious,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final currentStep = state.currentStep;
    if (currentStep == AttendanceRegularizationSteps.confirmation) return const SizedBox.shrink();

    final colors = AppColors.of(context);
    final isSubmitting = state.isSubmitting;

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 5.h, 16.w, 5.h),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        border: Border(
          top: BorderSide(color: colors.tableBorder),
        ),
      ),
      child: SafeArea(
        child: currentStep == AttendanceRegularizationSteps.enterDetails
            ? _Step1Actions(
                canContinue: state.formData.canContinue,
                onNext: onNext,
              )
            : _Step2Actions(
                isSubmitting: isSubmitting,
                onPrevious: onPrevious,
                onSubmit: onSubmit,
              ),
      ),
    );
  }
}

class _Step1Actions extends StatelessWidget {
  final bool canContinue;
  final VoidCallback onNext;

  const _Step1Actions({required this.canContinue, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      height: 38.h,
      width: double.infinity,
      child: CommonButton(
        text: l10n.nextText,
        onPressed: canContinue ? onNext : null,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
      ),
    );
  }
}

class _Step2Actions extends StatelessWidget {
  final bool isSubmitting;
  final VoidCallback onPrevious;
  final VoidCallback onSubmit;

  const _Step2Actions({
    required this.isSubmitting,
    required this.onPrevious,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 38.h,
          width: double.infinity,
          child: CommonButton(
            text: l10n.editDetails,
            onPressed: isSubmitting ? null : onPrevious,
            variant: ButtonVariant.outlined,
            width: double.infinity,
            textColor: colors.textPrimary,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
        ),
        SizedBox(height: 6.h),
        SizedBox(
          height: 38.h,
          width: double.infinity,
          child: CommonButton(
            text: l10n.submitRequest,
            onPressed: isSubmitting ? null : onSubmit,
            isLoading: isSubmitting,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
        ),
      ],
    );
  }
}
