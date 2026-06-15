import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/shimmer_loading.dart';

class NotificationItemShimmer extends StatelessWidget {
  const NotificationItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoading(height: 20.h, width: 150.w, borderRadius: 4),
                SizedBox(height: 8.h),
                ShimmerLoading(height: 14.h, width: double.infinity, borderRadius: 4),
                SizedBox(height: 4.h),
                ShimmerLoading(height: 14.h, width: 200.w, borderRadius: 4),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          ShimmerLoading(height: 24.h, width: 40.w, borderRadius: 12),
        ],
      ),
    );
  }
}
