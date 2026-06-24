import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:dhira_hrms/features/timesheet/presentation/widgets/timesheet_task_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimesheetLoadingView extends StatelessWidget {
  const TimesheetLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppConstants.p12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Skeleton (mirrors TimesheetNewHeader)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.tableBorder),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left circular button skeleton
                ShimmerLoading(
                  height: 32.w,
                  width: 32.w,
                  borderRadius: 99.r,
                ),
                // Center texts skeleton
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShimmerLoading(
                      height: 16.h,
                      width: 140.w,
                      borderRadius: 4.r,
                    ),
                    SizedBox(height: 4.h),
                    ShimmerLoading(
                      height: 12.h,
                      width: 80.w,
                      borderRadius: 4.r,
                    ),
                  ],
                ),
                // Right circular button skeleton
                ShimmerLoading(
                  height: 32.w,
                  width: 32.w,
                  borderRadius: 99.r,
                ),
              ],
            ),
          ),
          SizedBox(height: 6.h),
          // Weekly Range Skeleton (mirrors TimesheetWeeklyRange)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.tableBorder),
              boxShadow: [
                BoxShadow(
                  color: colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoading(
                  height: 12.h,
                  width: 80.w,
                  borderRadius: 4.r,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    const Expanded(
                      child: _StatCardSkeleton(),
                    ),
                    SizedBox(width: 6.w),
                    const Expanded(
                      child: _StatCardSkeleton(),
                    ),
                    SizedBox(width: 6.w),
                    const Expanded(
                      child: _StatCardSkeleton(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 6.h),
          // Main Progress Container Skeleton (mirrors main container in TimesheetContentView)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: colors.tableBorder,
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Daily progress header skeleton (mirrors TimesheetDailyProgress header)
                Row(
                  children: [
                    ShimmerLoading(
                      height: 12.h,
                      width: 80.w,
                      borderRadius: 4.r,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        ShimmerLoading(
                          height: 6.w,
                          width: 6.w,
                          borderRadius: 99.r,
                        ),
                        SizedBox(width: 4.w),
                        ShimmerLoading(
                          height: 10.h,
                          width: 40.w,
                          borderRadius: 4.r,
                        ),
                        SizedBox(width: 8.w),
                        ShimmerLoading(
                          height: 6.w,
                          width: 6.w,
                          borderRadius: 99.r,
                        ),
                        SizedBox(width: 4.w),
                        ShimmerLoading(
                          height: 10.h,
                          width: 40.w,
                          borderRadius: 4.r,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                // 7 days row skeleton (mirrors TimesheetDailyProgress 7 day buttons row)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (index) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: index == 6 ? 0.w : 5.w),
                        child: AspectRatio(
                          aspectRatio: 0.8,
                          child: Container(
                            decoration: BoxDecoration(
                              color: colors.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: colors.tableBorder,
                                width: 0.67,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ShimmerLoading(
                                  height: 8.h,
                                  width: 16.w,
                                  borderRadius: 2.r,
                                ),
                                SizedBox(height: 4.h),
                                ShimmerLoading(
                                  height: 12.h,
                                  width: 16.w,
                                  borderRadius: 2.r,
                                ),
                                SizedBox(height: 4.h),
                                ShimmerLoading(
                                  height: 5.w,
                                  width: 5.w,
                                  borderRadius: 99.r,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 8.h),
                // Selected Day Card Skeleton (mirrors SelectedDayCard)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: colors.tableBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerLoading(
                                height: 14.h,
                                width: 70.w,
                                borderRadius: 4.r,
                              ),
                              SizedBox(height: 4.h),
                              ShimmerLoading(
                                height: 10.h,
                                width: 90.w,
                                borderRadius: 4.r,
                              ),
                            ],
                          ),
                          ShimmerLoading(
                            height: 27.w,
                            width: 27.w,
                            borderRadius: 99.r,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShimmerLoading(
                            height: 10.h,
                            width: 80.w,
                            borderRadius: 4.r,
                          ),
                          ShimmerLoading(
                            height: 10.h,
                            width: 80.w,
                            borderRadius: 4.r,
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      ShimmerLoading(
                        height: 5.h,
                        width: double.infinity,
                        borderRadius: 99.r,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                // Task Entries title skeleton (mirrors TimesheetTaskSection title)
                SizedBox(
                  height: 26.h,
                  child: Row(
                    children: [
                      ShimmerLoading(
                        height: 14.h,
                        width: 90.w,
                        borderRadius: 4.r,
                      ),
                    ],
                  ),
                ),
                // Divider skeleton (mirrors divider in TimesheetTaskSection)
                Padding(
                  padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                  child: Divider(
                    height: 1,
                    thickness: 0.8,
                    color: colors.tableBorder,
                  ),
                ),
                // Task entries list skeleton (reuses TaskCardSkeleton)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return const TaskCardSkeleton();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}

class _StatCardSkeleton extends StatelessWidget {
  const _StatCardSkeleton();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: colors.tableBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoading(
            height: 10.h,
            width: 40.w,
            borderRadius: 4.r,
          ),
          SizedBox(height: 4.h),
          ShimmerLoading(
            height: 14.h,
            width: 50.w,
            borderRadius: 4.r,
          ),
          SizedBox(height: 4.h),
          ShimmerLoading(
            height: 10.h,
            width: 40.w,
            borderRadius: 4.r,
          ),
        ],
      ),
    );
  }
}
