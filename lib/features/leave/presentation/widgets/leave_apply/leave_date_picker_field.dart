import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p16,
              vertical: AppConstants.p14,
            ),
            decoration: BoxDecoration(
              color: isReadOnly
                  ? AppColors.of(context).surfaceContainerLow
                  : Colors.white,
              borderRadius: BorderRadius.circular(AppConstants.r12),
              border: errorText != null
                  ? Border.all(color: Colors.red, width: 1.w)
                  : Border.all(color: const Color(0xFF90A1B9), width: 1.w),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: (isReadOnly || text == 'dd/MM/yyyy')
                        ? AppColors.of(context).outline
                        : AppColors.of(context).onSurface,
                  ),
                ),
                Icon(
                  Icons.calendar_month,
                  color: isReadOnly
                      ? AppColors.of(context).outline.withValues(alpha: 0.5)
                      : AppColors.of(context).outline,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        if (errorText != null) ...[
                SizedBox(height: 4.h),
          Padding(
            padding:       EdgeInsets.symmetric(horizontal: 4.w),
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
