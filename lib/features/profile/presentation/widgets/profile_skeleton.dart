import 'package:flutter/material.dart';
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
            color: AppColors.profileHeaderBg,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar Skeleton
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 4),
                  ),
                  child: const ClipOval(
                    child: ShimmerLoading(height: 100, width: 100),
                  ),
                ),
                const SizedBox(width: AppConstants.p20),
                // Text Skeleton
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ShimmerLoading(height: 24, width: 150),
                      const SizedBox(height: AppConstants.p12),
                      const ShimmerLoading(height: 16, width: 100),
                      const SizedBox(height: AppConstants.p16),
                      Row(
                        children: const [
                          ShimmerLoading(height: 20, width: 80, borderRadius: 4),
                          SizedBox(width: AppConstants.p8),
                          ShimmerLoading(height: 20, width: 80, borderRadius: 4),
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
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20, vertical: AppConstants.p12),
            color: AppColors.profileTabBg,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                ShimmerLoading(height: 20, width: 80),
                ShimmerLoading(height: 20, width: 120),
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
                  const ShimmerLoading(height: 20, width: 150),
                  const SizedBox(height: AppConstants.p16),
                  Container(
                    padding: const EdgeInsets.all(AppConstants.p16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppConstants.r12),
                      border: Border.all(color: AppColors.profileBadgeBorder.withValues(alpha: 0.5)),
                    ),
                    child: Column(
                      children: List.generate(4, (index) => Padding(
                        padding: const EdgeInsets.only(bottom: AppConstants.p16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            ShimmerLoading(height: 16, width: 80),
                            ShimmerLoading(height: 16, width: 120),
                          ],
                        ),
                      )),
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
