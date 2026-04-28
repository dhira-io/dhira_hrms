import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/constants/attendance_api_constants.dart';
import '../../domain/entities/attendance_regularization_entity.dart';
import '../bloc/attendance_regularization_bloc.dart';
import '../bloc/attendance_regularization_event.dart';
import '../bloc/attendance_regularization_state.dart';

import 'regularization_date_picker.dart';
import 'regularization_guidelines.dart';
import 'regularization_system_record.dart';
import 'regularization_request_type.dart';
import 'regularization_details_section.dart';
import 'regularization_documents_section.dart';
import 'regularization_action_buttons.dart';

class AttendanceRegularizationBody extends StatefulWidget {
  const AttendanceRegularizationBody({super.key});

  @override
  State<AttendanceRegularizationBody> createState() =>
      _AttendanceRegularizationBodyState();
}

class _AttendanceRegularizationBodyState
    extends State<AttendanceRegularizationBody> {
  DateTime? _selectedDate;
  String _requestType = '';
  final TextEditingController _inTimeController = TextEditingController(
    text: AppConstants.timePlaceholder,
  );
  final TextEditingController _outTimeController = TextEditingController(
    text: AppConstants.timePlaceholder,
  );
  final TextEditingController _reasonController = TextEditingController();
  bool _routeToHR = false;
  bool _isDateSelected = false;
  String? _selectedFileName;

  @override
  void dispose() {
    _inTimeController.dispose();
    _outTimeController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_requestType.isEmpty) {
      _requestType = RegularizationRequestTypeConstants.forgotToPunch;
    }
  }

  void resetUI() {
    setState(() {
      _selectedDate = null;
      _requestType = RegularizationRequestTypeConstants.forgotToPunch;
      _inTimeController.text = AppConstants.timePlaceholder;
      _outTimeController.text = AppConstants.timePlaceholder;
      _reasonController.clear();
      _routeToHR = false;
      _isDateSelected = false;
      _selectedFileName = null;
    });
  }

  void _submit(BuildContext context, String? uploadedFileUrl) {
    if (_reasonController.text.length < 10) {
      final l10n = AppLocalizations.of(context)!;
      ToastUtils.showError(
        _reasonController.text.isEmpty
            ? l10n.reasonRequired
            : l10n.atLeastCharactersRequired(10),
      );
      return;
    }

    final regularization = AttendanceRegularizationEntity(
      date: _selectedDate!,
      requestType: _getReasonCategory(_requestType),
      requestedInTime: _formatDateTime(_selectedDate!, _inTimeController.text),
      requestedOutTime: _formatDateTime(
        _selectedDate!,
        _outTimeController.text,
      ),
      routeToHR: _routeToHR,
      reason: _reasonController.text,
      supportingDocuments: uploadedFileUrl != null ? [uploadedFileUrl] : null,
    );

    context.read<AttendanceRegularizationBloc>().add(
      AttendanceRegularizationEvent.submitRequested(regularization),
    );
  }

  String _formatDateTime(DateTime date, String timeStr) {
    if (timeStr == AppConstants.timePlaceholder) return '';
    final time = DateTimeUtils.parseTime(timeStr);
    if (time == null) return '';

    final combined = DateTimeUtils.combineDateAndTime(date, time);
    return DateTimeUtils.formatToApi(combined);
  }

  String _getReasonCategory(String type) {
    switch (type) {
      case RegularizationRequestTypeConstants.forgotToPunch:
        return RegularizationReason.missedPunch;
      case RegularizationRequestTypeConstants.wrongPunchTime:
        return RegularizationReason.incorrectPunch;
      case RegularizationRequestTypeConstants.systemError:
        return RegularizationReason.systemError;
      case RegularizationRequestTypeConstants.networkIssue:
        return RegularizationReason.networkIssue;
      default:
        return type;
    }
  }

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = result.files.first;
      if (file.size > 10 * 1024 * 1024) {
        final l10n = AppLocalizations.of(context)!;
        ToastUtils.showError(l10n.fileSizeError(10));
        return;
      }
      setState(() => _selectedFileName = file.name);
      context.read<AttendanceRegularizationBloc>().add(
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
          prev.isSubmissionSuccess != curr.isSubmissionSuccess && curr.isSubmissionSuccess,
      listener: (context, state) {
        resetUI();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppConstants.p16),
            RegularizationDatePicker(
              selectedDate: _selectedDate,
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                  _isDateSelected = true;
                });
              },
            ),
            const SizedBox(height: AppConstants.p24),
            const RegularizationGuidelines(),
            if (_isDateSelected) ...[
              const SizedBox(height: AppConstants.p24),
              RegularizationSystemRecord(selectedDate: _selectedDate),
              const SizedBox(height: AppConstants.p24),
              RegularizationRequestType(
                selectedType: _requestType,
                onTypeSelected: (type) => setState(() => _requestType = type),
              ),
              const SizedBox(height: AppConstants.p24),
              RegularizationDetailsSection(
                inTimeController: _inTimeController,
                outTimeController: _outTimeController,
                reasonController: _reasonController,
                routeToHR: _routeToHR,
                onRouteToHRChanged: (val) => setState(() => _routeToHR = val!),
              ),
              const SizedBox(height: AppConstants.p24),
              BlocBuilder<AttendanceRegularizationBloc, AttendanceRegularizationState>(
                builder: (context, state) {
                  return RegularizationDocumentsSection(
                    selectedFileName: _selectedFileName,
                    uploadedFileUrl: state.uploadedFileUrl,
                    isUploading: state.isUploading,
                    onPickFile: () => _pickFile(context),
                    onDelete: () {
                      setState(() => _selectedFileName = null);
                    },
                  );
                },
              ),
              const SizedBox(height: AppConstants.p24),
              BlocBuilder<AttendanceRegularizationBloc, AttendanceRegularizationState>(
                builder: (context, state) {
                  return RegularizationActionButtons(
                    isLoading: state.isSubmitting,
                    onSubmit: () => _submit(context, state.uploadedFileUrl),
                    onCancel: () => context.pop(),
                  );
                },
              ),
            ],
            const SizedBox(height: AppConstants.p40),
          ],
        ),
      ),
    );
  }
}
