import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/performance/domain/entities/sa_tracking_entity.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/self_assessment/self_assessment_cubit.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/file_operation/file_operation_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dhira_hrms/core/utils/file_validation_utils.dart';
//import 'package:intl/intl.dart';

class SelfAssessmentEmployeeCard extends StatelessWidget {
  final String name;
  final String employeeId;
  final String department;
  final String dueDate;
  final double progress;
  final String progressItems;
  final bool isLoading;

  const SelfAssessmentEmployeeCard({
    super.key,
    required this.name,
    required this.employeeId,
    required this.department,
    required this.dueDate,
    required this.progress,
    required this.progressItems,
    this.isLoading = false,
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
                      name,
                      style: AppTextStyle.h3Bold.copyWith(
                        color: AppColors.onSurface,
                        fontSize: AppConstants.fs20,
                      ),
                    ),
                    const SizedBox(height: AppConstants.p4),
                    Text(
                      '${l10n.employeeIdLabel(employeeId)} | ${l10n.deptLabel(department)}',
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
                      letterSpacing: 1.0,
                      fontSize: AppConstants.fs10,
                    ),
                  ),
                  if (isLoading)
                    Shimmer.fromColors(
                      baseColor: AppColors.surfaceContainerHigh,
                      highlightColor: AppColors.surfaceContainerLowest,
                      child: Container(
                        height: AppConstants.p16,
                        width: AppConstants.p80,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(AppConstants.r4),
                        ),
                      ),
                    )
                  else
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
                      fontSize: AppConstants.fs11,
                    ),
                  ),
                  Text(
                    l10n.achievementPercentLabel(
                      (progress * 100).toInt().toString(),
                    ),
                    style: AppTextStyle.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppConstants.fs11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.p8),
              if (isLoading)
                Shimmer.fromColors(
                  baseColor: AppColors.surfaceContainerHigh,
                  highlightColor: AppColors.surfaceContainerLowest,
                  child: Container(
                    height: AppConstants.p8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
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
                    backgroundColor: AppColors.surfaceContainerHigh,
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
                  progress: 0,
                  progressItems: AppConstants.emptyString,
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

class SelfAssessmentAssessmentSection extends StatefulWidget {
  final List<String> kras;
  final Map<String, double> kraWeightages;
  final int selectedKraIndex;
  final List<GoalReviewEntity> goals;
  final List<FileAttachmentEntity> attachments;
  final bool isEditable;
  final Function(int) onKraSelected;
  final Function(GoalReviewEntity) onGoalChanged;

  const SelfAssessmentAssessmentSection({
    super.key,
    required this.kras,
    required this.kraWeightages,
    required this.selectedKraIndex,
    required this.goals,
    required this.attachments,
    this.isEditable = true,
    required this.onKraSelected,
    required this.onGoalChanged,
  });

  @override
  State<SelfAssessmentAssessmentSection> createState() =>
      _SelfAssessmentAssessmentSectionState();
}

class _SelfAssessmentAssessmentSectionState
    extends State<SelfAssessmentAssessmentSection> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final allKras = [...widget.kras, l10n.supportingDocuments];
    final isSupportingDocs = widget.selectedKraIndex == allKras.length - 1;

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
                  const Icon(
                    Icons.fact_check_outlined,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppConstants.p12),
                  Expanded(
                    child: Text(
                      l10n.assessmentLabel,
                      style: AppTextStyle.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
            const Divider(height: 1.0, color: AppColors.surfaceContainerHigh),
            Padding(
              padding: const EdgeInsets.all(AppConstants.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(allKras.length, (index) {
                        final isSelected = widget.selectedKraIndex == index;
                        final kra = allKras[index];
                        final weightage = widget.kraWeightages[kra] ?? 0.0;
                        final isDocKra = index == allKras.length - 1;

                        return Padding(
                          padding: const EdgeInsets.only(
                            right: AppConstants.p8,
                          ),
                          child: ChoiceChip(
                            label: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  kra,
                                  style: AppTextStyle.labelSmall.copyWith(
                                    color: isSelected
                                        ? AppColors.onPrimary
                                        : AppColors.onSurface,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                if (!isDocKra)
                                  Text(
                                    l10n.weightageText('${weightage.toInt()}%'),
                                    style: AppTextStyle.labelSmall.copyWith(
                                      fontSize: AppConstants.fs10,
                                      color: isSelected
                                          ? AppColors.onPrimary.withValues(
                                              alpha: 0.8,
                                            )
                                          : AppColors.onSurfaceVariant,
                                    ),
                                  ),
                                if (isDocKra)
                                  Text(
                                    '${widget.attachments.length} ${l10n.files}',
                                    style: AppTextStyle.labelSmall.copyWith(
                                      fontSize: AppConstants.fs10,
                                      color: isSelected
                                          ? AppColors.onPrimary.withValues(
                                              alpha: 0.8,
                                            )
                                          : AppColors.onSurfaceVariant,
                                    ),
                                  ),
                              ],
                            ),
                            selected: isSelected,
                            onSelected: (_) => widget.onKraSelected(index),
                            selectedColor: AppColors.primary,
                            backgroundColor: AppColors.surfaceContainerLow,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.p4,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstants.r32,
                              ),
                              side: BorderSide(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.outlineVariant,
                              ),
                            ),
                            showCheckmark: false,
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: AppConstants.p16),
                  if (isSupportingDocs)
                    _SupportingDocumentsSection(
                      attachments: widget.attachments,
                      isEditable: widget.isEditable,
                    )
                  else
                    _KpiList(
                      goals: widget.goals,
                      isEditable: widget.isEditable,
                      onGoalChanged: widget.onGoalChanged,
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

class _SupportingDocumentsSection extends StatelessWidget {
  final List<FileAttachmentEntity> attachments;
  final bool isEditable;

  const _SupportingDocumentsSection({
    required this.attachments,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<SelfAssessmentCubit>();
    final state = context.watch<SelfAssessmentCubit>().state;
    final isUploading = state.isAttachmentUploading;
    final deletingAttachmentId = state.deletingAttachmentId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isEditable) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.p24),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppConstants.r12),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppConstants.p12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHigh.withValues(
                      alpha: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                  child: const Icon(
                    Icons.description_outlined,
                    color: AppColors.onSurfaceVariant,
                    size: AppConstants.p32,
                  ),
                ),
                const SizedBox(height: AppConstants.p16),
                Text(
                  l10n.uploadSupportingDocs,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConstants.p4),
                Text(
                  l10n.maxFileSizeLabel(AppConstants.maxFileSizeText),
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppConstants.p16),
                ElevatedButton(
                  onPressed: isUploading
                      ? null
                      : () => cubit.pickAndUploadAttachment(
                            l10n: l10n,
                            currentCount: attachments.length,
                          ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.p24,
                      vertical: AppConstants.p12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.r8),
                    ),
                  ),
                  child: isUploading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.white,
                            ),
                          ),
                        )
                      : Text(l10n.selectFiles),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.p24),
        ],
        Text(
          l10n.attachedFiles,
          style: AppTextStyle.labelSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: AppConstants.p12),
        if (attachments.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.p24),
              child: Text(
                l10n.noFilesAttached,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
          )
        else
          ...attachments.map((file) {
            final lowerFileName = file.fileName.toLowerCase();
            final isImage = [
              'jpg',
              'jpeg',
              'png',
              'webp',
              'heic',
              'heif',
            ].any((ext) => lowerFileName.endsWith(ext));
            final isDeleting = deletingAttachmentId == file.name;

            return Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.p8),
              child: Container(
                padding: const EdgeInsets.all(AppConstants.p12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppConstants.r8),
                  border: Border.all(color: AppColors.surfaceContainerHigh),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.insert_drive_file_outlined,
                      color: AppColors.primary,
                      size: AppConstants.iconSmall,
                    ),
                    const SizedBox(width: AppConstants.p12),
                    Expanded(
                      child: Text(
                        file.fileName,
                        style: AppTextStyle.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<FileOperationCubit>().handleFileAction(
                              fileUrl: file.fileUrl,
                              fileName: file.fileName,
                              l10n: l10n,
                            );
                      },
                      icon: Icon(
                        isImage
                            ? Icons.visibility_outlined
                            : Icons.download_outlined,
                        size: AppConstants.iconSmall,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    if (isEditable)
                      isDeleting
                          ? const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppConstants.p12,
                              ),
                              child: SizedBox(
                                height: AppConstants.iconSmall,
                                width: AppConstants.iconSmall,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.error,
                                  ),
                                ),
                              ),
                            )
                          : IconButton(
                              onPressed: () => cubit.deleteAttachment(file.name),
                              icon: const Icon(
                                Icons.delete_outline,
                                size: AppConstants.iconSmall,
                                color: AppColors.error,
                              ),
                            ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }
}

class _KpiList extends StatelessWidget {
  final List<GoalReviewEntity> goals;
  final bool isEditable;
  final Function(GoalReviewEntity) onGoalChanged;

  const _KpiList({
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
          child: _KpiItem(
            goal: goal,
            isEditable: isEditable,
            onChanged: onGoalChanged,
          ),
        );
      }).toList(),
    );
  }
}

class _KpiItem extends StatefulWidget {
  final GoalReviewEntity goal;
  final bool isEditable;
  final Function(GoalReviewEntity) onChanged;

  const _KpiItem({
    required this.goal,
    required this.isEditable,
    required this.onChanged,
  });

  @override
  State<_KpiItem> createState() => _KpiItemState();
}

class _KpiItemState extends State<_KpiItem> {
  bool _expanded = false;
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController(text: widget.goal.selfComment);
  }

  @override
  void didUpdateWidget(_KpiItem oldWidget) {
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

    context.read<SelfAssessmentCubit>().updateGoal(
      widget.goal,
      selfRating: selfRating,
      progress: progress,
      selfComment: selfComment,
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
                      final currentRating = context
                          .read<SelfAssessmentCubit>()
                          .parseRating(widget.goal.selfRating);
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
                  if (context.read<SelfAssessmentCubit>().parseRating(
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
                              _RatingHint(rating: AppConstants.rating1),
                              _RatingHint(rating: AppConstants.rating2),
                              _RatingHint(rating: AppConstants.rating3),
                              _RatingHint(rating: AppConstants.rating4),
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
                          final rating = context
                              .read<SelfAssessmentCubit>()
                              .parseRating(widget.goal.selfRating)
                              .toInt();
                          final values = context
                              .read<SelfAssessmentCubit>()
                              .getProgressValues(rating);
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

class _RatingHint extends StatelessWidget {
  final String rating;

  const _RatingHint({
    required this.rating,
  });

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
                      style: AppTextStyle.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.surfaceContainerHigh),
      ),
      child: Row(
        children: [
          Container(
            width: AppConstants.p32,
            height: AppConstants.p32,
            decoration: BoxDecoration(
              color: isCompleted ? AppColors.successBg : AppColors.infoBg,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                isCompleted ? Icons.check : Icons.schedule,
                size: AppConstants.iconSmall,
                color: isCompleted ? AppColors.successDark : AppColors.info,
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
                    color: AppColors.onSurface,
                  ),
                ),
                Text(
                  stage.date.toIso8601String().split('T')[0],
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: AppConstants.fs10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.successBg
                  : AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(AppConstants.r32),
              border: Border.all(
                color: isCompleted
                    ? AppColors.successBorder
                    : AppColors.outlineVariant,
              ),
            ),
            child: Text(
              stage.status,
              style: AppTextStyle.labelSmall.copyWith(
                color: isCompleted
                    ? AppColors.successDark
                    : AppColors.onSurfaceVariant,
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

class SelfAssessmentBottomActions extends StatelessWidget {
  final VoidCallback onSaveDraft;
  final VoidCallback onSubmit;
  final bool isSaving;
  final bool isSubmitting;

  const SelfAssessmentBottomActions({
    super.key,
    required this.onSaveDraft,
    required this.onSubmit,
    this.isSaving = false,
    this.isSubmitting = false,
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
            blurRadius: AppConstants.r10,
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
              child: isSaving
                  ? const SizedBox(
                      height: AppConstants.p20,
                      width: AppConstants.p20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    )
                  : Text(
                      isSaving ? l10n.saving : l10n.saveDraft,
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
                  colors: [AppColors.primary, AppColors.primaryContainer],
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
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.p16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                ),
                child: isSubmitting
                    ? const SizedBox(
                        height: AppConstants.p20,
                        width: AppConstants.p20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.white,
                          ),
                        ),
                      )
                    : Text(
                        isSubmitting ? l10n.submitting : l10n.submitReview,
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

class SelfAssessmentTrackingSection extends StatelessWidget {
  final SaTrackingEntity? tracking;

  const SelfAssessmentTrackingSection({super.key, this.tracking});

  @override
  Widget build(BuildContext context) {
    if (tracking == null) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context)!;
    if (tracking!.sessions.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.p32,
          horizontal: AppConstants.p20,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppConstants.r12),
          border: Border.all(color: AppColors.surfaceContainerHigh),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.noTimelineDataAvailable,
              style: AppTextStyle.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.p8),
            Text(
              l10n.activityWillAppearHere,
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.outline,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: Border.all(color: AppColors.surfaceContainerHigh),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.p16),
            child: Row(
              children: [
                const Icon(Icons.track_changes, color: AppColors.primary),
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
          const Divider(height: 1),
          ...tracking!.sessions.map((session) {
            final sessionQuestions = tracking!.questions
                .where((q) => q.session == session.session)
                .toList();

            final cubit = context.read<SelfAssessmentCubit>();
            final formattedDate = cubit.formatSessionDate(session.sessionStart);
            final formattedTime = cubit.formatSessionTime(
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
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                  border: Border.all(color: AppColors.surfaceContainerHigh),
                ),
                child: ExpansionTile(
                  shape: const Border(),
                  collapsedShape: const Border(),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: Text(
                      session.session,
                      style: AppTextStyle.labelLarge.copyWith(
                        color: AppColors.primary,
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
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  childrenPadding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.p16,
                  ),
                  children: sessionQuestions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final question = entry.value;

                    final cubit = context.read<SelfAssessmentCubit>();
                    final ratingValue = cubit.getRatingOutOfFour(
                      question.rating,
                    );
                    final timeStr = cubit.formatQuestionTime(
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
                                  color: AppColors.success.withValues(
                                    alpha: 0.1,
                                  ),
                                  border: Border.all(
                                    color: AppColors.success.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: AppColors.success,
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
                                            color: AppColors.primaryContainer
                                                .withValues(alpha: 0.3),
                                            borderRadius: BorderRadius.circular(
                                              AppConstants.r4,
                                            ),
                                          ),
                                          child: Text(
                                            question.key,
                                            style: AppTextStyle.labelSmall
                                                .copyWith(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.bold,
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
                                            color: AppColors.success.withValues(
                                              alpha: 0.1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              AppConstants.r4,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                size: 12,
                                                color: AppColors.success,
                                              ),
                                              const SizedBox(
                                                width: AppConstants.p4,
                                              ),
                                              Text(
                                                '$ratingValue / 4',
                                                style: AppTextStyle.labelSmall
                                                    .copyWith(
                                                      color: AppColors.success,
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
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (index < sessionQuestions.length - 1)
                          const Divider(height: 1, thickness: 0.5),
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
