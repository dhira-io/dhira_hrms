import 'package:dhira_hrms/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/routing/app_router.dart';

class HomeEmployeeActions extends StatelessWidget {
  final String searchQuery;

  const HomeEmployeeActions({super.key, this.searchQuery = ''});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    final allActions = [
      _ActionItem(
        iconPath: AppAssets.timesheetIcon,
        label: l10n.timesheet,
        subtitle: l10n.emptimesheetSubtitle,
        iconBgColor: AppColors.of(context).leaveBg, // Light blue
        iconColor: AppColors.of(context).timesheeticon,
        onTap: () => context.push(AppRouter.timesheetPath),
      ),
      _ActionItem(
        iconPath: AppAssets.leaveIcon,
        label: l10n.leaveApplications,
        subtitle: l10n.empleaveSubtitle,
        iconBgColor: AppColors.of(context).successBg, // Light green
        iconColor: AppColors.of(context).calendarupicon,
        onTap: () => context.push(AppRouter.applyLeavePath),
      ),
      _ActionItem(
        iconPath: AppAssets.comofficon,
        label: l10n.comOff,
        subtitle: l10n.empcompoffSubtitle,
        iconBgColor: AppColors.of(context).bereavementTrack, // Light teal
        iconColor: AppColors.of(context).compofficon,
        onTap: () => context.push(AppRouter.comingSoonPath), // Comp off has no path defined yet
      ),
      _ActionItem(
        iconPath: AppAssets.attendanceIcon,
        label: l10n.attendanceRegularization,
        subtitle: l10n.empattendanceRegSubtitle,
        iconBgColor: AppColors.of(context).attendancebg, // Light purple
        iconColor: AppColors.of(context).attendanceicon,
        onTap: () => context.push(AppRouter.attendanceRegularizationPath),
      ),
    ];

    final actions = allActions.where((action) {
      if (searchQuery.isEmpty) return true;
      final query = searchQuery.toLowerCase();
      return action.label.toLowerCase().contains(query) ||
             action.subtitle.toLowerCase().contains(query);
    }).toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.p20.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.of(context).surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.of(context).outlineVariant.withOpacity(0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                l10n.employeeActions,
                style: AppTextStyle.bodyLarge.copyWith(
                  color: AppColors.of(context).onSurface,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.of(context).outlineVariant.withOpacity(0.3),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: actions.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: Center(
                        child: Text(
                          l10n.noDataFound,
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: AppColors.of(context).textSecondary,
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: actions.asMap().entries.map((entry) {
                        final index = entry.key;
                        final action = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(bottom: index == actions.length - 1 ? 0 : 10.h),
                    child: InkWell(
                      onTap: action.onTap,
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.of(context).outlineVariant.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                color: action.iconBgColor,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: action.iconPath.endsWith('.svg')
                                    ? SvgPicture.asset(
                                        action.iconPath,
                                        width: 20.w,
                                        height: 20.w,
                                        colorFilter: ColorFilter.mode(
                                          action.iconColor,
                                          BlendMode.srcIn,
                                        ),
                                      )
                                    : Image.asset(
                                        action.iconPath,
                                        width: 20.w,
                                        height: 20.w,
                                        color: action.iconColor,
                                      ),
                              ),
                            ),
                            SizedBox(width: 8.w), // gap 8px
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    action.label,
                                    style: AppTextStyle.bodyMedium.copyWith(
                                      color: AppColors.of(context).onSurface,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    action.subtitle,
                                    style: AppTextStyle.bodySmall.copyWith(
                                      color: AppColors.of(context).onSurfaceVariant,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: AppColors.of(context).onSurfaceVariant,
                              size: 20.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionItem {
  final String iconPath;
  final String label;
  final String subtitle;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  _ActionItem({
    required this.iconPath,
    required this.label,
    required this.subtitle,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
  });
}
