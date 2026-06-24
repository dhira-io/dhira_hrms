import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';

class ConfirmationAction {
  final String label;
  final VoidCallback onTap;

  const ConfirmationAction({required this.label, required this.onTap});
}

class CommonConfirmationBottomSheet extends StatelessWidget {
  final Widget icon;
  final String title;
  final String? subtitle;
  final ConfirmationAction confirmAction;
  final ConfirmationAction cancelAction;
  final Color? iconBackgroundColor;

  const CommonConfirmationBottomSheet({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.confirmAction,
    required this.cancelAction,
    this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context).white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(4, -2),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 28.h),
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.of(
                    context,
                  ).outlineVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  width: 42.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    color:
                        iconBackgroundColor ??
                        AppColors.of(
                          context,
                        ).errorContainer.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(child: icon),
                ),
                SizedBox(height: 6.h),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.h2.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.of(context).slate900,
                  ),
                ),
              ],
            ),
            if (subtitle != null) ...[
              SizedBox(height: 8.h),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: AppTextStyle.bodyMedium.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.of(context).slate500Confirmation,
                  height: 1.4,
                ),
              ),
            ],
            SizedBox(height: 10.h),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 35.h,
                  child: CommonButton(
                    text: cancelAction.label,
                    variant: ButtonVariant.outlined,
                    backgroundColor: AppColors.of(context).white,
                    foregroundColor: AppColors.of(context).slate900,
                    borderRadius: 8.r,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    onPressed: cancelAction.onTap,
                  ),
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: double.infinity,
                  height: 35.h,
                  child: CommonButton(
                    text: confirmAction.label,
                    variant: ButtonVariant.primary,
                    backgroundColor: AppColors.of(context).absentText,
                    foregroundColor: AppColors.of(context).slate50,
                    borderRadius: 8.r,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    onPressed: confirmAction.onTap,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
