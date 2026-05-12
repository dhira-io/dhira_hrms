import 'package:dhira_hrms/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import 'action_card.dart';

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
                    child: ActionCard(
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
                    child: ActionCard(
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
                  /*Expanded(
                    child: ActionCard(
                      iconPath: AppAssets.comofficon,
                      label: l10n.compensatoryOff,
                      subtitle: l10n.compOffSubtitle,
                      iconBgColor: AppColors.bereavementTrack,
                      iconColor: AppColors.compofficon,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: AppConstants.p16),*/
                  ActionCard(
                    iconPath: AppAssets.attendanceIcon,
                    label: l10n.attendanceRegularization,
                    subtitle: l10n.attendanceRegSubtitle,
                    iconBgColor: AppColors.attendancebg,
                    iconColor: AppColors.attendanceicon,
                    onTap: () => context.push(AppRouter.attendanceRegularizationPath),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
