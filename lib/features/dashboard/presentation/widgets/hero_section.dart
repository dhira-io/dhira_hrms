import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_assets.dart';

class HeroSection extends StatelessWidget {
  final String userName;
  final String role;

  const HeroSection({super.key, required this.userName, required this.role});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final greetingPrefix = l10n.helloLabel; // "Hello,"
    final greeting = DateTimeUtils.getGreetingMessage(prefix: greetingPrefix);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppConstants.r24),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.p24),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        greeting,
                        style: AppTextStyle.bodyLarge.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: AppConstants.p8),
                      Text(
                        userName,
                        style: AppTextStyle.h1.copyWith(
                          color: AppColors.white,
                          fontSize: AppConstants.p22,
                        ),
                      ),
                      const SizedBox(height: AppConstants.p4),
                      Text(
                        role,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: Image.asset(
              AppAssets.dashboardImg,
              fit: BoxFit.contain,
              width: AppConstants.p140,
            ),
          ),
        ],
      ),
    );
  }
}
