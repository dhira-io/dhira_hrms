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
          style: AppTextStyle.h3.copyWith(fontSize: 18),
        ),
        const SizedBox(height: AppConstants.p16),
        _buildInfoItem(
          context,
          iconPath: AppAssets.leaderIcon,
          label: l10n.organizationHierarchy,
          subtitle: "Organization structure",
          onTap: () => context.push(AppRouter.organizationPath),
        ),
        const SizedBox(height: AppConstants.p12),
        _buildInfoItem(
          context,
          iconPath: AppAssets.servicechart,
          label: l10n.projectBasedServiceChart,
          subtitle: "Project based service structure",
          onTap: () => context.push(AppRouter.organizationPath),
        ),
      ],
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required String iconPath,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
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
              width: 56,
              height: 56,
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
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.onSurfaceVariant,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
