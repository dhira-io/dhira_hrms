import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimesheetEditHeader extends StatelessWidget {
  final VoidCallback onClose;

  const TimesheetEditHeader({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.p20,
        AppConstants.p24,
        AppConstants.p20,
        AppConstants.p16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.requestDetails,
                  style: AppTextStyle.h2Bold.copyWith(
                    color: colors.onSurface,
                  ),
                ),
                Text(
                  l10n.timesheetRequestDetails,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: colors.onSurface),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}
