import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
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
                  labelBuilder: (m) => m,
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
