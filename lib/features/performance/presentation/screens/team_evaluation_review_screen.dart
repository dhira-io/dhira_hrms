import 'package:dhira_hrms/features/performance/presentation/cubit/file_operation/file_operation_state.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/generic_error_widget.dart';
import '../widgets/team_evaluation_review_widgets.dart';
import '../cubit/self_assessment/self_assessment_cubit.dart';
import '../cubit/file_operation/file_operation_cubit.dart';
import '../dialogs/image_preview_dialog.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/common_app_bar.dart';
import '../utils/performance_error_utils.dart';

class TeamEvaluationReviewScreen extends StatefulWidget {
  final String employeeName;
  final String employeeId;
  final String department;
  final String status;
  final String evaluationStatus;
  final String selfAssessmentId;
  final String evaluationId;

  const TeamEvaluationReviewScreen({
    super.key,
    required this.employeeName,
    required this.employeeId,
    required this.department,
    required this.status,
    required this.evaluationStatus,
    required this.selfAssessmentId,
    required this.evaluationId,
  });

  @override
  State<TeamEvaluationReviewScreen> createState() =>
      _TeamEvaluationReviewScreenState();
}

class _TeamEvaluationReviewScreenState
    extends State<TeamEvaluationReviewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Get.find<SelfAssessmentCubit>().initSelfAssessment(
          selfAssessmentId: widget.selfAssessmentId,
          evaluationId: widget.evaluationId,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> refreshAssessment() async {
      final cubit = context.read<SelfAssessmentCubit>();
      cubit.fetchSelfAssessment(
        widget.selfAssessmentId,
        widget.evaluationId,
      );
      await cubit.stream.firstWhere(
        (state) => state.status != SelfAssessmentStatus.loading,
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: Get.find<SelfAssessmentCubit>()),
        BlocProvider.value(value: Get.find<FileOperationCubit>()),
      ],

      child: MultiBlocListener(
        listeners: [
          BlocListener<SelfAssessmentCubit, SelfAssessmentState>(
            listener: (context, state) {},
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
        child: Scaffold(
          backgroundColor: AppColors.of(context).background,
          resizeToAvoidBottomInset: true,
          appBar: CommonAppBar(
            title: AppLocalizations.of(context)!.performanceReview,
          ),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            behavior: HitTestBehavior.opaque,
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<SelfAssessmentCubit, SelfAssessmentState>(
                      builder: (context, state) {
                        if (state.status == SelfAssessmentStatus.failure &&
                            PerformanceErrorUtils.isServerErrorMessage(
                              state.errorMessage,
                            )) {
                          return GenericErrorWidget(
                            onRetry: () {
                              context.read<SelfAssessmentCubit>().fetchSelfAssessment(
                                    widget.selfAssessmentId,
                                    widget.evaluationId,
                                  );
                            },
                          );
                        }

                        return RefreshIndicator(
                          onRefresh: refreshAssessment,
                          color: AppColors.of(context).primary,
                          backgroundColor: AppColors.of(context).surface,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            padding: const EdgeInsets.only(
                              bottom: 120,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                EmployeeHeroSection(
                                  name: widget.employeeName,
                                  empId: widget.employeeId,
                                  department: widget.department,
                                  status: widget.status,
                                ),
                                KraNavigation(
                                  selectedKra: state.selectedKra,
                                  onKraSelected: (kra) {
                                    context
                                        .read<SelfAssessmentCubit>()
                                        .selectKra(kra);
                                  },
                                ),
                                DetailedReviewSection(
                                  selectedKra: state.selectedKra,
                                  employeeName: widget.employeeName,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: MediaQuery.of(context).viewInsets.bottom > 0
              ? null
              : ReviewFooter(status: widget.evaluationStatus),
        ),
      ),
    );
  }
}
