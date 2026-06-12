import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';

class CompensatoryLeaveSkeleton extends StatelessWidget {
  const CompensatoryLeaveSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.of(context).surfaceContainerHigh,
      highlightColor: AppColors.of(context).surfaceContainerLowest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info Banner Shimmer
          Container(
            width: double.infinity,
            height: 30.h,
            color: AppColors.of(context).surfaceContainerLowest,
          ),
          SizedBox(height: 16.h),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Balance Summary Header
                  const CompensatoryLeaveSkeletonBox(width: 120, height: 16),
                  SizedBox(height: 10.h),

                  // Balance Summary grid of 2 in row
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: 2,
                    ),
                    itemCount: 3,
                    itemBuilder: (context, index) =>
                        const CompensatoryLeaveSkeletonBox(
                          height: 70,
                          width: double.infinity,
                        ),
                  ),
                  SizedBox(height: 10.h),

                  // Card Box 1: Work Details
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.of(context).border,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CompensatoryLeaveSkeletonBox(
                          width: 100,
                          height: 14,
                        ),
                        SizedBox(height: 6.h),
                        const CompensatoryLeaveSkeletonBox(
                          width: 180,
                          height: 10,
                        ),
                        SizedBox(height: 16.h),

                        const CompensatoryLeaveSkeletonBox(
                          width: 70,
                          height: 12,
                        ),
                        SizedBox(height: 8.h),
                        const CompensatoryLeaveSkeletonBox(
                          width: double.infinity,
                          height: 44,
                        ),
                        SizedBox(height: 16.h),

                        const CompensatoryLeaveSkeletonBox(
                          width: 90,
                          height: 12,
                        ),
                        SizedBox(height: 8.h),
                        const CompensatoryLeaveSkeletonBox(
                          width: double.infinity,
                          height: 44,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Card Box 2: Timesheet Details
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.of(context).border,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CompensatoryLeaveSkeletonBox(
                          width: 120,
                          height: 14,
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            const CompensatoryLeaveSkeletonBox(
                              width: 80,
                              height: 16,
                            ),
                            SizedBox(width: 24.w),
                            const CompensatoryLeaveSkeletonBox(
                              width: 80,
                              height: 16,
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        const CompensatoryLeaveSkeletonBox(
                          width: 110,
                          height: 12,
                        ),
                        SizedBox(height: 8.h),
                        const CompensatoryLeaveSkeletonBox(
                          width: double.infinity,
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CompensatoryLeaveSkeletonBox extends StatelessWidget {
  final double width;
  final double height;

  const CompensatoryLeaveSkeletonBox({
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
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}
