import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/settings/presentation/bloc/notification_settings_cubit.dart';
import 'package:dhira_hrms/features/settings/domain/entities/notification_settings_entity.dart';
import 'package:dhira_hrms/features/settings/data/constants/notification_settings_constants.dart';

class NotificationPreferencesTable extends StatelessWidget {
  final String title;
  final IconData icon;
  final NotificationSectionEntity section;
  final bool isManager;
  final bool isActionLoading;

  const NotificationPreferencesTable({
    super.key,
    required this.title,
    required this.icon,
    required this.section,
    required this.isManager,
    required this.isActionLoading,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final rowDefinitions = [
      {
        NotificationSettingsConstants.keyBaseId:
            NotificationSettingsConstants.baseLeave,
      },
      {
        NotificationSettingsConstants.keyBaseId:
            NotificationSettingsConstants.baseAttendance,
      },
      {
        NotificationSettingsConstants.keyBaseId:
            NotificationSettingsConstants.baseTimesheet,
      },
      {
        NotificationSettingsConstants.keyBaseId:
            NotificationSettingsConstants.baseCompOff,
      },
    ];

    final typeFlex = isManager ? 23 : 22;
    final personalFlex = isManager ? 9 : 10;
    final teamFlex = 7;

    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: colors.iconbgblue,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(icon, size: 18.w, color: colors.primaryContainer),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        // Table Wrapper
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: colors.border, width: 1.w),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // Table Header Row
              Container(
                height: 38.h,
                decoration: BoxDecoration(
                  color: isDark ? colors.surfaceContainerLow : colors.infoBg,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                  border: Border(bottom: BorderSide(color: colors.border)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: typeFlex,
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          border: isManager
                              ? Border(right: BorderSide(color: colors.border))
                              : null,
                        ),
                        child: Text(
                          l10n.notificationType,
                          style: AppTextStyle.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colors.textPrimary,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: personalFlex,
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        decoration: BoxDecoration(
                          border: isManager
                              ? Border(right: BorderSide(color: colors.border))
                              : null,
                        ),
                        child: Text(
                          isManager ? l10n.personal : '',
                          style: AppTextStyle.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colors.textPrimary,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    if (isManager)
                      Expanded(
                        flex: teamFlex,
                        child: Container(
                          height: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            l10n.team,
                            style: AppTextStyle.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colors.textPrimary,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Table Data Rows
              ...rowDefinitions.asMap().entries.map((entry) {
                final rowIndex = entry.key;
                final row = entry.value;
                final baseId = row[NotificationSettingsConstants.keyBaseId]!;
                final isLast = rowIndex == rowDefinitions.length - 1;

                // Find items in the section
                final personalItem = section.items.firstWhereOrNull(
                  (item) => item.id == '${section.id}_$baseId',
                );
                final teamItem = section.items.firstWhereOrNull(
                  (item) => item.id == '${section.id}_${baseId}_team',
                );

                return Container(
                  height: 38.h,
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLowest,
                    borderRadius: isLast
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(12.r),
                            bottomRight: Radius.circular(12.r),
                          )
                        : null,
                    border: isLast
                        ? null
                        : Border(bottom: BorderSide(color: colors.border)),
                  ),
                  child: Row(
                    children: [
                      // Column 1: Row Title
                      Expanded(
                        flex: typeFlex,
                        child: Container(
                          height: double.infinity,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            context
                                .read<NotificationSettingsCubit>()
                                .getRowTitle(baseId, l10n),
                            style: AppTextStyle.bodySmall.copyWith(
                              color: colors.textPrimary,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                      // Column 2: Personal Toggle
                      Expanded(
                        flex: personalFlex,
                        child: Container(
                          height: double.infinity,
                          alignment: Alignment.center,
                          child: personalItem == null
                              ? const SizedBox.shrink()
                              : _CustomToggleSwitch(
                                  value: personalItem.value,
                                  isLoading: personalItem.isLoading,
                                  onChanged: isActionLoading
                                      ? null
                                      : (val) => context
                                            .read<NotificationSettingsCubit>()
                                            .toggleItem(
                                              section.id,
                                              personalItem.id,
                                              val,
                                              l10n,
                                            ),
                                ),
                        ),
                      ),
                      // Column 3: Team Toggle (if manager)
                      if (isManager)
                        Expanded(
                          flex: teamFlex,
                          child: Container(
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: teamItem == null
                                ? const SizedBox.shrink()
                                : _CustomToggleSwitch(
                                    value: teamItem.value,
                                    isLoading: teamItem.isLoading,
                                    onChanged: isActionLoading
                                        ? null
                                        : (val) => context
                                              .read<NotificationSettingsCubit>()
                                              .toggleItem(
                                                section.id,
                                                teamItem.id,
                                                val,
                                                l10n,
                                              ),
                                  ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class _CustomToggleSwitch extends StatelessWidget {
  final bool value;
  final bool isLoading;
  final ValueChanged<bool>? onChanged;

  const _CustomToggleSwitch({
    required this.value,
    required this.isLoading,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: 16.w,
        height: 16.w,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.of(context).primaryContainer,
          ),
        ),
      );
    }

    final isClickable = onChanged != null;

    return GestureDetector(
      onTap: isClickable ? () => onChanged!(!value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36.w,
        height: 20.w,
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: value
              ? AppColors.of(context).primaryContainer
              : AppColors.of(context).border,
          borderRadius: BorderRadius.circular(9999),
        ),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 16.w,
          height: 16.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(9999),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
