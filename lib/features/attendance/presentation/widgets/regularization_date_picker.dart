import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../l10n/app_localizations.dart';

class RegularizationDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const RegularizationDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: l10n.selectDate,
            style: AppTextStyle.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: AppColors.absentText),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    inputDecorationTheme: const InputDecorationTheme(),
                  ),
                  child: child!,
                );
              },
            );
            if (date != null) onDateSelected(date);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppConstants.r8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate != null
                      ? DateTimeUtils.formatDate(
                          selectedDate!,
                          pattern: AppConstants.dateFormatDefault,
                        )
                      : AppConstants.datePlaceholder,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: selectedDate != null
                        ? AppColors.textPrimary
                        : AppColors.onSurfaceVariant.withOpacity(0.5),
                  ),
                ),
                const Icon(
                  Icons.calendar_today,
                  color: AppColors.onSurfaceVariant,
                  size: AppConstants.iconXSmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
