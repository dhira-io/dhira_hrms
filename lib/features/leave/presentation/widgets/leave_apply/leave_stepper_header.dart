import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveStepperHeader extends StatelessWidget {
  final int currentStep;

  const LeaveStepperHeader({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.only(top: AppConstants.p4.h, bottom: AppConstants.p10.h, right: AppConstants.p10,left: AppConstants.p10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: LeaveStepIndicator(
              stepIndex: 0,
              currentStep: currentStep,
              title: l10n.stepLabel(1),
              subtitle: l10n.leaveStepDetails,
            ),
          ),
          LeaveStepDivider(isActive: currentStep >= 1),
          Expanded(
            child: LeaveStepIndicator(
              stepIndex: 1,
              currentStep: currentStep,
              title: l10n.stepLabel(2),
              subtitle: l10n.leaveStepReview,
            ),
          ),
          LeaveStepDivider(isActive: currentStep >= 2),
          Expanded(
            child: LeaveStepIndicator(
              stepIndex: 2,
              currentStep: currentStep,
              title: l10n.stepLabel(3),
              subtitle: l10n.leaveStepConfirm,
            ),
          ),
        ],
      ),
    );
  }
}

class LeaveStepIndicator extends StatelessWidget {
  final int stepIndex;
  final int currentStep;
  final String title;
  final String subtitle;

  const LeaveStepIndicator({
    super.key,
    required this.stepIndex,
    required this.currentStep,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = currentStep > stepIndex;
    final bool isActive = currentStep == stepIndex;
    
    final Color color = isCompleted 
        ? AppColors.of(context).success 
        : (isActive ? AppColors.of(context).primaryContainer : AppColors.of(context).outlineVariant);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? color : (isActive ? color.withValues(alpha: 0.1) : Colors.transparent),
            border: Border.all(color: color, width: 2.w),
          ),
          child: Center(
            child: isCompleted
              ? Icon(Icons.check, size: 16.w, color: AppColors.of(context).white)
              : Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
          ),
        ),
        SizedBox(height: AppConstants.p8.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyle.labelSmallOne.copyWith(
            color: AppColors.of(context).textPrimary,
          ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppTextStyle.labelSmallOne.copyWith(
            color: AppColors.of(context).textPrimary,
          ),
        ),
      ],
    );
  }
}

class LeaveStepDivider extends StatelessWidget {
  final bool isActive;

  const LeaveStepDivider({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 16.h),
        height: 2.h,
        color: isActive ? AppColors.of(context).primaryContainer : AppColors.of(context).outlineVariant,
      ),
    );
  }
}
