import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/shimmer_loading.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Header Skeleton
          Container(
            padding: const EdgeInsets.all(AppConstants.p20),
            color: AppColors.of(context).profileHeaderBg,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar Skeleton
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.of(context).white,
                      width: 4.w,
                    ),
                  ),
                  child:       ClipOval(
                    child: ShimmerLoading(height: 100.h, width: 100.w),
                  ),
                ),
                const SizedBox(width: AppConstants.p20),
                // Text Skeleton
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                            ShimmerLoading(height: 24.h, width: 150.w),
                      const SizedBox(height: AppConstants.p12),
                            ShimmerLoading(height: 16.h, width: 100.w),
                            SizedBox(height: AppConstants.p16),
                      Row(
                        children:       [
                          ShimmerLoading(
                            height: 20.h,
                            width: 80.w,
                            borderRadius: 4,
                          ),
                          SizedBox(width: AppConstants.p8),
                          ShimmerLoading(
                            height: 20.h,
                            width: 80.w,
                            borderRadius: 4,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tabs Skeleton
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p20,
              vertical: AppConstants.p12,
            ),
            color: AppColors.of(context).profileTabBg,
            child:       Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ShimmerLoading(height: 20.h, width: 80.w),
                ShimmerLoading(height: 20.h, width: 120.w),
              ],
            ),
          ),

          // Content Skeleton
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.p20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                        ShimmerLoading(height: 20.h, width: 150.w),
                  const SizedBox(height: AppConstants.p16),
                  Container(
                    padding: const EdgeInsets.all(AppConstants.p16),
                    decoration: BoxDecoration(
                      color: AppColors.of(context).profileInfoCardBg,
                      borderRadius: BorderRadius.circular(AppConstants.r12),
                      border: Border.all(
                        color: AppColors.of(
                          context,
                        ).profileBadgeBorder.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Column(
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding:       EdgeInsets.only(
                            bottom: AppConstants.p16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:       [
                              ShimmerLoading(height: 16.h, width: 80.w),
                              ShimmerLoading(height: 16.h, width: 120.w),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
