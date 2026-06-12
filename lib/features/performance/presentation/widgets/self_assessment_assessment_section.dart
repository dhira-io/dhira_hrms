import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/self_assessment/self_assessment_cubit.dart';
import 'package:dhira_hrms/features/performance/presentation/widgets/self_assessment_kpi_list.dart';
import 'package:dhira_hrms/features/performance/presentation/widgets/self_assessment_supporting_documents_section.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelfAssessmentAssessmentSection extends StatefulWidget {
  final bool? isEditable;
  final SelfAssessmentEntity? details;
  final List<String>? kras;
  final String? selectedKra;
  final Map<String, double>? kraWeightages;
  final Map<String, List<GoalReviewEntity>>? groupedGoals;
  final bool? isAttachmentUploading;
  final String? deletingAttachmentId;
  final ValueChanged<String>? onKraSelected;
  final ValueChanged<GoalReviewEntity>? onGoalChanged;
  final Future<void> Function(String filePath, String fileName)?
  onUploadAttachment;
  final Future<bool> Function(String fileId)? onDeleteAttachment;
  final void Function({
    required String fileUrl,
    required String fileName,
    required AppLocalizations l10n,
  })?
  onFileAction;

  const SelfAssessmentAssessmentSection({
    super.key,
    this.details,
    this.kras,
    this.selectedKra,
    this.kraWeightages,
    this.groupedGoals,
    this.isAttachmentUploading,
    this.deletingAttachmentId,
    this.onKraSelected,
    this.onGoalChanged,
    this.onUploadAttachment,
    this.onDeleteAttachment,
    this.onFileAction,
    this.isEditable,
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
    final cubit = context.watch<SelfAssessmentCubit>();
    final state = cubit.state;

    final resolvedDetails = widget.details ?? state.details;
    if (resolvedDetails == null) return const SizedBox.shrink();

    final resolvedKras = widget.kras ?? state.kras;
    final resolvedSelectedKra =
        widget.selectedKra ??
        state.selectedKra ??
        (resolvedKras.isNotEmpty
            ? resolvedKras.first
            : AppConstants.emptyString);

    final resolvedKraWeightages = widget.kraWeightages ?? state.kraWeightages;
    final resolvedIsEditable =
        widget.isEditable ??
        (resolvedDetails.docStatus == AppConstants.docStatusDraft);

    final resolvedOnKraSelected =
        widget.onKraSelected ??
        (kra) => context.read<SelfAssessmentCubit>().selectKra(kra);

    final allKras = [...resolvedKras, l10n.supportingDocuments];
    final selectedKraIndex = allKras.indexOf(resolvedSelectedKra) >= 0
        ? allKras.indexOf(resolvedSelectedKra)
        : 0;
    final isSupportingDocs = selectedKraIndex == allKras.length - 1;
    final attachments = resolvedDetails.attachments;

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
                    Icons.fact_check_outlined,
                    color: AppColors.of(context).primary,
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
                    color: AppColors.of(context).onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded) ...[
            Divider(
              height: 1.0.h,
              color: AppColors.of(context).surfaceContainerHigh,
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(allKras.length, (index) {
                        final isSelected = selectedKraIndex == index;
                        final kra = allKras[index];
                        final weightage = resolvedKraWeightages[kra] ?? 0.0;
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
                                        ? AppColors.of(context).onPrimary
                                        : AppColors.of(context).onSurface,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                if (!isDocKra)
                                  Text(
                                    l10n.weightageText('${weightage.toInt()}%'),
                                    style: AppTextStyle.labelSmall.copyWith(
                                      fontSize: AppConstants.fs8.sp,
                                      color: isSelected
                                          ? AppColors.of(
                                              context,
                                            ).onPrimary.withValues(alpha: 0.8)
                                          : AppColors.of(
                                              context,
                                            ).onSurfaceVariant,
                                    ),
                                  ),
                                if (isDocKra)
                                  Text(
                                    '${attachments.length} ${l10n.files}',
                                    style: AppTextStyle.labelSmall.copyWith(
                                      fontSize: AppConstants.fs8.sp,
                                      color: isSelected
                                          ? AppColors.of(
                                              context,
                                            ).onPrimary.withValues(alpha: 0.8)
                                          : AppColors.of(
                                              context,
                                            ).onSurfaceVariant,
                                    ),
                                  ),
                              ],
                            ),
                            selected: isSelected,
                            onSelected: (_) =>
                                resolvedOnKraSelected(allKras[index]),
                            selectedColor: AppColors.of(context).primary,
                            backgroundColor: AppColors.of(
                              context,
                            ).surfaceContainerLow,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.p4,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstants.r32,
                              ),
                              side: BorderSide(
                                color: isSelected
                                    ? AppColors.of(context).primary
                                    : AppColors.of(context).outlineVariant,
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
                    SupportingDocumentsSection(
                      attachments: attachments,
                      isEditable: resolvedIsEditable,
                      isUploading: widget.isAttachmentUploading,
                      deletingAttachmentId: widget.deletingAttachmentId,
                      onUploadAttachment: widget.onUploadAttachment,
                      onDeleteAttachment: widget.onDeleteAttachment,
                      onFileAction: widget.onFileAction,
                    )
                  else
                    KpiList(
                      goals: widget.groupedGoals?[resolvedSelectedKra],
                      isEditable: resolvedIsEditable,
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
