import 'package:dhira_hrms/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';

class CompanyInformationSection extends StatelessWidget {
  const CompanyInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.companyInformation,
          style: AppTextStyle.h3.copyWith(fontSize: AppConstants.p18),
        ),
        const SizedBox(height: AppConstants.p16),
        _CompanyInfoTile(
          iconPath: AppAssets.leaderIcon,
          label: l10n.organizationHierarchy,
          onTap: () => context.push(AppRouter.organizationPath),
        ),
        const SizedBox(height: AppConstants.p12),
        _CompanyInfoTile(
          iconPath: AppAssets.servicechart,
          label: l10n.projectBasedServiceChart,
          onTap: () => context.push(AppRouter.organizationPath),
        ),
      ],
    );
  }
}

class _CompanyInfoTile extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  const _CompanyInfoTile({
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.r16),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.p16),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppConstants.r16),
        ),
        child: Row(
          children: [
            SizedBox(
              width: AppConstants.p56,
              height: AppConstants.p56,
              child: Image.asset(
                iconPath,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: AppConstants.p16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: AppConstants.p14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.onSurfaceVariant,
              size: AppConstants.iconXSmall,
            ),
          ],
        ),
      ),
    );
  }
}
