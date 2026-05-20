import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

class PunchCardSkeleton extends StatelessWidget {
  const PunchCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Shimmer.fromColors(
        baseColor: AppColors.of(context).shimmerBase,
        highlightColor: AppColors.of(context).shimmerHighlight,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.of(context).white,
            borderRadius: BorderRadius.circular(AppConstants.r16),
          ),
        ),
      ),
    );
  }
}
