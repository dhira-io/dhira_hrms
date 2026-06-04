import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class YtdBanner extends StatelessWidget {
  final double ytd;
  final NumberFormat formatter;
  final AppLocalizations l10n;

  const YtdBanner({
    super.key,
    required this.ytd,
    required this.formatter,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.p16),
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.of(context).primary,
            AppColors.of(context).primaryContainer,
          ],
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.p8),
                decoration: BoxDecoration(
                  color: AppColors.of(context).white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppConstants.r10),
                ),
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  color: AppColors.of(context).white,
                  size: 20.sp,
                ),
              ),
              const SizedBox(width: AppConstants.p12),
              Text(
                l10n.totalNetPayYtd,
                style: AppTextStyle.labelMedium.copyWith(
                  color: AppColors.of(context).white.withValues(alpha: 0.8),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p16),
          Text(
            formatter.format(ytd),
            style: AppTextStyle.h1.copyWith(
              color: AppColors.of(context).white,
              fontSize: 32.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
