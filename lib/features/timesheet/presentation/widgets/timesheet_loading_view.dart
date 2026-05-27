import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class TimesheetLoadingView extends StatelessWidget {
  const TimesheetLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bento stats skeleton
          const ShimmerLoading(
            height: 180,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
          const SizedBox(height: AppConstants.p24),
          // Week selector calendar range skeleton
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ShimmerLoading(height: 20, width: 20, borderRadius: 4),
              SizedBox(width: 16),
              ShimmerLoading(height: 24, width: 180, borderRadius: 4),
              SizedBox(width: 16),
              ShimmerLoading(height: 20, width: 20, borderRadius: 4),
            ],
          ),
          const SizedBox(height: AppConstants.p16),
          // Row of 7 day bubbles skeletons
          Row(
            children: List.generate(7, (index) {
              return const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: ShimmerLoading(
                    height: 56,
                    width: double.infinity,
                    borderRadius: AppConstants.r12,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: AppConstants.p24),
          // Task section title skeleton
          const ShimmerLoading(
            height: 24,
            width: 140,
            borderRadius: AppConstants.r4,
          ),
          const SizedBox(height: AppConstants.p24),
          // Task items skeletons
          const ShimmerLoading(
            height: 100,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
          const SizedBox(height: AppConstants.p24),
          const ShimmerLoading(
            height: 100,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
          const SizedBox(height: AppConstants.p24),
          // Submit button skeleton
          const ShimmerLoading(
            height: 54,
            width: double.infinity,
            borderRadius: AppConstants.r12,
          ),
        ],
      ),
    );
  }
}
