import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/routing/app_router.dart';
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
    final colors = AppColors.of(context);
    final start = DateTime.tryParse(payslip.startDate);
    final end = DateTime.tryParse(payslip.endDate);
    final monthYear = start != null
        ? DateTimeUtils.formatDate(start, pattern: 'MMMM yyyy')
        : payslip.startDate;
    final dateRange = start != null && end != null
        ? '${DateTimeUtils.formatDate(start, pattern: 'dd MMM')} – ${DateTimeUtils.formatDate(end, pattern: 'dd MMM yyyy')}'
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
                      const SizedBox(height: AppConstants.p4),
                      Text(
                        dateRange,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: colors.textSecondary,
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
