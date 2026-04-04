import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class HomeHeader extends StatelessWidget {
  final String userName;

  const HomeHeader({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hour = DateTime.now().hour;
    String greeting = l10n.goodMorning;
    if (hour >= 12 && hour < 17) greeting = l10n.goodAfternoon;
    if (hour >= 17) greeting = l10n.goodEvening;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: AppTextStyle.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
            Text(
              l10n.hello(userName),
              style: AppTextStyle.h1.copyWith(color: AppColors.primary),
            ),
          ],
        ),
        const CircleAvatar(
          radius: AppConstants.p24,
          backgroundImage: AssetImage(AppAssets.defaultProfile),
        ),
      ],
    );
  }
}


