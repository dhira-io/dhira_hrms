import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/shimmer_loading.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header Skeleton Card
            _SkeletonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar Skeleton
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: ShimmerLoading(height: 80.w, width: 80.w),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      // Text Skeleton
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerLoading(height: 20.h, width: 140.w),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                ShimmerLoading(height: 18.h, width: 60.w, borderRadius: 4),
                                SizedBox(width: 8.w),
                                ShimmerLoading(height: 18.h, width: 60.w, borderRadius: 4),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  ShimmerLoading(height: 36.h, width: 140.w, borderRadius: 8),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      ShimmerLoading(height: 14.h, width: 60.w),
                      SizedBox(width: 16.w),
                      Expanded(child: ShimmerLoading(height: 6.h, width: double.infinity, borderRadius: 3)),
                      SizedBox(width: 12.w),
                      ShimmerLoading(height: 14.h, width: 30.w),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      ShimmerLoading(height: 14.h, width: 60.w),
                      SizedBox(width: 16.w),
                      Expanded(child: ShimmerLoading(height: 6.h, width: double.infinity, borderRadius: 3)),
                      SizedBox(width: 12.w),
                      ShimmerLoading(height: 14.h, width: 30.w),
                    ],
                  ),
                ],
              ),
            ),

            // Tabs Skeleton
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.of(context).border
                          : AppColors.of(context).bordergrey,
                      width: 1.h,
                    ),
                  ),
                ),
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: AppColors.of(context).surfaceContainerLowest,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r),
                          ),
                        ),
                        child: Center(child: ShimmerLoading(height: 16.h, width: 80.w)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: AppColors.of(context).surfaceContainerLowest,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r),
                          ),
                        ),
                        child: Center(child: ShimmerLoading(height: 16.h, width: 120.w)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content Skeleton
            _SkeletonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ShimmerLoading(height: 20.w, width: 20.w, borderRadius: 10),
                      SizedBox(width: 8.w),
                      ShimmerLoading(height: 20.h, width: 150.w),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  ShimmerLoading(height: 60.h, width: double.infinity, borderRadius: 8),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerLoading(height: 12.h, width: 80.w),
                            SizedBox(height: 8.h),
                            ShimmerLoading(height: 16.h, width: 100.w),
                            SizedBox(height: 12.h),
                            Divider(height: 1.h, thickness: 0.5),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerLoading(height: 12.h, width: 80.w),
                            SizedBox(height: 8.h),
                            ShimmerLoading(height: 16.h, width: 100.w),
                            SizedBox(height: 12.h),
                            Divider(height: 1.h, thickness: 0.5),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerLoading(height: 12.h, width: 80.w),
                            SizedBox(height: 8.h),
                            ShimmerLoading(height: 16.h, width: 100.w),
                            SizedBox(height: 12.h),
                            Divider(height: 1.h, thickness: 0.5),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerLoading(height: 12.h, width: 80.w),
                            SizedBox(height: 8.h),
                            ShimmerLoading(height: 16.h, width: 100.w),
                            SizedBox(height: 12.h),
                            Divider(height: 1.h, thickness: 0.5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  final Widget child;

  const _SkeletonCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.of(context).surface
            : AppColors.of(context).white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark
              ? AppColors.of(context).border
              : AppColors.of(context).bordergrey,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(
              context,
            ).black.withValues(alpha: isDark ? 0.3 : 0.04),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: child,
    );
  }
}
