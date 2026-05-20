import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/performance/domain/entities/sa_tracking_entity.dart';
import 'package:dhira_hrms/features/performance/presentation/widgets/self_assessment_view_helpers.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/self_assessment/self_assessment_cubit.dart';

class SelfAssessmentTrackingSection extends StatelessWidget {
  final SaTrackingEntity? tracking;

  const SelfAssessmentTrackingSection({super.key, this.tracking});

  @override
  Widget build(BuildContext context) {
    final trackingData = tracking ??
        context.select((SelfAssessmentCubit cubit) => cubit.state.tracking);
    if (trackingData == null || trackingData.sessions.isEmpty) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.of(context).surfaceContainerHigh),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.p16),
            child: Row(
              children: [
                Icon(Icons.track_changes, color: AppColors.of(context).primary),
                const SizedBox(width: AppConstants.p12),
                Text(
                  l10n.timelineLabel,
                  style: AppTextStyle.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.of(context).surfaceContainerHigh),
          ...trackingData.sessions.map((session) {
            final sessionQuestions = trackingData.questions
                .where((q) => q.session == session.session)
                .toList();

            final formattedDate = SelfAssessmentViewHelpers.formatSessionDate(
              session.sessionStart,
            );
            final formattedTime = SelfAssessmentViewHelpers.formatSessionTime(
              session.sessionStart,
              session.sessionEnd,
            );
            return Padding(
              padding: const EdgeInsets.only(
                bottom: AppConstants.p12,
                left: AppConstants.p16,
                right: AppConstants.p16,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.of(context).surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                  border: Border.all(color: AppColors.of(context).surfaceContainerHigh),
                ),
                child: ExpansionTile(
                  shape: const Border(),
                  collapsedShape: const Border(),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.of(context).primary.withValues(alpha: 0.1),
                    child: Text(
                      session.session,
                      style: AppTextStyle.labelLarge.copyWith(
                        color: AppColors.of(context).primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    formattedDate,
                    style: AppTextStyle.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: AppConstants.p4),
                    child: Text(
                      formattedTime,
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: AppColors.of(context).onSurfaceVariant,
                      ),
                    ),
                  ),
                  childrenPadding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.p16,
                  ),
                  children: sessionQuestions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final question = entry.value;

                    final ratingValue =
                        SelfAssessmentViewHelpers.ratingOutOfFour(
                          question.rating,
                        );
                    final timeStr =
                        SelfAssessmentViewHelpers.formatQuestionTime(
                          question.lastModified,
                        );

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppConstants.p12,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(AppConstants.p4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.of(context).success.withValues(
                                    alpha: 0.1,
                                  ),
                                  border: Border.all(
                                    color: AppColors.of(context).success.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: AppColors.of(context).success,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: AppConstants.p12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      question.question,
                                      style: AppTextStyle.bodyMedium.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: AppConstants.p8),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: AppConstants.p6,
                                            vertical: AppConstants.p4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.of(context).primaryContainer
                                                .withValues(alpha: 0.3),
                                            borderRadius: BorderRadius.circular(
                                              AppConstants.r4,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: AppConstants.p8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: AppConstants.p6,
                                            vertical: AppConstants.p4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.of(context).success.withValues(
                                              alpha: 0.1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              AppConstants.r4,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 12,
                                                color: AppColors.of(context).success,
                                              ),
                                              const SizedBox(
                                                width: AppConstants.p4,
                                              ),
                                              Text(
                                                '$ratingValue / 4',
                                                style: AppTextStyle.labelSmall
                                                    .copyWith(
                                                      color: AppColors.of(context).success,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                              Text(
                                timeStr,
                                style: AppTextStyle.labelSmall.copyWith(
                                  color: AppColors.of(context).onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (index < sessionQuestions.length - 1)
                          Divider(height: 1, thickness: 0.5, color: AppColors.of(context).surfaceContainerHigh),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
