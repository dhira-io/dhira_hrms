import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                Padding(
            padding: EdgeInsets.all(AppConstants.p16),
            child: ShimmerLoading(
              height: 130.h,
              width: double.infinity,
              borderRadius: AppConstants.r20,
            ),
          ),

          // Filters Row Skeleton
                Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConstants.p16),
            child: Row(
              children: [
                Expanded(
                  child: ShimmerLoading(
                    height: 48.h,
                    width: double.infinity,
                    borderRadius: AppConstants.r10,
                  ),
                ),
                SizedBox(width: AppConstants.p12),
                Expanded(
                  child: ShimmerLoading(
                    height: 48.h,
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
              children: List.generate(4, (index) => const PayslipCardShimmer()),
            ),
          ),
        ],
      ),
    );
  }
}

class PayslipCardShimmer extends StatelessWidget {
  const PayslipCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return       Padding(
      padding: EdgeInsets.only(bottom: AppConstants.p12),
      child: ShimmerLoading(
        height: 80.h,
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
                ShimmerLoading(height: 16.h, width: 120.w),
          const SizedBox(height: AppConstants.p8),
                ShimmerLoading(
            height: 56.h,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
          const SizedBox(height: AppConstants.p16),

          // Employee Card Section
                ShimmerLoading(
            height: 110.h,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
          const SizedBox(height: AppConstants.p16),

          // Bank & Identifiers Grid Section
                ShimmerLoading(height: 16.h, width: 150.w),
          const SizedBox(height: AppConstants.p8),
                Row(
            children: [
              Expanded(
                child: ShimmerLoading(
                  height: 70.h,
                  width: double.infinity,
                  borderRadius: AppConstants.r12,
                ),
              ),
              SizedBox(width: AppConstants.p8),
              Expanded(
                child: ShimmerLoading(
                  height: 70.h,
                  width: double.infinity,
                  borderRadius: AppConstants.r12,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p8),
                Row(
            children: [
              Expanded(
                child: ShimmerLoading(
                  height: 70.h,
                  width: double.infinity,
                  borderRadius: AppConstants.r12,
                ),
              ),
              SizedBox(width: AppConstants.p8),
              Expanded(
                child: ShimmerLoading(
                  height: 70.h,
                  width: double.infinity,
                  borderRadius: AppConstants.r12,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p16),

          // Attendance Summary Section
                ShimmerLoading(height: 16.h, width: 140.w),
          const SizedBox(height: AppConstants.p8),
          Row(
            children: List.generate(
              4,
              (index) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index < 3 ? AppConstants.p8 : 0,
                  ),
                  child:       ShimmerLoading(
                    height: 84.h,
                    width: double.infinity,
                    borderRadius: AppConstants.r12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.p16),

          // Earnings Component Section
                ShimmerLoading(
            height: 130.h,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
          const SizedBox(height: AppConstants.p16),

          // Deductions Component Section
                ShimmerLoading(
            height: 130.h,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
          const SizedBox(height: AppConstants.p16),

          // Tax Summary Section
                ShimmerLoading(
            height: 140.h,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
        ],
      ),
    );
  }
}
