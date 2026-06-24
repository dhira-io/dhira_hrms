import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class YtdBanner extends StatelessWidget {
  final int payslipsCount;
  final double ytdGross;
  final double ytdDeduction;
  final double ytdNet;
  final NumberFormat formatter;
  final AppLocalizations l10n;

  const YtdBanner({
    super.key,
    required this.payslipsCount,
    required this.ytdGross,
    required this.ytdDeduction,
    required this.ytdNet,
    required this.formatter,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p12),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(color: AppColors.of(context).border),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.p16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Text(
                    l10n.ytdSummaryYear(DateTime.now().year.toString()),
                  style: AppTextStyle.labelMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.of(context).textPrimary,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColors.of(context).primary.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    l10n.payslipsCountText(payslipsCount),
                    style: AppTextStyle.labelMedium.copyWith(
                      color: AppColors.of(context).primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.of(context).border),
          Padding(
            padding: const EdgeInsets.all(AppConstants.p16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.totalEarned,
                        style: AppTextStyle.labelSmall.copyWith(color: AppColors.of(context).textSecondary),
                      ),
                      const SizedBox(height: AppConstants.p4),
                      Text(
                        formatter.format(ytdGross),
                        style: AppTextStyle.labelMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.of(context).textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 30.h,
                  color: AppColors.of(context).border,
                ),
                const SizedBox(width: AppConstants.p12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.deductions,
                        style: AppTextStyle.labelSmall.copyWith(color: AppColors.of(context).textSecondary),
                      ),
                      const SizedBox(height: AppConstants.p4),
                      Text(
                        formatter.format(ytdDeduction),
                        style: AppTextStyle.labelMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.of(context).error,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 30.h,
                  color: AppColors.of(context).border,
                ),
                const SizedBox(width: AppConstants.p12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.netPaid,
                        style: AppTextStyle.labelSmall.copyWith(color: AppColors.of(context).textSecondary),
                      ),
                      const SizedBox(height: AppConstants.p4),
                      Text(
                        formatter.format(ytdNet),
                        style: AppTextStyle.labelMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.of(context).success,
                        ),
                      ),
                    ],
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
