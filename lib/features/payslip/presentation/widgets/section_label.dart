import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class SectionLabel extends StatelessWidget {
  final String label;
  const SectionLabel({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Text(
      label.toUpperCase(),
      style: AppTextStyle.labelSmall.copyWith(
        color: colors.textSecondary,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
