import 'package:dhira_hrms/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/toast_utils.dart';
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
            fontSize: AppConstants.p16.sp,
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
                      subtitle: l10n.emptimesheetSubtitle,
                      iconBgColor: AppColors.of(context).leaveBg,
                      iconColor: AppColors.of(context).timesheeticon,
                      onTap: () => context.push(AppRouter.timesheetPath),
                    ),
                  ),
                  const SizedBox(width: AppConstants.p16),
                  Expanded(
                    child: ActionCard(
                      iconPath: AppAssets.leaveIcon,
                      label: l10n.leaveApplications,
                      subtitle: l10n.empleaveSubtitle,
                      iconBgColor: AppColors.of(context).successBg,
                      iconColor: AppColors.of(context).calendarupicon,
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
                    child: ActionCard(
                      iconPath: AppAssets.comofficon,
                      label: l10n.compensatoryLeave,
                      subtitle: l10n.requestCompensatoryLeave,
                      iconBgColor: AppColors.of(context).iconbggreen,
                      iconColor: AppColors.of(context).compofficon,
                      onTap: () => context.push(AppRouter.compensatoryLeavePath),
                    ),
                  ),
                  const SizedBox(width: AppConstants.p16),
                  Expanded(
                    child: ActionCard(
                      iconPath: AppAssets.attendanceIcon,
                      label: l10n.attendanceRegularization,
                      subtitle: l10n.empattendanceRegSubtitle,
                      iconBgColor: AppColors.of(context).attendancebg,
                      iconColor: AppColors.of(context).attendanceicon,
                      onTap: () =>
                          context.push(AppRouter.attendanceRegularizationPath),
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
}
