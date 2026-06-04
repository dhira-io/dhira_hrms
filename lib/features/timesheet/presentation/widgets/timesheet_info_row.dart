import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class TimesheetInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Widget? valueWidget;

  const TimesheetInfoRow({
    super.key,
    required this.label,
    this.value = '',
    this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:       EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: AppTextStyle.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
          ),
                SizedBox(width: 8.w),
          Expanded(
            child:
                valueWidget ??
                Text(
                  value,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.of(context).textPrimary,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
