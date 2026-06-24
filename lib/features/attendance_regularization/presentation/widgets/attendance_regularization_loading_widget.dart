import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceRegularizationLoadingWidget extends StatelessWidget {
  const AttendanceRegularizationLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      height: 34.h,
      width: double.infinity,
      borderRadius: 4.r,
    );
  }
}
