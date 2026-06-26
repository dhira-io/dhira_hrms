import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/team_leave_entity.dart';
import 'package:dhira_hrms/features/calendar/presentation/widgets/employee_leave_card.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

class CalendarOnLeaveTodayWidget extends StatelessWidget {
  final List<TeamLeaveEntity>? teamLeaves;

  const CalendarOnLeaveTodayWidget({super.key, required this.teamLeaves});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = AppColors.of(context);
    final todayFormatted = DateTimeUtils.formatDate(
      DateTime.now(),
      pattern: DateTimeUtils.dateFormatMonthDayYear,
    );

    final int leaveCount = teamLeaves?.length ?? 0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: themeColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: themeColors.tableBorder, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.teamOnLeave,
                style: AppTextStyle.labelLarge.copyWith(
                  color: AppColors.of(context).onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    todayFormatted,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.of(context).onSurfaceVariant,

                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    width: 3.w,
                    height: 3.w,
                    decoration: BoxDecoration(
                      color: AppColors.of(context).onSurfaceVariant,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    leaveCount == 1
                        ? l10n.oneEmployee
                        : l10n.multipleEmployees(leaveCount),
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.of(context).onSurfaceVariant,

                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Content body
          if (teamLeaves == null)
            const _ShimmerLoadingView()
          else if (teamLeaves!.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                l10n.noOneOnLeaveToday,
                style: AppTextStyle.labelLarge.copyWith(
                  color: AppColors.of(context).onSurfaceVariant,

                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: teamLeaves!.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                return EmployeeLeaveCard(leave: teamLeaves![index]);
              },
            ),
        ],
      ),
    );
  }
}

class _ShimmerLoadingView extends StatelessWidget {
  const _ShimmerLoadingView();

  @override
  Widget build(BuildContext context) {
    final themeColors = AppColors.of(context);

    return Shimmer.fromColors(
      baseColor: themeColors.shimmerBase,
      highlightColor: themeColors.shimmerHighlight,
      child: Column(
        children: List.generate(2, (index) {
          return Container(
            margin: EdgeInsets.only(bottom: index == 1 ? 0 : 12.h),
            width: double.infinity,
            height: 60.h,
            decoration: BoxDecoration(
              color: themeColors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: themeColors.outlineVariant, width: 1.w),
            ),
          );
        }),
      ),
    );
  }
}
