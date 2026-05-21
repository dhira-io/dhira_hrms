import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class AttendanceStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const AttendanceStat({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppConstants.p12, horizontal: AppConstants.p4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: AppConstants.p6),
          Text(
            value,
            style: AppTextStyle.h3.copyWith(
                color: color, fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: AppConstants.p4),
          Text(
            label,
            style: AppTextStyle.labelSmall
                .copyWith(color: colors.textSecondary, fontSize: 9),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
