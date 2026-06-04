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

    final empId =
        (profile.customPayrollId != null && profile.customPayrollId!.isNotEmpty)
        ? "EMP-${profile.customPayrollId}"
        : (profile.employee ?? profile.empId ?? "");

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.of(context).surface
            : AppColors.of(context).white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark
              ? AppColors.of(context).border
              : AppColors.of(context).bordergrey,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(
              context,
            ).black.withValues(alpha: isDark ? 0.3 : 0.04),
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
                        color: isDark
                            ? AppColors.of(context).border
                            : AppColors.of(context).slate100,
                        width: 3.w,
                      ),
                    ),
                    child: ClipOval(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child:
                                profile.userImage != null &&
                                    profile.userImage!.isNotEmpty
                                ? Image.network(
                                    profile.userImage!.isAbsoluteUrl
                                        ? profile.userImage!
                                        : '$baseUrl${profile.userImage}',
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                              AppAssets.defaultProfile,
                                              fit: BoxFit.cover,
                                            ),
                                  )
                                : Image.asset(
                                    AppAssets.defaultProfile,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          if (isUploading)
                            Positioned.fill(
                              child: Container(
                                color: AppColors.of(
                                  context,
                                ).black.withValues(alpha: 0.5),
                                child: Center(
                                  child: SizedBox(
                                    width: 24.w,
                                    height: 24.w,
                                    child: CircularProgressIndicator(
                                      color: AppColors.of(context).white,
                                      strokeWidth: 2.w,
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
                    bottom: 0.h,
                    right: 0.w,
                    child: GestureDetector(
                      onTap: onPickImage,
                      child: Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          color: AppColors.of(
                            context,
                          ).primary, // Blue background
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.of(context).white,
                            width: 2.w,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.of(
                                context,
                              ).black.withValues(alpha: 0.1),
                              blurRadius: 4.r,
                              offset: Offset(0, 2.h),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.edit,
                            size: 12.w,
                            color: AppColors.of(context).white,
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
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
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
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
                  icon: Icon(
                    Icons.download,
                    size: 14.w,
                    color: isDark
                        ? AppColors.of(context).white
                        : AppColors.of(context).black,
                  ),
                  label: Text(
                    l10n.downloadResume,
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.of(context).white
                          : AppColors.of(context).black,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: isDark
                          ? AppColors.of(context).border
                          : AppColors.of(context).bordergrey,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          _ProgressBar(
            label: "Profile",
            percentage: 70,
            color: AppColors.of(context).primary,
          ),
          SizedBox(height: 12.h),
          _ProgressBar(
            label: "Bandwidth",
            percentage: 60,
            color: AppColors.of(context).success,
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
        border: Border.all(color: borderColor),
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

class _ProgressBar extends StatelessWidget {
  final String label;
  final int percentage;
  final Color color;

  const _ProgressBar({
    required this.label,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            label,
            style: AppTextStyle.bodyMedium.copyWith(
              color: isDark
                  ? AppColors.of(context).slate300
                  : AppColors.of(context).slate600,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Container(
            height: 6.h,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.of(context).slate800
                  : AppColors.of(context).slate200,
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ),
                Expanded(flex: 100 - percentage, child: const SizedBox()),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        SizedBox(
          width: 36.w,
          child: Text(
            '$percentage%',
            textAlign: TextAlign.right,
            style: AppTextStyle.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}
