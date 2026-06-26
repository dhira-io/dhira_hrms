import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';

class CalendarSkeletonWidget extends StatelessWidget {
  const CalendarSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 14.h),

            // Month navigation Shimmer
            Center(
              child: ShimmerLoading(
                width: double.infinity,
                height: 50.h,
                borderRadius: AppConstants.r32,
              ),
            ),
            SizedBox(height: 16.h),

            // Calendar grid wrapper Shimmer
            Container(
              padding: const EdgeInsets.all(AppConstants.p12),
              decoration: BoxDecoration(
                color: AppColors.of(context).surface,
                borderRadius: BorderRadius.circular(AppConstants.r16),
                border: Border.all(color: AppColors.of(context).outlineVariant),
              ),
              child: Column(
                children: [
                  // Week days header Shimmer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      7,
                      (index) => ShimmerLoading(
                        width: 32.w,
                        height: 16.h,
                        borderRadius: AppConstants.r4,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Grid days Shimmer
                  Column(
                    children: List.generate(
                      5,
                      (rowIndex) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            7,
                            (colIndex) => ShimmerLoading(
                              width: 36.w,
                              height: 36.w,
                              borderRadius: AppConstants.r8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Monthly Summary Card Shimmer
            ShimmerLoading(
              width: double.infinity,
              height: 60.h,
              borderRadius: AppConstants.r12,
            ),
            SizedBox(height: 20.h),
            ShimmerLoading(
              width: double.infinity,
              height: 60.h,
              borderRadius: AppConstants.r12,
            ),
          ],
        ),
      ),
    );
  }
}
