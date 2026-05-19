import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/core/widgets/common_app_bar.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/file_operation/file_operation_cubit.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/file_operation/file_operation_state.dart';
import 'package:dhira_hrms/features/performance/presentation/dialogs/image_preview_dialog.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/self_assessment/self_assessment_cubit.dart';
import 'package:dhira_hrms/features/performance/presentation/widgets/self_assessment_widgets.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SelfAssessmentScreen extends StatelessWidget {
  final String selfAssessmentId;
  final String evaluationId;

  const SelfAssessmentScreen({
    super.key,
    required this.selfAssessmentId,
    required this.evaluationId,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CommonAppBar(title: l10n.selfAssessment),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: MultiBlocListener(
          listeners: [
            BlocListener<SelfAssessmentCubit, SelfAssessmentState>(
              listenWhen: (previous, current) =>
                  previous.actionStatus != current.actionStatus,
              listener: (context, state) {
                if (state.actionStatus ==
                    SelfAssessmentActionStatus.saveSuccess) {
                  ToastUtils.showSuccess(l10n.selfAssessmentSavedSuccess);
                } else if (state.actionStatus ==
                    SelfAssessmentActionStatus.submitSuccess) {
                  ToastUtils.showSuccess(l10n.selfAssessmentSubmittedSuccess);
                  Navigator.pop(context);
                } else if (state.actionStatus ==
                    SelfAssessmentActionStatus.attachmentUploadSuccess) {
                  ToastUtils.showSuccess(l10n.fileUploadSuccess);
                } else if (state.actionStatus ==
                    SelfAssessmentActionStatus.attachmentDeleteSuccess) {
                  ToastUtils.showSuccess(l10n.actionCompletedSuccessfully);
                } else if (state.actionStatus ==
                    SelfAssessmentActionStatus.failure) {
                  if (state.actionErrorMessage != PerformanceApiKeys.noData &&
                      state.actionErrorMessage.isNotEmpty) {
                    ToastUtils.showError(
                      _actionErrorMessage(l10n, state.actionErrorMessage),
                    );
                  }
                }
              },
            ),
            BlocListener<FileOperationCubit, FileOperationState>(
              listener: (context, state) {
                state.maybeWhen(
                  showImagePreview: (imageUrl, headers) {
                    showDialog(
                      context: context,
                      builder: (context) => ImagePreviewDialog(
                        imageUrl: imageUrl,
                        headers: headers,
                      ),
                    ).then((_) {
                      if (context.mounted) {
                        context.read<FileOperationCubit>().reset();
                      }
                    });
                  },
                  orElse: () {},
                );
              },
            ),
          ],
          child: BlocBuilder<SelfAssessmentCubit, SelfAssessmentState>(
            buildWhen: (previous, current) =>
                previous.status != current.status ||
                previous.details != current.details ||
                previous.selectedKra != current.selectedKra ||
                previous.actionStatus != current.actionStatus ||
                previous.isAttachmentUploading != current.isAttachmentUploading ||
                previous.deletingAttachmentId != current.deletingAttachmentId ||
                previous.tracking != current.tracking,
            builder: (context, state) {
              if (state.status == SelfAssessmentStatus.loading ||
                  state.status == SelfAssessmentStatus.initial) {
                return const SelfAssessmentSkeleton();
              }

              if (state.status == SelfAssessmentStatus.failure) {
                if (state.errorMessage == PerformanceApiKeys.noData) {
                  return const SelfAssessmentEmptyState();
                }

                return SelfAssessmentErrorState(
                  message: state.errorMessage,
                  onRetry: () => context
                      .read<SelfAssessmentCubit>()
                      .initSelfAssessment(
                        selfAssessmentId: selfAssessmentId,
                        evaluationId: evaluationId,
                      ),
                );
              }

              final details = state.details;
              if (details == null) return const SizedBox.shrink();

              final dueDate = DateTimeUtils.formatToDMY(details.submissionDate);
              final isEditable =
                  details.docStatus == AppConstants.docStatusDraft;

              return Column(
                children: [
                  SelfAssessmentContentView(
                    details: details,
                    dueDate: dueDate,
                    isEditable: isEditable,
                    kras: state.kras,
                    selectedKra: state.selectedKra,
                    kraWeightages: state.kraWeightages,
                    groupedGoals: state.groupedGoals,
                    tracking: state.tracking,
                    isAttachmentUploading: state.isAttachmentUploading,
                    deletingAttachmentId: state.deletingAttachmentId,
                    onRefresh: () async {
                      await context
                          .read<SelfAssessmentCubit>()
                          .fetchSelfAssessment(
                            details.name,
                            AppConstants.emptyString,
                          );
                    },
                    onKraSelected: (kra) =>
                        context.read<SelfAssessmentCubit>().selectKra(kra),
                    onGoalChanged: (goal) => context
                        .read<SelfAssessmentCubit>()
                        .updateLocalGoalFeedback(goal),
                    onUploadAttachment: (filePath, fileName) => context
                        .read<SelfAssessmentCubit>()
                        .uploadAttachment(
                          filePath: filePath,
                          fileName: fileName,
                        ),
                    onDeleteAttachment: (fileId) => context
                        .read<SelfAssessmentCubit>()
                        .deleteAttachment(fileId),
                    onFileAction: ({
                      required fileUrl,
                      required fileName,
                      required l10n,
                    }) =>
                        context.read<FileOperationCubit>().handleFileAction(
                              fileUrl: fileUrl,
                              fileName: fileName,
                              l10n: l10n,
                            ),
                  ),
                  if (isEditable)
                    SelfAssessmentBottomActions(
                      isSaving: state.actionStatus ==
                          SelfAssessmentActionStatus.saving,
                      isSubmitting: state.actionStatus ==
                          SelfAssessmentActionStatus.submitting,
                      onSave: () => context
                          .read<SelfAssessmentCubit>()
                          .saveSelfAssessment(),
                      onSubmit: () => context
                          .read<SelfAssessmentCubit>()
                          .submitSelfAssessment(),
                    )
                  else
                    const SelfAssessmentSubmittedStatus(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String _actionErrorMessage(AppLocalizations l10n, String message) {
    switch (message) {
      case PerformanceApiKeys.incompleteSelfAssessmentAnswer:
        return l10n.incomplete;
      case PerformanceApiKeys.assessmentDetailsNotLoaded:
        return l10n.failedToUploadFile;
      default:
        return message;
    }
  }
}
