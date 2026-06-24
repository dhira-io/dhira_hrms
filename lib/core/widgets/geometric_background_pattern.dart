import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import '../theme/app_colors.dart';

class GeometricBackgroundPattern extends StatelessWidget {
  const GeometricBackgroundPattern({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Shape on the top-left
          Positioned(
            top: -30.h,
            left: -210.w,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 180.w,
                    height: 260.w,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.113),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  Container(
                    width: 260.w,
                    height: 200.w,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.125),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 2. Shape on the middle-right
          Positioned(
            top: -100.h,
            right: -160.w,
            child: Transform.rotate(
              angle: math.pi / 3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 210.w,
                    height: 270.w,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.123),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  Container(
                    width: 260.w,
                    height: 330.w,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.135),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
