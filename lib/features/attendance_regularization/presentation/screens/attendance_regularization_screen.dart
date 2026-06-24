import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/core/widgets/common_app_bar.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

import 'package:dhira_hrms/features/attendance_regularization/presentation/bloc/attendance_regularization_bloc.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/bloc/attendance_regularization_event.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/bloc/attendance_regularization_state.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/widgets/attendance_regularization_stepper_widget.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/widgets/attendance_regularization_form_widget.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/widgets/attendance_regularization_content_state.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/widgets/attendance_regularization_bottom_actions.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/widgets/attendance_regularization_loading_view.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/widgets/attendance_regularization_error_view.dart';

class AttendanceRegularizationScreen extends StatelessWidget {
  final VoidCallback onMyRequestsPressed;

  const AttendanceRegularizationScreen({
    super.key,
    required this.onMyRequestsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);

    return BlocListener<AttendanceRegularizationBloc, AttendanceRegularizationState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.successKind != current.successKind,
      listener: (context, state) {
        if (state.isError) {
          final message = state.errorMessage ??
              state.validationError?.getMessage(l10n) ??
              l10n.submissionError;
          ToastUtils.showError(message);
        } else if (state.isSuccess &&
            state.successKind == AttendanceRegularizationSuccessKind.fileUpload) {
          ToastUtils.showSuccess(l10n.fileUploadSuccess);
        }
      },
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: CommonAppBar(
          title: l10n.attendanceRegularizationRequest,
          subtitle: l10n.correctAttendanceRecord,
        ),
        body: const AttendanceRegularizationScreenBody(),
      ),
    );
  }
}

class AttendanceRegularizationScreenBody extends StatefulWidget {
  const AttendanceRegularizationScreenBody({super.key});

  @override
  State<AttendanceRegularizationScreenBody> createState() =>
      _AttendanceRegularizationScreenBodyState();
}

class _AttendanceRegularizationScreenBodyState
    extends State<AttendanceRegularizationScreenBody> {
  late final TextEditingController _reasonController;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<AttendanceRegularizationBloc>();
    _reasonController = TextEditingController(text: bloc.state.formData.reason);
    _reasonController.addListener(_onReasonChanged);
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _onReasonChanged() {
    context.read<AttendanceRegularizationBloc>().add(
          AttendanceRegularizationEvent.reasonChanged(_reasonController.text),
        );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final bloc = context.read<AttendanceRegularizationBloc>();

    final formConfig = RegularizationFormConfig(
      reasonController: _reasonController,
      onPickFile: () {
        bloc.add(const AttendanceRegularizationEvent.pickFileRequested());
      },
      onRemoveFile: () {
        bloc.add(const AttendanceRegularizationEvent.fileRemoved());
      },
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          Container(
            color: colors.white,
            child: const AttendanceRegularizationStepperWidget(),
          ),
          Expanded(
            child: BlocBuilder<AttendanceRegularizationBloc, AttendanceRegularizationState>(
              buildWhen: (previous, current) =>
                  previous.currentStep != current.currentStep ||
                  previous.status != current.status ||
                  previous.errorMessage != current.errorMessage,
              builder: (context, state) {
                if (state.isLoading && state.loadingKind == null) {
                  return const AttendanceRegularizationLoadingView();
                }

                if (state.isError && state.formData.date == null && state.errorMessage != null) {
                  return AttendanceRegularizationErrorView(
                    errorMessage: state.errorMessage!,
                    onRetry: () {
                      bloc.add(const AttendanceRegularizationEvent.regularizationStarted());
                    },
                  );
                }

                return AttendanceRegularizationContentState(
                  state: state,
                  onMyRequestsPressed: () {
                    final screen = context.findAncestorWidgetOfExactType<AttendanceRegularizationScreen>();
                    screen?.onMyRequestsPressed();
                  },
                  onBackToHomePressed: () => context.pop(),
                  formConfig: formConfig,
                );
              },
            ),
          ),
          BlocBuilder<AttendanceRegularizationBloc, AttendanceRegularizationState>(
            buildWhen: (previous, current) =>
                previous.currentStep != current.currentStep ||
                previous.formData.canContinue != current.formData.canContinue ||
                previous.status != current.status ||
                previous.loadingKind != current.loadingKind,
            builder: (context, state) {
              return AttendanceRegularizationBottomActions(
                state: state,
                onNext: () {
                  FocusScope.of(context).unfocus();
                  bloc.add(const AttendanceRegularizationEvent.nextPressed());
                },
                onPrevious: () {
                  bloc.add(const AttendanceRegularizationEvent.previousPressed());
                },
                onSubmit: () {
                  bloc.add(const AttendanceRegularizationEvent.submitRequested());
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
