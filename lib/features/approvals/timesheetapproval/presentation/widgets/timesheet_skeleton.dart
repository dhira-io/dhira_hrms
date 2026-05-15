import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class TimesheetSkeleton extends StatelessWidget {
  const TimesheetSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerLoading(height: 60, width: double.infinity),
          const SizedBox(height: AppConstants.p24),
          const ShimmerLoading(height: 120, width: double.infinity),
          const SizedBox(height: AppConstants.p24),
          Row(
            children: const [
              Expanded(child: ShimmerLoading(height: 40, width: 100)),
              SizedBox(width: AppConstants.p12),
              Expanded(child: ShimmerLoading(height: 40, width: 100)),
              SizedBox(width: AppConstants.p12),
              Expanded(child: ShimmerLoading(height: 40, width: 100)),
            ],
          ),
          const SizedBox(height: AppConstants.p24),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: AppConstants.p16),
                child: const ShimmerLoading(height: 80, width: double.infinity),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
