import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/shimmer_loading.dart';

class ApprovalsShimmer extends StatelessWidget {
  const ApprovalsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: List.generate(3, (index) => const ShimmerCard()));
  }
}

/// Full-screen shimmer shown during the very first load.
/// Mimics the primary tab bar, sub-tab pills, and 3 approval cards.
class ApprovalsFullScreenShimmer extends StatelessWidget {
  const ApprovalsFullScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Primary Tab Shimmer (Team / Raised toggle)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
          child: ShimmerLoading(
            height: 48.h,
            width: double.infinity,
            borderRadius: AppConstants.r12,
          ),
        ),
        const SizedBox(height: AppConstants.p16),

        // Sub Tab Shimmer (Leave / Attendance / Timesheet / Comp-Off pills)
        SizedBox(
          height: 40.h,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (_, __) => SizedBox(width: AppConstants.p8),
            itemBuilder: (_, __) =>       ShimmerLoading(
              height: 40.h,
              width: 90.w,
              borderRadius: 24,
            ),
          ),
        ),
        const SizedBox(height: AppConstants.p16),

        // List Shimmer (3 approval cards)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
          child: Column(children: List.generate(3, (_) => const ShimmerCard())),
        ),
      ],
    );
  }
}

class SliverApprovalsShimmer extends StatelessWidget {
  const SliverApprovalsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => const Padding(
          padding: EdgeInsets.only(bottom: AppConstants.p16),
          child: ShimmerCard(),
        ),
        childCount: 3,
      ),
    );
  }
}

class SliverSingleApprovalsShimmer extends StatelessWidget {
  const SliverSingleApprovalsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(bottom: AppConstants.p16),
        child: ShimmerCard(),
      ),
    );
  }
}

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      margin: const EdgeInsets.only(bottom: AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Skeleton
          Row(
            children: [
                    ShimmerLoading(height: AppConstants.p48, width: AppConstants.p48, borderRadius: 24),
              const SizedBox(width: AppConstants.p12),
                    Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(height: 16.h, width: 140.w),
                    SizedBox(height: 8.h),
                    ShimmerLoading(height: 12.h, width: 100.w),
                  ],
                ),
              ),
              const SizedBox(width: AppConstants.p8),
                    ShimmerLoading(height: 24.h, width: 70.w, borderRadius: 12),
            ],
          ),
          const SizedBox(height: AppConstants.p16),

          // Details Skeleton
          Container(
            padding: const EdgeInsets.all(AppConstants.p12),
            decoration: BoxDecoration(
              color: AppColors.of(context).surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
            child: Column(
              children: [
                const _ShimmerDetailRow(),
                Divider(
                  height: AppConstants.p16,
                  color: AppColors.of(context).border,
                ),
                const _ShimmerDetailRow(),
                Divider(
                  height: AppConstants.p16,
                  color: AppColors.of(context).border,
                ),
                const _ShimmerDetailRow(),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.p16),

          // Actions Skeleton
                Row(
            children: [
              Expanded(
                child: ShimmerLoading(
                  height: 44.h,
                  width: double.infinity,
                  borderRadius: 8,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ShimmerLoading(
                  height: 44.h,
                  width: double.infinity,
                  borderRadius: 8,
                ),
              ),
              SizedBox(width: 12.w),
              ShimmerLoading(height: 44.h, width: 44.w, borderRadius: 8),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShimmerDetailRow extends StatelessWidget {
  const _ShimmerDetailRow();

  @override
  Widget build(BuildContext context) {
    return       Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ShimmerLoading(height: 12.h, width: 80.w),
        ShimmerLoading(height: 14.h, width: 100.w),
      ],
    );
  }
}
