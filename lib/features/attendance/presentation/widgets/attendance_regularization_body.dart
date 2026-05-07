import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/attendance_regularization_bloc.dart';
import '../bloc/attendance_regularization_event.dart';
import '../bloc/attendance_regularization_state.dart';

import 'attendance_regularization_date_picker.dart';
import 'attendance_regularization_guidelines.dart';
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
    _reasonController.addListener(() {
      context.read<AttendanceRegularizationBloc>().add(
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

  void _resetControllers() {
    _inTimeController.text = AppConstants.timePlaceholder;
    _outTimeController.text = AppConstants.timePlaceholder;
    _reasonController.clear();
  }

  Future<void> _pickFile(BuildContext context) async {
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
    return BlocListener<AttendanceRegularizationBloc, AttendanceRegularizationState>(
      listenWhen: (prev, curr) =>
          curr.maybeWhen(
            success: (_, __, isSubmissionSuccess) => isSubmissionSuccess,
            orElse: () => false,
          ) &&
          !prev.maybeWhen(
            success: (_, __, isSubmissionSuccess) => isSubmissionSuccess,
            orElse: () => false,
          ),
      listener: (context, state) {
        _resetControllers();
      },
      child: BlocBuilder<AttendanceRegularizationBloc, AttendanceRegularizationState>(
        builder: (context, state) {
          final formData = state.formData;
          final isSubmitting = state.maybeWhen(
            loading: (_, __, isSubmitting) => isSubmitting,
            orElse: () => false,
          );
          final isUploading = state.maybeWhen(
            loading: (_, isUploading, __) => isUploading,
            orElse: () => false,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppConstants.p16),
                RegularizationDatePicker(
                  selectedDate: formData.date,
                  onDateSelected: (date) {
                    context.read<AttendanceRegularizationBloc>().add(
                          AttendanceRegularizationEvent.dateChanged(date),
                        );
                  },
                ),
                const SizedBox(height: AppConstants.p24),
                const RegularizationGuidelines(),
                if (formData.date != null) ...[
                  const SizedBox(height: AppConstants.p24),
                  RegularizationSystemRecord(selectedDate: formData.date),
                  const SizedBox(height: AppConstants.p24),
                  RegularizationRequestTypeWidget(
                    selectedType: formData.requestType,
                    onTypeSelected: (type) {
                      context.read<AttendanceRegularizationBloc>().add(
                            AttendanceRegularizationEvent.requestTypeChanged(type),
                          );
                    },
                  ),
                  const SizedBox(height: AppConstants.p24),
                  RegularizationDetailsSection(
                    inTimeController: _inTimeController,
                    outTimeController: _outTimeController,
                    reasonController: _reasonController,
                    routeToHR: formData.routeToHR,
                    onRouteToHRChanged: (val) {
                      context.read<AttendanceRegularizationBloc>().add(
                            AttendanceRegularizationEvent.routeToHRChanged(val ?? false),
                          );
                    },
                    onInTimeChanged: (time) {
                      context.read<AttendanceRegularizationBloc>().add(
                            AttendanceRegularizationEvent.inTimeChanged(time),
                          );
                    },
                    onOutTimeChanged: (time) {
                      context.read<AttendanceRegularizationBloc>().add(
                            AttendanceRegularizationEvent.outTimeChanged(time),
                          );
                    },
                  ),
                  const SizedBox(height: AppConstants.p24),
                  RegularizationDocumentsSection(
                    selectedFileName: formData.selectedFileName,
                    uploadedFileUrl: formData.uploadedFileUrl,
                    isUploading: isUploading,
                    onPickFile: () => _pickFile(context),
                    onDelete: () {
                      context.read<AttendanceRegularizationBloc>().add(
                            const AttendanceRegularizationEvent.fileRemoved(),
                          );
                    },
                  ),
                  const SizedBox(height: AppConstants.p24),
                  RegularizationActionButtons(
                    isLoading: isSubmitting,
                    onSubmit: () {
                      context.read<AttendanceRegularizationBloc>().add(
                            const AttendanceRegularizationEvent.submitRequested(),
                          );
                    },
                    onCancel: () => context.pop(),
                  ),
                ],
                const SizedBox(height: AppConstants.p40),
              ],
            ),
          );
        },
      ),
    );
  }
}
