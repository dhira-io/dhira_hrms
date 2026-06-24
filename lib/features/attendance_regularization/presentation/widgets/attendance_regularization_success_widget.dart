import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

import 'package:dhira_hrms/core/widgets/common_button.dart';

class AttendanceRegularizationSuccessWidget extends StatelessWidget {
  final VoidCallback onMyRequests;
  final VoidCallback onBackToHome;

  const AttendanceRegularizationSuccessWidget({
    super.key,
    required this.onMyRequests,
    required this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = AppColors.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 120.h),
          // Success circular icon
          Container(
            width: 35.r,
            height: 35.r,
            decoration: BoxDecoration(
              //    color: themeColors.success, // green
              shape: BoxShape.circle,
              border: Border.all(color: themeColors.success, width: 2.w),
            ),
            child: Icon(
              Icons.check_outlined,
              color: themeColors.success,
              size: 26.r,
            ),
          ),
          SizedBox(height: 15.h),

          // Title
          Text(
            l10n.requestSubmitted,
            style: AppTextStyle.h3.copyWith(
              color: themeColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),

          // Description
          Text(
            l10n.regularizationSuccessDesc,
            textAlign: TextAlign.center,
            style: AppTextStyle.bodyMediumWithHeight.copyWith(
              color: themeColors.textSecondary,
            ),
          ),
          SizedBox(height: 30.h),

          // Buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 30.h,

                    child: CommonButton(
                      text: l10n.myRequests,
                      onPressed: onMyRequests,
                      variant: ButtonVariant.outlined,
                      padding: EdgeInsets.symmetric(vertical: 7.h),
                      borderRadius: 6.r,
                      fontweight: FontWeight.w100,
                      textColor: themeColors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: SizedBox(
                    height: 30.h,
                    child: CommonButton(
                      text: l10n.backToHome,
                      onPressed: onBackToHome,
                      padding: EdgeInsets.symmetric(vertical: 7.h),
                      borderRadius: 6.r,
                      fontweight: FontWeight.w100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
