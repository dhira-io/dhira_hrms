import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/constants/api_constants.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/utils/string_utils.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/team_leave_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

class CalendarOnLeaveTodayWidget extends StatelessWidget {
  final List<TeamLeaveEntity>? teamLeaves;

  const CalendarOnLeaveTodayWidget({
    super.key,
    required this.teamLeaves,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = AppColors.of(context);
    final todayFormatted = DateTimeUtils.formatDate(
      DateTime.now(),
      pattern: 'MMMM dd, yyyy',
    );

    final int leaveCount = teamLeaves?.length ?? 0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: themeColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: themeColors.outlineVariant, width: 1.w),
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
                style: AppTextStyle.bodyMedium.copyWith(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  height: 20 / 14,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    todayFormatted,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: const Color(0xFF62748E),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 16 / 12,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    width: 3.w,
                    height: 3.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF62748E),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    leaveCount == 1 ? '1 Employee' : '$leaveCount Employees',
                    style: AppTextStyle.bodySmall.copyWith(
                      color: const Color(0xFF62748E),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 16 / 12,
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
                '🎉 Great news! No one from your team is on leave today.',
                style: AppTextStyle.bodyMedium.copyWith(
                  color: const Color(0xFF62748E),
                  fontSize: 13.sp,
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
                return _EmployeeLeaveCard(leave: teamLeaves![index]);
              },
            ),
        ],
      ),
    );
  }
}

class _EmployeeLeaveCard extends StatelessWidget {
  final TeamLeaveEntity leave;

  const _EmployeeLeaveCard({required this.leave});

  @override
  Widget build(BuildContext context) {
    final themeColors = AppColors.of(context);
    final imageUrl = leave.image;
    final fullImageUrl = imageUrl != null && imageUrl.isNotEmpty
        ? (imageUrl.isAbsoluteUrl
            ? imageUrl
            : '${ApiConstants.baseUrl}${imageUrl.startsWith('/') ? imageUrl.substring(1) : imageUrl}')
        : null;

    return Container(
      width: double.infinity,
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: themeColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: themeColors.outlineVariant, width: 1.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: themeColors.slate100,
              image: fullImageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(fullImageUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: fullImageUrl == null
                ? Icon(
                    Icons.person,
                    size: 20.r,
                    color: themeColors.slate400,
                  )
                : null,
          ),
          SizedBox(width: 12.w),
          // Name & Designation
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leave.employeeName,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: const Color(0xFF020618),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 20 / 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  leave.designation ?? '',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: const Color(0xFF62748E),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    height: 16 / 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
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
