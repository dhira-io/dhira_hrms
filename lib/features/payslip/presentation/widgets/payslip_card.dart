import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/constants/payslip_constants.dart';
import '../../domain/entities/payslip_entities.dart';
import '../bloc/payslip_bloc.dart';
import '../bloc/payslip_event.dart';

class PayslipCard extends StatelessWidget {
  final PayslipEntity payslip;
  final NumberFormat formatter;
  final VoidCallback onViewDetails;

  const PayslipCard({
    super.key,
    required this.payslip,
    required this.formatter,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    
    final start = DateTime.tryParse(payslip.startDate);
    final monthYear = start != null
        ? DateTimeUtils.formatDate(
            start,
            pattern: DateTimeUtils.patternMonthYear,
            locale: locale,
          )
        : payslip.startDate;

    final endDate = DateTime.tryParse(payslip.endDate);
    final paidOnDate = endDate != null 
        ? '${l10n.paidOn} ${DateTimeUtils.formatDate(endDate, pattern: DateTimeUtils.patternDayMonthYear, locale: locale)}'
        : '';
        
    final workingDaysStr = payslip.totalWorkingDays != null 
        ? '${payslip.totalWorkingDays!.toStringAsFixed(0)} ${l10n.daysLabel}'
        : '-';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(color: AppColors.of(context).border),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      monthYear,
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: AppColors.of(context).textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _StatusChip(status: payslip.status),
                  ],
                ),
                const SizedBox(height: AppConstants.p4),
                Text(
                  paidOnDate,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.of(context).textSecondary,
                  ),
                ),
                const SizedBox(height: AppConstants.p20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.netPay,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.of(context).textSecondary,
                            ),
                          ),
                          const SizedBox(height: AppConstants.p4),
                          Text(
                            formatter.format(payslip.netPay),
                            style: AppTextStyle.bodyLarge.copyWith(
                              color: AppColors.of(context).textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40.h,
                      color: AppColors.of(context).border,
                    ),
                    const SizedBox(width: AppConstants.p16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.workingDays,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.of(context).textSecondary,
                            ),
                          ),
                          const SizedBox(height: AppConstants.p4),
                          Text(
                            workingDaysStr,
                            style: AppTextStyle.bodyLarge.copyWith(
                              color: AppColors.of(context).textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: AppColors.of(context).border,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onViewDetails,
                  child: Text(
                    l10n.viewDetails,
                    style: AppTextStyle.labelLarge.copyWith(
                      color: AppColors.of(context).primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<PayslipBloc>().add(
                      PayslipEvent.downloadPayslipPdf(name: payslip.name, l10n: l10n),
                    );
                  },
                  borderRadius: BorderRadius.circular(AppConstants.p8),
                  child: Container(
                    padding: const EdgeInsets.all(AppConstants.p8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.of(context).primary.withValues(alpha: 0.3)),
                      borderRadius: BorderRadius.circular(AppConstants.p8),
                    ),
                    child: Icon(
                      Icons.download_outlined,
                      color: AppColors.of(context).primary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
      case PayslipStatusConstants.paid:
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
