import 'package:dhira_hrms/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          style: AppTextStyle.h3.copyWith(
            fontSize: AppConstants.p18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.p16),
        Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _buildActionCard(
                      context,
                      iconPath: AppAssets.timesheetIcon,
                      label: l10n.timesheet,
                      subtitle: l10n.timesheetSubtitle,
                      iconBgColor: AppColors.leaveBg,
                      iconColor: AppColors.timesheeticon,
                      onTap: () => context.push(AppRouter.timesheetPath),
                    ),
                  ),
                  const SizedBox(width: AppConstants.p16),
                  Expanded(
                    child: _buildActionCard(
                      context,
                      iconPath: AppAssets.leaveIcon,
                      label: l10n.leaveApplications,
                      subtitle: l10n.leaveSubtitle,
                      iconBgColor: AppColors.successBg,
                      iconColor: AppColors.calendarupicon,
                      onTap: () => context.push(AppRouter.applyLeavePath),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.p16),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _buildActionCard(
                      context,
                      iconPath: AppAssets.comofficon,
                      label: l10n.compensatoryOff,
                      subtitle: l10n.compOffSubtitle,
                      iconBgColor: AppColors.bereavementTrack,
                      iconColor: AppColors.compofficon,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: AppConstants.p16),
                  Expanded(
                    child: _buildActionCard(
                      context,
                      iconPath: AppAssets.attendanceIcon,
                      label: l10n.attendanceRegularization,
                      subtitle: l10n.attendanceRegSubtitle,
                      iconBgColor: AppColors.attendancebg,
                      iconColor: AppColors.attendanceicon,
                      onTap: () => context.push(AppRouter.attendanceRegularizationPath),
                    ),
                  ),
                ],
              ),
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
                  child: SvgPicture.asset(
                    iconPath,
                    width: AppConstants.iconXXSmall,
                    height: AppConstants.iconXXSmall,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
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
