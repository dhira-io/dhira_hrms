import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DashboardSkeleton extends StatelessWidget {
  const DashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p20,
        vertical: AppConstants.p24,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: AppConstants.p150,
              height: AppConstants.p20,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppConstants.p4),
              ),
            ),
            const SizedBox(height: AppConstants.p8),
            Container(
              width: AppConstants.p250,
              height: AppConstants.p32,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppConstants.p4),
              ),
            ),
            const SizedBox(height: AppConstants.p24),

            // Profile Card Skeleton
            Container(
              width: double.infinity,
              height: AppConstants.p180,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppConstants.r16),
              ),
            ),
            const SizedBox(height: AppConstants.p32),

            // Quick Stats Skeleton
            Row(
              children: List.generate(
                3,
                (index) => Expanded(
                  child: Container(
                    height: 80,
                    margin: const EdgeInsets.only(right: AppConstants.p12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppConstants.r12),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppConstants.p32),

            // Actions Header Skeleton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: AppConstants.p140,
                  height: AppConstants.p24,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppConstants.p4),
                  ),
                ),
                Container(
                  width: 60,
                  height: AppConstants.p16,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppConstants.p4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.p16),

            // Actions Grid Skeleton
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: AppConstants.p16,
              crossAxisSpacing: AppConstants.p16,
              childAspectRatio: 1,
              children: List.generate(
                4,
                (index) => Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppConstants.r16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
