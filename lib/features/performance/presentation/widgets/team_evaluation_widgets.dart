import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(
              alpha: AppConstants.opacityExtraLow / 2,
            ),
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
              child: Container(width: 4, color: accentBarColor),
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
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title.toUpperCase(),
                      style: AppTextStyle.labelSmall.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                        fontSize: AppConstants.fs10,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: AppTextStyle.h1Bold.copyWith(
                  fontSize: AppConstants.fs24,
                  color: AppColors.onSurface.withValues(
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
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return const SizedBox.shrink();

    // Logic moved to extensions, these are kept for backward compatibility if needed, 
    // but we will update the usage below.

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(
              alpha: AppConstants.opacityExtraLow / 1.5,
            ),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryContainer,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: name == null
                          ? Shimmer.fromColors(
                              baseColor: AppColors.slate200,
                              highlightColor: AppColors.slate100,
                              child: Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.circle,
                                  ),
                              ),
                            )
                          : Text(
                              name!.getInitials,
                              style: AppTextStyle.labelLarge.copyWith(
                                color: AppColors.onSecondaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (name == null)
                            Shimmer.fromColors(
                              baseColor: AppColors.slate200,
                              highlightColor: AppColors.slate100,
                              child: Container(
                                width: 120,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            )
                          else
                            Text(
                              name!,
                              style: AppTextStyle.labelLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: AppConstants.fs16,
                              ),
                            ),
                          const SizedBox(height: 2),
                          Text(
                            '$empId • $role',
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.onSurfaceVariant,
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
                        color: status.toLowerCase() == PerformanceStatus.submitted.toLowerCase() 
                            ? AppColors.successBg 
                            : AppColors.warningBg,
                        borderRadius: BorderRadius.circular(AppConstants.r20),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: AppTextStyle.labelSmall.copyWith(
                          color: status.toLowerCase() == PerformanceStatus.submitted.toLowerCase() 
                              ? AppColors.success 
                              : AppColors.warning,
                          fontSize: AppConstants.fs10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                if (submittedAt != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.event_available_outlined,
                        size: 14,
                        color: AppColors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${l10n.submittedOn}: ${submittedAt!.format(AppConstants.dateDisplayFormat)}',
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryContainer],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(
                          alpha: AppConstants.opacitySlight,
                        ),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: onReview,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.transparent,
                      foregroundColor: AppColors.white,
                      shadowColor: AppColors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstants.r12),
                      ),
                    ),
                    child: Text(
                      l10n.review,
                      style: AppTextStyle.labelMedium.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
