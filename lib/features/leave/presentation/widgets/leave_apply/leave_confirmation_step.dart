import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveConfirmationStep extends StatelessWidget {
  final VoidCallback onMyRequests;
  final VoidCallback onBackToHome;

  const LeaveConfirmationStep({
    super.key,
    required this.onMyRequests,
    required this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: AppConstants.p32.h),
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.of(context).primary.withValues(alpha: 0.1),
          ),
          child: Center(
            child: Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.of(context).primary,
              ),
              child: Center(
                child: Icon(
                  Icons.check,
                  size: 32.sp,
                  color: AppColors.of(context).onPrimary,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: AppConstants.p24.h),
        Text(
          l10n.requestSubmitted,
          style: AppTextStyle.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.of(context).onSurface,
          ),
        ),
        SizedBox(height: AppConstants.p16.h),
        Text(
          l10n.leaveSubmitSuccess,
          textAlign: TextAlign.center,
          style: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.of(context).outline,
          ),
        ),
        SizedBox(height: AppConstants.p48.h),
        SizedBox(
          width: double.infinity,
          child: CommonButton(
            text: l10n.myRequests,
            onPressed: onMyRequests,
          ),
        ),
        SizedBox(height: AppConstants.p16.h),
        SizedBox(
          width: double.infinity,
          child: CommonButton(
            text: l10n.backToHome,
            variant: ButtonVariant.outlined,
            onPressed: onBackToHome,
          ),
        ),
      ],
    );
  }
}
