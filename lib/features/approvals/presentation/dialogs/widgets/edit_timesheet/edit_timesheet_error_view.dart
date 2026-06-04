import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class EditTimesheetErrorView extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onClose;

  const EditTimesheetErrorView({
    super.key,
    this.errorMessage,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding:       EdgeInsets.all(40.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: AppColors.of(context).error,
          ),
                SizedBox(height: 16.h),
          Text(
            errorMessage ?? l10n.failedToLoadTimesheet,
            textAlign: TextAlign.center,
          ),
                SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onClose,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.of(context).primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                l10n.close,
                style: TextStyle(color: AppColors.of(context).white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
