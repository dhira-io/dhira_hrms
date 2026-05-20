import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/core/widgets/common_app_bar.dart';
import 'package:dhira_hrms/core/widgets/generic_error_widget.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/file_operation/file_operation_cubit.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/file_operation/file_operation_state.dart';
import 'package:dhira_hrms/features/performance/presentation/dialogs/image_preview_dialog.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/self_assessment/self_assessment_cubit.dart';
import 'package:dhira_hrms/features/performance/presentation/utils/performance_error_utils.dart';
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

  String _actionErrorMessage(AppLocalizations l10n, String message) {
    switch (message) {
      case PerformanceApiKeys.incompleteSelfAssessmentAnswer:
        return l10n.incompleteSelfAssessmentAnswer;
      case PerformanceApiKeys.assessmentDetailsNotLoaded:
        return l10n.failedToUploadFile;
      default:
        return message;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.of(context).background,
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
                previous.status != current.status,
            builder: (context, state) {
              if (state.status == SelfAssessmentStatus.loading ||
                  state.status == SelfAssessmentStatus.initial) {
                return const SelfAssessmentSkeleton();
              }

              if (state.status == SelfAssessmentStatus.failure) {
                if (state.errorMessage == PerformanceApiKeys.noData) {
                  return const SelfAssessmentEmptyState();
                }
                if (PerformanceErrorUtils.isServerErrorMessage(
                  state.errorMessage,
                )) {
                  return GenericErrorWidget(
                    onRetry: () => context
                        .read<SelfAssessmentCubit>()
                        .initSelfAssessment(
                          selfAssessmentId: selfAssessmentId,
                          evaluationId: evaluationId,
                        ),
                  );
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

              return Column(
                children: const [
                  SelfAssessmentContentView(),
                  SelfAssessmentBottomSection(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class SelfAssessmentBottomSection extends StatelessWidget {
  const SelfAssessmentBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isEditable = context.select((SelfAssessmentCubit cubit) =>
        cubit.state.details?.docStatus == AppConstants.docStatusDraft);

    if (isEditable) {
      return const SelfAssessmentBottomActions();
    }
    return const SelfAssessmentSubmittedStatus();
  }
}
