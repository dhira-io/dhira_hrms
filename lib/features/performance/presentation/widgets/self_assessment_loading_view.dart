import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'self_assessment_employee_card.dart';

class SelfAssessmentSkeleton extends StatelessWidget {
  final String name;
  final String employeeId;
  final String department;

  const SelfAssessmentSkeleton({
    super.key,
    this.name = AppConstants.emptyString,
    this.employeeId = AppConstants.emptyString,
    this.department = AppConstants.emptyString,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.p16),
            child: Column(
              children: [
                SelfAssessmentEmployeeCard(
                  name: name,
                  employeeId: employeeId,
                  department: department,
                  dueDate: AppConstants.emptyString,
                  isLoading: true,
                ),
                const SizedBox(height: AppConstants.p16),
                const SelfAssessmentShimmerSection(),
                const SizedBox(height: AppConstants.p16),
                const SelfAssessmentShimmerSection(),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(AppConstants.p16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.1),
                blurRadius: AppConstants.r10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Shimmer.fromColors(
            baseColor: AppColors.surfaceContainerHigh,
            highlightColor: AppColors.surfaceContainerLowest,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: AppConstants.p48,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppConstants.r12),
                    ),
                  ),
                ),
                const SizedBox(width: AppConstants.p16),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: AppConstants.p48,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppConstants.r12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SelfAssessmentShimmerSection extends StatelessWidget {
  const SelfAssessmentShimmerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.surfaceContainerHigh),
      ),
      child: Shimmer.fromColors(
        baseColor: AppColors.surfaceContainerHigh,
        highlightColor: AppColors.surfaceContainerLowest,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: AppConstants.p20,
              width: AppConstants.p150,
              color: AppColors.white,
            ),
            const SizedBox(height: AppConstants.p16),
            Container(
              height: AppConstants.p40,
              width: double.infinity,
              color: AppColors.white,
            ),
            const SizedBox(height: AppConstants.p16),
            Container(
              height: AppConstants.p100,
              width: double.infinity,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
