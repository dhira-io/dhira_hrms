import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class ApprovalTab extends StatelessWidget {
  final String label;
  final bool isSelected;

  const ApprovalTab({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 40,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.p16,
          vertical: AppConstants.p8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryFixed : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppConstants.r24),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyle.labelMedium.copyWith(
            color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
