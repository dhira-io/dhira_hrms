import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/self_assessment/self_assessment_cubit.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SelfAssessmentEmployeeCard extends StatelessWidget {
  final String? name;
  final String? employeeId;
  final String? department;
  final String? dueDate;
  final bool? isLoading;
  final SelfAssessmentEntity? details;

  const SelfAssessmentEmployeeCard({
    super.key,
    this.name,
    this.employeeId,
    this.department,
    this.dueDate,
    this.isLoading,
    this.details,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final bool resolvedIsLoading = isLoading ??
        context.select((SelfAssessmentCubit cubit) =>
            cubit.state.status == SelfAssessmentStatus.loading);

    final resolvedDetails = details ??
        context.select((SelfAssessmentCubit cubit) => cubit.state.details);

    final empName = (resolvedDetails?.employeeName.isNotEmpty ?? false)
        ? resolvedDetails!.employeeName
        : (name ?? AppConstants.emptyString);
    final empId = (resolvedDetails?.employee.isNotEmpty ?? false)
        ? resolvedDetails!.employee
        : (employeeId ?? AppConstants.emptyString);
    final dept = (resolvedDetails?.department.isNotEmpty ?? false)
        ? resolvedDetails!.department
        : (department ?? AppConstants.emptyString);

    final resolvedDueDate = dueDate ??
        (resolvedDetails != null
            ? DateTimeUtils.formatToDMY(resolvedDetails.submissionDate)
            : AppConstants.emptyString);

    final answered = resolvedDetails?.goalReviews
            .where((g) => g.selfRating.isNotEmpty)
            .length ??
        0;
    final total = resolvedDetails?.goalReviews.length ?? 0;
    final progress = total == 0 ? 0.0 : answered / total;

    return Container(
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.of(context).surfaceContainerHigh),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).black.withValues(alpha: 0.05),
            blurRadius: AppConstants.r4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      empName,
                      style: AppTextStyle.h3Bold.copyWith(
                        color: AppColors.of(context).onSurface,
                        fontSize: AppConstants.fs20,
                      ),
                    ),
                    const SizedBox(height: AppConstants.p4),
                    Text(
                      '${l10n.employeeIdLabel(empId)} | ${l10n.deptLabel(dept)}',
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.of(context).onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    l10n.dueDate.toUpperCase(),
                    style: AppTextStyle.labelSmall.copyWith(
                      color: AppColors.of(context).outline,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      fontSize: AppConstants.fs10,
                    ),
                  ),
                  if (resolvedIsLoading)
                    Shimmer.fromColors(
                      baseColor: AppColors.of(context).surfaceContainerHigh,
                      highlightColor: AppColors.of(context).surfaceContainerLowest,
                      child: Container(
                        height: AppConstants.p16,
                        width: AppConstants.p80,
                        decoration: BoxDecoration(
                          color: AppColors.of(context).white,
                          borderRadius: BorderRadius.circular(AppConstants.r4),
                        ),
                      ),
                    )
                  else
                    Text(
                      resolvedDueDate,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.of(context).primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.overallProgressLabel,
                    style: AppTextStyle.labelSmall.copyWith(
                      color: AppColors.of(context).onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: AppConstants.fs11,
                    ),
                  ),
                  Text(
                    l10n.achievementPercentLabel(
                      (progress * 100).toInt().toString(),
                    ),
                    style: AppTextStyle.labelSmall.copyWith(
                      color: AppColors.of(context).primary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppConstants.fs11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.p8),
              if (resolvedIsLoading)
                Shimmer.fromColors(
                  baseColor: AppColors.of(context).surfaceContainerHigh,
                  highlightColor: AppColors.of(context).surfaceContainerLowest,
                  child: Container(
                    height: AppConstants.p8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.of(context).white,
                      borderRadius: BorderRadius.circular(AppConstants.r32),
                    ),
                  ),
                )
              else
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstants.r32),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: AppConstants.p8,
                    backgroundColor: AppColors.of(context).surfaceContainerHigh,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
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
