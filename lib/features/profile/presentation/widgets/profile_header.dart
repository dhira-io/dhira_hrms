import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/profile_entities.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileEntity profile;
  final VoidCallback onPickImage;
  final bool isUploading;

  const ProfileHeader({
    super.key,
    required this.profile,
    required this.onPickImage,
    this.isUploading = false,
  });

  @override
  Widget build(BuildContext context) {
    final baseUrl = Get.find<DioClient>().baseUrl;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    final empId = profile.customPayrollId ?? profile.employee ?? profile.empId ?? "0871";
    final designation = profile.designation ?? "UI/UX Designer";
    final department = profile.orgDepartment ?? profile.department ?? "Engineering - Frontend";
    final division = profile.division ?? "Hyderabad";

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.of(context).surface : AppColors.of(context).white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? AppColors.of(context).border : AppColors.of(context).bordergrey,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).black.withValues(alpha: isDark ? 0.3 : 0.04),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? AppColors.of(context).border : AppColors.of(context).slate100,
                        width: 3.w,
                      ),
                    ),
                    child: ClipOval(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: profile.userImage != null && profile.userImage!.isNotEmpty
                                ? Image.network(
                                    profile.userImage!.isAbsoluteUrl 
                                        ? profile.userImage! 
                                        : '$baseUrl${profile.userImage}',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Image.asset(AppAssets.defaultProfile, fit: BoxFit.cover),
                                  )
                                : Image.asset(AppAssets.defaultProfile, fit: BoxFit.cover),
                          ),
                          if (isUploading)
                            Positioned.fill(
                              child: Container(
                                color: AppColors.of(context).black.withValues(alpha: 0.4),
                                child: Center(
                                    child: SizedBox(
                                      width: 20.w,
                                      height: 20.w,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.of(context).white,
                                      ),
                                    ),
                                  ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 22.w,
                      height: 22.w,
                      decoration: BoxDecoration(
                        color: AppColors.of(context).white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.of(context).black.withValues(alpha: 0.1),
                            blurRadius: 4.r,
                            offset: Offset(0, 2.h),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.of(context).success, // Vibrant active green
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 6.h,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          profile.fullName,
                          style: AppTextStyle.h3.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppColors.of(context).iconbgblue,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            empId,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.of(context).primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppColors.of(context).successBg,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6.w,
                                height: 6.w,
                                decoration: BoxDecoration(
                                  color: AppColors.of(context).success,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                l10n.active,
                                style: AppTextStyle.bodySmall.copyWith(
                                  color: AppColors.of(context).successDark,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "• $designation",
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: AppColors.of(context).textSecondary,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "• $department  • $division",
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: AppColors.of(context).textSecondary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _StatPill(
                text: l10n.yearsExperience,
                icon: Icons.work_history_outlined,
                backgroundColor: isDark
                    ? AppColors.of(context).slate800
                    : AppColors.of(context).iconbgviolet,
                borderColor: isDark
                    ? AppColors.of(context).slate700
                    : AppColors.of(context).bordergrey,
                iconColor: AppColors.of(context).brandPurple,
                textColor: isDark ? AppColors.of(context).white : AppColors.of(context).brandPurple,
              ),
              _StatPill(
                text: l10n.activeProjects,
                icon: Icons.folder_open_outlined,
                backgroundColor: isDark
                    ? AppColors.of(context).slate800
                    : AppColors.of(context).iconbgblue,
                borderColor: isDark
                    ? AppColors.of(context).slate700
                    : AppColors.of(context).bordergrey,
                iconColor: AppColors.of(context).primary,
                textColor: isDark ? AppColors.of(context).white : AppColors.of(context).primary,
              ),
              _StatPill(
                text: l10n.skillsCount,
                icon: Icons.psychology_outlined,
                backgroundColor: isDark
                    ? AppColors.of(context).slate800
                    : AppColors.of(context).iconbggreen,
                borderColor: isDark
                    ? AppColors.of(context).slate700
                    : AppColors.of(context).bordergrey,
                iconColor: AppColors.of(context).success,
                textColor: isDark ? AppColors.of(context).white : AppColors.of(context).success,
              ),
              _StatPill(
                text: l10n.certificationsCount,
                icon: Icons.verified_outlined,
                backgroundColor: isDark
                    ? AppColors.of(context).slate800
                    : AppColors.of(context).iconbgorange,
                borderColor: isDark
                    ? AppColors.of(context).slate700
                    : AppColors.of(context).bordergrey,
                iconColor: AppColors.of(context).warning,
                textColor: isDark ? AppColors.of(context).white : AppColors.of(context).warningDark,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(height: 1.h, thickness: 0.5),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 16.w,
              runSpacing: 16.h,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.download, size: 14.w, color: isDark ? AppColors.of(context).white : AppColors.of(context).black),
                  label: Text(
                    l10n.downloadResume,
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.of(context).white : AppColors.of(context).black,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: isDark ? AppColors.of(context).border : AppColors.of(context).bordergrey),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;

  const _StatPill({
    required this.text,
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.w, color: iconColor),
          SizedBox(width: 4.w),
          Text(
            text,
            style: AppTextStyle.bodySmall.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
