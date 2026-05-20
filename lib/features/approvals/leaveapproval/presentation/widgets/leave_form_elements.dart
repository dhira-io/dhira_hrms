import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class LeaveLabel extends StatelessWidget {
  final String label;

  const LeaveLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
      child: Text(
        label,
        style: AppTextStyle.labelMedium.copyWith(
          color: AppColors.of(context).onSurfaceVariant,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class LeaveDatePickerField extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isReadOnly;

  const LeaveDatePickerField({
    super.key,
    required this.text,
    this.onTap,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isReadOnly ? null : onTap,
      borderRadius: BorderRadius.circular(AppConstants.r12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.p16,
          vertical: AppConstants.p14,
        ),
        decoration: BoxDecoration(
          color: isReadOnly
              ? AppColors.of(context).surfaceContainerLow.withValues(alpha: 0.5)
              : AppColors.of(context).surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppConstants.r12),
          border: Border.all(color: AppColors.of(context).outlineVariant.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppTextStyle.bodyMedium.copyWith(
                color: isReadOnly ? AppColors.of(context).outline : AppColors.of(context).onSurface,
              ),
            ),
            Icon(
              Icons.calendar_today_rounded,
              color: isReadOnly
                  ? AppColors.of(context).outline.withValues(alpha: 0.5)
                  : AppColors.of(context).primary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
