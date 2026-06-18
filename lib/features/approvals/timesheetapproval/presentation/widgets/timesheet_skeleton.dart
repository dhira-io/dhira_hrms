import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                ShimmerLoading(height: 60.h, width: double.infinity),
                SizedBox(height: AppConstants.p24),
                ShimmerLoading(height: 120.h, width: double.infinity),
                SizedBox(height: AppConstants.p24),
          Row(
            children:       [
              Expanded(
                child: ShimmerLoading(height: 40.h, width: 100.w),
              ),
              SizedBox(width: AppConstants.p12),
              Expanded(
                child: ShimmerLoading(height: 40.h, width: 100.w),
              ),
              SizedBox(width: AppConstants.p12),
              Expanded(
                child: ShimmerLoading(height: 40.h, width: 100.w),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p24),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: AppConstants.p16),
                child:       ShimmerLoading(
                  height: 80.h,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
