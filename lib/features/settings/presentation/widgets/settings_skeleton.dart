import 'package:flutter/material.dart';
import '../../../../core/widgets/shimmer_loading.dart';

class SettingsSkeleton extends StatelessWidget {
  const SettingsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 120.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Card Skeleton
          const ShimmerLoading(height: 100, width: double.infinity, borderRadius: 16),
          const SizedBox(height: 24),
          
          // Group Skeleton
          _buildGroupSkeleton(2),
          const SizedBox(height: 24),
          
          // Group Skeleton
          _buildGroupSkeleton(3),
          const SizedBox(height: 24),
          
          // Group Skeleton
          _buildGroupSkeleton(3),
          const SizedBox(height: 24),
          
          // Logout Button Skeleton
          const ShimmerLoading(height: 56, width: double.infinity, borderRadius: 12),
        ],
      ),
    );
  }

  Widget _buildGroupSkeleton(int itemCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ShimmerLoading(height: 24, width: 120, borderRadius: 4),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: List.generate(itemCount, (index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const ShimmerLoading(height: 24, width: 24, borderRadius: 12), // icon
                    const SizedBox(width: 16),
                    const ShimmerLoading(height: 20, width: 150, borderRadius: 4), // text
                    const Spacer(),
                    const ShimmerLoading(height: 20, width: 20, borderRadius: 10), // right arrow/icon
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
