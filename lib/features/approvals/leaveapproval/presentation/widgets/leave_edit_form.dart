import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/constants/leave_constants.dart';
import 'package:dhira_hrms/core/constants/storage_constants.dart';
import 'package:dhira_hrms/core/services/image_compress_service.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/utils/string_utils.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_bloc.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_event.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_state.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/utils/leave_date_time_utils.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/widgets/leave_action_buttons.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/widgets/leave_card_section.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/widgets/leave_date_range_pickers.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/widgets/leave_file_upload_section.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/widgets/leave_guidelines.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/widgets/leave_half_day_details.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/widgets/leave_half_day_toggle.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/widgets/leave_overlap_section.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/widgets/leave_reason_field.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/widgets/leave_type_dropdown.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dhira_hrms/core/utils/file_validation_utils.dart';

class LeaveEditForm extends StatefulWidget {
  final String employeeId;
  final LeaveEntity leave;

  const LeaveEditForm({
    super.key,
    required this.employeeId,
    required this.leave,
  });

  @override
  State<LeaveEditForm> createState() => _LeaveEditFormState();
}

class _LeaveEditFormState extends State<LeaveEditForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _leaveType;
  final TextEditingController _reasonController = TextEditingController();
  bool _isHalfDay = false;
  DateTime? _halfDayDate;
  String? _daySegment;
  String? _selectedFileName;
  bool _showOverlapDetails = false;
  bool _hideOverlapAfterSubmit = false;
  int _uploadCount = 0;

  String _gender = "";
  List<DateTime> _cachedHolidays = [];

  @override
  void initState() {
    super.initState();
    _loadGender();
    _leaveType = widget.leave.leaveType;
    _fromDate = DateTime.tryParse(widget.leave.fromDate);
    _toDate = DateTime.tryParse(widget.leave.toDate);
    _isHalfDay = widget.leave.halfDay == 1;
    _halfDayDate = widget.leave.halfDayDate != null ? DateTime.tryParse(widget.leave.halfDayDate!) : null;
    _daySegment = widget.leave.halfDaySegment;
    _reasonController.text = widget.leave.description ?? "";
    if (widget.leave.fileUrl != null && widget.leave.fileUrl!.isNotEmpty) {
      _selectedFileName = widget.leave.fileUrl!.split('/').last;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _refreshBalance();
        if (_fromDate != null && _toDate != null) {
          context.read<LeaveApprovalBloc>().add(LeaveApprovalEvent.statisticsRequested(
                employeeId: widget.employeeId,
                fromDate: _fromDate!.format(),
                toDate: _toDate!.format(),
              ));
          _checkOverlap();
        }
      }
    });
  }

  Future<void> _loadGender() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _gender = prefs.getString(StorageConstants.gender) ?? "";
    });
  }

  void _refreshStatistics() {
    if (_fromDate != null && _toDate != null) {
      context.read<LeaveApprovalBloc>().add(LeaveApprovalEvent.statisticsRequested(
            employeeId: widget.employeeId,
            fromDate: _fromDate!.format(),
            toDate: _toDate!.format(),
          ));
    }
    _refreshBalance();
  }

  void _refreshBalance() {
    context.read<LeaveApprovalBloc>().add(LeaveApprovalEvent.balanceRequested(
          employeeId: widget.employeeId,
          todayDate: (_fromDate ?? DateTime.now()).format(),
          gender: _gender,
        ));
  }

  double get _totalDays => LeaveDateTimeUtils.calculateTotalDays(_fromDate, _toDate, _isHalfDay);

  bool get _isSickLeave => _leaveType == LeaveTypes.sickLeave;
  bool get _requiresSupportingDocs => _isSickLeave && _totalDays > 2;

  bool get _isSickLeaveDateInvalid => LeaveDateTimeUtils.isSickLeaveDateInvalid(_fromDate, _toDate, _isSickLeave);

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    if (!isFromDate && _fromDate == null) {
      final l10n = AppLocalizations.of(context)!;
      ToastUtils.showInfo(l10n.selectFromDateFirst);
      return;
    }

    final today = DateUtils.dateOnly(DateTime.now());
    final DateTime firstDate;
    final DateTime lastDate;
    final DateTime initial;

    if (isFromDate) {
      final bounds = LeaveDateTimeUtils.getFromDateBounds(_leaveType);
      firstDate = bounds.firstDate;
      lastDate = bounds.lastDate;
      initial = (_fromDate != null &&
          !_fromDate!.isBefore(firstDate) &&
          !_fromDate!.isAfter(lastDate))
          ? _fromDate!
          : (today.isBefore(firstDate) ? firstDate : (today.isAfter(lastDate) ? lastDate : today));
    } else {
      firstDate = _fromDate!;
      lastDate = LeaveDateTimeUtils.getLastDate(_isSickLeave);

      // Ensure initial is within bounds
      final validInitial = (_toDate != null && !_toDate!.isBefore(firstDate) && !_toDate!.isAfter(lastDate))
          ? _toDate!
          : (firstDate.isAfter(lastDate) ? lastDate : firstDate);
      initial = validInitial;
    }

    _cachedHolidays = context.read<LeaveApprovalBloc>().state.statistics?.details.appliedLeaves
        .whereType<Map<String, dynamic>>()
        .where((e) => e['is_holiday'] == true)
        .map<DateTime>((e) => DateUtils.dateOnly(DateTime.parse(e['date'] as String)))
        .toList() ??
        <DateTime>[];

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: firstDate,
      lastDate: lastDate,
      selectableDayPredicate: (day) => !LeaveDateTimeUtils.isWeekend(day),
    );

    if (picked == null) return;

    if (LeaveDateTimeUtils.isWeekend(picked) || LeaveDateTimeUtils.isHoliday(picked, _cachedHolidays)) {
      ToastUtils.showError(AppLocalizations.of(context)!.weekendHolidayError);
      return;
    }

    setState(() {
      if (isFromDate) {
        _fromDate = picked;
        if (_isHalfDay) {
          _toDate = picked;
          _halfDayDate = picked;
        } else {
          _toDate = null;
          _halfDayDate = null;
        }
      } else {
        _toDate = picked;
      }

      if (_isHalfDay) {
        if (_fromDate != null && _toDate != null) {
          if (_fromDate == _toDate) {
            _halfDayDate = _fromDate;
          } else if (_halfDayDate != null) {
            if (_halfDayDate!.isBefore(_fromDate!) ||
                _halfDayDate!.isAfter(_toDate!)) {
              _halfDayDate = null;
            }
          }
        }
      }
    });
    _refreshStatistics();
    _checkOverlap();
  }

  void _checkOverlap() {
    if (_fromDate != null && _toDate != null) {
      setState(() {
        _hideOverlapAfterSubmit = false;
      });
      context.read<LeaveApprovalBloc>().add(LeaveApprovalEvent.overlapLeavesRequested(
        employeeId: widget.employeeId,
        fromDate: _fromDate!.format(),
        toDate: _toDate!.format(),
      ));
    }
  }

  Future<void> _selectHalfDayDate(BuildContext context) async {
    if (_fromDate == null || _toDate == null) return;
    if (_fromDate == _toDate) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _halfDayDate ?? _fromDate!,
      firstDate: _fromDate!,
      lastDate: _toDate!,
    );
    if (picked != null) {
      setState(() => _halfDayDate = picked);
      _refreshStatistics();
    }
  }

  Future<void> _pickAndUploadFile() async {
    final l10n = AppLocalizations.of(context)!;

    if (!FileValidationUtils.canUploadMore(
      currentCount: _uploadCount,
      l10n: l10n,
    )) return;

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: FileValidationUtils.leaveAllowedExtensions,
    );

    if (result != null && result.files.single.path != null) {
      final file = result.files.single;

      if (!FileValidationUtils.validateFile(
        file: file,
        l10n: l10n,
      )) return;

      setState(() => _uploadCount++);

      String finalPath = file.path!;
      final extension = p.extension(finalPath).toLowerCase();
      if (['.jpg', '.jpeg', '.png'].contains(extension)) {
        final imageCompressService = Get.find<ImageCompressService>();
        final compressedFile = await imageCompressService.compressImage(finalPath);
        if (compressedFile != null) {
          finalPath = compressedFile.path;
        }
      }

      setState(() => _selectedFileName = file.name);

      if (mounted) {
        context.read<LeaveApprovalBloc>().add(LeaveApprovalEvent.uploadFileRequested(
          filePath: finalPath,
          fileName: file.name,
          employeeId: widget.leave.name,
        ));
      }
    }
  }

  void _submitForm() {

    if (_formKey.currentState!.validate()) {
      setState(() {
        _hideOverlapAfterSubmit = true;
      });
      final String fromStr = (_fromDate ?? DateTime.now()).format();
      final String toStr = (_toDate ?? DateTime.now()).format();

      context.read<LeaveApprovalBloc>().add(LeaveApprovalEvent.updateRequested(
        leaveId: widget.leave.name,
        employeeId: widget.leave.employee,
        employeeName: widget.leave.employeeName,
        leaveType: _leaveType!,
        fromDate: fromStr,
        toDate: toStr,
        reason: _reasonController.text,
        halfDay: _isHalfDay ? 1 : 0,
        halfDayDate: _isHalfDay && _halfDayDate != null ? _halfDayDate!.format() : null,
        halfDaySegment: _isHalfDay ? _daySegment : null,
        totalleavedays: _totalDays,
        workflowState: LeaveStatusConstants.pending,
        attachment: context.read<LeaveApprovalBloc>().state.uploadedFileUrl ??
            (widget.leave.fileUrl?.isAbsoluteUrl == true
                ? Uri.parse(widget.leave.fileUrl!).path
                : widget.leave.fileUrl),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<LeaveApprovalBloc, LeaveApprovalState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeaveCardSection(
                title: l10n.requestDetails,
                child: Column(
                  children: [
                    LeaveTypeDropdown(
                      l10n: l10n,
                      state: state,
                      currentLeaveType: _leaveType,
                      gender: _gender,
                      onChanged: (val) {
                        setState(() => _leaveType = val);
                        _refreshBalance();
                      },
                    ),
                    const SizedBox(height: AppConstants.p20),
                    LeaveHalfDayToggle(
                      l10n: l10n,
                      isHalfDay: _isHalfDay,
                      onChanged: (val) {
                        setState(() {
                          _isHalfDay = val;
                          if (val && _fromDate != null) {
                            _toDate = _fromDate;
                            _halfDayDate = _fromDate;
                          }
                        });
                      },
                    ),
                    SizedBox(height: AppConstants.p20),
                    LeaveDateRangePickers(
                      l10n: l10n,
                      fromDate: _fromDate,
                      toDate: _toDate,
                      onFromDateTap: () => _selectDate(context, true),
                      onToDateTap: () => _selectDate(context, false),
                      isToDateReadOnly: _isHalfDay,
                    ),
                    if (_isSickLeaveDateInvalid) ...[
                      SizedBox(height: AppConstants.p8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.sickLeaveDateInvalid,
                          style: AppTextStyle.bodySmall.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                    if (_isHalfDay) ...[
                      const SizedBox(height: AppConstants.p16),
                      LeaveHalfDayDetails(
                        l10n: l10n,
                        daySegment: _daySegment,
                        onSegmentChanged: (val) => setState(() => _daySegment = val),
                        halfDayDate: _halfDayDate,
                        onDateTap: () => _selectHalfDayDate(context),
                        isDateReadOnly: (_fromDate != null && _toDate != null && _fromDate == _toDate),
                      ),
                    ],
                    const SizedBox(height: AppConstants.p20),
                    LeaveReasonField(
                      l10n: l10n,
                      controller: _reasonController,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.p24),
              if (_requiresSupportingDocs) ...[
                LeaveCardSection(
                  title: l10n.supportingDocuments,
                  child: LeaveFileUploadSection(
                    l10n: l10n,
                    state: state,
                    selectedFileName: _selectedFileName,
                    onPickFile: _pickAndUploadFile,
                  ),
                ),
                const SizedBox(height: AppConstants.p24),
              ],
              LeaveGuidelines(l10n: l10n),
              const SizedBox(height: AppConstants.p24),
              LeaveOverlapSection(hideOverlapAfterSubmit: _hideOverlapAfterSubmit),
              const SizedBox(height: AppConstants.p32),
              LeaveActionButtons(
                l10n: l10n,
                state: state,
                onSubmit: _submitForm,
                disableSubmit: (_requiresSupportingDocs && state.uploadedFileUrl == null) || _isSickLeaveDateInvalid,
              ),
            ],
          ),
        );
      },
    );
  }
}

