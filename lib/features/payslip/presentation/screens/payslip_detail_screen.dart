import 'dart:convert';
import 'package:dhira_hrms/features/payslip/presentation/widgets/badge_chip.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/bank_identifiers_grid.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/divider.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/info_card.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/row_item.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/net_pay_banner.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/section_label.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/file_operation/file_operation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/common_app_bar.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/payslip_entities.dart';
import '../bloc/payslip_bloc.dart';
import '../bloc/payslip_event.dart';
import '../bloc/payslip_state.dart';
import '../../../../core/utils/number_to_words_utils.dart';

class PayslipDetailScreen extends StatefulWidget {
  final String name;

  const PayslipDetailScreen({super.key, required this.name});

  @override
  State<PayslipDetailScreen> createState() => _PayslipDetailScreenState();
}

class _PayslipDetailScreenState extends State<PayslipDetailScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<PayslipBloc>()
        .add(PayslipEvent.fetchPayslipDetail(name: widget.name));
  }

  void _onDownload(BuildContext context, PayslipDetailEntity detail) {
    final l10n = AppLocalizations.of(context)!;
    final fileOpCubit = Get.find<FileOperationCubit>();
    final baseUrl = fileOpCubit.dioClient.baseUrl;

    // Build URL: salary_slip_names=["<name>"]
    final encoded = Uri.encodeQueryComponent(jsonEncode([detail.name]));
    final url =
        '$baseUrl/api/method/dhira_hrms.api.payroll.download_salary_slips_pdf'
        '?salary_slip_names=$encoded';

    // Derive a clean file name from the slip name, e.g. "Sal_Slip_CNT-EMP-00001_00003.pdf"
    final fileName =
        '${detail.name.replaceAll('/', '_').replaceAll(' ', '_')}.pdf';

    fileOpCubit.downloadFile(url, fileName, l10n);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: CommonAppBar(
        title: l10n.payslipDetail,
        onBack: () => context.pop(),
        actions: [
          BlocBuilder<PayslipBloc, PayslipState>(
            buildWhen: (prev, curr) => prev.detail != curr.detail,
            builder: (context, state) {
              final detail = state.detail;
              if (detail == null) return const SizedBox.shrink();
              return IconButton(
                icon: Icon(Icons.download_outlined, color: colors.primary),
                tooltip: l10n.download,
                onPressed: () => _onDownload(context, detail),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<PayslipBloc, PayslipState>(
        builder: (context, state) {
          if (state.isDetailLoading) {
            return Center(
              child: CircularProgressIndicator(color: colors.primary),
            );
          }
          if (state.detailError != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.p24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline_rounded,
                        color: colors.error, size: 52),
                    const SizedBox(height: AppConstants.p16),
                    Text(
                      state.detailError!,
                      style: AppTextStyle.bodyMedium
                          .copyWith(color: colors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          final detail = state.detail;
          if (detail == null) return const SizedBox.shrink();
          return _DetailBody(detail: detail, l10n: l10n);
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Body
// ─────────────────────────────────────────────────────────────────────────────

class _DetailBody extends StatelessWidget {
  final PayslipDetailEntity detail;
  final AppLocalizations l10n;

  const _DetailBody({required this.detail, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final formatter =
        NumberFormat.currency(symbol: '₹', decimalDigits: 2, locale: 'en_IN');
    final start = DateTime.tryParse(detail.startDate);
    final end = DateTime.tryParse(detail.endDate);
    final periodLabel = (start != null && end != null)
        ? '${DateFormat('dd MMM yyyy').format(start)} – ${DateFormat('dd MMM yyyy').format(end)}'
        : '${detail.startDate} – ${detail.endDate}';

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
          AppConstants.p16, AppConstants.p8, AppConstants.p16, AppConstants.p100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Financial Period ────────────────────────────────────────
          SectionLabel(label: l10n.financialPeriod),
          const SizedBox(height: AppConstants.p8),
          InfoCard(
            child: Row(
              children: [
                Icon(Icons.calendar_month_outlined,
                    color: colors.primary, size: 20),
                const SizedBox(width: AppConstants.p10),
                Expanded(
                  child: Text(
                    periodLabel,
                    style: AppTextStyle.bodyMedium.copyWith(
                        color: colors.textPrimary, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.p16),

          // ── Employee Card ───────────────────────────────────────────
          InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor:
                          colors.primary.withValues(alpha: 0.12),
                      child: Text(
                        detail.employeeName.isNotEmpty
                            ? detail.employeeName[0].toUpperCase()
                            : '?',
                        style:
                            AppTextStyle.h3.copyWith(color: colors.primary),
                      ),
                    ),
                    const SizedBox(width: AppConstants.p12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.employeeName,
                            style: AppTextStyle.bodyLarge.copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.w700),
                          ),
                          if (detail.designation.isNotEmpty) ...[
                            const SizedBox(height: AppConstants.p4),
                            Text(
                              detail.designation,
                              style: AppTextStyle.bodySmall
                                  .copyWith(color: colors.textSecondary),
                            ),
                          ],
                          const SizedBox(height: AppConstants.p8),
                          Wrap(
                            spacing: AppConstants.p8,
                            runSpacing: AppConstants.p6,
                            children: [
                              if (detail.branch.isNotEmpty)
                                BadgeChip(
                                    icon: Icons.location_on_outlined,
                                    label: detail.branch),
                                BadgeChip(
                                  icon: Icons.badge_outlined, label: detail.employee),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.p16),

          // ── Bank & Identifiers (2×2 Grid) ───────────────────────────
          SectionLabel(label: l10n.bankAndIdentifiers),
          const SizedBox(height: AppConstants.p8),
          BankIdentifiersGrid(detail: detail, l10n: l10n),
          const SizedBox(height: AppConstants.p16),

          // ── Attendance Summary (4 cards) ────────────────────────────
          SectionLabel(label: l10n.attendanceSummary),
          const SizedBox(height: AppConstants.p8),
          Row(
            children: [
              Expanded(
                child: _AttendanceStat(
                  icon: Icons.work_outline_rounded,
                  value: detail.workingDays.toStringAsFixed(1),
                  label: l10n.workingDays,
                  color: colors.primary,
                ),
              ),
              const SizedBox(width: AppConstants.p8),
              Expanded(
                child: _AttendanceStat(
                  icon: Icons.check_circle_outline_rounded,
                  value: detail.presentDays.toStringAsFixed(1),
                  label: l10n.daysPresent,
                  color: colors.success,
                ),
              ),
              const SizedBox(width: AppConstants.p8),
              Expanded(
                child: _AttendanceStat(
                  icon: Icons.cancel_outlined,
                  value: detail.absentDays.toStringAsFixed(1),
                  label: l10n.absentDays,
                  color: colors.error,
                ),
              ),
              const SizedBox(width: AppConstants.p8),
              Expanded(
                child: _AttendanceStat(
                  icon: Icons.event_busy_outlined,
                  value: detail.leaves.toStringAsFixed(1),
                  label: l10n.leaves,
                  color: colors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p16),

          // ── Earnings ────────────────────────────────────────────────
          _ComponentsBlock(
            title: l10n.earnings,
            components: detail.earnings,
            total: detail.totalEarnings,
            formatter: formatter,
            accentColor: colors.primary,
            isEarnings: true,
          ),
          const SizedBox(height: AppConstants.p16),

          // ── Deductions ──────────────────────────────────────────────
          _ComponentsBlock(
            title: l10n.deductions,
            components: detail.deductions,
            total: detail.totalDeductions,
            formatter: formatter,
            accentColor: colors.error,
            isEarnings: false,
          ),
          const SizedBox(height: AppConstants.p16),

          // ── Tax Summary ─────────────────────────────────────────────
          InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      color: colors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: AppConstants.p8),
                    Text(
                      l10n.taxSummary,
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.p12),
                Dividerline(),
                RowItem(
                    label: l10n.annualTaxableIncome,
                    value: formatter.format(detail.annualTaxableIncome)),
                Dividerline(),
                RowItem(
                    label: l10n.standardDeduction,
                    value: formatter.format(detail.standardDeduction)),
                Dividerline(),
                RowItem(
                  label: l10n.totalIncomeTax,
                  value: formatter.format(detail.totalIncomeTax),
                  valueColor: colors.error,
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.p16),

          // ── Net Pay Banner ───────────────────────────────────────────
          NetPayBanner(
            amount: formatter.format(detail.netPay),
            label: l10n.netPayableAmount,
            totalInWords: detail.totalInWords.isNotEmpty
                ? detail.totalInWords
                : convertNumberToIndianWords(detail.netPay),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Attendance Stat Card
// ─────────────────────────────────────────────────────────────────────────────

class _AttendanceStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _AttendanceStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppConstants.p12, horizontal: AppConstants.p4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: AppConstants.p6),
          Text(
            value,
            style: AppTextStyle.h3.copyWith(
                color: color, fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: AppConstants.p4),
          Text(
            label,
            style: AppTextStyle.labelSmall
                .copyWith(color: colors.textSecondary, fontSize: 9),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Earnings / Deductions Block
// ─────────────────────────────────────────────────────────────────────────────

class _ComponentsBlock extends StatelessWidget {
  final String title;
  final List<SalaryComponentEntity> components;
  final double total;
  final NumberFormat formatter;
  final Color accentColor;
  final bool isEarnings;

  const _ComponentsBlock({
    required this.title,
    required this.components,
    required this.total,
    required this.formatter,
    required this.accentColor,
    required this.isEarnings,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.p16, vertical: AppConstants.p14),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppConstants.r16)),
            ),
            child: Row(
              children: [
                Icon(
                  isEarnings
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded,
                  color: accentColor,
                  size: 18,
                ),
                const SizedBox(width: AppConstants.p8),
                Text(
                  title,
                  style: AppTextStyle.labelLarge.copyWith(
                      color: accentColor, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Text(
                  formatter.format(total),
                  style: AppTextStyle.labelLarge.copyWith(
                      color: accentColor, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          // Rows
          if (components.isEmpty)
            Padding(
              padding: const EdgeInsets.all(AppConstants.p16),
              child: Text(AppConstants.placeholderText,
                  style: AppTextStyle.bodySmall
                      .copyWith(color: colors.textSecondary)),
            )
          else
            Padding(
              padding: const EdgeInsets.all(AppConstants.p16),
              child: Column(
                children: [
                  for (int i = 0; i < components.length; i++) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            components[i].component,
                            style: AppTextStyle.bodySmall
                                .copyWith(color: colors.textSecondary),
                          ),
                        ),
                        Text(
                          formatter.format(components[i].amount),
                          style: AppTextStyle.bodySmall.copyWith(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    if (i < components.length - 1) ...[
                      const SizedBox(height: AppConstants.p10),
                      Divider(color: colors.border, height: 1),
                      const SizedBox(height: AppConstants.p10),
                    ],
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
