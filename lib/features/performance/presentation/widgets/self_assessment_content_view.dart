import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/features/performance/domain/entities/sa_tracking_entity.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'self_assessment_assessment_section.dart';
import 'self_assessment_employee_card.dart';
import 'self_assessment_tracking_section.dart';

class SelfAssessmentContentView extends StatelessWidget {
  final SelfAssessmentEntity details;
  final String dueDate;
  final bool isEditable;
  final List<String> kras;
  final String? selectedKra;
  final Map<String, double> kraWeightages;
  final Map<String, List<GoalReviewEntity>> groupedGoals;
  final SaTrackingEntity? tracking;
  final bool isAttachmentUploading;
  final String deletingAttachmentId;
  final Future<void> Function() onRefresh;
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

  const SelfAssessmentContentView({
    super.key,
    required this.details,
    required this.dueDate,
    required this.isEditable,
    required this.kras,
    required this.selectedKra,
    required this.kraWeightages,
    required this.groupedGoals,
    required this.tracking,
    required this.isAttachmentUploading,
    required this.deletingAttachmentId,
    required this.onRefresh,
    required this.onKraSelected,
    required this.onGoalChanged,
    required this.onUploadAttachment,
    required this.onDeleteAttachment,
    required this.onFileAction,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppConstants.p16),
          child: Column(
            children: [
              SelfAssessmentEmployeeCard(
                details: details,
                department: details.department,
                dueDate: dueDate,
              ),
              const SizedBox(height: AppConstants.p16),
              SelfAssessmentAssessmentSection(
                details: details,
                kras: kras,
                selectedKra: selectedKra,
                kraWeightages: kraWeightages,
                groupedGoals: groupedGoals,
                isAttachmentUploading: isAttachmentUploading,
                deletingAttachmentId: deletingAttachmentId,
                onKraSelected: onKraSelected,
                onGoalChanged: onGoalChanged,
                onUploadAttachment: onUploadAttachment,
                onDeleteAttachment: onDeleteAttachment,
                onFileAction: onFileAction,
                isEditable: isEditable,
              ),
              SelfAssessmentTrackingSection(tracking: tracking),
            ],
          ),
        ),
      ),
    );
  }
}
