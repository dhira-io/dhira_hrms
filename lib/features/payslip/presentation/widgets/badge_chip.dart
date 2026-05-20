import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';

class BadgeChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const BadgeChip({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p8,
        vertical: AppConstants.p4,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppConstants.r8),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colors.textSecondary),
          const SizedBox(width: AppConstants.p4),
          Text(
            label,
            style: AppTextStyle.labelSmall.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}
