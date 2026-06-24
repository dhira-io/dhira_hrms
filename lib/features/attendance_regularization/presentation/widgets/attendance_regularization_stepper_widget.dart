import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/bloc/attendance_regularization_bloc.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/bloc/attendance_regularization_state.dart';

class AttendanceRegularizationStepperWidget extends StatelessWidget {
  const AttendanceRegularizationStepperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final primaryColor = AppColors.of(context).primary;
    final textColor = AppColors.of(context).textPrimary;
    final mutedColor = AppColors.of(context).textSecondary;
    return BlocSelector<
      AttendanceRegularizationBloc,
      AttendanceRegularizationState,
      int
    >(
      selector: (state) => state.currentStep,
      builder: (context, currentStep) {
        return Padding(
          padding: EdgeInsets.only(
            left: 14.w,
            right: 14.w,
            top: 0.h,
            bottom: 10.h,
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Connection lines behind circles
              Positioned(
                top: 16.r, // Center of 32.r circle is 16
                left: 0,
                right: 0,
                child: Row(
                  children: [
                    SizedBox(width: 42.w), // Center of first step (84.w / 2)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Container(
                          height: 1.h,
                          color: AppColors.of(context).slate300,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Container(
                          height: 1.h,
                          color: AppColors.of(context).slate300,
                        ),
                      ),
                    ),
                    SizedBox(width: 42.w), // Center of third step (84.w / 2)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StepItem(
                    stepNum: 1,
                    title: l10n.step1EnterDetails,
                    isActive: currentStep == 0,
                    isCompleted: currentStep > 0,
                    primaryColor: primaryColor,
                    textColor: textColor,
                    mutedColor: mutedColor,
                  ),
                  _StepItem(
                    stepNum: 2,
                    title: l10n.step2ReviewDetails,
                    isActive: currentStep == 1,
                    isCompleted: currentStep > 1,
                    primaryColor: primaryColor,
                    textColor: textColor,
                    mutedColor: mutedColor,
                  ),
                  _StepItem(
                    stepNum: 3,
                    title: l10n.step3Confirmation,
                    isActive: currentStep == 2,
                    isCompleted: false, // Step 3 is final active
                    primaryColor: primaryColor,
                    textColor: textColor,
                    mutedColor: mutedColor,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StepItem extends StatelessWidget {
  final int stepNum;
  final String title;
  final bool isActive;
  final bool isCompleted;
  final Color primaryColor;
  final Color textColor;
  final Color mutedColor;

  const _StepItem({
    required this.stepNum,
    required this.title,
    required this.isActive,
    required this.isCompleted,
    required this.primaryColor,
    required this.textColor,
    required this.mutedColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    Widget circle;
    if (isCompleted) {
      circle = SizedBox(
        width: 30.r,
        height: 30.r,
        child: Center(
          child: Container(
            width: 28.r,
            height: 28.r,
            decoration: BoxDecoration(
              color: colors.greenSuccess,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.check_rounded, color: colors.white, size: 14.r),
          ),
        ),
      );
    } else if (isActive) {
      circle = Container(
        alignment: Alignment.center,
        width: 30.r,
        height: 30.r,
        child: Container(
          width: 25.r,
          height: 25.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: primaryColor,
              width: 1.w,
            ), // Reduced border thickness
            color: colors.white,
            boxShadow: [
              BoxShadow(
                color: primaryColor.withValues(alpha: 0.24), // Soft blue shade
                blurRadius: 4.r,
                spreadRadius: 2.r,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Container(
            width: 8.r,
            height: 8.r,
            decoration: BoxDecoration(
              color: primaryColor, // Center solid blue dot
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    } else {
      circle = Container(
        alignment: Alignment.center,
        width: 30.r,
        height: 30.r,
        child: Container(
          width: 25.r,
          height: 25.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: colors.stepperColor, // Soft gray shade
              width: 1.w, // Reduced border thickness
            ),
            color: colors.white,
          ),
          alignment: Alignment.center,
          child: Container(
            width: 8.r,
            height: 8.r,
            decoration: BoxDecoration(
              color: colors.slate300, // Center gray dot
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: 84.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circle,
          SizedBox(height: 4.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.bodySmallSemibold.copyWith(
              color: isActive || isCompleted ? textColor : mutedColor,
            ),
          ),
        ],
      ),
    );
  }
}
