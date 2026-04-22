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
          style: AppTextStyle.h2,
        ),
        const SizedBox(height: AppConstants.p16),
        _buildInfoItem(
          context,
          icon: Icons.account_tree_outlined,
          label: l10n.organizationHierarchy,
          onTap: () => context.push(AppRouter.organizationPath),
        ),
        const SizedBox(height: AppConstants.p12),
        _buildInfoItem(
          context,
          icon: Icons.bar_chart_outlined,
          label: l10n.projectBasedServiceChart,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String label,
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
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primaryContainer,
                size: 20,
              ),
            ),
            const SizedBox(width: AppConstants.p16),
            Expanded(
              child: Text(
                label,
                style: AppTextStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
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
