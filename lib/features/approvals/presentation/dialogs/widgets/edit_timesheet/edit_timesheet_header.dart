import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class EditTimesheetHeader extends StatelessWidget {
  final VoidCallback onClose;

  const EditTimesheetHeader({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.requestDetails,
                  style: AppTextStyle.h3.copyWith(fontSize: 18.sp),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  l10n.timesheetRequestDetails,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.of(context).textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.close), onPressed: onClose),
        ],
      ),
    );
  }
}
