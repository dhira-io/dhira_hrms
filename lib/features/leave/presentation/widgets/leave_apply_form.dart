import 'package:dhira_hrms/core/constants/storage_constants.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import '../../../../core/services/image_compress_service.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/leave_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../bloc/leave_state.dart';
import 'leave_stats_grid.dart';
import 'leave_balance_overview_card.dart';
import 'leave_apply/leave_overlap_section.dart';
import 'leave_apply/leave_request_guidelines.dart';
import 'leave_apply/leave_form_action_buttons.dart';
import 'leave_apply/leave_type_dropdown.dart';
import 'leave_apply/half_day_toggle.dart';
import 'leave_apply/leave_date_picker_field.dart';
import 'leave_apply/leave_reason_field.dart';
import 'leave_apply/leave_supporting_docs_upload.dart';
import 'leave_apply/leave_form_elements.dart';
import '../utils/leave_form_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dhira_hrms/core/utils/file_validation_utils.dart';
import 'dashed_border_painter.dart';
import 'package:file_picker/file_picker.dart';

class LeaveApplyForm extends StatefulWidget {
  final String employeeId;
  final LeaveEntity? leave;

  const LeaveApplyForm({
    super.key,
    required this.employeeId,
    this.leave,
  });

  @override
  State<LeaveApplyForm> createState() => _LeaveApplyFormState();
}

class _LeaveApplyFormState extends State<LeaveApplyForm> {
  final _formKey = GlobalKey<FormState>();
  final _toDateKey = GlobalKey<FormFieldState<DateTime>>();
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _leaveType;
  final TextEditingController _reasonController = TextEditingController();
  bool _isHalfDay = false;
  DateTime? _halfDayDate;
  String? _daySegment;

  String _empName = "";
  String _gender = "";

  bool _showOverlapDetails = false;
  bool _hideOverlapAfterSubmit = false;
  String? _selectedFileName;
  int _uploadCount = 0;
  List<DateTime> _cachedHolidays = [];

  double get _totalDays {
    if (_fromDate == null || _toDate == null) return 0;
    if (_isHalfDay) return 0.5;
    return _toDate!.difference(_fromDate!).inDays.toDouble() + 1.0;
  }

  bool get _isSickLeave => _leaveType == LeaveTypes.sickLeave;
  bool get _requiresSupportingDocs => _isSickLeave && _totalDays > 2;

  @override
  void initState() {
    super.initState();
    _loadEmpDetails();
    
    // Fetch initial leave statistics for the current month
    final now = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<LeaveBloc>().add(LeaveEvent.statisticsRequested(
          employeeId: widget.employeeId,
          fromDate: now.firstDayOfMonth.format(),
          toDate: now.lastDayOfMonth.format(),
        ));

        if (widget.leave != null) {
          _checkOverlap();
        }
      }
    });

    if (widget.leave != null) {
      _leaveType = widget.leave!.leaveType;
      _fromDate = DateTime.tryParse(widget.leave!.fromDate);
      _toDate = DateTime.tryParse(widget.leave!.toDate);
      _isHalfDay = widget.leave!.halfDay == 1;
      _halfDayDate = widget.leave!.halfDayDate != null ? DateTime.tryParse(widget.leave!.halfDayDate!) : null;
      _daySegment = widget.leave!.halfDaySegment;
      _reasonController.text = widget.leave!.description ?? ""; 
    }
  }

  void _refreshStatistics() {
    if (_fromDate != null && _toDate != null) {
      context.read<LeaveBloc>().add(LeaveEvent.statisticsRequested(
            employeeId: widget.employeeId,
            fromDate: _fromDate!.format(),
            toDate: _toDate!.format(),
          ));
    }
    _refreshBalance();
  }

  Future<void> _loadEmpDetails() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _empName = prefs.getString(StorageConstants.empName) ?? "";
      _gender = prefs.getString(StorageConstants.gender) ?? "";
    });
    
    // Call balance API after loading employee details
    if (mounted) {
      _refreshBalance();
    }
  }

  void _refreshBalance() {
    context.read<LeaveBloc>().add(LeaveEvent.balanceRequested(
          employeeId: widget.employeeId,
          todayDate: (_fromDate ?? DateTime.now()).format(),
          gender: _gender,
        ));
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  /// Returns the firstDate and lastDate bounds based on the selected leave type.
  /// Rules:
  ///   Bereavement Leave  → past & today only (no future)
  ///   Sick Leave         → past & today only (no future)
  ///   Casual Leave       → today & future only (no past)
  ///   Compensatory Off   → today & future only (no past)
  ///   All others         → today & future only (no past)


  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    if (!isFromDate && _fromDate == null) {
      final l10n = AppLocalizations.of(context)!;
      ToastUtils.showInfo(l10n.selectFromDateFirst);
      return;
    }

    final today = DateUtils.dateOnly(DateTime.now());

    // Compute first/last date for fromDate based on leave type.
    final DateTime firstDate;
    final DateTime lastDate;
    final DateTime initial;

    if (isFromDate) {
      final bounds = LeaveFormUtils.getFromDateBounds(_leaveType);
      firstDate = bounds.firstDate;
      lastDate = bounds.lastDate;
      initial = (_fromDate != null &&
              !_fromDate!.isBefore(firstDate) &&
              !_fromDate!.isAfter(lastDate))
          ? _fromDate!
          : (today.isBefore(firstDate) ? firstDate : (today.isAfter(lastDate) ? lastDate : today));
    } else {
      // toDate must be >= fromDate and at most 1 year ahead
      firstDate = _fromDate!;
      lastDate = today.add(const Duration(days: 365));
      initial = (_toDate != null && !_toDate!.isBefore(firstDate))
          ? _toDate!
          : firstDate;
    }

    // Cache holiday list synchronously BEFORE the async gap.
    _cachedHolidays = context.read<LeaveBloc>().state.statistics?.details.appliedLeaves
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
      selectableDayPredicate: (day) {
        // Block weekends directly in the picker
        return !DateTimeUtils.isWeekend(day);
      },
    );

    if (picked == null) return;

    // Secondary guard: show toast if weekend somehow slips through,
    // or if the date is a holiday stored in the BLoC state.
    // bloc ref captured before await - safe across async gap
    if (LeaveFormUtils.isWeekendOrHoliday(picked, _cachedHolidays)) {
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

      // Handle half-day date constraint
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
      context.read<LeaveBloc>().add(LeaveEvent.overlapLeavesRequested(
            employeeId: widget.employeeId,
            fromDate: _fromDate!.format(),
            toDate: _toDate!.format(),
          ));
    }
  }

  Future<void> _selectHalfDayDate(BuildContext context) async {
    if (_fromDate == null || _toDate == null) return;
    
    if (_fromDate == _toDate) return; // Same date, can't change

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

      setState(() {
        _selectedFileName = file.name;
      });

      if (mounted) {
        context.read<LeaveBloc>().add(LeaveEvent.uploadFileRequested(
          filePath: finalPath,
          fileName: file.name,
          employeeId: widget.employeeId,
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
      final double totalDays = _isHalfDay ? 0.5 : (_toDate!.difference(_fromDate!).inDays.toDouble() + 1.0);

      if (widget.leave == null) {
        final l10n = AppLocalizations.of(context)!;
        context.read<LeaveBloc>().add(LeaveEvent.applyRequested(
              employeeId: widget.employeeId,
              employeeName: _empName.isEmpty ? l10n.user : _empName,
              leaveType: _leaveType!,
              fromDate: fromStr,
              toDate: toStr,
              reason: _reasonController.text,
              halfDay: _isHalfDay ? 1 : 0,
              halfDayDate: _isHalfDay && _halfDayDate != null ? _halfDayDate!.format() : null,
              halfDaySegment: _isHalfDay ? _daySegment : null,
              totalleavedays: totalDays,
            ));
      } else {
        context.read<LeaveBloc>().add(LeaveEvent.updateRequested(
              leaveId: widget.leave!.name,
              fromDate: fromStr,
              toDate: toStr,
              reason: _reasonController.text,
              halfDay: _isHalfDay ? 1 : 0,
              halfDayDate: _isHalfDay && _halfDayDate != null ? _halfDayDate!.format() : null,
              halfDaySegment: _isHalfDay ? _daySegment : null,
              totalleavedays: totalDays,
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<LeaveBloc, LeaveState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeaveStatsGrid(balance: state.balance, isLoading: state.isLoading),
              const SizedBox(height: AppConstants.p20),
              LeaveBalanceOverviewCard(balance: state.balance, isLoading: state.isLoading),
              const SizedBox(height: AppConstants.p24),
              LeaveFormSectionTitle(title: l10n.requestDetails),
              const SizedBox(height: AppConstants.p16),
              _buildFormFields(l10n, state),
              const SizedBox(height: AppConstants.p24),
              const LeaveRequestGuidelines(),
              const SizedBox(height: AppConstants.p24),
              LeaveOverlapSection(
                overlapLeaves: state.overlapLeaves,
                hideOverlapAfterSubmit: _hideOverlapAfterSubmit,
              ),
              const SizedBox(height: AppConstants.p32),
              LeaveFormActionButtons(
                onCancel: () => Navigator.pop(context),
                onSubmit: _submitForm,
                isLoading: state.isLoading,
                isSubmitDisabled: state.isLoading ||
                    state.isUploading ||
                    (_requiresSupportingDocs && state.uploadedFileUrl == null),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildFormFields(AppLocalizations l10n, LeaveState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Leave Type
        LeaveFormLabel(label: l10n.leaveType),
        LeaveTypeDropdown(
          value: _leaveType,
          leaveTypes: state.leaveTypes,
          gender: _gender,
          onChanged: (val) => setState(() => _leaveType = val),
          validator: (val) => val == null ? l10n.required : null,
        ),
        const SizedBox(height: AppConstants.p20),

        // Half Day Toggle
        HalfDayToggle(
          value: _isHalfDay,
          onChanged: (val) {
            setState(() {
              _isHalfDay = val;
              if (val && _fromDate != null) {
                _toDate = _fromDate;
                _halfDayDate = _fromDate;
              }
              // Clear validation error for toDate if toggle is enabled
              if (val) {
                _toDateKey.currentState?.validate();
              }
            });
          },
        ),
        const SizedBox(height: AppConstants.p20),

        // Date Range
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LeaveFormLabel(label: l10n.fromDate),
                  FormField<DateTime>(
                    initialValue: _fromDate,
                    validator: (val) => _fromDate == null ? l10n.required : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    builder: (field) {
                      return LeaveDatePickerField(
                        text: _fromDate == null ? "" : _fromDate!.format(),
                        onTap: () async {
                          await _selectDate(context, true);
                          field.didChange(_fromDate);
                        },
                        errorText: field.errorText,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppConstants.p16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LeaveFormLabel(label: l10n.toDate),
                  FormField<DateTime>(
                    key: _toDateKey,
                    initialValue: _toDate,
                    validator: (val) => (_toDate == null && !_isHalfDay) ? l10n.required : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    builder: (field) {
                      return LeaveDatePickerField(
                        text: _toDate == null ? "" : _toDate!.format(),
                        onTap: _isHalfDay ? null : () async {
                          await _selectDate(context, false);
                          field.didChange(_toDate);
                        },
                        isReadOnly: _isHalfDay,
                        errorText: field.errorText,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.p20),

        if (_isHalfDay) ...[
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeaveFormLabel(label: l10n.halfDayDate),
                    FormField<DateTime>(
                      initialValue: _halfDayDate,
                      builder: (field) {
                        return LeaveDatePickerField(
                          text: _halfDayDate == null ? "" : _halfDayDate!.format(),
                          onTap: (_fromDate != null && _toDate != null && _fromDate == _toDate)
                              ? null
                              : () async {
                                  await _selectHalfDayDate(context);
                                  field.didChange(_halfDayDate);
                                },
                          isReadOnly: (_fromDate != null && _toDate != null && _fromDate == _toDate),
                          errorText: field.errorText,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppConstants.p16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeaveFormLabel(label: l10n.daySegment),
                    DropdownButtonFormField<String>(
                      value: _daySegment,
                      items: [l10n.firstHalf, l10n.secondHalf].map((segment) {
                        return DropdownMenuItem(
                          value: segment,
                          child: Text(segment, style: AppTextStyle.bodyMedium),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _daySegment = val),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.surfaceContainerHighest,
                        contentPadding: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p18),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.r12), borderSide: BorderSide.none),
                        errorStyle: AppTextStyle.bodySmall.copyWith(color: Colors.red),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      icon: const Icon(Icons.arrow_drop_down, color: AppColors.outline),
                      validator: (val) => val == null && _isHalfDay ? l10n.required : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p20),
        ],

        // Reason
        LeaveFormLabel(label: l10n.reasonForLeave),
        LeaveReasonField(
          controller: _reasonController,
          validator: (val) => val == null || val.isEmpty ? l10n.required : null,
        ),
        const SizedBox(height: AppConstants.p20),
        
        // Supporting Docs
        if (_requiresSupportingDocs) ...[
          LeaveFormLabel(label: l10n.supportingDocuments),
          LeaveSupportingDocsUpload(
            isUploading: state.isUploading,
            uploadedFileUrl: state.uploadedFileUrl,
            uploadError: state.uploadError,
            selectedFileName: _selectedFileName,
            onPickFile: _pickAndUploadFile,
          ),
          const SizedBox(height: AppConstants.p20),
        ],
      ],
    );
  }
}


