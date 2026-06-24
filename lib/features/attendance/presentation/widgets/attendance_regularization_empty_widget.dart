import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceRegularizationEmptyWidget extends StatelessWidget {
  const AttendanceRegularizationEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        AppLocalizations.of(context)!.noRecordFound,
        textAlign: TextAlign.center,
        style: AppTextStyle.bodySmall.copyWith(
          color: AppColors.of(context).textSecondary,
        ),
      ),
    );
  }
}
