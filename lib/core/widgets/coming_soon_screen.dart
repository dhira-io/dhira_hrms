import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/widgets/app_header.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComingSoonScreen extends StatelessWidget {
  final String title;

  const ComingSoonScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: AppBar(
        backgroundColor: AppColors.of(context).surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.of(context).onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text(
          title,
          style: AppTextStyle.bodyLarge.copyWith(
            color: AppColors.of(context).onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction_rounded,
              size: 80.w,
              color: AppColors.of(context).primary,
            ),
            SizedBox(height: 24.h),
            Text(
              "Coming Soon!",
              style: AppTextStyle.headlineSmall.copyWith(
                color: AppColors.of(context).onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              "We are working hard to bring this feature to you.",
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.of(context).onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
