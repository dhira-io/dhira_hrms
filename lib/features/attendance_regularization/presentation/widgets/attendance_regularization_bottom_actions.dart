import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
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
    if (currentStep == 2) return const SizedBox.shrink();

    final colors = AppColors.of(context);
    final isSubmitting = state.isSubmitting;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        border: Border(
          top: BorderSide(
            color: colors.slate200,
            width: 1.w,
          ),
        ),
      ),
      child: SafeArea(
        child: currentStep == 0
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

  const _Step1Actions({
    required this.canContinue,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CommonButton(
      text: l10n.nextText,
      onPressed: canContinue ? onNext : null,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 16.w),
      borderRadius: 6.r,
      fontweight: FontWeight.w100,
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
        CommonButton(
          text: l10n.editDetails,
          onPressed: isSubmitting ? null : onPrevious,
          variant: ButtonVariant.outlined,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 16.w),
          borderRadius: 6.r,
          fontweight: FontWeight.w100,
          textColor: colors.textPrimary,
        ),
        SizedBox(height: 6.h),
        CommonButton(
          text: l10n.submitRequest,
          onPressed: isSubmitting ? null : onSubmit,
          isLoading: isSubmitting,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 16.w),
          borderRadius: 6.r,
          fontweight: FontWeight.w100,
        ),
      ],
    );
  }
}
