import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p20,
        vertical: AppConstants.p12,
      ),
      color: AppColors.surface,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'DHIRA',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'www.dhira.ai',
                style: AppTextStyle.bodySmall.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          const SizedBox(width: AppConstants.p8),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.purple.shade50,
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.purple.shade100,
              child: const Text(
                'S',
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.textPrimary),
          const SizedBox(width: AppConstants.p8),
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
