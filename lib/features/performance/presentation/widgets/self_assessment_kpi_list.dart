import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';
import 'package:dhira_hrms/features/performance/presentation/widgets/self_assessment_view_helpers.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class KpiList extends StatelessWidget {
  final List<GoalReviewEntity> goals;
  final bool isEditable;
  final Function(GoalReviewEntity) onGoalChanged;

  const KpiList({
    required this.goals,
    required this.isEditable,
    required this.onGoalChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (goals.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.noDataAvailable));
    }

    return Column(
      children: goals.map((goal) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.p12),
          child: KpiItem(
            goal: goal,
            isEditable: isEditable,
            onChanged: onGoalChanged,
          ),
        );
      }).toList(),
    );
  }
}

class KpiItem extends StatefulWidget {
  final GoalReviewEntity goal;
  final bool isEditable;
  final Function(GoalReviewEntity) onChanged;

  const KpiItem({
    required this.goal,
    required this.isEditable,
    required this.onChanged,
  });

  @override
  State<KpiItem> createState() => KpiItemState();
}

class KpiItemState extends State<KpiItem> {
  bool _expanded = false;
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController(text: widget.goal.selfComment);
  }

  @override
  void didUpdateWidget(KpiItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.goal.selfComment != widget.goal.selfComment &&
        _commentController.text != widget.goal.selfComment) {
      _commentController.text = widget.goal.selfComment;
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _updateGoal({
    String? selfRating,
    double? progress,
    String? selfComment,
  }) {
    if (!widget.isEditable) return;

    String finalRating = selfRating ?? widget.goal.selfRating;
    double finalProgress = progress ?? widget.goal.progress;

    final ratingInt = SelfAssessmentViewHelpers.parseRating(
      finalRating,
    ).toInt();
    final values = SelfAssessmentViewHelpers.progressValues(ratingInt);
    final minVal = values.first;
    final maxVal = values.last;

    if (selfRating != null &&
        (finalProgress < minVal || finalProgress > maxVal)) {
      finalProgress = minVal;
    }

    widget.onChanged(
      widget.goal.copyWith(
        selfRating: finalRating,
        progress: finalProgress.clamp(minVal, maxVal),
        selfComment: selfComment ?? widget.goal.selfComment,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.surfaceContainerHigh),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(AppConstants.r12),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.p12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.goal.goal,
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(AppConstants.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.selfRatingLabel,
                    style: AppTextStyle.labelSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.p8),
                  Row(
                    children: List.generate(4, (index) {
                      final val = index + 1;
                      final currentRating =
                          SelfAssessmentViewHelpers.parseRating(
                            widget.goal.selfRating,
                          );
                      final isSelected = currentRating == val;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.p4,
                          ),
                          child: InkWell(
                            onTap: widget.isEditable
                                ? () => _updateGoal(selfRating: val.toString())
                                : null,
                            child: Container(
                              height: AppConstants.p40,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.surfaceContainerLowest,
                                borderRadius: BorderRadius.circular(
                                  AppConstants.r8,
                                ),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.outlineVariant,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '$val',
                                  style: AppTextStyle.bodyMedium.copyWith(
                                    color: isSelected
                                        ? AppColors.onPrimary
                                        : AppColors.onSurface,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: AppConstants.p16),
                  if (SelfAssessmentViewHelpers.parseRating(
                        widget.goal.selfRating,
                      ) ==
                      0)
                    Container(
                      padding: const EdgeInsets.all(AppConstants.p12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(AppConstants.r8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.selectRatingToEnableAchievement,
                            style: AppTextStyle.bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.onSurface,
                            ),
                          ),
                          const SizedBox(height: AppConstants.p8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              RatingHint(rating: AppConstants.rating1),
                              RatingHint(rating: AppConstants.rating2),
                              RatingHint(rating: AppConstants.rating3),
                              RatingHint(rating: AppConstants.rating4),
                            ],
                          ),
                        ],
                      ),
                    )
                  else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.achievementLabel,
                          style: AppTextStyle.labelSmall.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          l10n.achievementPercentLabel(
                            widget.goal.progress.toInt().toString(),
                          ),
                          style: AppTextStyle.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: AppConstants.p4,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: AppConstants.r8,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: AppConstants.p16,
                        ),
                      ),
                      child: Builder(
                        builder: (context) {
                          final rating = SelfAssessmentViewHelpers.parseRating(
                            widget.goal.selfRating,
                          ).toInt();
                          final values =
                              SelfAssessmentViewHelpers.progressValues(rating);
                          final double minVal = values.first;
                          final double maxVal = values.last;

                          return Column(
                            children: [
                              Slider(
                                value: widget.goal.progress.clamp(
                                  minVal,
                                  maxVal,
                                ),
                                min: minVal,
                                max: maxVal,
                                onChanged: widget.isEditable
                                    ? (val) {
                                        _updateGoal(progress: val);
                                      }
                                    : null,
                                activeColor: AppColors.primary,
                                inactiveColor: AppColors.surfaceContainerHigh,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppConstants.p12,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: values
                                      .map(
                                        (v) => Text(
                                          '${v.toInt()}%',
                                          style: AppTextStyle.labelSmall
                                              .copyWith(
                                                color:
                                                    AppColors.onSurfaceVariant,
                                                fontSize: AppConstants.fs10,
                                              ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                  const SizedBox(height: AppConstants.p16),
                  Text(
                    l10n.reflectionAndImpactLabel,
                    style: AppTextStyle.labelSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.p8),
                  TextField(
                    controller: _commentController,
                    maxLines: 4,
                    style: AppTextStyle.bodySmall,
                    enabled: widget.isEditable,
                    onChanged: (val) => _updateGoal(selfComment: val),
                    decoration: InputDecoration(
                      hintText: l10n.reflectionPlaceholder,
                      hintStyle: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.outline,
                      ),
                      fillColor: AppColors.surfaceContainerLowest,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.r8),
                        borderSide: const BorderSide(
                          color: AppColors.outlineVariant,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.r8),
                        borderSide: const BorderSide(
                          color: AppColors.outlineVariant,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.r8),
                        borderSide: BorderSide(
                          color: AppColors.outlineVariant.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class RatingHint extends StatelessWidget {
  final String rating;

  const RatingHint({required this.rating});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String range = '';
    switch (rating) {
      case AppConstants.rating1:
        range = l10n.rating1Range;
        break;
      case AppConstants.rating2:
        range = l10n.rating2Range;
        break;
      case AppConstants.rating3:
        range = l10n.rating3Range;
        break;
      case AppConstants.rating4:
        range = l10n.rating4Range;
        break;
    }

    return Row(
      children: [
        Text(
          range,
          style: AppTextStyle.labelSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        if (rating != AppConstants.rating4)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.p8),
            child: Container(
              height: AppConstants.p12,
              width: 1,
              color: AppColors.outlineVariant,
            ),
          ),
      ],
    );
  }
}
