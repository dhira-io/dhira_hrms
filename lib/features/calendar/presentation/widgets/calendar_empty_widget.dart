import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

class CalendarEmptyWidget extends StatelessWidget {
  const CalendarEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 64,
            color: AppColors.of(context).onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noDataFound,
            style: AppTextStyle.bodyLarge.copyWith(
              color: AppColors.of(context).onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
