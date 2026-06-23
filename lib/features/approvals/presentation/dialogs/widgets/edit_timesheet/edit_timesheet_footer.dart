import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class EditTimesheetFooter extends StatelessWidget {
  final int selectedCount;
  final int totalCount;
  final VoidCallback onUpdate;
  final VoidCallback onCancel;

  const EditTimesheetFooter({
    super.key,
    required this.selectedCount,
    required this.totalCount,
    required this.onUpdate,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final btnShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.r),
    );
    const btnSize = Size(100, 44);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        border: Border(top: BorderSide(color: AppColors.of(context).border)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                l10n.rowsSelected(selectedCount, totalCount),
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.of(context).textSecondary,
                ),
              ),
              const Spacer(),
            ],
          ),
                SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onUpdate,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.of(context).primary,
                minimumSize: btnSize,
                shape: btnShape,
                padding:       EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 12.h,
                ),
                elevation: 0,
              ),
              child: Text(
                l10n.update,
                style: AppTextStyle.bodyMedium.copyWith(
                  color: AppColors.of(context).white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
                SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                minimumSize: btnSize,
                shape: btnShape,
                side: BorderSide(color: AppColors.of(context).primary),
                padding:       EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 12.h,
                ),
              ),
              child: Text(
                l10n.cancel,
                style: AppTextStyle.bodyMedium.copyWith(
                  color: AppColors.of(context).primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
