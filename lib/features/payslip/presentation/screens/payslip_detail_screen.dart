import 'package:dhira_hrms/features/payslip/presentation/widgets/badge_chip.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/payslip_shimmers.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/bank_identifiers_grid.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/divider.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/info_card.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/row_item.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/net_pay_banner.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/section_label.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/attendance_stat.dart';
import 'package:dhira_hrms/features/payslip/presentation/widgets/components_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/common_app_bar.dart';
import '../../../../core/widgets/generic_error_widget.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/payslip_entities.dart';
import '../bloc/payslip_bloc.dart';
import '../bloc/payslip_event.dart';
import '../bloc/payslip_state.dart';
import '../../../../core/utils/number_to_words_utils.dart';
import '../../../../core/utils/date_time_utils.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context
          .read<PayslipBloc>()
          .add(PayslipEvent.fetchPayslipDetail(name: widget.name));
    });
  }

  void _onDownload(BuildContext context, PayslipDetailEntity detail) {
    final l10n = AppLocalizations.of(context)!;
    context.read<PayslipBloc>().add(
          PayslipEvent.downloadPayslipPdf(name: detail.name, l10n: l10n),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.of(context).background,
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
                icon: Icon(Icons.download_outlined, color: AppColors.of(context).primary),
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
            return const PayslipDetailShimmer();
          }
          if (state.detailError != null) {
            return GenericErrorWidget(
              onRetry: () {
                context
                    .read<PayslipBloc>()
                    .add(PayslipEvent.fetchPayslipDetail(name: widget.name));
              },
              message: state.detailError,
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
    final locale = Localizations.localeOf(context).languageCode;
    final formatter =
        NumberFormat.currency(symbol: '₹', decimalDigits: 2, locale: 'en_IN');
    final startLabel = DateTimeUtils.formatDateString(detail.startDate, pattern: AppConstants.dateFormatDayMonthYear, locale: locale);
    final endLabel = DateTimeUtils.formatDateString(detail.endDate, pattern: AppConstants.dateFormatDayMonthYear, locale: locale);
    final periodLabel = '$startLabel – $endLabel';

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
                    color: AppColors.of(context).primary, size: 20),
                const SizedBox(width: AppConstants.p10),
                Expanded(
                  child: Text(
                    periodLabel,
                    style: AppTextStyle.bodyMedium.copyWith(
                        color: AppColors.of(context).textPrimary, fontWeight: FontWeight.w600),
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
                      AppColors.of(context).primary.withValues(alpha: 0.12),
                      child: Text(
                        detail.employeeName.isNotEmpty
                            ? detail.employeeName[0].toUpperCase()
                            : '?',
                        style:
                            AppTextStyle.h3.copyWith(color: AppColors.of(context).primary),
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
                                color: AppColors.of(context).textPrimary,
                                fontWeight: FontWeight.w700),
                          ),
                          if (detail.designation.isNotEmpty) ...[
                            const SizedBox(height: AppConstants.p4),
                            Text(
                              detail.designation,
                              style: AppTextStyle.bodySmall
                                  .copyWith(color: AppColors.of(context).textSecondary),
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
                child: AttendanceStat(
                  icon: Icons.work_outline_rounded,
                  value: detail.workingDays.toStringAsFixed(1),
                  label: l10n.workingDays,
                  color: AppColors.of(context).primary,
                ),
              ),
              const SizedBox(width: AppConstants.p8),
              Expanded(
                child: AttendanceStat(
                  icon: Icons.check_circle_outline_rounded,
                  value: detail.presentDays.toStringAsFixed(1),
                  label: l10n.daysPresent,
                  color: AppColors.of(context).success,
                ),
              ),
              const SizedBox(width: AppConstants.p8),
              Expanded(
                child: AttendanceStat(
                  icon: Icons.cancel_outlined,
                  value: detail.absentDays.toStringAsFixed(1),
                  label: l10n.absentDays,
                  color: AppColors.of(context).error,
                ),
              ),
              const SizedBox(width: AppConstants.p8),
              Expanded(
                child: AttendanceStat(
                  icon: Icons.event_busy_outlined,
                  value: detail.leaves.toStringAsFixed(1),
                  label: l10n.leaves,
                  color: AppColors.of(context).warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p16),

          // ── Earnings ────────────────────────────────────────────────
          ComponentsBlock(
            title: l10n.earnings,
            components: detail.earnings,
            total: detail.totalEarnings,
            formatter: formatter,
            accentColor: AppColors.of(context).primary,
            isEarnings: true,
            totalLabel: l10n.totalEarnings,
          ),
          const SizedBox(height: AppConstants.p16),

          // ── Deductions ──────────────────────────────────────────────
          ComponentsBlock(
            title: l10n.deductions,
            components: detail.deductions,
            total: detail.totalDeductions,
            formatter: formatter,
            accentColor: AppColors.of(context).error,
            isEarnings: false,
            totalLabel: l10n.totalDeductions,
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
                      color: AppColors.of(context).primary,
                      size: 20,
                    ),
                    const SizedBox(width: AppConstants.p8),
                    Text(
                      l10n.taxSummary,
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: AppColors.of(context).textPrimary,
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
                  valueColor: AppColors.of(context).error,
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

