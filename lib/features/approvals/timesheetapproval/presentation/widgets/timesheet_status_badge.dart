import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimesheetStatusBadge extends StatelessWidget {
  final String status;

  const TimesheetStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isPending =
        status.toLowerCase() == TimesheetStatus.pending.toLowerCase();
    final isRejected =
        status.toLowerCase() == TimesheetStatus.rejected.toLowerCase();

    // Map raw status to localized string
    String displayStatus = status;
    final lowerStatus = status.toLowerCase();
    if (lowerStatus == TimesheetStatus.pending.toLowerCase()) {
      displayStatus = l10n.pending;
    } else if (lowerStatus == TimesheetStatus.approved.toLowerCase()) {
      displayStatus = l10n.approved;
    } else if (lowerStatus == TimesheetStatus.rejected.toLowerCase()) {
      displayStatus = l10n.rejected;
    } else if (lowerStatus == TimesheetStatus.draft.toLowerCase()) {
      displayStatus = l10n.draft;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isPending
              ? colors.orange300
              : isRejected
                  ? colors.error
                  : colors.green300,
          width: 1,
        ),
      ),
      child: Text(
        displayStatus,
        style: AppTextStyle.bodySmall.copyWith(
          fontWeight: FontWeight.bold,
          color: isPending
              ? colors.orange500
              : isRejected
                  ? colors.error
                  : colors.green600,
        ),
      ),
    );
  }
}
