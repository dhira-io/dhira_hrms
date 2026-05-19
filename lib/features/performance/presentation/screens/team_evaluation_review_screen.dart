import 'package:dhira_hrms/features/performance/presentation/cubit/file_operation/file_operation_state.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../widgets/team_evaluation_review_widgets.dart';
import '../cubit/self_assessment/self_assessment_cubit.dart';
import '../cubit/file_operation/file_operation_cubit.dart';
import '../dialogs/image_preview_dialog.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/common_app_bar.dart';

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
        Get.find<SelfAssessmentCubit>().fetchSelfAssessment(
          widget.selfAssessmentId,
          widget.evaluationId,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
          backgroundColor: AppColors.background,
          resizeToAvoidBottomInset: true,
          appBar: CommonAppBar(
            title: AppLocalizations.of(context)!.performanceReview,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      final cubit = Get.find<SelfAssessmentCubit>();
                      cubit.fetchSelfAssessment(
                        widget.selfAssessmentId,
                        widget.evaluationId,
                      );
                      // Wait for the next state that is not loading
                      await cubit.stream.firstWhere(
                        (state) => state.status != SelfAssessmentStatus.loading,
                      );
                    },
                    color: AppColors.primary,
                    backgroundColor: AppColors.surface,
                    child:
                        BlocBuilder<SelfAssessmentCubit, SelfAssessmentState>(
                          builder: (context, state) {
                            return SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              padding: const EdgeInsets.only(
                                bottom: 120,
                              ), // Space for sticky footer
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
                                  // const TimelineSection(),
                                ],
                              ),
                            );
                          },
                        ),
                  ),
                ),
              ],
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
