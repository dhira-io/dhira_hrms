import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/shimmer_loading.dart';

/// Premium shimmer loading skeleton for the Payslip List Screen.
class PayslipListShimmer extends StatelessWidget {
  const PayslipListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // YTD Banner Skeleton
          const Padding(
            padding: EdgeInsets.all(AppConstants.p16),
            child: ShimmerLoading(
              height: 130,
              width: double.infinity,
              borderRadius: AppConstants.r20,
            ),
          ),

          // Filters Row Skeleton
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConstants.p16),
            child: Row(
              children: [
                Expanded(
                  child: ShimmerLoading(
                    height: 48,
                    width: double.infinity,
                    borderRadius: AppConstants.r10,
                  ),
                ),
                SizedBox(width: AppConstants.p12),
                Expanded(
                  child: ShimmerLoading(
                    height: 48,
                    width: double.infinity,
                    borderRadius: AppConstants.r10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.p24),

          // Payslip Cards Skeleton List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
            child: Column(
              children: List.generate(4, (index) => const _CardShimmer()),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardShimmer extends StatelessWidget {
  const _CardShimmer();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: AppConstants.p12),
      child: ShimmerLoading(
        height: 80,
        width: double.infinity,
        borderRadius: AppConstants.r16,
      ),
    );
  }
}

/// Premium shimmer loading skeleton for the Payslip Detail Screen.
class PayslipDetailShimmer extends StatelessWidget {
  const PayslipDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppConstants.p16,
        AppConstants.p8,
        AppConstants.p16,
        AppConstants.p100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Financial Period Section
          const ShimmerLoading(height: 16, width: 120),
          const SizedBox(height: AppConstants.p8),
          const ShimmerLoading(
            height: 56,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
          const SizedBox(height: AppConstants.p16),

          // Employee Card Section
          const ShimmerLoading(
            height: 110,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
          const SizedBox(height: AppConstants.p16),

          // Bank & Identifiers Grid Section
          const ShimmerLoading(height: 16, width: 150),
          const SizedBox(height: AppConstants.p8),
          const Row(
            children: [
              Expanded(
                child: ShimmerLoading(
                  height: 70,
                  width: double.infinity,
                  borderRadius: AppConstants.r12,
                ),
              ),
              SizedBox(width: AppConstants.p8),
              Expanded(
                child: ShimmerLoading(
                  height: 70,
                  width: double.infinity,
                  borderRadius: AppConstants.r12,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p8),
          const Row(
            children: [
              Expanded(
                child: ShimmerLoading(
                  height: 70,
                  width: double.infinity,
                  borderRadius: AppConstants.r12,
                ),
              ),
              SizedBox(width: AppConstants.p8),
              Expanded(
                child: ShimmerLoading(
                  height: 70,
                  width: double.infinity,
                  borderRadius: AppConstants.r12,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p16),

          // Attendance Summary Section
          const ShimmerLoading(height: 16, width: 140),
          const SizedBox(height: AppConstants.p8),
          Row(
            children: List.generate(
              4,
              (index) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index < 3 ? AppConstants.p8 : 0,
                  ),
                  child: const ShimmerLoading(
                    height: 84,
                    width: double.infinity,
                    borderRadius: AppConstants.r12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.p16),

          // Earnings Component Section
          const ShimmerLoading(
            height: 130,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
          const SizedBox(height: AppConstants.p16),

          // Deductions Component Section
          const ShimmerLoading(
            height: 130,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
          const SizedBox(height: AppConstants.p16),

          // Tax Summary Section
          const ShimmerLoading(
            height: 140,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
        ],
      ),
    );
  }
}
