import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../l10n/app_localizations.dart';

class RegularizationSystemRecord extends StatelessWidget {
  final DateTime? selectedDate;

  const RegularizationSystemRecord({super.key, this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final displayDate = selectedDate != null
        ? DateTimeUtils.formatDate(
            selectedDate!,
            pattern: AppConstants.dateDisplayFormat,
          )
        : l10n.noRecord;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        boxShadow: [
          BoxShadow(
            color: AppColors.onSurface.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.systemRecord.toUpperCase(),
                    style: AppTextStyle.labelSmall.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    displayDate,
                    style: AppTextStyle.h3.copyWith(color: AppColors.onSurface),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.p20,
                  vertical: AppConstants.p4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.errorContainer,
                  borderRadius: BorderRadius.circular(AppConstants.r20),
                ),
                child: Text(
                  l10n.incomplete.toUpperCase(),
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.onErrorContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: AppConstants.fs10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildTimeBox(
                  l10n.punchIn,
                  AppConstants
                      .timePlaceholder, // Hardcoded as per figma screenshot
                  AppColors.onSurfaceVariant,
                  false,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTimeBox(
                  l10n.punchOut,
                  AppConstants.timePlaceholder,
                  AppColors.onSurfaceVariant,
                  true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(
    String label,
    String value,
    Color valueColor,
    bool isDashed,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppConstants.r8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyle.labelSmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.onSurfaceVariant,
              fontSize: AppConstants.fs10,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyle.h3.copyWith(
              fontWeight: FontWeight.w900,
              color: valueColor,
              fontSize: AppConstants.fs20,
            ),
          ),
        ],
      ),
    );
  }
}
