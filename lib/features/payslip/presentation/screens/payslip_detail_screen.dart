import 'dart:convert';
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
import '../../../performance/presentation/cubit/file_operation/file_operation_cubit.dart';
import '../../domain/entities/payslip_entities.dart';
import '../bloc/payslip_bloc.dart';
import '../bloc/payslip_event.dart';
import '../bloc/payslip_state.dart';

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
          _SectionLabel(label: l10n.financialPeriod),
          const SizedBox(height: AppConstants.p8),
          _InfoCard(
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
          _InfoCard(
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
                                _BadgeChip(
                                    icon: Icons.location_on_outlined,
                                    label: detail.branch),
                              _BadgeChip(
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
          _SectionLabel(label: l10n.bankAndIdentifiers),
          const SizedBox(height: AppConstants.p8),
          _BankIdentifiersGrid(detail: detail, l10n: l10n),
          const SizedBox(height: AppConstants.p16),

          // ── Attendance Summary (4 cards) ────────────────────────────
          _SectionLabel(label: l10n.attendanceSummary),
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
          _InfoCard(
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
                _Divider(),
                _RowItem(
                    label: l10n.annualTaxableIncome,
                    value: formatter.format(detail.annualTaxableIncome)),
                _Divider(),
                _RowItem(
                    label: l10n.standardDeduction,
                    value: formatter.format(detail.standardDeduction)),
                _Divider(),
                _RowItem(
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
          _NetPayBanner(
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
// Bank & Identifiers 2×2 Grid
// ─────────────────────────────────────────────────────────────────────────────

class _BankIdentifiersGrid extends StatelessWidget {
  final PayslipDetailEntity detail;
  final AppLocalizations l10n;

  const _BankIdentifiersGrid({required this.detail, required this.l10n});

  String _maskedAccount(String accountNo) {
    if (accountNo.isEmpty) return AppConstants.placeholderText;
    if (accountNo.length <= 4) return accountNo;
    return '••••${accountNo.substring(accountNo.length - 4)}';
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      _BankItem(label: l10n.bankName, value: detail.bankName),
      _BankItem(label: l10n.accountNumber, value: _maskedAccount(detail.bankAccountNo)),
      _BankItem(label: l10n.panNumber, value: detail.panNumber),
      _BankItem(label: l10n.pfNumber, value: detail.pfNumber),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppConstants.p10,
      crossAxisSpacing: AppConstants.p10,
      childAspectRatio: 2.2,
      children: items.map((item) => _BankCell(item: item)).toList(),
    );
  }
}

class _BankItem {
  final String label;
  final String value;
  const _BankItem({required this.label, required this.value});
}

class _BankCell extends StatelessWidget {
  final _BankItem item;
  const _BankCell({required this.item});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.p12, vertical: AppConstants.p10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.label.toUpperCase(),
            style: AppTextStyle.labelSmall.copyWith(
              color: colors.primary,
              fontSize: 9,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppConstants.p4),
          Text(
            item.value.isNotEmpty ? item.value : AppConstants.placeholderText,
            style: AppTextStyle.bodyMedium.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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

// ─────────────────────────────────────────────────────────────────────────────
// Net Pay Banner
// ─────────────────────────────────────────────────────────────────────────────

class _NetPayBanner extends StatelessWidget {
  final String amount;
  final String label;
  final String totalInWords;

  const _NetPayBanner({
    required this.amount,
    required this.label,
    required this.totalInWords,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          vertical: AppConstants.p20, horizontal: AppConstants.p24),
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
          Text(
            label.toUpperCase(),
            style: AppTextStyle.labelMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppConstants.p8),
          Text(
            amount,
            style: AppTextStyle.h1.copyWith(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppConstants.p16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  totalInWords,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.p16),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.p16, vertical: AppConstants.p10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(AppConstants.r16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'FINAL',
                      style: AppTextStyle.labelSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'PAYOUT',
                      style: AppTextStyle.labelSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared helpers
// ─────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Text(
      label.toUpperCase(),
      style: AppTextStyle.labelSmall.copyWith(
        color: colors.textSecondary,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Widget child;
  const _InfoCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.p16),
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
      child: child,
    );
  }
}

class _BadgeChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _BadgeChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.p8, vertical: AppConstants.p4),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppConstants.r8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: colors.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyle.labelSmall
                .copyWith(color: colors.primary, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isLast;

  const _RowItem({
    required this.label,
    required this.value,
    this.valueColor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : AppConstants.p10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: AppTextStyle.bodySmall
                  .copyWith(color: colors.textSecondary)),
          Flexible(
            child: Text(
              value,
              style: AppTextStyle.bodySmall.copyWith(
                  color: valueColor ?? colors.textPrimary,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      children: [
        Divider(color: colors.border, height: 1),
        const SizedBox(height: AppConstants.p10),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dynamic Number to Words Converter (Indian Numbering System)
// ─────────────────────────────────────────────────────────────────────────────

String convertNumberToIndianWords(double amount) {
  if (amount == 0) return 'Rupees Zero Only';
  
  final int absoluteAmount = amount.truncate();
  final int paisa = ((amount - absoluteAmount) * 100).round();
  
  String rupeePart = _convertToIndianWords(absoluteAmount);
  String paisaPart = '';
  
  if (paisa > 0) {
    paisaPart = ' and ${_convertToIndianWords(paisa)} Paisa';
  }
  
  String result = 'Rupees $rupeePart$paisaPart Only';
  result = result.replaceAll(RegExp(r'\s+'), ' ');
  return result;
}

String _convertToIndianWords(int number) {
  if (number == 0) return '';
  
  final Map<int, String> unitsMap = {
    0: '', 1: 'One', 2: 'Two', 3: 'Three', 4: 'Four', 5: 'Five', 6: 'Six', 7: 'Seven',
    8: 'Eight', 9: 'Nine', 10: 'Ten', 11: 'Eleven', 12: 'Twelve', 13: 'Thirteen',
    14: 'Fourteen', 15: 'Fifteen', 16: 'Sixteen', 17: 'Seventeen', 18: 'Eighteen', 19: 'Nineteen'
  };
  
  final Map<int, String> tensMap = {
    0: '', 1: 'Ten', 2: 'Twenty', 3: 'Thirty', 4: 'Forty', 5: 'Fifty', 6: 'Sixty',
    7: 'Seventy', 8: 'Eighty', 9: 'Ninety'
  };
  
  if (number < 20) {
    return unitsMap[number]!;
  }
  
  if (number < 100) {
    final int tens = number ~/ 10;
    final int units = number % 10;
    return '${tensMap[tens]}${units > 0 ? '-${unitsMap[units]}' : ''}';
  }
  
  if (number < 1000) {
    final int hundreds = number ~/ 100;
    final int remaining = number % 100;
    final String remString = remaining > 0 ? ' ${_convertToIndianWords(remaining)}' : '';
    return '${unitsMap[hundreds]} Hundred$remString';
  }
  
  if (number < 100000) {
    final int thousands = number ~/ 1000;
    final int remaining = number % 1000;
    final String remString = remaining > 0 ? ' ${_convertToIndianWords(remaining)}' : '';
    return '${_convertToIndianWords(thousands)} Thousand$remString';
  }
  
  if (number < 10000000) {
    final int lakhs = number ~/ 100000;
    final int remaining = number % 100000;
    final String remString = remaining > 0 ? ' ${_convertToIndianWords(remaining)}' : '';
    return '${_convertToIndianWords(lakhs)} Lakh$remString';
  }
  
  final int crores = number ~/ 10000000;
  final int remaining = number % 10000000;
  final String remString = remaining > 0 ? ' ${_convertToIndianWords(remaining)}' : '';
  return '${_convertToIndianWords(crores)} Crore$remString';
}
