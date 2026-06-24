import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';

class LeaveFormSkeleton extends StatelessWidget {
  const LeaveFormSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.of(context).surfaceContainerHigh,
      highlightColor: AppColors.of(context).surfaceContainerLowest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          SkeletonBox(width: 140.w, height: 24.h),
          SizedBox(height: AppConstants.p20.h),

          // Leave Type Label
          SkeletonBox(width: 100.w, height: 16.h),
          SizedBox(height: AppConstants.p8.h),
          // Leave Type Dropdown
          SkeletonBox(width: double.infinity, height: 56.h),
          SizedBox(height: AppConstants.p20.h),

          // Half Day Toggle
          SkeletonBox(width: double.infinity, height: 50.h),
          SizedBox(height: AppConstants.p20.h),

          // From/To Dates
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonBox(width: 80.w, height: 16.h),
                    SizedBox(height: AppConstants.p8.h),
                    SkeletonBox(width: double.infinity, height: 56.h),
                  ],
                ),
              ),
              SizedBox(width: AppConstants.p16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonBox(width: 80.w, height: 16.h),
                    SizedBox(height: AppConstants.p8.h),
                    SkeletonBox(width: double.infinity, height: 56.h),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppConstants.p20.h),

          // Reason Label
          SkeletonBox(width: 120.w, height: 16.h),
          SizedBox(height: AppConstants.p8.h),
          // Reason Field
          SkeletonBox(width: double.infinity, height: 120.h),
          SizedBox(height: AppConstants.p24.h),

          // Guidelines
          SkeletonBox(width: double.infinity, height: 100.h),
        ],
      ),
    );
  }
}

class SkeletonBox extends StatelessWidget {
  final double width;
  final double height;

  const SkeletonBox({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.of(context).white,
        borderRadius: BorderRadius.circular(AppConstants.r12.r),
      ),
    );
  }
}
