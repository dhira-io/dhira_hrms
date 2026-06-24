import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceRegularizationLoadingView extends StatelessWidget {
  const AttendanceRegularizationLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        children: [
          ShimmerLoading(height: 50.h, width: double.infinity, borderRadius: 8.r),
          SizedBox(height: 16.h),
          ShimmerLoading(height: 120.h, width: double.infinity, borderRadius: 8.r),
          SizedBox(height: 16.h),
          ShimmerLoading(height: 50.h, width: double.infinity, borderRadius: 8.r),
        ],
      ),
    );
  }
}
