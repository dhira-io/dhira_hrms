import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MandatoryLabel extends StatelessWidget {
  final String labelText;
  final Color? textColor;

  const MandatoryLabel({
    super.key,
    required this.labelText,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            labelText,
            style: TextStyle(
              color: textColor ?? AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const Text(
            " *", // Added a space for better spacing
            style: TextStyle(
              color: AppColors.error,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
