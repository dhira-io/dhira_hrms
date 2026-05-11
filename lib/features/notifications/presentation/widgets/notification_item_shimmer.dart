import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/shimmer_loading.dart';

class NotificationItemShimmer extends StatelessWidget {
  const NotificationItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.p12),
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.05)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 8),
          ShimmerLoading(height: 40, width: 40, borderRadius: 20),
          SizedBox(width: AppConstants.p12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoading(height: 16, width: 120),
                    ShimmerLoading(height: 12, width: 50),
                  ],
                ),
                SizedBox(height: 12),
                ShimmerLoading(height: 12, width: double.infinity),
                SizedBox(height: 6),
                ShimmerLoading(height: 12, width: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
