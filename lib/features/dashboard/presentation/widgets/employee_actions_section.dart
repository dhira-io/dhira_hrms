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
        Text(
          l10n.employeeActions,
          style: AppTextStyle.h3.copyWith(fontSize: AppConstants.p18),
        ),
        const SizedBox(height: AppConstants.p16),
        GridView.count(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppConstants.p16,
          crossAxisSpacing: AppConstants.p16,
          childAspectRatio: 1.2,
          children: [
            _buildActionCard(
              context,
              iconPath: AppAssets.timesheetIcon,
              label: l10n.timesheet,
              onTap: () => context.push(AppRouter.timesheetPath),
            ),
            _buildActionCard(
              context,
              iconPath: AppAssets.leaveIcon,
              label: l10n.leaveApplications,
              onTap: () => context.push(AppRouter.applyLeavePath),
            ),
            _buildActionCard(
              context,
              iconPath: AppAssets.comofficon,
              label: l10n.compensatoryOff,
              onTap: () {},
            ),
            _buildActionCard(
              context,
              iconPath: AppAssets.attendanceIcon,
              label: l10n.attendanceRegularization,
              onTap: () {},
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
        required VoidCallback onTap,
      }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.p16,
            vertical: AppConstants.p12,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppConstants.r16),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: AppConstants.opacityLow),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: AppConstants.p56,
                height: AppConstants.p56,
                padding: const EdgeInsets.all(0), // Removed padding to keep icon large
                child: Image.asset(
                  iconPath,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: AppConstants.p10),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: AppConstants.p14,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
