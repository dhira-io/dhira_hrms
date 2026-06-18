import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/widgets/generic_error_widget.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/payslip_entities.dart';
import '../bloc/payslip_bloc.dart';
import '../bloc/payslip_event.dart';
import '../bloc/payslip_state.dart';
import '../widgets/payslip_shimmers.dart';
import '../../data/constants/payslip_constants.dart';

class PayslipDetailBottomSheet extends StatefulWidget {
  final String payslipName;

  const PayslipDetailBottomSheet({super.key, required this.payslipName});

  static Future<void> show(BuildContext context, String payslipName) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.of(context).surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppConstants.r24)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: context.read<PayslipBloc>(),
          child: PayslipDetailBottomSheet(payslipName: payslipName),
        );
      },
    );
  }

  @override
  State<PayslipDetailBottomSheet> createState() => _PayslipDetailBottomSheetState();
}

class _PayslipDetailBottomSheetState extends State<PayslipDetailBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<PayslipBloc>().add(
        PayslipEvent.fetchPayslipDetail(name: widget.payslipName),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.payslipDetail,
                    style: AppTextStyle.h3.copyWith(
                      color: AppColors.of(context).textPrimary,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: AppColors.of(context).textPrimary),
                    onPressed: () => context.pop(),
                  )
                ],
              ),
            ),
            Divider(height: 1, color: AppColors.of(context).border),
            
            Expanded(
              child: BlocBuilder<PayslipBloc, PayslipState>(
                builder: (context, state) {
                  if (state.isDetailLoading) {
                    return ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(AppConstants.p16),
                      children: const [PayslipDetailShimmer()],
                    );
                  }
                  if (state.detailError != null) {
                    return GenericErrorWidget(
                      onRetry: () {
                        context.read<PayslipBloc>().add(
                          PayslipEvent.fetchPayslipDetail(name: widget.payslipName),
                        );
                      },
                      message: state.detailError,
                    );
                  }
                  final detail = state.detail;
                  if (detail == null) return const SizedBox.shrink();
                  
                  return _DetailContent(detail: detail, l10n: l10n, scrollController: scrollController);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DetailContent extends StatelessWidget {
  final PayslipDetailEntity detail;
  final AppLocalizations l10n;
  final ScrollController scrollController;

  const _DetailContent({required this.detail, required this.l10n, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final formatter = NumberFormat.currency(
      symbol: '₹',
      decimalDigits: 0,
      locale: 'en_IN',
    );
    
    final endDate = DateTime.tryParse(detail.endDate);
    final paidOnDate = endDate != null 
        ? '${l10n.paidOn} ${DateTimeUtils.formatDate(endDate, pattern: DateTimeUtils.patternDayMonthYear, locale: locale)}'
        : '';

    return Stack(
      children: [
        ListView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(AppConstants.p16, AppConstants.p16, AppConstants.p16, AppConstants.p100),
          children: [
            Row(
              children: [
                _StatusChip(status: detail.status),
                const SizedBox(width: AppConstants.p12),
                Text(
                  paidOnDate,
                  style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).textSecondary),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.p16),
            
            // Employee Card
            Container(
              padding: const EdgeInsets.all(AppConstants.p16),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6), // Blue background
                borderRadius: BorderRadius.circular(AppConstants.r16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.of(context).surfaceContainerLowest.withValues(alpha: 0.2),
                        child: Text(
                          detail.employeeName.isNotEmpty ? detail.employeeName[0].toUpperCase() : '?',
                          style: AppTextStyle.h3.copyWith(color: AppColors.of(context).surfaceContainerLowest),
                        ),
                      ),
                      const SizedBox(width: AppConstants.p12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.employeeName,
                            style: AppTextStyle.h3.copyWith(color: AppColors.of(context).surfaceContainerLowest),
                          ),
                          const SizedBox(height: AppConstants.p4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8D4FF), // Light purple
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.badge_outlined, size: 12, color: Color(0xFF9333EA)),
                                const SizedBox(width: 4),
                                Text(
                                  detail.employee,
                                  style: AppTextStyle.labelSmall.copyWith(color: const Color(0xFF9333EA)),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: AppConstants.p24),
                  _EmployeeRow(label: l10n.employeeName, value: detail.employeeName),
                  const SizedBox(height: AppConstants.p8),
                  _EmployeeRow(label: l10n.employeeId, value: detail.employee),
                  const SizedBox(height: AppConstants.p8),
                  _EmployeeRow(label: l10n.designation, value: detail.designation.isNotEmpty ? detail.designation : '-'),
                  const SizedBox(height: AppConstants.p8),
                  _EmployeeRow(label: l10n.netPay, value: formatter.format(detail.netPay)),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.p16),
            
            // Salary Breakdown
            Container(
              padding: const EdgeInsets.all(AppConstants.p16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.r16),
                border: Border.all(color: AppColors.of(context).border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.salaryBreakdown, style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: AppConstants.p16),
                  ...detail.earnings.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: AppConstants.p8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(e.component, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).textSecondary)),
                            Text(formatter.format(e.amount), style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.p16),
            
            // Deductions
            Container(
              padding: const EdgeInsets.all(AppConstants.p16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.r16),
                border: Border.all(color: AppColors.of(context).error.withValues(alpha: 0.3)),
                color: AppColors.of(context).error.withValues(alpha: 0.05), // Light red tint
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.deductions, style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: AppConstants.p16),
                  ...detail.deductions.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: AppConstants.p8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(e.component, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).textSecondary)),
                            Text(formatter.format(e.amount), style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.p16),
            
            // Totals
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.totalEarnings, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                Text(formatter.format(detail.totalEarnings), style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: AppConstants.p8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.totalDeductions, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                Text(formatter.format(detail.totalDeductions), style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: AppConstants.p24),
            
            // Work Information
            Text(l10n.workInformation, style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: AppConstants.p12),
            Row(
              children: [
                Expanded(child: _WorkInfoCard(title: l10n.workingDays, value: '${detail.workingDays.toStringAsFixed(0)} ${l10n.daysLabel}')),
                const SizedBox(width: AppConstants.p12),
                Expanded(child: _WorkInfoCard(title: l10n.daysPresent, value: '${detail.presentDays.toStringAsFixed(0)} ${l10n.daysLabel}')),
              ],
            ),
            const SizedBox(height: AppConstants.p12),
            Row(
              children: [
                Expanded(child: _WorkInfoCard(title: l10n.paidDays, value: '${(detail.workingDays - detail.absentDays).toStringAsFixed(0)} ${l10n.daysLabel}')), // Approx paid days
                const SizedBox(width: AppConstants.p12),
                Expanded(child: _WorkInfoCard(title: l10n.totalLoggedHours, value: '-')), // If total logged hours isn't available
              ],
            ),
            
            const SizedBox(height: AppConstants.p24),
          ],
        ),
        
        // Bottom Fixed Button
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.of(context).surfaceContainerLowest,
              boxShadow: [
                BoxShadow(
                  color: AppColors.of(context).black.withValues(alpha: 0.05),
                  offset: const Offset(0, -4),
                  blurRadius: 10,
                )
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.p16),
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<PayslipBloc>().add(PayslipEvent.downloadPayslipPdf(name: detail.name, l10n: l10n));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.of(context).primary,
                    foregroundColor: AppColors.of(context).surfaceContainerLowest,
                    padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
                  ),
                  icon: const Icon(Icons.download_outlined, size: 20),
                  label: Text(l10n.downloadPayslip, style: AppTextStyle.labelLarge.copyWith(fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _EmployeeRow extends StatelessWidget {
  final String label;
  final String value;

  const _EmployeeRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).surfaceContainerLowest.withValues(alpha: 0.8))),
        Text(value, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).surfaceContainerLowest, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _WorkInfoCard extends StatelessWidget {
  final String title;
  final String value;

  const _WorkInfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.r8),
        border: Border.all(color: AppColors.of(context).border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyle.labelSmall.copyWith(color: AppColors.of(context).textSecondary)),
          const SizedBox(height: AppConstants.p4),
          Text(value, style: AppTextStyle.labelMedium.copyWith(fontWeight: FontWeight.w700, color: AppColors.of(context).textPrimary)),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Color bg;
    Color text;
    Color border;
    String displayStatus;
    
    switch (status.toLowerCase()) {
      case PayslipStatusConstants.submitted:
      case 'paid':
        bg = AppColors.of(context).approvedBg;
        text = AppColors.of(context).approvedText;
        border = AppColors.of(context).success;
        displayStatus = l10n.paid; // Assuming we have 'paid' or use status directly
        break;
      case PayslipStatusConstants.draft:
        bg = AppColors.of(context).cancelledBg;
        text = AppColors.of(context).cancelledText;
        border = AppColors.of(context).error;
        displayStatus = l10n.draft;
        break;
      default:
        bg = AppColors.of(context).surfaceContainerLow;
        text = AppColors.of(context).textSecondary;
        border = AppColors.of(context).border;
        displayStatus = status;
    }
    
    // Fallback if l10n.paid isn't there, we'll just use the status directly
    if (status.toLowerCase() == 'submitted') {
        displayStatus = l10n.submitted; // Frappe uses Submitted
    } else {
        displayStatus = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: border.withValues(alpha: 0.5)),
      ),
      child: Text(
        displayStatus,
        style: AppTextStyle.labelMedium.copyWith(color: text, fontWeight: FontWeight.w600),
      ),
    );
  }
}
