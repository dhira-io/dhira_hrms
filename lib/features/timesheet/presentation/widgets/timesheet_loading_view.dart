import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class TimesheetLoadingView extends StatelessWidget {
  const TimesheetLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:       EdgeInsets.all(AppConstants.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bento stats skeleton
                ShimmerLoading(
            height: 180.h,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
                SizedBox(height: AppConstants.p24),
          // Week selector calendar range skeleton
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:       [
              ShimmerLoading(height: 20.h, width: 20.w, borderRadius: 4),
              SizedBox(width: 16.w),
              ShimmerLoading(height: 24.h, width: 180.w, borderRadius: 4),
              SizedBox(width: 16.w),
              ShimmerLoading(height: 20.h, width: 20.w, borderRadius: 4),
            ],
          ),
          const SizedBox(height: AppConstants.p16),
          // Row of 7 day bubbles skeletons
          Row(
            children: List.generate(7, (index) {
              return       Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: ShimmerLoading(
                    height: 56.h,
                    width: double.infinity,
                    borderRadius: AppConstants.r12,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: AppConstants.p24),
          // Task section title skeleton
                ShimmerLoading(
            height: 24.h,
            width: 140.w,
            borderRadius: AppConstants.r4,
          ),
          const SizedBox(height: AppConstants.p24),
          // Task items skeletons
                ShimmerLoading(
            height: 100.h,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
          const SizedBox(height: AppConstants.p24),
                ShimmerLoading(
            height: 100.h,
            width: double.infinity,
            borderRadius: AppConstants.r16,
          ),
          const SizedBox(height: AppConstants.p24),
          // Submit button skeleton
                ShimmerLoading(
            height: 54.h,
            width: double.infinity,
            borderRadius: AppConstants.r12,
          ),
        ],
      ),
    );
  }
}
