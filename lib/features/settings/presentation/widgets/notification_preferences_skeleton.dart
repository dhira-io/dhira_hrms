import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/shimmer_loading.dart';

class NotificationPreferencesSkeleton extends StatelessWidget {
  const NotificationPreferencesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerLoading(height: 38, width: 250, borderRadius: 8),
          const SizedBox(height: 8),
          const ShimmerLoading(height: 20, width: double.infinity, borderRadius: 4),
          const SizedBox(height: 4),
          const ShimmerLoading(height: 20, width: 200, borderRadius: 4),
          const SizedBox(height: 40),
          
          _buildSectionSkeleton(),
          const SizedBox(height: 32),
          _buildSectionSkeleton(),
        ],
      ),
    );
  }

  Widget _buildSectionSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const ShimmerLoading(height: 24, width: 24, borderRadius: 12),
            const SizedBox(width: 8),
            const ShimmerLoading(height: 24, width: 150, borderRadius: 4),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.slate200),
          ),
          child: Column(
            children: [
              _buildItemSkeleton(),
              const Divider(height: 1, color: AppColors.slate100),
              _buildItemSkeleton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemSkeleton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerLoading(height: 20, width: 180, borderRadius: 4),
                const SizedBox(height: 4),
                const ShimmerLoading(height: 16, width: double.infinity, borderRadius: 4),
                const SizedBox(height: 2),
                const ShimmerLoading(height: 16, width: 100, borderRadius: 4),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const ShimmerLoading(height: 24, width: 40, borderRadius: 12), // switch
        ],
      ),
    );
  }
}
