import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SelfAssessmentTimelineSection extends StatefulWidget {
  final List<TimelineStageEntity> timeline;

  const SelfAssessmentTimelineSection({super.key, required this.timeline});

  @override
  State<SelfAssessmentTimelineSection> createState() =>
      _SelfAssessmentTimelineSectionState();
}

class _SelfAssessmentTimelineSectionState
    extends State<SelfAssessmentTimelineSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.of(context).surfaceContainerHigh),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(AppConstants.r12),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.p16),
              child: Row(
                children: [
                  Icon(
                    Icons.timeline_outlined,
                    color: AppColors.of(context).primary,
                  ),
                  const SizedBox(width: AppConstants.p12),
                  Expanded(
                    child: Text(
                      l10n.timelineLabel,
                      style: AppTextStyle.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.of(context).onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded) ...[
            Divider(
              height: 1.h,
              color: AppColors.of(context).surfaceContainerHigh,
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.p16),
              child: _TimelineList(timeline: widget.timeline),
            ),
          ],
        ],
      ),
    );
  }
}

class _TimelineList extends StatelessWidget {
  final List<TimelineStageEntity> timeline;

  const _TimelineList({required this.timeline});

  @override
  Widget build(BuildContext context) {
    if (timeline.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.noDataAvailable));
    }

    return Column(
      children: timeline.map((stage) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.p12),
          child: _TimelineStageCard(stage: stage),
        );
      }).toList(),
    );
  }
}

class _TimelineStageCard extends StatelessWidget {
  final TimelineStageEntity stage;

  const _TimelineStageCard({required this.stage});

  @override
  Widget build(BuildContext context) {
    final isCompleted = stage.status.toLowerCase() == 'completed';

    return Container(
      padding: const EdgeInsets.all(AppConstants.p12),
      decoration: BoxDecoration(
        color: AppColors.of(context).background,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.of(context).surfaceContainerHigh),
      ),
      child: Row(
        children: [
          Container(
            width: AppConstants.p32,
            height: AppConstants.p32,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.of(context).successBg
                  : AppColors.of(context).infoBg,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                isCompleted ? Icons.check : Icons.schedule,
                size: AppConstants.iconSmall,
                color: isCompleted
                    ? AppColors.of(context).successDark
                    : AppColors.of(context).info,
              ),
            ),
          ),
          const SizedBox(width: AppConstants.p12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stage.stageName,
                  style: AppTextStyle.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.of(context).onSurface,
                  ),
                ),
                Text(
                  stage.date.toIso8601String().split('T')[0],
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.of(context).onSurfaceVariant,
                    fontSize: AppConstants.fs10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding:       EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.of(context).successBg
                  : AppColors.of(context).surfaceContainerHigh,
              borderRadius: BorderRadius.circular(AppConstants.r32),
              border: Border.all(
                color: isCompleted
                    ? AppColors.of(context).successBorder
                    : AppColors.of(context).outlineVariant,
              ),
            ),
            child: Text(
              stage.status,
              style: AppTextStyle.labelSmall.copyWith(
                color: isCompleted
                    ? AppColors.of(context).successDark
                    : AppColors.of(context).onSurfaceVariant,
                fontWeight: FontWeight.bold,
                fontSize: AppConstants.fs10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
