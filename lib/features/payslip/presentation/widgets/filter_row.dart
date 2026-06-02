import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../bloc/payslip_bloc.dart';
import '../bloc/payslip_event.dart';
import '../bloc/payslip_state.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<PayslipBloc, PayslipState>(
      buildWhen: (previous, current) =>
          previous.selectedYear != current.selectedYear ||
          previous.selectedMonth != current.selectedMonth ||
          previous.payslips != current.payslips,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
          child: Row(
            children: [
              Expanded(
                child: DropdownFilter<String>(
                  value: state.selectedYear,
                  hint: l10n.allYears,
                  items: state.years,
                  labelBuilder: (y) => y,
                  onChanged: (v) {
                    context.read<PayslipBloc>().add(
                      PayslipEvent.updateFilter(
                        selectedYear: v,
                        selectedMonth: null,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: AppConstants.p12),
              Expanded(
                child: DropdownFilter<String>(
                  value: state.selectedMonth,
                  hint: l10n.allMonths,
                  items: state.months,
                  labelBuilder: (m) {
                    final locale = Localizations.localeOf(context).languageCode;
                    final date = DateTime(2026, _monthNumber(m), 1);
                    return DateTimeUtils.formatToMonthAbbr(date, locale);
                  },
                  onChanged: (v) {
                    context.read<PayslipBloc>().add(
                      PayslipEvent.updateFilter(
                        selectedYear: state.selectedYear,
                        selectedMonth: v,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
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
    super.key,
    required this.value,
    required this.hint,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p12,
        vertical: AppConstants.p4,
      ),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r10),
        border: Border.all(color: AppColors.of(context).border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          hint: Text(
            hint,
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.of(context).textSecondary,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.of(context).textSecondary,
          ),
          dropdownColor: AppColors.of(context).surface,
          items: [
            DropdownMenuItem<T>(
              value: null,
              child: Text(
                hint,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.of(context).textSecondary,
                ),
              ),
            ),
            ...items.map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  labelBuilder(item),
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.of(context).textPrimary,
                  ),
                ),
              ),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}

int _monthNumber(String abbr) {
  switch (abbr.toLowerCase()) {
    case 'jan':
      return 1;
    case 'feb':
      return 2;
    case 'mar':
      return 3;
    case 'apr':
      return 4;
    case 'may':
      return 5;
    case 'jun':
      return 6;
    case 'jul':
      return 7;
    case 'aug':
      return 8;
    case 'sep':
      return 9;
    case 'oct':
      return 10;
    case 'nov':
      return 11;
    case 'dec':
      return 12;
    default:
      return 1;
  }
}
