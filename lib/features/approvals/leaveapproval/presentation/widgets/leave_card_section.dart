import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class LeaveCardSection extends StatelessWidget {
  final String title;
  final Widget child;

  const LeaveCardSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.r20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppConstants.p20),
          child,
        ],
      ),
    );
  }
}
