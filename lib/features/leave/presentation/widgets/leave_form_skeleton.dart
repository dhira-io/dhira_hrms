import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';

class LeaveFormSkeleton extends StatelessWidget {
  const LeaveFormSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.of(context).surfaceContainerHigh,
      highlightColor: AppColors.of(context).surfaceContainerLowest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          _buildBox(width: 140, height: 24),
          const SizedBox(height: AppConstants.p20),

          // Leave Type Label
          _buildBox(width: 100, height: 16),
          const SizedBox(height: AppConstants.p8),
          // Leave Type Dropdown
          _buildBox(width: double.infinity, height: 56),
          const SizedBox(height: AppConstants.p20),

          // Half Day Toggle
          _buildBox(width: double.infinity, height: 50),
          const SizedBox(height: AppConstants.p20),

          // From/To Dates
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBox(width: 80, height: 16),
                    const SizedBox(height: AppConstants.p8),
                    _buildBox(width: double.infinity, height: 56),
                  ],
                ),
              ),
              const SizedBox(width: AppConstants.p16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBox(width: 80, height: 16),
                    const SizedBox(height: AppConstants.p8),
                    _buildBox(width: double.infinity, height: 56),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p20),

          // Reason Label
          _buildBox(width: 120, height: 16),
          const SizedBox(height: AppConstants.p8),
          // Reason Field
          _buildBox(width: double.infinity, height: 120),
          const SizedBox(height: AppConstants.p24),

          // Guidelines
          _buildBox(width: double.infinity, height: 100),
        ],
      ),
    );
  }

  Widget _buildBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.r12),
      ),
    );
  }
}
