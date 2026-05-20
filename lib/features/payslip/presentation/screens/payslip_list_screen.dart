import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/common_app_bar.dart';
import '../../domain/entities/payslip_entities.dart';
import '../bloc/payslip_bloc.dart';
import '../bloc/payslip_event.dart';
import '../bloc/payslip_state.dart';

class PayslipListScreen extends StatefulWidget {
  const PayslipListScreen({super.key});

  @override
  State<PayslipListScreen> createState() => _PayslipListScreenState();
}

class _PayslipListScreenState extends State<PayslipListScreen> {
  String? _selectedYear;
  String? _selectedMonth;

  @override
  void initState() {
    super.initState();
    final empId = Get.find<LocalStorageService>().getEmpId() ?? '';
    context.read<PayslipBloc>().add(
          PayslipEvent.fetchPayslips(employeeId: empId),
        );
  }

  List<String> _getYears(List<PayslipEntity> payslips) {
    final years = payslips
        .map((p) => p.startDate.substring(0, 4))
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));
    return years;
  }

  List<String> _getMonths(List<PayslipEntity> payslips) {
    return payslips
        .where((p) =>
            _selectedYear == null ||
            p.startDate.startsWith(_selectedYear!))
        .map((p) {
          final date = DateTime.tryParse(p.startDate);
          return date != null ? DateFormat('MMM').format(date) : '';
        })
        .where((m) => m.isNotEmpty)
        .toSet()
        .toList();
  }

  List<PayslipEntity> _filtered(List<PayslipEntity> all) {
    return all.where((p) {
      final date = DateTime.tryParse(p.startDate);
      if (date == null) return false;
      final yearMatch = _selectedYear == null ||
          p.startDate.startsWith(_selectedYear!);
      final monthMatch = _selectedMonth == null ||
          DateFormat('MMM').format(date) == _selectedMonth;
      return yearMatch && monthMatch;
    }).toList();
  }

  double _ytdTotal(List<PayslipEntity> all) {
    final now = DateTime.now();
    return all
        .where((p) {
          final d = DateTime.tryParse(p.startDate);
          return d != null && d.year == now.year;
        })
        .fold(0.0, (sum, p) => sum + p.netPay);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: CommonAppBar(
        title: l10n.payslips,
        onBack: () => context.pop(),
      ),
      body: BlocBuilder<PayslipBloc, PayslipState>(
        builder: (context, state) {
          if (state.isListLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.listError != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline_rounded,
                      color: colors.error, size: 48),
                  const SizedBox(height: AppConstants.p12),
                  Text(
                    state.listError!,
                    style: AppTextStyle.bodyMedium
                        .copyWith(color: colors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          final all = state.payslips;
          final years = _getYears(all);
          final months = _getMonths(all);
          final filtered = _filtered(all);
          final ytd = _ytdTotal(all);
          final formatter = NumberFormat.currency(
              symbol: '₹', decimalDigits: 0, locale: 'en_IN');

          return CustomScrollView(
            slivers: [
              // YTD Stats Banner
              SliverToBoxAdapter(
                child: _YtdBanner(ytd: ytd, formatter: formatter, l10n: l10n),
              ),

              // Filters
              SliverToBoxAdapter(
                child: _FilterRow(
                  years: years,
                  months: months,
                  selectedYear: _selectedYear,
                  selectedMonth: _selectedMonth,
                  onYearChanged: (v) =>
                      setState(() => _selectedYear = v),
                  onMonthChanged: (v) =>
                      setState(() => _selectedMonth = v),
                  l10n: l10n,
                ),
              ),

              if (filtered.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      l10n.noPayslipsFound,
                      style: AppTextStyle.bodyMedium
                          .copyWith(color: colors.textSecondary),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                      AppConstants.p16,
                      AppConstants.p8,
                      AppConstants.p16,
                      AppConstants.p24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final payslip = filtered[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: AppConstants.p12),
                          child: _PayslipCard(
                            payslip: payslip,
                            formatter: formatter,
                          ),
                        );
                      },
                      childCount: filtered.length,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _YtdBanner extends StatelessWidget {
  final double ytd;
  final NumberFormat formatter;
  final AppLocalizations l10n;

  const _YtdBanner({
    required this.ytd,
    required this.formatter,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      margin: const EdgeInsets.all(AppConstants.p16),
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary, colors.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.r20),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.28),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.p8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppConstants.r10),
                ),
                child: const Icon(Icons.account_balance_wallet_outlined,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: AppConstants.p12),
              Text(
                l10n.totalNetPayYtd,
                style: AppTextStyle.labelMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p16),
          Text(
            formatter.format(ytd),
            style: AppTextStyle.h1.copyWith(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  final List<String> years;
  final List<String> months;
  final String? selectedYear;
  final String? selectedMonth;
  final ValueChanged<String?> onYearChanged;
  final ValueChanged<String?> onMonthChanged;
  final AppLocalizations l10n;

  const _FilterRow({
    required this.years,
    required this.months,
    required this.selectedYear,
    required this.selectedMonth,
    required this.onYearChanged,
    required this.onMonthChanged,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
      child: Row(
        children: [
          Expanded(
            child: _DropdownFilter<String>(
              value: selectedYear,
              hint: l10n.allYears,
              items: years,
              labelBuilder: (y) => y,
              onChanged: onYearChanged,
            ),
          ),
          const SizedBox(width: AppConstants.p12),
          Expanded(
            child: _DropdownFilter<String>(
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

class _DropdownFilter<T> extends StatelessWidget {
  final T? value;
  final String hint;
  final List<T> items;
  final String Function(T) labelBuilder;
  final ValueChanged<T?> onChanged;

  const _DropdownFilter({
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
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.p12, vertical: AppConstants.p4),
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
            style: AppTextStyle.bodySmall
                .copyWith(color: colors.textSecondary),
          ),
          icon:
              Icon(Icons.keyboard_arrow_down_rounded, color: colors.textSecondary),
          dropdownColor: colors.surface,
          items: [
            DropdownMenuItem<T>(
              value: null,
              child: Text(hint,
                  style: AppTextStyle.bodySmall
                      .copyWith(color: colors.textSecondary)),
            ),
            ...items.map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(labelBuilder(item),
                    style: AppTextStyle.bodySmall
                        .copyWith(color: colors.textPrimary)),
              ),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _PayslipCard extends StatelessWidget {
  final PayslipEntity payslip;
  final NumberFormat formatter;

  const _PayslipCard({required this.payslip, required this.formatter});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final start = DateTime.tryParse(payslip.startDate);
    final end = DateTime.tryParse(payslip.endDate);
    final monthYear = start != null ? DateFormat('MMMM yyyy').format(start) : payslip.startDate;
    final dateRange = start != null && end != null
        ? '${DateFormat('dd MMM').format(start)} – ${DateFormat('dd MMM yyyy').format(end)}'
        : '';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConstants.r16),
        onTap: () {
          context.push(
            AppRouter.payslipDetailPath,
            extra: {AppRouter.argDocName: payslip.name},
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppConstants.r16),
            border: Border.all(color: colors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.p16),
            child: Row(
              children: [
                // Salary/Money Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.payments_outlined,
                      color: colors.primary,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: AppConstants.p12),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        monthYear,
                        style: AppTextStyle.bodyMedium.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: AppConstants.p4),
                      Text(
                        dateRange,
                        style: AppTextStyle.bodySmall.copyWith(
                            color: colors.textSecondary),
                      ),
                    ],
                  ),
                ),
                // Net Pay + Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatter.format(payslip.netPay),
                      style: AppTextStyle.labelLarge.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: AppConstants.p4),
                    _StatusChip(status: payslip.status),
                  ],
                ),
                const SizedBox(width: AppConstants.p4),
                Icon(Icons.chevron_right_rounded,
                    color: colors.textSecondary, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    Color bg;
    Color text;
    switch (status.toLowerCase()) {
      case 'submitted':
        bg = colors.approvedBg;
        text = colors.approvedText;
        break;
      case 'draft':
        bg = colors.cancelledBg;
        text = colors.cancelledText;
        break;
      default:
        bg = colors.surfaceContainerLow;
        text = colors.textSecondary;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppConstants.p6),
      ),
      child: Text(
        status,
        style: AppTextStyle.labelSmall.copyWith(color: text, fontSize: 10),
      ),
    );
  }
}
