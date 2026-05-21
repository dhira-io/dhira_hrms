import 'package:flutter/material.dart';
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
    final colors = AppColors.of(context);
    return Container(
      margin: const EdgeInsets.all(AppConstants.p16),
      padding: const EdgeInsets.all(AppConstants.p20),
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.p8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppConstants.r10),
                ),
                child: const Icon(Icons.account_balance_wallet_outlined,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: AppConstants.p12),
              Text(
                l10n.totalNetPayYtd,
                style: AppTextStyle.labelMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p16),
          Text(
            formatter.format(ytd),
            style: AppTextStyle.h1.copyWith(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
