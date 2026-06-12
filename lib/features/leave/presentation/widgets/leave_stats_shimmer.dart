import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';

class LeaveStatsShimmer extends StatelessWidget {
  const LeaveStatsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.of(context).surfaceContainerHigh,
      highlightColor: AppColors.of(context).surfaceContainerLowest,
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: AppConstants.p12,
        mainAxisSpacing: AppConstants.p12,
        childAspectRatio: 1.3,
        children: List.generate(
          4,
          (index) => Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
          ),
        ),
      ),
    );
  }
}
