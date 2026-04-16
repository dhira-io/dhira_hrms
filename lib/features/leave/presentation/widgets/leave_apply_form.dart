import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../bloc/leave_state.dart';
import 'leave_employee_details_card.dart';
import 'leave_dates_reason_card.dart';
import 'leave_summary_card.dart';
import 'leave_action_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';

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
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _leaveType;
  final TextEditingController _reasonController = TextEditingController();
  bool _isHalfDay = false;
  DateTime? _halfDayDate;

  String _empName = "";
  String _department = "";
  String _approver = "";

  @override
  void initState() {
    super.initState();
    _loadEmpDetails();
    if (widget.leave != null) {
      _leaveType = widget.leave!.leaveType;
      _fromDate = DateTime.tryParse(widget.leave!.fromDate);
      _toDate = DateTime.tryParse(widget.leave!.toDate);
      _isHalfDay = widget.leave!.halfDay == 1;
      _halfDayDate = widget.leave!.halfDayDate != null ? DateTime.tryParse(widget.leave!.halfDayDate!) : null;
      _reasonController.text = widget.leave!.description ?? ""; 
    }
  }

  Future<void> _loadEmpDetails() async {
    final l10n = AppLocalizations.of(context)!;
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _empName = prefs.getString(StorageConstants.empName) ?? l10n.user;
      _department = prefs.getString(StorageConstants.department) ?? l10n.notAvailable;
      _approver = prefs.getString(StorageConstants.leaveApproverName) ?? l10n.notAssigned;
    });
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final now = DateTime.now();
    final DateTime first;
    final DateTime initial;

    if (isFromDate) {
      first = now.subtract(const Duration(days: 365));
      initial = _fromDate ?? now;
    } else {
      first = _fromDate ?? now;
      initial = (_toDate != null && !_toDate!.isBefore(first)) ? _toDate! : first;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
          if (_toDate != null && _toDate!.isBefore(_fromDate!)) {
            _toDate = _fromDate;
          }
        } else {
          _toDate = picked;
        }
        if (_fromDate != null && _toDate != null && _fromDate == _toDate) {
          _halfDayDate = _fromDate;
        } else if (_halfDayDate != null && _fromDate != null && _toDate != null) {
          if (_halfDayDate!.isBefore(_fromDate!) || _halfDayDate!.isAfter(_toDate!)) {
            _halfDayDate = null;
          }
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final String fromStr = DateFormat('yyyy-MM-dd').format(_fromDate ?? DateTime.now());
      final String toStr = DateFormat('yyyy-MM-dd').format(_toDate ?? DateTime.now());

      if (widget.leave == null) {
        context.read<LeaveBloc>().add(LeaveEvent.applyRequested(
              employeeId: widget.employeeId,
              leaveType: _leaveType!,
              fromDate: fromStr,
              toDate: toStr,
              reason: _reasonController.text,
              halfDay: _isHalfDay ? 1 : 0,
              halfDayDate: _isHalfDay && _halfDayDate != null ? DateFormat('yyyy-MM-dd').format(_halfDayDate!) : null,
            ));
      } else {
        context.read<LeaveBloc>().add(LeaveEvent.updateRequested(
              leaveId: widget.leave!.name,
              fromDate: fromStr,
              toDate: toStr,
              reason: _reasonController.text,
              halfDay: _isHalfDay ? 1 : 0,
              halfDayDate: _isHalfDay && _halfDayDate != null ? DateFormat('yyyy-MM-dd').format(_halfDayDate!) : null,
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
              _buildSectionTitle(l10n.employeeDetails),
              LeaveEmployeeDetailsCard(
                empName: _empName,
                department: _department,
                approver: _approver,
              ),
              const SizedBox(height: AppConstants.p24),
              _buildSectionTitle(l10n.datesAndReason),
              LeaveDatesReasonCard(
                fromDate: _fromDate,
                toDate: _toDate,
                isHalfDay: _isHalfDay,
                halfDayDate: _halfDayDate,
                leaveType: _leaveType,
                leaveTypes: state.leaveTypes,
                reasonController: _reasonController,
                onSelectDate: (isFromDate) => _selectDate(context, isFromDate),
                onToggleHalfDay: () => setState(() => _isHalfDay = !_isHalfDay),
                onSelectHalfDayDate: () async {
                  if (_fromDate == null || _toDate == null) return;
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _halfDayDate ?? _fromDate!,
                    firstDate: _fromDate!,
                    lastDate: _toDate!,
                  );
                  if (picked != null) setState(() => _halfDayDate = picked);
                },
                onLeaveTypeChanged: (val) => setState(() => _leaveType = val),
              ),
              const SizedBox(height: AppConstants.p24),
              _buildSectionTitle(l10n.summary),
              LeaveSummaryCard(balance: state.balance),
              const SizedBox(height: AppConstants.p32),
              LeaveActionButtons(
                isLoading: state.isLoading,
                isEdit: widget.leave != null,
                onSubmit: _submitForm,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.p12),
      child: Text(
        title,
        style: AppTextStyle.bodyLarge.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}


