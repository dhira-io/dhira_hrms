import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/core/widgets/common_app_bar.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/get_active_self_assessment_id_usecase.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/get_self_assessment_details_usecase.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/update_evaluation_usecase.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/update_self_assessment_usecase.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/get_sa_tracking_usecase.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/update_sa_tracking_usecase.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/upload_sa_attachment_usecase.dart';
import 'package:dhira_hrms/features/performance/domain/usecases/delete_sa_attachment_usecase.dart';
import 'package:dhira_hrms/core/services/image_compress_service.dart';
import 'package:dhira_hrms/features/performance/domain/entities/sa_tracking_entity.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/file_operation/file_operation_cubit.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/file_operation/file_operation_state.dart';
import 'package:dhira_hrms/features/performance/presentation/dialogs/image_preview_dialog.dart';
import 'package:dhira_hrms/features/performance/presentation/dialogs/submit_self_assessment_dialog.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/self_assessment/self_assessment_cubit.dart';
import 'package:dhira_hrms/features/performance/presentation/widgets/self_assessment_widgets.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SelfAssessmentScreen extends StatefulWidget {
  final String selfAssessmentId;
  final String evaluationId;

  const SelfAssessmentScreen({
    super.key,
    required this.selfAssessmentId,
    required this.evaluationId,
  });

  @override
  State<SelfAssessmentScreen> createState() => _SelfAssessmentScreenState();
}

class _SelfAssessmentScreenState extends State<SelfAssessmentScreen> {
  late final LocalStorageService _localStorageService;
  late final SelfAssessmentCubit _selfAssessmentCubit;
  String _department = AppConstants.emptyString;
  String _employeeName = AppConstants.emptyString;
  String _employeeId = AppConstants.emptyString;

  @override
  void initState() {
    super.initState();
    _localStorageService = Get.find<LocalStorageService>();
    _department =
        _localStorageService.getDepartment() ?? AppConstants.emptyString;
    _employeeName =
        _localStorageService.getEmpName() ?? AppConstants.emptyString;
    _employeeId = _localStorageService.getEmpId() ?? AppConstants.emptyString;

    _selfAssessmentCubit = SelfAssessmentCubit(
      Get.find<GetActiveSelfAssessmentIdUseCase>(),
      Get.find<GetSelfAssessmentDetailsUseCase>(),
      Get.find<UpdateEvaluationUseCase>(),
      Get.find<UpdateSelfAssessmentUseCase>(),
      Get.find<GetSaTrackingUseCase>(),
      Get.find<UpdateSaTrackingUseCase>(),
      Get.find<UploadSaAttachmentUseCase>(),
      Get.find<DeleteSaAttachmentUseCase>(),
      Get.find<ImageCompressService>(),
      Get.find<LocalStorageService>(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _selfAssessmentCubit.initSelfAssessment();
      }
    });
  }

  @override
  void dispose() {
    _selfAssessmentCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _selfAssessmentCubit),
        BlocProvider.value(value: Get.find<FileOperationCubit>()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CommonAppBar(title: l10n.selfAssessment),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: MultiBlocListener(
            listeners: [
              BlocListener<SelfAssessmentCubit, SelfAssessmentState>(
                listener: (context, state) {
                  state.maybeMap(
                    saveSuccess: (_) {
                      ToastUtils.showSuccess(l10n.selfAssessmentSavedSuccess);
                    },
                    submitSuccess: (_) {
                      ToastUtils.showSuccess(
                        l10n.selfAssessmentSubmittedSuccess,
                      );
                      Navigator.pop(context);
                    },
                    failure: (s) {
                      if (s.message != PerformanceApiKeys.noData) {
                        ToastUtils.showError(s.message);
                      }
                    },
                    orElse: () {},
                  );
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
              builder: (context, state) {
                return state.maybeMap(
                  loading: (_) => SelfAssessmentSkeleton(
                    name: _employeeName,
                    employeeId: _employeeId,
                    department: _department,
                  ),
                  orElse: () {
                    if (state.details == null) {
                      final message = state.maybeMap(
                        failure: (s) => s.message,
                        orElse: () => AppConstants.emptyString,
                      );
                      if (message == PerformanceApiKeys.noData) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.p24,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Optional placeholder if asset is missing
                                const Icon(
                                  Icons.assignment_outlined,
                                  size: 100,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(height: AppConstants.p24),
                                Text(
                                  l10n.noSelfAssessmentTitle,
                                  style: AppTextStyle.h2.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: AppConstants.p16),
                                Text(
                                  l10n.noSelfAssessmentSubtitle,
                                  style: AppTextStyle.bodyMedium.copyWith(
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(message),
                            const SizedBox(height: AppConstants.p16),
                            ElevatedButton(
                              onPressed: () => context
                                  .read<SelfAssessmentCubit>()
                                  .initSelfAssessment(),
                              child: Text(l10n.retry),
                            ),
                          ],
                        ),
                      );
                    }

                    final data = state.maybeMap(
                      success: (s) => s,
                      saving: (s) => s,
                      saveSuccess: (s) => s,
                      submitting: (s) => s,
                      submitSuccess: (s) => s,
                      failure: (s) => s,
                      orElse: () => null,
                    );

                    if (data == null) return const SizedBox.shrink();

                    final details = data.details;
                    if (details == null) return const SizedBox.shrink();
                    final groupedGoals = data.groupedGoals;
                    final kras = data.kras;
                    final selectedKra =
                        state.selectedKra ??
                        (kras.isNotEmpty
                            ? kras.first
                            : AppConstants.emptyString);
                    final allKras = [...kras, l10n.supportingDocuments];
                    final selectedKraIndex = allKras.indexOf(selectedKra);
                    final filteredGoals = groupedGoals[selectedKra] ?? [];

                    final kraWeightages = context
                        .read<SelfAssessmentCubit>()
                        .getKraWeightages(groupedGoals);

                    final dueDate = DateTimeUtils.formatToDMY(
                      details.submissionDate,
                    );

                    final isEditable = details.docStatus == 0;

                    return Column(
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await context
                                  .read<SelfAssessmentCubit>()
                                  .fetchSelfAssessment(
                                    details.name,
                                    AppConstants.emptyString,
                                  );
                            },
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(AppConstants.p16),
                              child: Column(
                                children: [
                                  SelfAssessmentEmployeeCard(
                                    name: details.employeeName,
                                    employeeId: details.employee,
                                    department: details.department.isNotEmpty
                                        ? details.department
                                        : _department,
                                    dueDate: dueDate,
                                    progress: details.goalReviews.isEmpty
                                        ? 0
                                        : details.goalReviews
                                                  .where(
                                                    (g) =>
                                                        g.selfRating.isNotEmpty,
                                                  )
                                                  .length /
                                              details.goalReviews.length,
                                    progressItems: l10n.itemsCountLabel(
                                      details.goalReviews
                                          .where((g) => g.selfRating.isNotEmpty)
                                          .length,
                                      details.goalReviews.length,
                                    ),
                                  ),
                                  const SizedBox(height: AppConstants.p16),
                                  SelfAssessmentAssessmentSection(
                                    kras: kras,
                                    kraWeightages: kraWeightages,
                                    selectedKraIndex: selectedKraIndex >= 0
                                        ? selectedKraIndex
                                        : 0,
                                    goals: filteredGoals,
                                    attachments: details.attachments,
                                    isEditable: isEditable,
                                    onKraSelected: (index) {
                                      context
                                          .read<SelfAssessmentCubit>()
                                          .selectKra(allKras[index]);
                                    },
                                    onGoalChanged: (updatedGoal) {
                                      context
                                          .read<SelfAssessmentCubit>()
                                          .updateLocalGoalFeedback(updatedGoal);
                                    },
                                  ),
                                  if (state.tracking != null &&
                                      state.tracking!.sessions.isNotEmpty) ...[
                                    const SizedBox(height: AppConstants.p16),
                                    SelfAssessmentTrackingSection(
                                      tracking: state.tracking,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (isEditable)
                          SelfAssessmentBottomActions(
                            isSaving: state.maybeMap(
                              saving: (_) => true,
                              orElse: () => false,
                            ),
                            isSubmitting: state.maybeMap(
                              submitting: (_) => true,
                              orElse: () => false,
                            ),
                            onSaveDraft: () {
                              context
                                  .read<SelfAssessmentCubit>()
                                  .saveSelfAssessment();
                            },
                            onSubmit: () {
                              showDialog(
                                context: context,
                                builder: (dialogContext) =>
                                    SubmitSelfAssessmentDialog(
                                      onConfirm: () {
                                        context
                                            .read<SelfAssessmentCubit>()
                                            .submitSelfAssessment();
                                      },
                                    ),
                              );
                            },
                          )
                        else
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(AppConstants.p16),
                            color: AppColors.surfaceContainerLowest,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppConstants.p16,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.successBg,
                                borderRadius: BorderRadius.circular(
                                  AppConstants.r12,
                                ),
                                border: Border.all(
                                  color: AppColors.successBorder,
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline,
                                      color: AppColors.successDark,
                                      size: AppConstants.iconSmall,
                                    ),
                                    const SizedBox(width: AppConstants.p8),
                                    Text(
                                      l10n.submitted,
                                      style: AppTextStyle.labelMedium.copyWith(
                                        color: AppColors.successDark,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
