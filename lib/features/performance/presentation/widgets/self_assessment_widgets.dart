import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class SelfAssessmentEmployeeCard extends StatelessWidget {
  final String name;
  final String employeeId;
  final String department;
  final String dueDate;
  final double progress;
  final String progressItems;

  const SelfAssessmentEmployeeCard({
    super.key,
    required this.name,
    required this.employeeId,
    required this.department,
    required this.dueDate,
    required this.progress,
    required this.progressItems,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.surfaceContainerHigh),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 4,
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
                      name,
                      style: AppTextStyle.h3Bold.copyWith(
                        color: AppColors.onSurface,
                        fontSize: AppConstants.fs20,
                      ),
                    ),
                    const SizedBox(height: AppConstants.p4),
                    Text(
                      'ID: $employeeId | Dept: $department',
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.onSurfaceVariant,
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
                      color: AppColors.outline,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    dueDate,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.primary,
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
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}% ($progressItems)',
                    style: AppTextStyle.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.p8),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.r32),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: AppColors.surfaceContainerHigh,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SelfAssessmentAssessmentSection extends StatefulWidget {
  final List<String> kras;
  final int selectedKraIndex;
  final Function(int) onKraSelected;

  const SelfAssessmentAssessmentSection({
    super.key,
    required this.kras,
    required this.selectedKraIndex,
    required this.onKraSelected,
  });

  @override
  State<SelfAssessmentAssessmentSection> createState() => _SelfAssessmentAssessmentSectionState();
}

class _SelfAssessmentAssessmentSectionState extends State<SelfAssessmentAssessmentSection> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.surfaceContainerHigh),
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
                  const Icon(Icons.fact_check_outlined, color: AppColors.primary),
                  const SizedBox(width: AppConstants.p12),
                  Expanded(
                    child: Text(
                      l10n.assessmentLabel,
                      style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded) ...[
            const Divider(height: 1, color: AppColors.surfaceContainerHigh),
            Padding(
              padding: const EdgeInsets.all(AppConstants.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(widget.kras.length, (index) {
                        final isSelected = widget.selectedKraIndex == index;
                        return Padding(
                          padding: const EdgeInsets.only(right: AppConstants.p8),
                          child: ChoiceChip(
                            label: Text(widget.kras[index]),
                            selected: isSelected,
                            onSelected: (_) => widget.onKraSelected(index),
                            selectedColor: AppColors.primary,
                            backgroundColor: AppColors.surfaceContainerLow,
                            labelStyle: AppTextStyle.labelSmall.copyWith(
                              color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppConstants.r32),
                              side: BorderSide(
                                color: isSelected ? AppColors.primary : AppColors.outlineVariant,
                              ),
                            ),
                            showCheckmark: false,
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: AppConstants.p16),
                  _KpiList(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _KpiList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _KpiItem(
          title: 'Quality of Work (Code, Design, Implementation)',
          subtitle: 'Code, Design, & Implementation',
          isExpanded: true,
        ),
        const SizedBox(height: AppConstants.p12),
        _KpiItem(
          title: 'Drive a robust and fair performance culture',
          subtitle: 'KPI Description',
          isExpanded: false,
        ),
        const SizedBox(height: AppConstants.p12),
        _KpiItem(
          title: 'Maintain healthy employee relations and workplace discipline',
          subtitle: 'KPI Description',
          isExpanded: false,
        ),
      ],
    );
  }
}

class _KpiItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool isExpanded;

  const _KpiItem({
    required this.title,
    required this.subtitle,
    this.isExpanded = false,
  });

  @override
  State<_KpiItem> createState() => _KpiItemState();
}

class _KpiItemState extends State<_KpiItem> {
  late bool _expanded;
  double _rating = 3;
  double _percentage = 85;

  @override
  void initState() {
    super.initState();
    _expanded = widget.isExpanded;
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
                          widget.title,
                          style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.subtitle,
                          style: AppTextStyle.labelSmall.copyWith(color: AppColors.onSurfaceVariant),
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
                  // Self Rating
                  Text(
                    l10n.selfRatingLabel,
                    style: AppTextStyle.labelSmall.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: AppConstants.p8),
                  Row(
                    children: List.generate(5, (index) {
                      final val = index + 1;
                      final isSelected = _rating == val;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: InkWell(
                            onTap: () => setState(() => _rating = val.toDouble()),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary : AppColors.surfaceContainerLowest,
                                borderRadius: BorderRadius.circular(AppConstants.r8),
                                border: Border.all(
                                  color: isSelected ? AppColors.primary : AppColors.outlineVariant,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '$val',
                                  style: AppTextStyle.bodyMedium.copyWith(
                                    color: isSelected ? AppColors.onPrimary : AppColors.onSurface,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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

                  // Percentage Slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Percentage Slider', // Hardcoded as per design or use l10n
                        style: AppTextStyle.labelSmall.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${_percentage.toInt()}%',
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                    ),
                    child: Slider(
                      value: _percentage,
                      min: 0,
                      max: 100,
                      onChanged: (val) => setState(() => _percentage = val),
                      activeColor: AppColors.primary,
                      inactiveColor: AppColors.surfaceContainerHigh,
                    ),
                  ),
                  const SizedBox(height: AppConstants.p16),

                  // Reflection
                  Text(
                    l10n.reflectionAndImpactLabel,
                    style: AppTextStyle.labelSmall.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: AppConstants.p8),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: l10n.reflectionPlaceholder,
                      hintStyle: AppTextStyle.bodySmall.copyWith(color: AppColors.outline),
                      fillColor: AppColors.surfaceContainerLowest,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.r8),
                        borderSide: const BorderSide(color: AppColors.outlineVariant),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.r8),
                        borderSide: const BorderSide(color: AppColors.outlineVariant),
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

class SelfAssessmentTimelineSection extends StatefulWidget {
  const SelfAssessmentTimelineSection({super.key});

  @override
  State<SelfAssessmentTimelineSection> createState() => _SelfAssessmentTimelineSectionState();
}

class _SelfAssessmentTimelineSectionState extends State<SelfAssessmentTimelineSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.surfaceContainerHigh),
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
                  const Icon(Icons.timeline_outlined, color: AppColors.primary),
                  const SizedBox(width: AppConstants.p12),
                  Expanded(
                    child: Text(
                      l10n.timelineLabel,
                      style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(AppConstants.p16),
              child: Column(
                children: [
                  // Summary Card
                  Container(
                    padding: const EdgeInsets.all(AppConstants.p16),
                    decoration: BoxDecoration(
                      color: AppColors.successBg,
                      borderRadius: BorderRadius.circular(AppConstants.r12),
                      border: Border.all(color: AppColors.successBorder),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.completedLabel,
                              style: AppTextStyle.bodySmall.copyWith(
                                color: AppColors.successDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              l10n.questionsCountLabel(15, 15),
                              style: AppTextStyle.bodySmall.copyWith(
                                color: AppColors.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppConstants.p8),
                        Container(
                          height: 4,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.pmsSuccess,
                            borderRadius: BorderRadius.circular(AppConstants.r2),
                          ),
                        ),
                        const SizedBox(height: AppConstants.p12),
                        Text(
                          l10n.sessionSummaryLabel(4, 'April 3, 2026'),
                          style: AppTextStyle.labelSmall.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppConstants.p16),
                  const _TimelineList(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TimelineList extends StatelessWidget {
  const _TimelineList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TimelineSessionCard(
          session: 'S1',
          date: '25 Mar 2026',
          timeRange: '09:55 am - 10:48 am',
          completedCount: 5,
          isInitiallyExpanded: true,
          kpis: [
            _TimelineKpiData(
              index: 1,
              title: 'Quality of Work (Code, Design, Implementation)',
              tag: 'A - Q1',
              rating: '4 / 5',
              time: '10:14 am',
            ),
            _TimelineKpiData(
              index: 2,
              title: 'Problem-Solving & Debugging Skills',
              tag: 'A - Q2',
              rating: '3 / 5',
              time: '10:18 am',
            ),
            _TimelineKpiData(
              index: 4,
              title: 'Adherence to Coding Standards & Best Practices',
              tag: 'A - Q4',
              rating: '3 / 5',
              time: '10:23 am',
            ),
            _TimelineKpiData(
              index: 6,
              title: 'Communication & Clarity in Technical Discussions',
              tag: 'A - Q3',
              rating: '3 / 5',
              time: '10:35 am',
            ),
            _TimelineKpiData(
              index: 7,
              title: 'Cross-Team Collaboration & Knowledge Sharing',
              tag: 'B - Q7',
              rating: '3 / 5',
              time: '10:42 am',
            ),
          ],
        ),
        const SizedBox(height: AppConstants.p12),
        const _TimelineSessionCard(
          session: 'S2',
          date: '25 Mar 2026',
          timeRange: '03:15 pm - 03:30 pm',
          completedCount: 3,
        ),
        const SizedBox(height: AppConstants.p12),
        const _TimelineSessionCard(
          session: 'S3',
          date: '26 Mar 2026',
          timeRange: '10:25 am - 10:56 am',
          completedCount: 4,
        ),
        const SizedBox(height: AppConstants.p12),
        const _TimelineSessionCard(
          session: 'S4',
          date: '26 Mar 2026',
          timeRange: '12:35 pm - 1:30 pm',
          completedCount: 4,
        ),
      ],
    );
  }
}

class _TimelineKpiData {
  final int index;
  final String title;
  final String tag;
  final String rating;
  final String time;

  _TimelineKpiData({
    required this.index,
    required this.title,
    required this.tag,
    required this.rating,
    required this.time,
  });
}

class _TimelineSessionCard extends StatefulWidget {
  final String session;
  final String date;
  final String timeRange;
  final int completedCount;
  final bool isInitiallyExpanded;
  final List<_TimelineKpiData> kpis;

  const _TimelineSessionCard({
    required this.session,
    required this.date,
    required this.timeRange,
    required this.completedCount,
    this.isInitiallyExpanded = false,
    this.kpis = const [],
  });

  @override
  State<_TimelineSessionCard> createState() => _TimelineSessionCardState();
}

class _TimelineSessionCardState extends State<_TimelineSessionCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isInitiallyExpanded;
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
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(AppConstants.r12),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.p12),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: AppColors.infoBg,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        widget.session,
                        style: AppTextStyle.labelSmall.copyWith(
                          color: AppColors.info,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppConstants.p12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.date,
                          style: AppTextStyle.bodySmall.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                        Text(
                          widget.timeRange,
                          style: AppTextStyle.labelSmall.copyWith(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.successBg,
                      borderRadius: BorderRadius.circular(AppConstants.r32),
                      border: Border.all(color: AppColors.successBorder),
                    ),
                    child: Text(
                      l10n.progressCount(widget.completedCount),
                      style: AppTextStyle.labelSmall.copyWith(
                        color: AppColors.successDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppConstants.p8),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.onSurfaceVariant,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded && widget.kpis.isNotEmpty) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppConstants.p8),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.kpis.length,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppConstants.p16),
                  child: Divider(height: 1, thickness: 0.5),
                ),
                itemBuilder: (context, index) {
                  final kpi = widget.kpis[index];
                  return _TimelineKpiItem(kpi: kpi);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TimelineKpiItem extends StatelessWidget {
  final _TimelineKpiData kpi;

  const _TimelineKpiItem({required this.kpi});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.p12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.successBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.successBorder),
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.success,
                  size: 14,
                ),
              ),
              const SizedBox(width: AppConstants.p8),
              Expanded(
                child: Text(
                  '${kpi.index}. ${kpi.title}',
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p8),
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.infoBg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        kpi.tag,
                        style: AppTextStyle.labelSmall.copyWith(
                          color: AppColors.info,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppConstants.p8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.successBg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: AppColors.success, size: 10),
                          const SizedBox(width: 2),
                          Text(
                            kpi.rating,
                            style: AppTextStyle.labelSmall.copyWith(
                              color: AppColors.successDark,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  kpi.time,
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.outline,
                    fontSize: 9,
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

class SelfAssessmentBottomActions extends StatelessWidget {
  final VoidCallback onSaveDraft;
  final VoidCallback onSubmit;

  const SelfAssessmentBottomActions({
    super.key,
    required this.onSaveDraft,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: onSaveDraft,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryContainer,
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                ),
                elevation: 0,
              ),
              child: Text(
                l10n.saveDraft,
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
                gradient: const LinearGradient(
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
                onPressed: onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.transparent,
                  foregroundColor: AppColors.white,
                  shadowColor: AppColors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                ),
                child: Text(
                  l10n.submitReview,
                  style: AppTextStyle.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
