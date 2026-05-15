import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_constants.dart';
import '../../../../../../core/theme/app_text_style.dart';

class LeaveDatePickerField extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isReadOnly;
  final String? errorText;

  const LeaveDatePickerField({
    super.key,
    required this.text,
    this.onTap,
    this.isReadOnly = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: isReadOnly ? null : onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p14),
            decoration: BoxDecoration(
              color: isReadOnly ? AppColors.surfaceContainerLow : AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppConstants.r12),
              border: errorText != null ? Border.all(color: Colors.red, width: 1) : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: isReadOnly ? AppColors.outline : AppColors.onSurface,
                  ),
                ),
                Icon(
                  Icons.calendar_month,
                  color: isReadOnly ? AppColors.outline.withValues(alpha: 0.5) : AppColors.outline,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        if (errorText != null) ...[
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              errorText!,
              style: AppTextStyle.bodySmall.copyWith(color: Colors.red),
            ),
          ),
        ],
      ],
    );
  }
}
