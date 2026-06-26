import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class ApprovalTab extends StatelessWidget {
  final String label;
  final bool isSelected;

  const ApprovalTab({super.key, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Tab(
      height: 40.h,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.p16,
          vertical: AppConstants.p8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primaryFixed
              : colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppConstants.r24),
          border: Border.all(
            color: isSelected
                ? colors.primary
                : colors.border,
            width: 1.w,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyle.labelMedium.copyWith(
            color: isSelected
                ? colors.primary
                : colors.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
