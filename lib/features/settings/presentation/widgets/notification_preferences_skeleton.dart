import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/shimmer_loading.dart';

class NotificationPreferencesSkeleton extends StatelessWidget {
  const NotificationPreferencesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:       EdgeInsets.all(24.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                ShimmerLoading(height: 38.h, width: 250.w, borderRadius: 8),
                SizedBox(height: 8.h),
                ShimmerLoading(
            height: 20.h,
            width: double.infinity,
            borderRadius: 4,
          ),
                SizedBox(height: 4.h),
                ShimmerLoading(height: 20.h, width: 200.w, borderRadius: 4),
                SizedBox(height: 40.h),

          _buildSectionSkeleton(),
                SizedBox(height: 32.h),
          _buildSectionSkeleton(),
        ],
      ),
    );
  }

  Widget _buildSectionSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
                  ShimmerLoading(height: 24.h, width: 24.w, borderRadius: 12),
                  SizedBox(width: 8.w),
                  ShimmerLoading(height: 24.h, width: 150.w, borderRadius: 4),
          ],
        ),
              SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.slate200),
          ),
          child: Column(
            children: [
              _buildItemSkeleton(),
                    Divider(height: 1.h, color: AppColors.slate100),
              _buildItemSkeleton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemSkeleton() {
    return Padding(
      padding:       EdgeInsets.all(16.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                      ShimmerLoading(
                  height: 20.h,
                  width: 180.w,
                  borderRadius: 4,
                ),
                      SizedBox(height: 4.h),
                      ShimmerLoading(
                  height: 16.h,
                  width: double.infinity,
                  borderRadius: 4,
                ),
                      SizedBox(height: 2.h),
                      ShimmerLoading(
                  height: 16.h,
                  width: 100.w,
                  borderRadius: 4,
                ),
              ],
            ),
          ),
                SizedBox(width: 16.w),
                ShimmerLoading(
            height: 24.h,
            width: 40.w,
            borderRadius: 12,
          ), // switch
        ],
      ),
    );
  }
}
