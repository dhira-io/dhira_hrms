import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/shimmer_loading.dart';

class SettingsSkeleton extends StatelessWidget {
  const SettingsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:       EdgeInsets.only(
        left: 16.0.w,
        right: 16.0.w,
        top: 16.0.h,
        bottom: 120.0.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Card Skeleton
                ShimmerLoading(
            height: 100.h,
            width: double.infinity,
            borderRadius: 16,
          ),
                SizedBox(height: 24.h),

          // Group Skeleton
          _buildGroupSkeleton(2),
                SizedBox(height: 24.h),

          // Group Skeleton
          _buildGroupSkeleton(3),
                SizedBox(height: 24.h),

          // Group Skeleton
          _buildGroupSkeleton(3),
                SizedBox(height: 24.h),

          // Logout Button Skeleton
                ShimmerLoading(
            height: 56.h,
            width: double.infinity,
            borderRadius: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildGroupSkeleton(int itemCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
              ShimmerLoading(height: 24.h, width: 120.w, borderRadius: 4),
              SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: List.generate(itemCount, (index) {
              return Padding(
                padding:       EdgeInsets.all(16.0.w),
                child: Row(
                  children: [
                          ShimmerLoading(
                      height: 24.h,
                      width: 24.w,
                      borderRadius: 12,
                    ), // icon
                          SizedBox(width: 16.w),
                          ShimmerLoading(
                      height: 20.h,
                      width: 150.w,
                      borderRadius: 4,
                    ), // text
                    const Spacer(),
                          ShimmerLoading(
                      height: 20.h,
                      width: 20.w,
                      borderRadius: 10,
                    ), // right arrow/icon
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
