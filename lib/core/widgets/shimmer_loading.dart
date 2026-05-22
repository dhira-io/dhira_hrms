import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const ShimmerLoading({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Shimmer.fromColors(
      baseColor: colors.surfaceContainerHigh,
      highlightColor: colors.surfaceContainerLowest,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
