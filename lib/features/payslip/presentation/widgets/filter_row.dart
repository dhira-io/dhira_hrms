import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class FilterRow extends StatelessWidget {
  final List<String> years;
  final List<String> months;
  final String? selectedYear;
  final String? selectedMonth;
  final ValueChanged<String?> onYearChanged;
  final ValueChanged<String?> onMonthChanged;
  final AppLocalizations l10n;

  const FilterRow({
    required this.years,
    required this.months,
    required this.selectedYear,
    required this.selectedMonth,
    required this.onYearChanged,
    required this.onMonthChanged,
    required this.l10n,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
      child: Row(
        children: [
          Expanded(
            child: DropdownFilter<String>(
              value: selectedYear,
              hint: l10n.allYears,
              items: years,
              labelBuilder: (y) => y,
              onChanged: onYearChanged,
            ),
          ),
          const SizedBox(width: AppConstants.p12),
          Expanded(
            child: DropdownFilter<String>(
              value: selectedMonth,
              hint: l10n.allMonths,
              items: months,
              labelBuilder: (m) => m,
              onChanged: onMonthChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class DropdownFilter<T> extends StatelessWidget {
  final T? value;
  final String hint;
  final List<T> items;
  final String Function(T) labelBuilder;
  final ValueChanged<T?> onChanged;

  const DropdownFilter({
    required this.value,
    required this.hint,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p12, vertical: AppConstants.p4),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r10),
        border: Border.all(color: colors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          hint: Text(
            hint,
            style: AppTextStyle.bodySmall.copyWith(color: colors.textSecondary),
          ),
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: colors.textSecondary),
          dropdownColor: colors.surface,
          items: [
            DropdownMenuItem<T>(
              value: null,
              child: Text(hint, style: AppTextStyle.bodySmall.copyWith(color: colors.textSecondary)),
            ),
            ...items.map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(labelBuilder(item), style: AppTextStyle.bodySmall.copyWith(color: colors.textPrimary)),
              ),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
