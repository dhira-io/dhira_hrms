import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/constants/api_constants.dart';
import 'package:dhira_hrms/core/utils/string_utils.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/team_leave_entity.dart';

class EmployeeLeaveCard extends StatelessWidget {
  final TeamLeaveEntity leave;

  const EmployeeLeaveCard({super.key, required this.leave});

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
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: themeColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: themeColors.tableBorder, width: 1.w),
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
                ? Icon(Icons.person, size: 20.r, color: themeColors.slate400)
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
                    color: themeColors.slate950,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  leave.designation ?? '',
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: themeColors.slate550,

                    fontWeight: FontWeight.w500,
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
