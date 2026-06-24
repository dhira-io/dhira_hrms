import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/core/widgets/common_app_bar.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';

import 'package:dhira_hrms/features/attendance_regularization/presentation/bloc/attendance_regularization_bloc.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/bloc/attendance_regularization_event.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/bloc/attendance_regularization_state.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/widgets/attendance_regularization_stepper_widget.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/widgets/attendance_regularization_form_widget.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/widgets/attendance_regularization_review_widget.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/widgets/attendance_regularization_success_widget.dart';

class AttendanceRegularizationScreen extends StatefulWidget {
  const AttendanceRegularizationScreen({super.key});

  @override
  State<AttendanceRegularizationScreen> createState() =>
      _AttendanceRegularizationScreenState();
}

class _AttendanceRegularizationScreenState
    extends State<AttendanceRegularizationScreen> {
  final TextEditingController _reasonController = TextEditingController();
  Timer? _reasonDebounce;

  @override
  void initState() {
    super.initState();
    _reasonController.addListener(_onReasonChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<AttendanceRegularizationBloc>().add(
        const AttendanceRegularizationEvent.regularizationStarted(),
      );
    });
  }

  @override
  void dispose() {
    _reasonDebounce?.cancel();
    _reasonController.dispose();
    super.dispose();
  }

  void _onReasonChanged() {
    _reasonDebounce?.cancel();
    _reasonDebounce = Timer(const Duration(milliseconds: 220), () {
      if (!mounted) return;
      context.read<AttendanceRegularizationBloc>().add(
        AttendanceRegularizationEvent.reasonChanged(_reasonController.text),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = AppColors.of(context);
    final managerName =
        Get.find<LocalStorageService>().getApproverName() ?? l10n.notAvailable;

    final formConfig = RegularizationFormConfig(
      reasonController: _reasonController,
      onPickFile: () {
        context.read<AttendanceRegularizationBloc>().add(
          const AttendanceRegularizationEvent.pickFileRequested(),
        );
      },
      onRemoveFile: () {
        context.read<AttendanceRegularizationBloc>().add(
          const AttendanceRegularizationEvent.fileRemoved(),
        );
      },
    );

    return BlocListener<
      AttendanceRegularizationBloc,
      AttendanceRegularizationState
    >(
      listenWhen: (previous, current) => current.maybeMap(
        error: (_) => true,
        success: (currentSuccess) => previous.maybeMap(
          success: (previousSuccess) =>
              previousSuccess.kind != currentSuccess.kind,
          orElse: () => true,
        ),
        orElse: () => false,
      ),
      listener: (context, state) {
        state.whenOrNull(
          error: (_, message, validationError, __) => ToastUtils.showError(
            message ??
                (validationError?.getMessage(l10n) ?? l10n.submissionError),
          ),
          success: (_, kind, __) {
            if (kind == AttendanceRegularizationSuccessKind.fileUpload) {
              ToastUtils.showSuccess(l10n.fileUploadSuccess);
            }
          },
        );
      },
      child: Scaffold(
        backgroundColor: themeColors.background,
        appBar: CommonAppBar(title: l10n.attendanceRegularizationRequest),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              // Stepper at the top
              Container(
                color: themeColors.white,
                child: const AttendanceRegularizationStepperWidget(),
              ),

              // Content area
              Expanded(
                child:
                    BlocBuilder<
                      AttendanceRegularizationBloc,
                      AttendanceRegularizationState
                    >(
                      buildWhen: (previous, current) =>
                          previous.currentStep != current.currentStep,
                      builder: (context, state) {
                        final currentStep = state.currentStep;

                        if (currentStep == 2) {
                          return AttendanceRegularizationSuccessWidget(
                            onMyRequests: () {
                              // Switch to Approvals tab and show Raised Requests for Attendance
                              Get.find<BottomNavCubit>().changeIndex(
                                BottomNavCubit.approvalsIndex,
                              );
                              Get.find<ApprovalsBloc>().add(
                                const ApprovalsEvent.started(
                                  initialCategory: ApprovalCategory.raised,
                                  initialType: ApprovalType.attendance,
                                ),
                              );
                              context.pop();
                            },
                            onBackToHome: () {
                              context.pop();
                            },
                          );
                        }

                        return SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 18.h),
                          child: currentStep == 1
                              ? AttendanceRegularizationReviewWidget(
                                  formData: state.formData,
                                  managerName: managerName,
                                )
                              : AttendanceRegularizationFormWidget(
                                  config: formConfig,
                                ),
                        );
                      },
                    ),
              ),

              // Bottom Action Bar for Step 1 and Step 2
              BlocBuilder<
                AttendanceRegularizationBloc,
                AttendanceRegularizationState
              >(
                buildWhen: (previous, current) =>
                    previous.currentStep != current.currentStep ||
                    previous.formData.canContinue !=
                        current.formData.canContinue ||
                    previous.maybeWhen(
                          loading: (_, kind, __) =>
                              kind ==
                              AttendanceRegularizationLoadingKind.submit,
                          orElse: () => false,
                        ) !=
                        current.maybeWhen(
                          loading: (_, kind, __) =>
                              kind ==
                              AttendanceRegularizationLoadingKind.submit,
                          orElse: () => false,
                        ),
                builder: (context, state) {
                  final currentStep = state.currentStep;
                  if (currentStep == 2) return const SizedBox.shrink();

                  final bool isSubmitting = state.maybeWhen(
                    loading: (_, kind, __) =>
                        kind == AttendanceRegularizationLoadingKind.submit,
                    orElse: () => false,
                  );

                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: themeColors.surfaceContainerLowest,
                      border: Border(
                        top: BorderSide(
                          color: themeColors.slate200,
                          width: 1.w,
                        ),
                      ),
                    ),
                    child: SafeArea(
                      child: currentStep == 0
                          ? AttendanceRegularizationStep1Actions(
                              canContinue: state.formData.canContinue,
                            )
                          : AttendanceRegularizationStep2Actions(
                              isSubmitting: isSubmitting,
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AttendanceRegularizationStep1Actions extends StatelessWidget {
  final bool canContinue;

  const AttendanceRegularizationStep1Actions({
    super.key,
    required this.canContinue,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CommonButton(
      text: l10n.nextText,
      onPressed: canContinue
          ? () {
              FocusScope.of(context).unfocus();
              context.read<AttendanceRegularizationBloc>().add(
                const AttendanceRegularizationEvent.nextPressed(),
              );
            }
          : null,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 16.w),
      borderRadius: 6.r,
      fontweight: FontWeight.w100,
    );
  }
}

class AttendanceRegularizationStep2Actions extends StatelessWidget {
  final bool isSubmitting;

  const AttendanceRegularizationStep2Actions({
    super.key,
    required this.isSubmitting,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = AppColors.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Edit Details Button
        CommonButton(
          text: l10n.editDetails,
          onPressed: isSubmitting
              ? null
              : () {
                  context.read<AttendanceRegularizationBloc>().add(
                    const AttendanceRegularizationEvent.previousPressed(),
                  );
                },
          variant: ButtonVariant.outlined,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 16.w),
          borderRadius: 6.r,
          fontweight: FontWeight.w100,
          textColor: themeColors.textPrimary,
        ),
        SizedBox(height: 6.h),
        // Submit Request Button
        CommonButton(
          text: l10n.submitRequest,
          onPressed: isSubmitting
              ? null
              : () {
                  context.read<AttendanceRegularizationBloc>().add(
                    const AttendanceRegularizationEvent.submitRequested(),
                  );
                },
          isLoading: isSubmitting,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 16.w),
          borderRadius: 6.r,
          fontweight: FontWeight.w100,
        ),
      ],
    );
  }
}
