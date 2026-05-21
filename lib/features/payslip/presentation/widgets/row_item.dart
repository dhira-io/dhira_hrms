import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';

class RowItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isLast;
  const RowItem({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : AppConstants.p10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).textSecondary)),
          Flexible(
            child: Text(
              value,
              style: AppTextStyle.bodySmall.copyWith(
                  color: valueColor ?? AppColors.of(context).textPrimary,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
