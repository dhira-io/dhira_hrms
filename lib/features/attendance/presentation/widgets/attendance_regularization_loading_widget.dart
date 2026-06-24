import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceRegularizationLoadingWidget extends StatelessWidget {
  const AttendanceRegularizationLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: SizedBox(
        width: 18.r,
        height: 18.r,
        child: const CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
