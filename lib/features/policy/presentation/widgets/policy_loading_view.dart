import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';

class PolicyLoadingView extends StatelessWidget {
  const PolicyLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.of(context).surfaceContainerLow,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppConstants.r16),
                topRight: Radius.circular(AppConstants.r16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Subtitle Skeleton
                  ShimmerLoading(height: 14.h, width: 200.w),
                  SizedBox(height: AppConstants.p16.h),

                  // Search Box Skeleton
                  ShimmerLoading(
                    height: 48.h,
                    width: double.infinity,
                    borderRadius: AppConstants.r12,
                  ),
                  SizedBox(height: AppConstants.p16.h),

                  // Controls Row Skeleton
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerLoading(height: 14.h, width: 120.w),
                      ShimmerLoading(
                        height: 36.h,
                        width: 80.w,
                        borderRadius: AppConstants.r12,
                      ),
                    ],
                  ),
                  SizedBox(height: AppConstants.p16.h),

                  // List Skeleton
                  Expanded(
                    child: ListView.separated(
                      itemCount: 5,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: AppConstants.p10.h),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(AppConstants.p16.w),
                          decoration: BoxDecoration(
                            color: AppColors.of(context).surfaceContainerLowest,
                            borderRadius: BorderRadius.circular(
                              AppConstants.r12,
                            ),
                            border: Border.all(
                              color: AppColors.of(
                                context,
                              ).outlineVariant.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerLoading(
                                height: 60.w,
                                width: 60.w,
                                borderRadius: AppConstants.r8,
                              ),
                              SizedBox(width: AppConstants.p12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShimmerLoading(height: 16.h, width: 200.w),
                                    SizedBox(height: AppConstants.p8.h),
                                    ShimmerLoading(height: 12.h, width: 150.w),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
