import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class NetPayBanner extends StatelessWidget {
  final String amount;
  final String label;
  final String totalInWords;

  const NetPayBanner({
    super.key,
    required this.amount,
    required this.label,
    required this.totalInWords,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final parts = l10n.finalPayout.split(' ');
    final firstPart = parts.isNotEmpty ? parts[0] : '';
    final secondPart = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          vertical: AppConstants.p20, horizontal: AppConstants.p24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.of(context).primary, AppColors.of(context).primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.r20),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).primary.withValues(alpha: 0.28),
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
              color: AppColors.of(context).white.withValues(alpha: 0.85),
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppConstants.p8),
          Text(
            amount,
            style: AppTextStyle.h1.copyWith(
              color: AppColors.of(context).white,
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
                    color: AppColors.of(context).white.withValues(alpha: 0.8),
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
                  color: AppColors.of(context).white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(AppConstants.r16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (firstPart.isNotEmpty)
                      Text(
                        firstPart.toUpperCase(),
                        style: AppTextStyle.labelSmall.copyWith(
                          color: AppColors.of(context).white,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          letterSpacing: 0.5,
                        ),
                      ),
                    if (secondPart.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        secondPart.toUpperCase(),
                        style: AppTextStyle.labelSmall.copyWith(
                          color: AppColors.of(context).white,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
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
