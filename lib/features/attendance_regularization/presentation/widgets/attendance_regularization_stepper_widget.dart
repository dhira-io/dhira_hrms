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
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Connection lines behind circles
              Positioned(
                top: 13.r,
                left: 0,
                right: 0,
                child: Row(
                  children: [
                    SizedBox(width: 39.w), // Center of first step (78.w / 2)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          height: 1.h,
                          color: AppColors.of(context).slate300,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          height: 1.h,
                          color: AppColors.of(context).slate300,
                        ),
                      ),
                    ),
                    SizedBox(width: 39.w), // Center of third step (78.w / 2)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStep(
                    context: context,
                    stepNum: 1,
                    title: l10n.step1EnterDetails,
                    isActive: currentStep == 0,
                    isCompleted: currentStep > 0,
                    primaryColor: primaryColor,
                    textColor: textColor,
                    mutedColor: mutedColor,
                  ),
                  _buildStep(
                    context: context,
                    stepNum: 2,
                    title: l10n.step2ReviewDetails,
                    isActive: currentStep == 1,
                    isCompleted: currentStep > 1,
                    primaryColor: primaryColor,
                    textColor: textColor,
                    mutedColor: mutedColor,
                  ),
                  _buildStep(
                    context: context,
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

  Widget _buildStep({
    required BuildContext context,
    required int stepNum,
    required String title,
    required bool isActive,
    required bool isCompleted,
    required Color primaryColor,
    required Color textColor,
    required Color mutedColor,
  }) {
    Widget circle;
    if (isCompleted) {
      circle = SizedBox(
        width: 20.r,
        height: 20.r,
        child: Center(
          child: Container(
            width: 18.r,
            height: 18.r,
            decoration: BoxDecoration(
              color: AppColors.of(context).greenSuccess,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.check_rounded, color: Colors.white, size: 11.r),
          ),
        ),
      );
    } else if (isActive) {
      circle = SizedBox(
        width: 26.r,
        height: 26.r,
        child: Center(
          child: Container(
            width: 19.r,
            height: 19.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: primaryColor, width: 2.w),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Container(
              width: 6.r,
              height: 6.r,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      );
    } else {
      circle = SizedBox(
        width: 26.r,
        height: 26.r,
        child: Center(
          child: Container(
            width: 19.r,
            height: 19.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.of(context).slate400,
                width: 1.w,
              ),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Container(
              width: 6.r,
              height: 6.r,
              decoration: BoxDecoration(
                color: AppColors.of(context).slate400,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: 78.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circle,
          SizedBox(height: 4.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.bodySmall.copyWith(
              fontSize: 8.sp,
              fontWeight: FontWeight.w500,
              color: isActive || isCompleted ? textColor : mutedColor,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
