import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceRegularizationErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const AttendanceRegularizationErrorWidget({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return TextButton(
      onPressed: onRetry,
      child: Text(
        l10n.retry,
        style: AppTextStyle.button.copyWith(
          color: AppColors.of(context).primary,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
