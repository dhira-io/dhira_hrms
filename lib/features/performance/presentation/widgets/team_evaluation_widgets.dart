import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../../core/utils/date_time_utils.dart';

class TeamEvaluationMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final Color? accentBarColor;
  final bool isFullWidth;

  const TeamEvaluationMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconBgColor = AppColors.iconbgblue,
    this.iconColor = AppColors.primary,
    this.accentBarColor,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.p16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(
              context,
            ).black.withValues(alpha: AppConstants.opacityExtraLow / 2),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (accentBarColor != null)
            Positioned(
              left: -16,
              top: -16,
              bottom: -16,
              child: Container(width: 4.w, color: accentBarColor),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppConstants.p6),
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: iconColor, size: 14),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      title.toUpperCase(),
                      style: AppTextStyle.labelSmall.copyWith(
                        color: AppColors.of(context).onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                        fontSize: AppConstants.fs9.sp,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                value,
                style: AppTextStyle.h1Bold.copyWith(
                  fontSize: AppConstants.fs22.sp,
                  color: AppColors.of(context).onSurface.withValues(
                    alpha: value == '00' ? AppConstants.opacityMedium : 1.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TeamEvaluationEmployeeCard extends StatelessWidget {
  final String? name;
  final String role;
  final String empId;
  final String status;
  final DateTime? submittedAt;
  final VoidCallback onReview;

  const TeamEvaluationEmployeeCard({
    super.key,
    this.name,
    required this.role,
    required this.empId,
    required this.status,
    this.submittedAt,
    required this.onReview,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r20),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(
              context,
            ).black.withValues(alpha: AppConstants.opacityExtraLow / 1.5),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: AppColors.of(context).secondaryContainer,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: name == null
                          ? Shimmer.fromColors(
                              baseColor: AppColors.of(
                                context,
                              ).surfaceContainerLow,
                              highlightColor: AppColors.of(
                                context,
                              ).surfaceContainer,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.of(
                                    context,
                                  ).surfaceContainerLow,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          : Text(
                              name!.getInitials,
                              style: AppTextStyle.labelLarge.copyWith(
                                color: AppColors.of(
                                  context,
                                ).onSecondaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (name == null)
                            Shimmer.fromColors(
                              baseColor: AppColors.of(
                                context,
                              ).surfaceContainerLow,
                              highlightColor: AppColors.of(
                                context,
                              ).surfaceContainer,
                              child: Container(
                                width: 120.w,
                                height: 16.h,
                                decoration: BoxDecoration(
                                  color: AppColors.of(
                                    context,
                                  ).surfaceContainerLow,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                            )
                          else
                            Text(
                              name!,
                              style: AppTextStyle.labelLarge.copyWith(
                                color: AppColors.of(context).onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize: AppConstants.fs14.sp,
                              ),
                            ),
                          SizedBox(height: 2.h),
                          Text(
                            '$empId • $role',
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.of(context).onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.p10,
                        vertical: AppConstants.p4,
                      ),
                      decoration: BoxDecoration(
                        // NOTE: This widget currently receives raw strings.
                        // In a real scenario, we should pass the entity.
                        color:
                            status.toLowerCase() ==
                                PerformanceStatus.submitted.toLowerCase()
                            ? AppColors.of(context).successBg
                            : AppColors.of(context).warningBg,
                        borderRadius: BorderRadius.circular(AppConstants.r20),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: AppTextStyle.labelSmall.copyWith(
                          color:
                              status.toLowerCase() ==
                                  PerformanceStatus.submitted.toLowerCase()
                              ? AppColors.of(context).success
                              : AppColors.of(context).warning,
                          fontSize: AppConstants.fs8.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                if (submittedAt case final date?) ...[
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.event_available_outlined,
                        size: 14,
                        color: AppColors.of(context).onSurfaceVariant,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        l10n.submittedOn(
                          date.format(AppConstants.dateDisplayFormat),
                        ),
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.of(context).onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 20.h),
                CommonButton(
                  text: l10n.review,
                  onPressed: onReview,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
