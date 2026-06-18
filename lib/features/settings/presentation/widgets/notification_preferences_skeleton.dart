import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../../core/theme/app_colors.dart';

class NotificationPreferencesSkeleton extends StatelessWidget {
  final bool isManager;

  const NotificationPreferencesSkeleton({
    super.key,
    this.isManager = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionSkeleton(context, isManager: isManager),
          SizedBox(height: 40.h),
          _buildSectionSkeleton(context, isManager: isManager),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildSectionSkeleton(BuildContext context, {required bool isManager}) {
    final typeFlex = isManager ? 28 : 22;
    final personalFlex = isManager ? 7 : 10;
    final teamFlex = 7;

    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: colors.iconbgblue,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: ShimmerLoading(
                  height: 18.w,
                  width: 18.w,
                  borderRadius: 9999,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            ShimmerLoading(
              height: 20.h,
              width: 180.w,
              borderRadius: 4.r,
            ),
          ],
        ),
        SizedBox(height: 10.h),
        // Table Wrapper
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: colors.tableBorder, width: 1.w),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // Table Header Row
              Container(
                height: 38.h,
                decoration: BoxDecoration(
                  color: isDark ? colors.surfaceContainerLow : colors.infoBg,
                  border: Border(
                    bottom: BorderSide(color: colors.tableBorder),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: typeFlex,
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          border: isManager
                              ? Border(
                                  right: BorderSide(color: colors.tableBorder),
                                )
                              : null,
                        ),
                        child: ShimmerLoading(
                          height: 14.h,
                          width: 110.w,
                          borderRadius: 4.r,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: personalFlex,
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        decoration: BoxDecoration(
                          border: isManager
                              ? Border(
                                  right: BorderSide(color: colors.tableBorder),
                                )
                              : null,
                        ),
                        child: isManager
                            ? ShimmerLoading(
                                height: 14.h,
                                width: 50.w,
                                borderRadius: 4.r,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                    if (isManager)
                      Expanded(
                        flex: teamFlex,
                        child: Container(
                          height: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: ShimmerLoading(
                            height: 14.h,
                            width: 50.w,
                            borderRadius: 4.r,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Table Data Rows (4 rows)
              ...List.generate(4, (index) {
                final isLast = index == 3;
                return Container(
                  height: 38.h,
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLowest,
                    border: isLast
                        ? null
                        : Border(
                            bottom: BorderSide(color: colors.tableBorder),
                          ),
                  ),
                  child: Row(
                    children: [
                      // Column 1: Row Title
                      Expanded(
                        flex: typeFlex,
                        child: Container(
                          height: double.infinity,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: ShimmerLoading(
                            height: 14.h,
                            width: index == 0
                                ? 120.w
                                : index == 1
                                    ? 150.w
                                    : index == 2
                                        ? 80.w
                                        : 110.w,
                            borderRadius: 4.r,
                          ),
                        ),
                      ),
                      // Column 2: Personal Toggle
                      Expanded(
                        flex: personalFlex,
                        child: Container(
                          height: double.infinity,
                          alignment: Alignment.center,
                          child: ShimmerLoading(
                            height: 20.w,
                            width: 36.w,
                            borderRadius: 9999,
                          ),
                        ),
                      ),
                      // Column 3: Team Toggle (if manager)
                      if (isManager)
                        Expanded(
                          flex: teamFlex,
                          child: Container(
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: ShimmerLoading(
                              height: 20.w,
                              width: 36.w,
                              borderRadius: 9999,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
