import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';

/// A reusable divider component with spacing, used in payslip UI.
class Dividerline extends StatelessWidget {
  const Dividerline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      children: [
        Divider(color: colors.border, height: 1),
        const SizedBox(height: AppConstants.p10),
      ],
    );
  }
}
