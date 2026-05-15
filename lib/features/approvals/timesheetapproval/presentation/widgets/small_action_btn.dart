import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class SmallActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const SmallActionBtn({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: AppColors.textSecondary),
            SizedBox(width: 4),
            Text(label, style: AppTextStyle.labelSmall.copyWith(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
