import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(
          color: AppColors.of(context).primary.withValues(alpha: 0.05),
        ),
      ),
      child:       Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 8.w),
          ShimmerLoading(height: 40.h, width: 40.w, borderRadius: 20),
          SizedBox(width: AppConstants.p12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoading(height: 16.h, width: 120.w),
                    ShimmerLoading(height: 12.h, width: 50.w),
                  ],
                ),
                SizedBox(height: 12.h),
                ShimmerLoading(height: 12.h, width: double.infinity),
                SizedBox(height: 6.h),
                ShimmerLoading(height: 12.h, width: 200.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
