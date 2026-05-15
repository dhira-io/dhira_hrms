import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

import '../../../../l10n/app_localizations.dart';

class DashboardSearchBar extends StatelessWidget {
  const DashboardSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: AppConstants.opacityVeryLow),
            blurRadius: AppConstants.p10,
            offset: const Offset(0, AppConstants.p4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: l10n.searchServices,
          hintStyle: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.placeholdergrey,
          ),
          prefixIcon: const Icon(Icons.search, color: AppColors.textPrimary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.r16),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: AppConstants.p16),
        ),
      ),
    );
  }
}
