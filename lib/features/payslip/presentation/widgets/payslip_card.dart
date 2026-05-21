import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/constants/payslip_constants.dart';
import '../../domain/entities/payslip_entities.dart';

class PayslipCard extends StatelessWidget {
  final PayslipEntity payslip;
  final NumberFormat formatter;

  const PayslipCard({
    super.key,
    required this.payslip,
    required this.formatter,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final start = DateTime.tryParse(payslip.startDate);
    final end = DateTime.tryParse(payslip.endDate);
    final monthYear = start != null
        ? DateTimeUtils.formatDate(start, pattern: DateTimeUtils.patternMonthYear, locale: locale)
        : payslip.startDate;
    final dateRange = start != null && end != null
        ? '${DateTimeUtils.formatDate(start, pattern: DateTimeUtils.patternDayMonth, locale: locale)} – ${DateTimeUtils.formatDate(end, pattern: DateTimeUtils.patternDayMonthYear, locale: locale)}'
        : '';

    return Material(
      color: AppColors.of(context).transparent,
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
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.p16),
            child: Row(
              children: [
                // Salary Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.of(context).primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.payments_outlined,
                      color: AppColors.of(context).primary,
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
                          color: AppColors.of(context).textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppConstants.p4),
                      Text(
                        dateRange,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.of(context).textSecondary,
                        ),
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
                        color: AppColors.of(context).primary,
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
                    color: AppColors.of(context).textSecondary, size: 20),
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
    final l10n = AppLocalizations.of(context)!;
    Color bg;
    Color text;
    String displayStatus;
    switch (status.toLowerCase()) {
      case PayslipStatusConstants.submitted:
        bg = AppColors.of(context).approvedBg;
        text = AppColors.of(context).approvedText;
        displayStatus = l10n.submitted;
        break;
      case PayslipStatusConstants.draft:
        bg = AppColors.of(context).cancelledBg;
        text = AppColors.of(context).cancelledText;
        displayStatus = l10n.draft;
        break;
      default:
        bg = AppColors.of(context).surfaceContainerLow;
        text = AppColors.of(context).textSecondary;
        displayStatus = status;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppConstants.p6),
      ),
      child: Text(
        displayStatus,
        style: AppTextStyle.labelSmall.copyWith(color: text, fontSize: 10),
      ),
    );
  }
}
