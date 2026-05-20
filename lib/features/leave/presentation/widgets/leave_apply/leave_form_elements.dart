import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';

class LeaveFormSectionTitle extends StatelessWidget {
  final String title;

  const LeaveFormSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.h3.copyWith(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.bold,
        color: AppColors.of(context).onSurface,
      ),
    );
  }
}

class LeaveFormLabel extends StatelessWidget {
  final String label;

  const LeaveFormLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
      child: Text(
        label,
        style: AppTextStyle.bodySmall.copyWith(
          color: AppColors.of(context).onSurfaceVariant,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
