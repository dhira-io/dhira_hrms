import 'package:dhira_hrms/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';

class EmployeeActionsSection extends StatelessWidget {
  const EmployeeActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.employeeActions,
              style: AppTextStyle.h3.copyWith(
                fontSize: AppConstants.p18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                l10n.viewAll.toUpperCase(),
                style: AppTextStyle.labelMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.p16),
        GridView.count(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppConstants.p16,
          crossAxisSpacing: AppConstants.p16,
          childAspectRatio: 0.85,
          children: [
            _buildActionCard(
              context,
              iconPath: AppAssets.timesheetIcon,
              label: l10n.timesheet,
              subtitle: l10n.timesheetSubtitle,
              iconBgColor: AppColors.iconbgblue,
              iconColor: AppColors.primary,
              onTap: () => context.push(AppRouter.timesheetPath),
            ),
            _buildActionCard(
              context,
              iconPath: AppAssets.leaveIcon,
              label: l10n.leaveApplications,
              subtitle: l10n.leaveSubtitle,
              iconBgColor: AppColors.iconbgred,
              iconColor: AppColors.error,
              onTap: () => context.push(AppRouter.applyLeavePath),
            ),
            _buildActionCard(
              context,
              iconPath: AppAssets.comofficon,
              label: l10n.compensatoryOff,
              subtitle: l10n.compOffSubtitle,
              iconBgColor: AppColors.slate100,
              iconColor: AppColors.slate600,
              onTap: () {},
            ),
            _buildActionCard(
              context,
              iconPath: AppAssets.attendanceIcon,
              label: l10n.attendanceRegularization,
              subtitle: l10n.attendanceRegSubtitle,
              iconBgColor: AppColors.iconbgviolet,
              iconColor: AppColors.brandBlue,
              onTap: () => context.push(AppRouter.attendanceRegularizationPath),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
      BuildContext context, {
        required String iconPath,
        required String label,
        required String subtitle,
        required Color iconBgColor,
        required Color iconColor,
        required VoidCallback onTap,
      }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        child: Ink(
          padding: const EdgeInsets.all(AppConstants.p16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppConstants.r16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                ),
                child: Center(
                  child: Image.asset(
                    iconPath,
                    width: 32,
                    height: 32,
                    // color: iconColor,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.p16),
              Text(
                label,
                style: AppTextStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstants.p14,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppConstants.p4),
              Text(
                subtitle,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
