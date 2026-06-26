import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class TimesheetSkeleton extends StatelessWidget {
  const TimesheetSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Card Shimmer
          ShimmerLoading(
            width: double.infinity,
            height: 100.h,
            borderRadius: 16.r,
          ),
          SizedBox(height: 16.h),
          // Day Section Shimmers
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  border: Border.all(color: colors.slateBorder),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    ShimmerLoading(
                      width: 40.w,
                      height: 40.h,
                      borderRadius: 8.r,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerLoading(width: 120.w, height: 16.h),
                          SizedBox(height: 8.h),
                          ShimmerLoading(width: 80.w, height: 12.h),
                        ],
                      ),
                    ),
                    ShimmerLoading(width: 50.w, height: 16.h),
                    SizedBox(width: 16.w),
                    ShimmerLoading(width: 24.w, height: 24.h, borderRadius: 12.r),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
