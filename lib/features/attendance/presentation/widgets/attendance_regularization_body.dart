import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/attendance_punch_summary_entity.dart';
import '../../domain/entities/regularization_constants.dart';
import '../bloc/attendance_regularization_bloc.dart';
import '../bloc/attendance_regularization_event.dart';
import '../bloc/attendance_regularization_state.dart';

import '../../../../core/widgets/common_guidelines.dart';
import 'attendance_regularization_date_picker.dart';
import 'attendance_regularization_system_record.dart';
import 'attendance_regularization_request_type.dart';
import 'attendance_regularization_details_section.dart';
import 'attendance_regularization_documents_section.dart';
import 'attendance_regularization_action_buttons.dart';

class AttendanceRegularizationBody extends StatefulWidget {
  const AttendanceRegularizationBody({super.key});

  @override
  State<AttendanceRegularizationBody> createState() =>
      _AttendanceRegularizationBodyState();
}

class _AttendanceRegularizationBodyState
    extends State<AttendanceRegularizationBody> {
  final TextEditingController _inTimeController = TextEditingController(
    text: AppConstants.timePlaceholder,
  );
  final TextEditingController _outTimeController = TextEditingController(
    text: AppConstants.timePlaceholder,
  );
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<AttendanceRegularizationBloc>();
    _reasonController.addListener(() {
      bloc.add(
        AttendanceRegularizationEvent.reasonChanged(_reasonController.text),
      );
    });
  }

  @override
  void dispose() {
    _inTimeController.dispose();
    _outTimeController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _dispatch(AttendanceRegularizationEvent event) {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<AttendanceRegularizationBloc>().add(event);
  }

  Future<void> _pickFile(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).unfocus();
    final bloc = context.read<AttendanceRegularizationBloc>();
    final l10n = AppLocalizations.of(context)!;

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );

    if (!mounted) return;

    if (result != null) {
      final file = result.files.first;
      if (file.path == null) return;

      if (file.size > AppConstants.maxAttachmentBytes) {
        ToastUtils.showError(l10n.fileSizeError(10));
        return;
      }

      bloc.add(
        AttendanceRegularizationEvent.uploadFileRequested(
          filePath: file.path!,
          fileName: file.name,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<
      AttendanceRegularizationBloc,
      AttendanceRegularizationState
    >(
      listenWhen: (prev, curr) =>
          curr.maybeWhen(
            success: (_, __, isSubmissionSuccess) => isSubmissionSuccess,
            orElse: () => false,
          ) &&
          !prev.maybeWhen(
            success: (_, __, isSubmissionSuccess) => isSubmissionSuccess,
            orElse: () => false,
          ),
      listener: (context, state) {},
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.p20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppConstants.p16),
            BlocSelector<
              AttendanceRegularizationBloc,
              AttendanceRegularizationState,
              DateTime?
            >(
              selector: (state) => state.formData.date,
              builder: (context, selectedDate) {
                return RegularizationDatePicker(
                  selectedDate: selectedDate,
                  onDateSelected: (date) {
                    _dispatch(AttendanceRegularizationEvent.dateChanged(date));
                  },
                );
              },
            ),
            const SizedBox(height: AppConstants.p24),
            CommonGuidelines(
              title: l10n.regularizationGuidelines,
              items: [
                l10n.regGuideline1,
                l10n.regGuideline2,
                l10n.regGuideline3,
                l10n.regGuideline4,
                l10n.regGuideline5,
                l10n.regGuideline6,
              ],
            ),
            BlocSelector<
              AttendanceRegularizationBloc,
              AttendanceRegularizationState,
              bool
            >(
              selector: (state) => state.formData.date != null,
              builder: (context, hasDate) {
                if (!hasDate) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppConstants.p24),
                    BlocSelector<
                      AttendanceRegularizationBloc,
                      AttendanceRegularizationState,
                      ({
                        DateTime? date,
                        AttendancePunchSummaryEntity? punchSummary,
                        bool isLoading,
                      })
                    >(
                      selector: (state) => (
                        date: state.formData.date,
                        punchSummary: state.formData.punchSummary,
                        isLoading: state.formData.isPunchSummaryLoading,
                      ),
                      builder: (context, recordState) {
                        return RegularizationSystemRecord(
                          selectedDate: recordState.date,
                          punchSummary: recordState.punchSummary,
                          isLoading: recordState.isLoading,
                        );
                      },
                    ),
                    const SizedBox(height: AppConstants.p24),
                    BlocSelector<
                      AttendanceRegularizationBloc,
                      AttendanceRegularizationState,
                      RegularizationRequestType
                    >(
                      selector: (state) => state.formData.requestType,
                      builder: (context, requestType) {
                        return RegularizationRequestTypeWidget(
                          selectedType: requestType,
                          onTypeSelected: (type) {
                            _dispatch(
                              AttendanceRegularizationEvent.requestTypeChanged(
                                type,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: AppConstants.p24),
                    BlocSelector<
                      AttendanceRegularizationBloc,
                      AttendanceRegularizationState,
                      bool
                    >(
                      selector: (state) => state.formData.routeToHR,
                      builder: (context, routeToHR) {
                        return RegularizationDetailsSection(
                          inTimeController: _inTimeController,
                          outTimeController: _outTimeController,
                          reasonController: _reasonController,
                          routeToHR: routeToHR,
                          onRouteToHRChanged: (val) {
                            _dispatch(
                              AttendanceRegularizationEvent.routeToHRChanged(
                                val ?? false,
                              ),
                            );
                          },
                          onInTimeChanged: (time) {
                            _dispatch(
                              AttendanceRegularizationEvent.inTimeChanged(time),
                            );
                          },
                          onOutTimeChanged: (time) {
                            _dispatch(
                              AttendanceRegularizationEvent.outTimeChanged(time),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: AppConstants.p24),
                    BlocSelector<
                      AttendanceRegularizationBloc,
                      AttendanceRegularizationState,
                      ({
                        String? selectedFileName,
                        String? uploadedFileUrl,
                        bool isUploading,
                      })
                    >(
                      selector: (state) {
                        final isUploading = state.maybeWhen(
                          loading: (_, isUploading, __) => isUploading,
                          orElse: () => false,
                        );
                        return (
                          selectedFileName: state.formData.selectedFileName,
                          uploadedFileUrl: state.formData.uploadedFileUrl,
                          isUploading: isUploading,
                        );
                      },
                      builder: (context, docState) {
                        return RegularizationDocumentsSection(
                          selectedFileName: docState.selectedFileName,
                          uploadedFileUrl: docState.uploadedFileUrl,
                          isUploading: docState.isUploading,
                          onPickFile: () => _pickFile(context),
                          onDelete: () {
                            _dispatch(
                              const AttendanceRegularizationEvent.fileRemoved(),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: AppConstants.p24),
                    BlocSelector<
                      AttendanceRegularizationBloc,
                      AttendanceRegularizationState,
                      bool
                    >(
                      selector: (state) => state.maybeWhen(
                        loading: (_, __, isSubmitting) => isSubmitting,
                        orElse: () => false,
                      ),
                      builder: (context, isSubmitting) {
                        return RegularizationActionButtons(
                          isLoading: isSubmitting,
                          onSubmit: () {
                            _dispatch(
                              const AttendanceRegularizationEvent.submitRequested(),
                            );
                          },
                          onCancel: () => context.pop(),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            const SafeArea(
              top: false,
              child: SizedBox(height: AppConstants.p40),
            ),
          ],
        ),
      ),
    );
  }
}
