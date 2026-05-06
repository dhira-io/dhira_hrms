import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/constants/leave_constants.dart';
import 'package:dhira_hrms/core/constants/storage_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_bloc.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_event.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_state.dart';
import 'package:dhira_hrms/features/leave/presentation/widgets/dashed_border_painter.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _checkOverlap();
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

  double get _totalDays {
    if (_fromDate == null || _toDate == null) return 0;
    if (_isHalfDay) return 0.5;
    return _toDate!.difference(_fromDate!).inDays.toDouble() + 1.0;
  }

  bool get _isSickLeave => _leaveType == LeaveTypes.sickLeave;
  bool get _requiresSupportingDocs => _isSickLeave && _totalDays > 2;

  ({DateTime firstDate, DateTime lastDate}) _fromDateBounds() {
    final today = DateUtils.dateOnly(DateTime.now());
    final isPastAllowed = _leaveType == LeaveTypes.bereavementLeave ||
        _leaveType == LeaveTypes.sickLeave;
    return (
      firstDate: isPastAllowed ? today.subtract(const Duration(days: 365)) : today,
      lastDate: isPastAllowed ? today : today.add(const Duration(days: 365)),
    );
  }

  bool _isWeekend(DateTime date) =>
      date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;

  bool _isHoliday(DateTime date, List<DateTime> holidays) {
    final day = DateUtils.dateOnly(date);
    return holidays.any((h) => DateUtils.isSameDay(h, day));
  }

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
      final bounds = _fromDateBounds();
      firstDate = bounds.firstDate;
      lastDate = bounds.lastDate;
      initial = (_fromDate != null &&
              !_fromDate!.isBefore(firstDate) &&
              !_fromDate!.isAfter(lastDate))
          ? _fromDate!
          : (today.isBefore(firstDate) ? firstDate : (today.isAfter(lastDate) ? lastDate : today));
    } else {
      firstDate = _fromDate!;
      lastDate = today.add(const Duration(days: 365));
      initial = (_toDate != null && !_toDate!.isBefore(firstDate))
          ? _toDate!
          : firstDate;
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
      selectableDayPredicate: (day) => !_isWeekend(day),
    );

    if (picked == null) return;

    if (_isWeekend(picked) || _isHoliday(picked, _cachedHolidays)) {
      ToastUtils.showError(AppLocalizations.of(context)!.weekendHolidayError);
      return;
    }

    setState(() {
      if (isFromDate) {
        _fromDate = picked;
        _toDate = null;
        _halfDayDate = null;
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
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'xlsx', 'jpg', 'png'],
    );

    if (result != null && result.files.single.path != null) {
      final file = result.files.single;
      setState(() => _selectedFileName = file.name);
      
      if (mounted) {
        context.read<LeaveApprovalBloc>().add(LeaveApprovalEvent.uploadFileRequested(
          filePath: file.path!,
          fileName: file.name,
          employeeId: widget.employeeId,
        ));
      }
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
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
        workflowState: "Pending",
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
                    LeaveDateRangePickers(
                      l10n: l10n,
                      fromDate: _fromDate,
                      toDate: _toDate,
                      onFromDateTap: () => _selectDate(context, true),
                      onToDateTap: () => _selectDate(context, false),
                    ),
                    const SizedBox(height: AppConstants.p20),
                    LeaveHalfDayToggle(
                      l10n: l10n,
                      isHalfDay: _isHalfDay,
                      onChanged: (val) {
                        setState(() {
                          _isHalfDay = val;
                          if (val && _fromDate != null && _toDate != null) {
                            if (_fromDate == _toDate) {
                              _halfDayDate = _fromDate;
                            }
                          }
                        });
                      },
                    ),
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
              const LeaveOverlapSection(),
              const SizedBox(height: AppConstants.p32),
              LeaveActionButtons(
                l10n: l10n,
                state: state,
                onSubmit: _submitForm,
              ),
            ],
          ),
        );
      },
    );
  }
}

class LeaveCardSection extends StatelessWidget {
  final String title;
  final Widget child;

  const LeaveCardSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.r20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppConstants.p20),
          child,
        ],
      ),
    );
  }
}

class LeaveLabel extends StatelessWidget {
  final String label;

  const LeaveLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
      child: Text(
        label,
        style: AppTextStyle.labelMedium.copyWith(
          color: AppColors.onSurfaceVariant,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class LeaveDatePickerField extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isReadOnly;

  const LeaveDatePickerField({
    super.key,
    required this.text,
    this.onTap,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isReadOnly ? null : onTap,
      borderRadius: BorderRadius.circular(AppConstants.r12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.p16,
          vertical: AppConstants.p14,
        ),
        decoration: BoxDecoration(
          color: isReadOnly
              ? AppColors.surfaceContainerLow.withValues(alpha: 0.5)
              : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppConstants.r12),
          border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppTextStyle.bodyMedium.copyWith(
                color: isReadOnly ? AppColors.outline : AppColors.onSurface,
              ),
            ),
            Icon(
              Icons.calendar_today_rounded,
              color: isReadOnly
                  ? AppColors.outline.withValues(alpha: 0.5)
                  : AppColors.primary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class LeaveTypeDropdown extends StatelessWidget {
  final AppLocalizations l10n;
  final LeaveApprovalState state;
  final String? currentLeaveType;
  final String gender;
  final ValueChanged<String?> onChanged;

  const LeaveTypeDropdown({
    super.key,
    required this.l10n,
    required this.state,
    required this.currentLeaveType,
    required this.gender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filteredLeaveTypes = state.leaveTypes.where((type) {
      final typeName = type.name.toLowerCase();
      final userGender = gender.toLowerCase();
      if (userGender == 'male' &&
          typeName.contains(LeaveTypes.maternityLeave.toLowerCase())) {
        return false;
      }
      if (userGender == 'female' &&
          typeName.contains(LeaveTypes.paternityLeave.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LeaveLabel(label: l10n.leaveType),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppConstants.r12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              value: filteredLeaveTypes.any((e) => e.name == currentLeaveType)
                  ? currentLeaveType
                  : null,
              items: filteredLeaveTypes.map((type) {
                return DropdownMenuItem(
                  value: type.name,
                  child: Text(type.name, style: AppTextStyle.bodyMedium),
                );
              }).toList(),
              onChanged: onChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColors.primary),
              validator: (val) => val == null ? l10n.required : null,
            ),
          ),
        ),
      ],
    );
  }
}

class LeaveDateRangePickers extends StatelessWidget {
  final AppLocalizations l10n;
  final DateTime? fromDate;
  final DateTime? toDate;
  final VoidCallback onFromDateTap;
  final VoidCallback onToDateTap;

  const LeaveDateRangePickers({
    super.key,
    required this.l10n,
    required this.fromDate,
    required this.toDate,
    required this.onFromDateTap,
    required this.onToDateTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeaveLabel(label: l10n.fromDate),
              LeaveDatePickerField(
                text: fromDate == null ? "" : fromDate!.format(),
                onTap: onFromDateTap,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppConstants.p16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeaveLabel(label: l10n.toDate),
              LeaveDatePickerField(
                text: toDate == null ? "" : toDate!.format(),
                onTap: onToDateTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LeaveHalfDayToggle extends StatelessWidget {
  final AppLocalizations l10n;
  final bool isHalfDay;
  final ValueChanged<bool> onChanged;

  const LeaveHalfDayToggle({
    super.key,
    required this.l10n,
    required this.isHalfDay,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p16,
        vertical: AppConstants.p4,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppConstants.r12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.wb_sunny_rounded,
                color: isHalfDay ? AppColors.primary : AppColors.outline,
                size: 20,
              ),
              const SizedBox(width: AppConstants.p12),
              Text(l10n.halfDayToggle, style: AppTextStyle.bodyMedium),
            ],
          ),
          Switch.adaptive(
            value: isHalfDay,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class LeaveHalfDayDetails extends StatelessWidget {
  final AppLocalizations l10n;
  final String? daySegment;
  final ValueChanged<String?> onSegmentChanged;
  final DateTime? halfDayDate;
  final VoidCallback onDateTap;
  final bool isDateReadOnly;

  const LeaveHalfDayDetails({
    super.key,
    required this.l10n,
    required this.daySegment,
    required this.onSegmentChanged,
    required this.halfDayDate,
    required this.onDateTap,
    required this.isDateReadOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LeaveLabel(label: l10n.daySegment),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppConstants.p12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(AppConstants.r12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        value: daySegment,
                        items: [l10n.firstHalf, l10n.secondHalf]
                            .map((s) => DropdownMenuItem(
                                value: s,
                                child: Text(s, style: AppTextStyle.bodyMedium)))
                            .toList(),
                        onChanged: onSegmentChanged,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        validator: (val) => val == null ? l10n.required : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.p16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LeaveLabel(label: l10n.halfDayDate),
                  LeaveDatePickerField(
                    text: halfDayDate == null ? "" : halfDayDate!.format(),
                    onTap: onDateTap,
                    isReadOnly: isDateReadOnly,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LeaveReasonField extends StatelessWidget {
  final AppLocalizations l10n;
  final TextEditingController controller;

  const LeaveReasonField({
    super.key,
    required this.l10n,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LeaveLabel(label: l10n.reasonForLeave),
        TextFormField(
          controller: controller,
          maxLines: 3,
          style: AppTextStyle.bodyMedium,
          decoration: InputDecoration(
            hintText: l10n.provideReasonHint,
            filled: true,
            fillColor: AppColors.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.r12),
              borderSide: BorderSide(
                  color: AppColors.outlineVariant.withValues(alpha: 0.5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.r12),
              borderSide: BorderSide(
                  color: AppColors.outlineVariant.withValues(alpha: 0.5)),
            ),
          ),
          validator: (val) => val == null || val.isEmpty ? l10n.required : null,
        ),
      ],
    );
  }
}

class LeaveFileUploadSection extends StatelessWidget {
  final AppLocalizations l10n;
  final LeaveApprovalState state;
  final String? selectedFileName;
  final VoidCallback onPickFile;

  const LeaveFileUploadSection({
    super.key,
    required this.l10n,
    required this.state,
    required this.selectedFileName,
    required this.onPickFile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          painter: DashedBorderPainter(color: AppColors.outlineVariant),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.p24),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppConstants.p12),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryFixed,
                    shape: BoxShape.circle,
                  ),
                  child: state.isUploading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primary,
                          ),
                        )
                      : Icon(
                          state.uploadedFileUrl != null
                              ? Icons.check_circle_outline
                              : Icons.cloud_upload_outlined,
                          color: state.uploadedFileUrl != null
                              ? Colors.green
                              : AppColors.primary,
                        ),
                ),
                const SizedBox(height: AppConstants.p12),
                Text(
                  selectedFileName ?? l10n.dragAndDrop,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: state.uploadedFileUrl != null
                        ? Colors.green
                        : AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (state.uploadError != null) ...[
                  const SizedBox(height: AppConstants.p8),
                  Text(
                    state.uploadError!,
                    style: AppTextStyle.bodySmall
                        .copyWith(color: Colors.red, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: AppConstants.p8),
                ElevatedButton(
                  onPressed: state.isUploading ? null : onPickFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColors.primary,
                    elevation: 0,
                    side: BorderSide(
                        color: AppColors.primary.withValues(alpha: 0.2)),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    state.uploadedFileUrl != null ? l10n.changeFile : l10n.browseFiles,
                    style: AppTextStyle.button
                        .copyWith(fontSize: 12, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppConstants.p20),
        Container(
          padding: const EdgeInsets.all(AppConstants.p16),
          decoration: BoxDecoration(
            color: AppColors.tertiaryContainer.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppConstants.r12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.tertiaryContainer,
                size: 20,
              ),
              const SizedBox(width: AppConstants.p12),
              Expanded(
                child: Text(
                  l10n.medicalWarning,
                  style: AppTextStyle.bodySmall
                      .copyWith(color: AppColors.tertiary, height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LeaveGuidelines extends StatelessWidget {
  final AppLocalizations l10n;

  const LeaveGuidelines({super.key, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: AppColors.outlineVariant, height: 1),
        const SizedBox(height: AppConstants.p24),
        Text(
          l10n.leaveRequestGuidelines.toUpperCase(),
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.outline,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: AppConstants.p12),
        _GuidelineItem(text: l10n.guideline1),
        const SizedBox(height: AppConstants.p8),
        _GuidelineItem(text: l10n.guideline2),
        const SizedBox(height: AppConstants.p8),
        _GuidelineItem(text: l10n.guideline3),
        const SizedBox(height: AppConstants.p8),
        _GuidelineItem(text: l10n.guideline4),
        const SizedBox(height: AppConstants.p8),
        _GuidelineItem(text: l10n.guideline5),
        const SizedBox(height: AppConstants.p8),
        _GuidelineItem(text: l10n.guideline6),
      ],
    );
  }
}

class _GuidelineItem extends StatelessWidget {
  final String text;

  const _GuidelineItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppConstants.p12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.5,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}

class LeaveOverlapSection extends StatelessWidget {
  const LeaveOverlapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveApprovalBloc, LeaveApprovalState>(
      builder: (context, state) {
        if (state.overlapLeaves.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppConstants.p24),
            Text(
              "CONFLICTING LEAVES",
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.outline,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: AppConstants.p12),
            ...state.overlapLeaves.map((leave) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.errorContainer.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppColors.error.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline,
                          color: AppColors.error, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${leave.employeeName} is on ${leave.leaveType} from ${leave.fromDate} to ${leave.toDate}",
                          style: AppTextStyle.bodySmall
                              .copyWith(color: AppColors.error),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        );
      },
    );
  }
}

class LeaveActionButtons extends StatelessWidget {
  final AppLocalizations l10n;
  final LeaveApprovalState state;
  final VoidCallback onSubmit;

  const LeaveActionButtons({
    super.key,
    required this.l10n,
    required this.state,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.cancel,
              style: TextStyle(color: AppColors.onSurfaceVariant),
            ),
          ),
        ),
        const SizedBox(width: AppConstants.p16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: state.isLoading ? null : onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.r12),
              ),
              elevation: 0,
            ),
            child: state.isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    l10n.submit,
                    style: AppTextStyle.button.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
