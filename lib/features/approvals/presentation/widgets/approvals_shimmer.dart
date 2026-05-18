import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/shimmer_loading.dart';

class ApprovalsShimmer extends StatelessWidget {
  const ApprovalsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index) => const ShimmerCard()),
    );
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
            height: 48,
            width: double.infinity,
            borderRadius: AppConstants.r12,
          ),
        ),
        SizedBox(height: AppConstants.p16),

        // Sub Tab Shimmer (Leave / Attendance / Timesheet / Comp-Off pills)
        SizedBox(
          height: 40,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (_, __) => SizedBox(width: AppConstants.p8),
            itemBuilder: (_, __) => const ShimmerLoading(
              height: 40,
              width: 90,
              borderRadius: 24,
            ),
          ),
        ),
        SizedBox(height: AppConstants.p16),

        // List Shimmer (3 approval cards)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
          child: Column(
            children: List.generate(3, (_) => const ShimmerCard()),
          ),
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
        color: AppColors.of(context).white,
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
              const ShimmerLoading(height: 48, width: 48, borderRadius: 24),
              SizedBox(width: AppConstants.p12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(height: 16, width: 140),
                    SizedBox(height: 8),
                    ShimmerLoading(height: 12, width: 100),
                  ],
                ),
              ),
              SizedBox(width: AppConstants.p8),
              const ShimmerLoading(height: 24, width: 70, borderRadius: 12),
            ],
          ),
          SizedBox(height: AppConstants.p16),

          // Details Skeleton
          Container(
            padding: const EdgeInsets.all(AppConstants.p12),
            decoration: BoxDecoration(
              color: AppColors.of(context).surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
            child:  Column(
              children: [
                const _ShimmerDetailRow(),
                Divider(height: AppConstants.p16, color: AppColors.of(context).border),
                const _ShimmerDetailRow(),
                Divider(height: AppConstants.p16, color: AppColors.of(context).border),
                const _ShimmerDetailRow(),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.p16),

          // Actions Skeleton
          const Row(
            children: [
              Expanded(child: ShimmerLoading(height: 44, width: double.infinity, borderRadius: 8)),
              SizedBox(width: 12),
              Expanded(child: ShimmerLoading(height: 44, width: double.infinity, borderRadius: 8)),
              SizedBox(width: 12),
              ShimmerLoading(height: 44, width: 44, borderRadius: 8),
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
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ShimmerLoading(height: 12, width: 80),
        ShimmerLoading(height: 14, width: 100),
      ],
    );
  }
}