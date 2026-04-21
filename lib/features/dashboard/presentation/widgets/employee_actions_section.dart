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
              style: AppTextStyle.h2,
            ),
            Text(
              l10n.viewAll,
              style: AppTextStyle.labelSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.p16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppConstants.p16,
          crossAxisSpacing: AppConstants.p16,
          childAspectRatio: 1.4,
          children: [
            _buildActionCard(
              context,
              icon: Icons.history,
              label: l10n.timesheet,
              iconColor: AppColors.primary,
              bgColor: AppColors.primaryFixed,
              onTap: () => context.push(AppRouter.timesheetPath),
            ),
            _buildActionCard(
              context,
              icon: Icons.event_busy,
              label: l10n.leave,
              iconColor: AppColors.tertiary,
              bgColor: AppColors.tertiaryFixed,
              onTap: () => context.push(AppRouter.leavePath),
            ),
            _buildActionCard(
              context,
              icon: Icons.free_cancellation,
              label: l10n.compensatoryOff,
              iconColor: AppColors.onSecondaryFixedVariant,
              bgColor: AppColors.primaryFixed.withValues(alpha: 0.5),
              onTap: () {},
            ),
            _buildActionCard(
              context,
              icon: Icons.rule,
              label: l10n.attendanceRegularization,
              iconColor: AppColors.primary,
              bgColor: AppColors.primaryFixed,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color iconColor,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.p20),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppConstants.r16),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(AppConstants.r12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: AppConstants.iconMedium,
              ),
            ),
            const Spacer(),
            Text(
              label,
              style: AppTextStyle.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
