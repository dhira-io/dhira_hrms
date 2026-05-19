import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';
import 'package:dhira_hrms/features/performance/presentation/widgets/self_assessment_kpi_list.dart';
import 'package:dhira_hrms/features/performance/presentation/widgets/self_assessment_supporting_documents_section.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SelfAssessmentAssessmentSection extends StatefulWidget {
  final bool isEditable;
  final SelfAssessmentEntity details;
  final List<String> kras;
  final String? selectedKra;
  final Map<String, double> kraWeightages;
  final Map<String, List<GoalReviewEntity>> groupedGoals;
  final bool isAttachmentUploading;
  final String deletingAttachmentId;
  final ValueChanged<String> onKraSelected;
  final ValueChanged<GoalReviewEntity> onGoalChanged;
  final Future<void> Function(String filePath, String fileName)
  onUploadAttachment;
  final Future<bool> Function(String fileId) onDeleteAttachment;
  final void Function({
    required String fileUrl,
    required String fileName,
    required AppLocalizations l10n,
  })
  onFileAction;

  const SelfAssessmentAssessmentSection({
    super.key,
    required this.details,
    required this.kras,
    required this.selectedKra,
    required this.kraWeightages,
    required this.groupedGoals,
    required this.isAttachmentUploading,
    required this.deletingAttachmentId,
    required this.onKraSelected,
    required this.onGoalChanged,
    required this.onUploadAttachment,
    required this.onDeleteAttachment,
    required this.onFileAction,
    this.isEditable = true,
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
    final selectedKra =
        widget.selectedKra ??
        (widget.kras.isNotEmpty ? widget.kras.first : AppConstants.emptyString);
    final allKras = [...widget.kras, l10n.supportingDocuments];
    final selectedKraIndex = allKras.indexOf(selectedKra) >= 0
        ? allKras.indexOf(selectedKra)
        : 0;
    final isSupportingDocs = selectedKraIndex == allKras.length - 1;
    final goals = widget.groupedGoals[selectedKra] ?? [];
    final attachments = widget.details.attachments;

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
                        final isSelected = selectedKraIndex == index;
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
                                    '${attachments.length} ${l10n.files}',
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
                            onSelected: (_) =>
                                widget.onKraSelected(allKras[index]),
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
                    SupportingDocumentsSection(
                      attachments: attachments,
                      isEditable: widget.isEditable,
                      isUploading: widget.isAttachmentUploading,
                      deletingAttachmentId: widget.deletingAttachmentId,
                      onUploadAttachment: widget.onUploadAttachment,
                      onDeleteAttachment: widget.onDeleteAttachment,
                      onFileAction: widget.onFileAction,
                    )
                  else
                    KpiList(
                      goals: goals,
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
