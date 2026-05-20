import 'package:dhira_hrms/features/payslip/presentation/widgets/filter_row.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/payslip_card.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/ytd_banner.dart';
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
        .where((p) => _selectedYear == null || p.startDate.startsWith(_selectedYear!))
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
      final yearMatch = _selectedYear == null || p.startDate.startsWith(_selectedYear!);
      final monthMatch = _selectedMonth == null || DateFormat('MMM').format(date) == _selectedMonth;
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
                  Icon(Icons.error_outline_rounded, color: colors.error, size: 48),
                  const SizedBox(height: AppConstants.p12),
                  Text(
                    state.listError!,
                    style: AppTextStyle.bodyMedium.copyWith(color: colors.textSecondary),
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
          final formatter = NumberFormat.currency(symbol: '₹', decimalDigits: 0, locale: 'en_IN');

          return CustomScrollView(
            slivers: [
              // YTD Stats Banner
              SliverToBoxAdapter(
                child: YtdBanner(ytd: ytd, formatter: formatter, l10n: l10n),
              ),

              // Filters
              SliverToBoxAdapter(
                child: FilterRow(
                  years: years,
                  months: months,
                  selectedYear: _selectedYear,
                  selectedMonth: _selectedMonth,
                  onYearChanged: (v) => setState(() => _selectedYear = v),
                  onMonthChanged: (v) => setState(() => _selectedMonth = v),
                  l10n: l10n,
                ),
              ),

              if (filtered.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      l10n.noPayslipsFound,
                      style: AppTextStyle.bodyMedium.copyWith(color: colors.textSecondary),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppConstants.p16,
                    AppConstants.p8,
                    AppConstants.p16,
                    AppConstants.p24,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final payslip = filtered[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppConstants.p12),
                          child: PayslipCard(payslip: payslip, formatter: formatter),
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
