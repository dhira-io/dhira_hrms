import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../cubit/self_assessment/self_assessment_cubit.dart';
import '../../domain/entities/self_assessment_entity.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/toast_utils.dart';
import '../dialogs/submit_feedback_dialog.dart';

class ReviewHeader extends StatelessWidget implements PreferredSizeWidget {
  const ReviewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + AppConstants.p8,
        bottom: AppConstants.p16,
        left: AppConstants.p20,
        right: AppConstants.p20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                color: AppColors.primary,
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.surfaceContainerLowest,
                  padding: const EdgeInsets.all(AppConstants.p8),
                ),
              ),
              const SizedBox(width: AppConstants.p12),
              Text(
                l10n.performanceReview,
                style: AppTextStyle.h2.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class EmployeeHeroSection extends StatelessWidget {
  final String name;
  final String empId;
  final String department;
  final String status;

  const EmployeeHeroSection({
    super.key,
    required this.name,
    required this.empId,
    required this.department,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p20,
        vertical: AppConstants.p16,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.p20),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppConstants.r16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: AppConstants.p32,
              offset: const Offset(0, AppConstants.p12),
            ),
          ],
        ),
        child: BlocBuilder<SelfAssessmentCubit, SelfAssessmentState>(
          builder: (context, state) {
            final l10n = AppLocalizations.of(context)!;

            final dueDate = state.maybeWhen(
              success: (details) =>
                  details.modified.format(AppConstants.dateDisplayFormat),
              orElse: () => '--/--/--',
            );

            final managerProgress = state.maybeWhen(
              success: (details) {
                final total = details.goalReviews.length;
                final answered = details.goalReviews
                    .where(
                      (e) =>
                          e.managerComment.trim().isNotEmpty ||
                          e.managerRating.trim().isNotEmpty,
                    )
                    .length;
                final percentage = total > 0
                    ? (answered / total * 100).round()
                    : 0;
                return '$percentage% ($answered/$total)';
              },
              orElse: () => '0% (0/0)',
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.employeeDetails.toUpperCase(),
                            style: AppTextStyle.labelSmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: AppConstants.p4),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: name,
                                  style: AppTextStyle.h2.copyWith(
                                    color: AppColors.onSurface,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ($empId)',
                                  style: AppTextStyle.bodyLarge.copyWith(
                                    color: AppColors.onSurfaceVariant,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppConstants.p4),
                          Text(
                            department,
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: AppColors.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.p12,
                        vertical: AppConstants.p4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(AppConstants.full),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: AppTextStyle.labelSmall.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.p24),
                Row(
                  children: [
                    HeroMetric(
                      icon: Icons.calendar_today_outlined,
                      label: l10n.dueDate.toUpperCase(),
                      value: dueDate,
                    ),
                    const SizedBox(width: AppConstants.p16),
                    HeroMetric(
                      icon: Icons.rate_review_outlined,
                      label: l10n.reviewProgress.toUpperCase(),
                      value: managerProgress,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class HeroMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const HeroMetric({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppConstants.p12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppConstants.r12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.p8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(
                  alpha: AppConstants.opacityVeryLow,
                ),
                borderRadius: BorderRadius.circular(AppConstants.r8),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: AppConstants.iconSmall,
              ),
            ),
            const SizedBox(width: AppConstants.p12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyle.labelSmall.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                      fontSize: AppConstants.p8,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: AppConstants.r2),
                  Text(
                    value,
                    style: AppTextStyle.labelMedium.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KraNavigation extends StatelessWidget {
  final String? selectedKra;
  final Function(String) onKraSelected;

  const KraNavigation({
    super.key,
    this.selectedKra,
    required this.onKraSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelfAssessmentCubit, SelfAssessmentState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        return state.maybeWhen(
          success: (details) {
            // Group weightages by KRA
            final kraWeightages = <String, double>{};
            for (var review in details.goalReviews) {
              kraWeightages.update(
                review.kras,
                (value) => value + review.weightage,
                ifAbsent: () => review.weightage,
              );
            }

            final kras = kraWeightages.keys.toList();
            if (details.attachments.isNotEmpty) {
              kras.add(l10n.supportingEvidence);
              kraWeightages[l10n.supportingEvidence] = 0.0;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.p24,
                    vertical: AppConstants.p8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.goalsAndKras,
                        style: AppTextStyle.h3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppConstants.p100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.p20,
                    ),
                    itemCount: kras.length,
                    itemBuilder: (context, index) {
                      final kra = kras[index];
                      final weightage = kraWeightages[kra]!;
                      return KraCard(
                        label: kra,
                        weightage: weightage.toInt().toString(),
                        isActive: kra == selectedKra,
                        onTap: () => onKraSelected(kra),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          orElse: () => const KraNavigationSkeleton(),
        );
      },
    );
  }
}

class KraCard extends StatelessWidget {
  final String label;
  final String weightage;
  final bool isActive;
  final VoidCallback onTap;

  const KraCard({
    super.key,
    required this.label,
    required this.weightage,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppConstants.p140 + AppConstants.p20, // 160
        margin: const EdgeInsets.only(
          right: AppConstants.p12,
          bottom: AppConstants.p8,
        ),
        padding: const EdgeInsets.all(AppConstants.p16),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary
              : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppConstants.r16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: AppConstants.r10,
              offset: const Offset(0, AppConstants.p4),
            ),
          ],
          border: isActive
              ? null
              : Border.all(
                  color: AppColors.outlineVariant.withValues(alpha: 0.2),
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.weightageText(weightage),
              style: AppTextStyle.labelSmall.copyWith(
                color: isActive
                    ? AppColors.white.withValues(alpha: 0.8)
                    : AppColors.onSurfaceVariant,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.p4),
            Text(
              label,
              style: AppTextStyle.labelMedium.copyWith(
                color: isActive ? AppColors.white : AppColors.onSurface,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class DetailedReviewSection extends StatelessWidget {
  final String? selectedKra;
  const DetailedReviewSection({super.key, this.selectedKra});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<SelfAssessmentCubit, SelfAssessmentState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const DetailedReviewSkeleton(),
          success: (details) {
            // Group goals by KRA
            final kraGroups = <String, List<GoalReviewEntity>>{};
            for (var review in details.goalReviews) {
              if (selectedKra != null && review.kras != selectedKra) continue;
              kraGroups.putIfAbsent(review.kras, () => []).add(review);
            }

            if (selectedKra == l10n.supportingEvidence) {
              return Padding(
                padding: const EdgeInsets.all(AppConstants.p20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.attachedDocuments,
                      style: AppTextStyle.h3.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.p16),
                    ...details.attachments.map(
                      (file) => AttachedDocumentCard(file: file),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: kraGroups.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.p20,
                    vertical: AppConstants.p16,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: AppConstants.r4,
                            height: AppConstants.p24,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(
                                AppConstants.full,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppConstants.p8),
                          Expanded(
                            child: Text(
                              entry.key,
                              style: AppTextStyle.h3.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.p16),
                      ...entry.value.map(
                        (goalReview) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppConstants.p16,
                          ),
                          child: QuestionCard(
                            goalReview: goalReview,
                            employeeName: details.employeeName,
                            onChanged: (updatedGoal) {
                              context
                                  .read<SelfAssessmentCubit>()
                                  .updateLocalGoalFeedback(updatedGoal);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
          failure: (message) => Center(child: Text(message)),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class QuestionCard extends StatelessWidget {
  final GoalReviewEntity goalReview;
  final String employeeName;
  final Function(GoalReviewEntity)? onChanged;
  const QuestionCard({
    super.key,
    required this.goalReview,
    required this.employeeName,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
          title: Text(
            goalReview.goal,
            style: AppTextStyle.labelMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p12,
              vertical: AppConstants.p4,
            ),
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppConstants.full),
            ),
            child: Text(
              '${l10n.total}: 100%',
              style: AppTextStyle.labelSmall.copyWith(
                color: AppColors.onSecondaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          children: [
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(AppConstants.p20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelfAssessmentSection(
                    rating:
                        int.tryParse(goalReview.selfRating.split(' ')[0]) ?? 0,
                    comment: goalReview.employeeComment.isNotEmpty
                        ? goalReview.employeeComment
                        : goalReview.selfComment,
                    achievement: goalReview.achieved > 0
                        ? goalReview.achieved
                        : goalReview.progress,
                    employeeName: employeeName,
                  ),
                  const SizedBox(height: AppConstants.p24),
                  ManagerFeedbackSection(
                    initialRating:
                        int.tryParse(goalReview.managerRating.split(' ')[0]) ??
                        0,
                    initialAchievement: goalReview.managerPercentage,
                    initialComment: goalReview.managerComment,
                    onChanged: (rating, achievement, comment) {
                      final updatedGoal = goalReview.copyWith(
                        managerRating:
                            "$rating - ${rating == 1
                                ? l10n.needsImprovement
                                : rating == 2
                                ? l10n.belowExpectations
                                : rating == 3
                                ? l10n.meetsExpectations
                                : l10n.exceedsExpectations}",
                        managerPercentage: achievement,
                        managerComment: comment,
                      );
                      onChanged?.call(updatedGoal);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelfAssessmentSection extends StatelessWidget {
  final int rating;
  final String comment;
  final double achievement;
  final String employeeName;

  const SelfAssessmentSection({
    super.key,
    required this.rating,
    required this.comment,
    required this.achievement,
    required this.employeeName,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.selfAssessment,
          style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppConstants.p20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.rating,
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConstants.p12),
                RatingRow(selectedRating: rating, isEditable: false),
              ],
            ),
            const SizedBox(height: AppConstants.p24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.achievementPercent,
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConstants.p12),
                AchievementSlider(
                  value: achievement,
                  isEditable: false,
                  rating: rating,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppConstants.p20),
        Text(
          l10n.elaborateRatingHint,
          style: AppTextStyle.labelSmall.copyWith(
            color: AppColors.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.p8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.p16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppConstants.r12),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            comment.isEmpty ? l10n.noCommentProvided : comment,
            style: AppTextStyle.bodySmall.copyWith(color: AppColors.onSurface),
          ),
        ),
        const SizedBox(height: AppConstants.p12),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            l10n.answeredBy('Sameeruddin Shaik'),
            style: AppTextStyle.labelSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class ManagerFeedbackSection extends StatefulWidget {
  final int initialRating;
  final double initialAchievement;
  final String initialComment;
  final Function(int rating, double achievement, String comment)? onChanged;

  const ManagerFeedbackSection({
    super.key,
    this.initialRating = 0,
    this.initialAchievement = 0.0,
    this.initialComment = '',
    this.onChanged,
  });

  @override
  State<ManagerFeedbackSection> createState() => _ManagerFeedbackSectionState();
}

class _ManagerFeedbackSectionState extends State<ManagerFeedbackSection> {
  late int _selectedRating;
  late double _currentAchievement;
  late final TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _selectedRating = widget.initialRating;
    _currentAchievement = widget.initialAchievement;
    _commentController = TextEditingController(text: widget.initialComment);

    _commentController.addListener(_notifyChanged);
  }

  void _notifyChanged() {
    widget.onChanged?.call(
      _selectedRating,
      _currentAchievement,
      _commentController.text,
    );
  }

  @override
  void dispose() {
    _commentController.removeListener(_notifyChanged);
    _commentController.dispose();
    super.dispose();
  }

  void _onRatingChanged(int rating) {
    setState(() {
      _selectedRating = rating;
      // Reset achievement to min value of the new range
      if (rating == 1) {
        _currentAchievement = PerformanceRatingRanges.r1Min;
      } else if (rating == 2) {
        _currentAchievement = PerformanceRatingRanges.r2Min;
      } else if (rating == 3) {
        _currentAchievement = PerformanceRatingRanges.r3Min;
      } else if (rating == 4) {
        _currentAchievement = PerformanceRatingRanges.r4Min;
      }
      _notifyChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p16,
              vertical: AppConstants.p12,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppConstants.r12),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 18,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppConstants.p8),
                Text(
                  l10n.feedback,
                  style: AppTextStyle.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                // const Spacer(),
                // const Icon(
                //   Icons.expand_less,
                //   size: 20,
                //   color: AppColors.onSurfaceVariant,
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.manager,
                      style: AppTextStyle.labelSmall.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text(
                    //   widget.initialComment.isNotEmpty
                    //     ? 'Updated' // Or show some indicator
                    //     : l10n.processing,
                    //   style: AppTextStyle.labelSmall.copyWith(
                    //     color: AppColors.onSurfaceVariant,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: AppConstants.p20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.rating,
                      style: AppTextStyle.labelSmall.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.p12),
                    RatingRow(
                      selectedRating: _selectedRating,
                      isEditable: true,
                      onRatingChanged: _onRatingChanged,
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.p24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.achievementPercent,
                      style: AppTextStyle.labelSmall.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.p12),
                    if (_selectedRating == 0)
                      const RatingAchievementHint()
                    else
                      AchievementSlider(
                        value: _currentAchievement,
                        isEditable: true,
                        rating: _selectedRating,
                      ),
                  ],
                ),
                const SizedBox(height: AppConstants.p24),
                Text(
                  l10n.describeMore,
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConstants.p8),
                TextField(
                  controller: _commentController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: l10n.describeMoreHint,
                    filled: true,
                    fillColor: AppColors.surfaceContainerHighest.withValues(
                      alpha: 0.1,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.r12),
                      borderSide: BorderSide(
                        color: AppColors.outlineVariant.withValues(alpha: 0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.r12),
                      borderSide: BorderSide(
                        color: AppColors.outlineVariant.withValues(alpha: 0.3),
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(AppConstants.p16),
                  ),
                  style: AppTextStyle.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RatingRow extends StatefulWidget {
  final int selectedRating;
  final bool isEditable;
  final ValueChanged<int>? onRatingChanged;

  const RatingRow({
    super.key,
    required this.selectedRating,
    this.isEditable = true,
    this.onRatingChanged,
  });

  @override
  State<RatingRow> createState() => _RatingRowState();
}

class _RatingRowState extends State<RatingRow> {
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.selectedRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        final rating = index + 1;
        final isActive = rating == _currentRating;
        return GestureDetector(
          onTap: widget.isEditable
              ? () {
                  setState(() => _currentRating = rating);
                  widget.onRatingChanged?.call(rating);
                }
              : null,
          child: Container(
            width: AppConstants.p40 + AppConstants.p10, // 50
            height: AppConstants.p40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppConstants.r8),
              border: isActive
                  ? null
                  : Border.all(
                      color: AppColors.outlineVariant.withValues(alpha: 0.3),
                    ),
            ),
            child: Text(
              '$rating',
              style: AppTextStyle.labelMedium.copyWith(
                color: isActive ? AppColors.white : AppColors.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class AchievementSlider extends StatefulWidget {
  final double value;
  final bool isEditable;
  final int rating;

  const AchievementSlider({
    super.key,
    required this.value,
    required this.rating,
    this.isEditable = true,
  });

  @override
  State<AchievementSlider> createState() => _AchievementSliderState();
}

class _AchievementSliderState extends State<AchievementSlider> {
  late double _currentValue;

  double get minVal {
    if (widget.rating == 1) return PerformanceRatingRanges.r1Min;
    if (widget.rating == 2) return PerformanceRatingRanges.r2Min;
    if (widget.rating == 3) return PerformanceRatingRanges.r3Min;
    if (widget.rating == 4) return PerformanceRatingRanges.r4Min;
    return 0;
  }

  double get maxVal {
    if (widget.rating == 1) return PerformanceRatingRanges.r1Max;
    if (widget.rating == 2) return PerformanceRatingRanges.r2Max;
    if (widget.rating == 3) return PerformanceRatingRanges.r3Max;
    if (widget.rating == 4) return PerformanceRatingRanges.r4Max;
    return 100;
  }

  List<double> get steps {
    if (widget.rating == 1) return PerformanceRatingRanges.r1Steps;
    if (widget.rating == 2) return PerformanceRatingRanges.r2Steps;
    if (widget.rating == 3) return PerformanceRatingRanges.r3Steps;
    if (widget.rating == 4) return PerformanceRatingRanges.r4Steps;
    return PerformanceRatingRanges.defaultSteps;
  }

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(AchievementSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rating != widget.rating) {
      _currentValue = minVal;
    } else if (oldWidget.value != widget.value) {
      _currentValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: AppConstants.r8,
            ),
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: AppConstants.r16,
            ),
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.outlineVariant.withValues(alpha: 0.3),
            thumbColor: AppColors.primary,
          ),
          child: Slider(
            value: _currentValue.clamp(minVal, maxVal),
            min: minVal,
            max: maxVal,
            divisions: steps.length - 1,
            onChanged: widget.isEditable
                ? (val) => setState(() => _currentValue = val)
                : null,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: steps
              .map(
                (s) => Text(
                  '${s.toInt()}%',
                  style: AppTextStyle.labelSmall.copyWith(
                    color: s == _currentValue
                        ? AppColors.primary
                        : AppColors.onSurfaceVariant,
                    fontSize: AppConstants.p8,
                    fontWeight: s == _currentValue
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<SelfAssessmentCubit, SelfAssessmentState>(
      builder: (context, state) {
        return state.maybeWhen(
          success: (details) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.p20,
                vertical: AppConstants.p16,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppConstants.r16),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppConstants.p20),
                      child: Row(
                        children: [
                          const Icon(Icons.history, color: AppColors.primary),
                          const SizedBox(width: AppConstants.p12),
                          Text(
                            l10n.reviewTimeline,
                            style: AppTextStyle.h3.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.expand_more,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppConstants.p32,
                        right: AppConstants.p20,
                        bottom: AppConstants.p20,
                      ),
                      child: Column(
                        children: List.generate(details.timeline.length, (
                          index,
                        ) {
                          final stage = details.timeline[index];
                          return TimelineItem(
                            title: stage.stageName,
                            date: stage.date.toString().split(
                              ' ',
                            )[0], // Simple format
                            status: stage.status,
                            isLast: index == details.timeline.length - 1,
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class TimelineItem extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final bool isLast;
  final bool isActive;

  const TimelineItem({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    this.isLast = false,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: AppConstants.p12,
                height: AppConstants.p12,
                decoration: BoxDecoration(
                  color: status == 'Completed'
                      ? AppColors.primary
                      : AppColors.surfaceContainerHighest,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: AppConstants.r2,
                    color: AppColors.primaryContainer.withValues(alpha: 0.3),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppConstants.p16),
          Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.p24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: AppTextStyle.labelSmall.copyWith(
                    color: status == 'Completed'
                        ? AppColors.primary
                        : AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title,
                  style: AppTextStyle.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.onSurfaceVariant,
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


class ReviewFooter extends StatelessWidget {
  final String status;
  const ReviewFooter({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<SelfAssessmentCubit, SelfAssessmentState>(
      listener: (context, state) {
        state.maybeWhen(
          saveSuccess: (_) {
            ToastUtils.showSuccess(l10n.managerFeedbackSaved);
          },
          submitSuccess: (_) {
            ToastUtils.showSuccess(l10n.feedbackSubmitted);
          },
          failure: (message) {
            ToastUtils.showError(message);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final isSaving = state.maybeWhen(
          saving: (_) => true,
          submitting: (_) => true,
          orElse: () => false,
        );
        final isSubmitting = state.maybeWhen(
          submitting: (_) => true,
          orElse: () => false,
        );

        return Container(
          padding: const EdgeInsets.all(AppConstants.p20),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.8),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.06),
                blurRadius: AppConstants.p32,
                offset: const Offset(0, -AppConstants.p12),
              ),
            ],
          ),
          child: status.toLowerCase() == 'submitted'
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.p16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.successBg, // Light green
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                    border: Border.all(color: AppColors.successBorder),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: AppColors.success, // Dark green
                        size: AppConstants.iconXSmall,
                      ),
                      const SizedBox(width: AppConstants.p8),
                      Text(
                        l10n.feedbackSubmitted,
                        style: AppTextStyle.labelLarge.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: isSaving
                            ? null
                            : () {
                                state.maybeWhen(
                                  success: (details) => _save(context, details),
                                  saveSuccess: (details) =>
                                      _save(context, details),
                                  orElse: () {},
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryContainer,
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppConstants.p16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppConstants.r12,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          isSaving && !isSubmitting
                              ? l10n.saving
                              : l10n.save,
                          style: AppTextStyle.labelMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppConstants.p16),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.primaryContainer,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(AppConstants.r12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.2),
                              blurRadius: AppConstants.r20,
                              offset: const Offset(0, AppConstants.p10),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: isSaving
                              ? null
                              : () {
                                  state.maybeWhen(
                                    success: (details) =>
                                        _showSubmitDialog(context, details),
                                    saveSuccess: (details) =>
                                        _showSubmitDialog(context, details),
                                    orElse: () {},
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.transparent,
                            foregroundColor: AppColors.white,
                            shadowColor: AppColors.transparent,
                            padding: const EdgeInsets.symmetric(
                              vertical: AppConstants.p16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstants.r12,
                              ),
                            ),
                          ),
                          child: Text(
                            isSubmitting ? l10n.submitting : l10n.submitReview,
                            style: AppTextStyle.labelMedium.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  void _showSubmitDialog(BuildContext context, SelfAssessmentEntity details) {
    showDialog(
      context: context,
      builder: (innerContext) => SubmitFeedbackDialog(
        onConfirm: () {
          _save(context, details, isSubmit: true);
        },
      ),
    );
  }

  void _save(BuildContext context, SelfAssessmentEntity details,
      {bool isSubmit = false}) {
    final goalRatings = details.goalReviews.map((goal) {
      return {
        "name": goal.name,
        "goal": goal.goal,
        "weightage": goal.weightage,
        "target": goal.target,
        "achieved": goal.achieved,
        "self_rating": goal.selfRating,
        "employee_comment": goal.employeeComment,
        "manager_rating": goal.managerRating,
        "manager_percentage": goal.managerPercentage,
        "manager_comment": goal.managerComment,
        "weighted_score": goal.weightedScore,
        "parent": details.name,
        "parentfield": "goal_ratings",
        "parenttype": "PMS Evaluation",
        "doctype": "Goal Ratings",
        "docstatus": isSubmit ? 1 : 0,
      };
    }).toList();

    if (isSubmit) {
      context.read<SelfAssessmentCubit>().submitEvaluation(details.name, {
        "docstatus": 1,
        "goal_ratings": goalRatings,
      });
    } else {
      context.read<SelfAssessmentCubit>().updateEvaluation(details.name, {
        "docstatus": 0,
        "goal_ratings": goalRatings,
      });
    }
  }
}

class DetailedReviewSkeleton extends StatelessWidget {
  const DetailedReviewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Column(
        children: List.generate(
          2,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p20,
              vertical: AppConstants.p16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: AppConstants.r4,
                      height: AppConstants.p24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppConstants.full),
                      ),
                    ),
                    const SizedBox(width: AppConstants.p8),
                    Container(
                      width: AppConstants.p150,
                      height: AppConstants.p20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppConstants.r4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.p16),
                Container(
                  width: double.infinity,
                  height: AppConstants.p120,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppConstants.r16),
                  ),
                ),
                const SizedBox(height: AppConstants.p16),
                Container(
                  width: double.infinity,
                  height: AppConstants.p120,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppConstants.r16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KraNavigationSkeleton extends StatelessWidget {
  const KraNavigationSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p24,
              vertical: AppConstants.p8,
            ),
            child: Container(
              width: AppConstants.p120,
              height: AppConstants.p20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppConstants.r4),
              ),
            ),
          ),
          SizedBox(
            height: AppConstants.p100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20),
              itemCount: 3,
              itemBuilder: (context, index) => Container(
                width: AppConstants.p140 + AppConstants.p20, // 160
                margin: const EdgeInsets.only(
                  right: AppConstants.p12,
                  bottom: AppConstants.p8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppConstants.r16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AttachedDocumentCard extends StatelessWidget {
  final FileAttachmentEntity file;

  const AttachedDocumentCard({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.p12),
      padding: const EdgeInsets.all(AppConstants.p12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.p8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(
                alpha: AppConstants.opacityVeryLow,
              ),
              borderRadius: BorderRadius.circular(AppConstants.r8),
            ),
            child: const Icon(
              Icons.insert_drive_file_outlined,
              color: AppColors.primary,
              size: AppConstants.iconXSmall,
            ),
          ),
          const SizedBox(width: AppConstants.p12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.fileName,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.attachedToManagerReview,
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              // final baseUrl = GetIt.I<DioClient>().baseUrl;
              // final fullUrl = baseUrl + file.fileUrl;
              // final uri = Uri.parse(fullUrl);
              // if (await canLaunchUrl(uri)) {
              //   await launchUrl(uri, mode: LaunchMode.externalApplication);
              // }
            },
            icon: const Icon(
              Icons.visibility_outlined,
              color: AppColors.primary,
              size: AppConstants.iconXSmall,
            ),
          ),
        ],
      ),
    );
  }
}

class RatingAchievementHint extends StatelessWidget {
  const RatingAchievementHint({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.selectRatingToEnableAchievement,
            style: AppTextStyle.labelMedium.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.p12),
          FittedBox(
            child: Row(
              children: [
                _RangeItem(label: l10n.rating1Range),
                _Divider(),
                _RangeItem(label: l10n.rating2Range),
                _Divider(),
                _RangeItem(label: l10n.rating3Range),
                _Divider(),
                _RangeItem(label: l10n.rating4Range),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RangeItem extends StatelessWidget {
  final String label;
  const _RangeItem({required this.label});

  @override
  Widget build(BuildContext context) {
    final parts = label.split(':');
    if (parts.length < 2) return Text(label);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${parts[0]}:',
            style: AppTextStyle.labelMedium.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: parts[1],
            style: AppTextStyle.labelMedium.copyWith(
              color: AppColors.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p12),
      child: Container(
        width: 1,
        height: 14,
        color: AppColors.outlineVariant,
      ),
    );
  }
}


