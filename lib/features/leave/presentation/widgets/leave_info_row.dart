import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class LeaveInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;
  final FontWeight? valueFontWeight;
  final double? valueFontSize;

  const LeaveInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
    this.valueFontWeight,
    this.valueFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.onSurfaceVariant.withOpacity(0.7),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.bodyMedium.copyWith(
            fontWeight: valueFontWeight ?? (isBold ? FontWeight.bold : FontWeight.w500),
            color: valueColor ?? AppColors.onSurface,
            fontSize: valueFontSize ?? 12,
          ),
        ),
      ],
    );
  }
}
