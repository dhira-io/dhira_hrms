import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../bloc/leave_state.dart';
import 'leave_type_dropdown.dart';
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
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _empName = prefs.getString(StorageConstants.empName) ?? "Unknown Employee";
      _department = prefs.getString(StorageConstants.department) ?? "N/A";
      _approver = prefs.getString(StorageConstants.leaveApproverName) ?? "Not Assigned";
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
        // Auto-set half day date when from and to dates are the same
        if (_fromDate != null && _toDate != null && _fromDate == _toDate) {
          _halfDayDate = _fromDate;
        }
        // Reset half day date if it's outside the new range
        else if (_halfDayDate != null && _fromDate != null && _toDate != null) {
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
              _buildEmployeeDetailsCard(l10n),
              const SizedBox(height: 24),
              _buildSectionTitle(l10n.datesAndReason),
              _buildDatesAndReasonCard(l10n, state),
              const SizedBox(height: 24),
              _buildSectionTitle(l10n.summary),
              _buildSummaryCard(l10n, state),
              const SizedBox(height: 32),
              _buildActionButtons(l10n, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: AppTextStyle.bodyLarge.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildEmployeeDetailsCard(AppLocalizations l10n) {
    return Card(
      elevation: 0.1,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildDetailRow(l10n.employeeName, _empName),
            const Divider(height: 24, color: AppColors.bordergrey),
            _buildDetailRow(l10n.department, _department),
            const Divider(height: 24, color: AppColors.bordergrey),
            _buildDetailRow(l10n.approver, _approver),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildDatesAndReasonCard(AppLocalizations l10n, LeaveState state) {
    return Card(
      elevation: 0.1,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateRangeFields(l10n),
            const SizedBox(height: 20),
            _buildHalfDayToggle(l10n),
            if (_isHalfDay) ...[
              const SizedBox(height: 12),
              Text(l10n.halfDayDate, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _DatePickerField(
                selectedDate: _halfDayDate,
                onTap: () async {
                  if (_fromDate == null || _toDate == null) return;
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _halfDayDate ?? _fromDate!,
                    firstDate: _fromDate!,
                    lastDate: _toDate!,
                  );
                  if (picked != null) setState(() => _halfDayDate = picked);
                },
              ),
            ],
            const SizedBox(height: 20),
            Text(l10n.leaveType, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            LeaveTypeDropdown(
              value: _leaveType,
              leaveTypes: state.leaveTypes,
              onChanged: (val) => setState(() => _leaveType = val),
            ),
            const SizedBox(height: 20),
            Text(l10n.reason, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _reasonController,
              maxLines: 4,
              style: AppTextStyle.bodyMedium,
              decoration: InputDecoration(
                hintText: l10n.pleaseProvideReason,
                hintStyle: TextStyle(color: AppColors.placeholdergrey),
                filled: true,
                fillColor: AppColors.background,
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.bordergrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.bordergrey),
                ),
              ),
              validator: (val) => val == null || val.isEmpty ? l10n.required : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(AppLocalizations l10n, LeaveState state) {
    return Card(
      elevation: 0.1,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildSummaryTile(l10n.totalAllocated, state.balance.totalAllocated.toString(), false)),
                const SizedBox(width: 12),
                Expanded(child: _buildSummaryTile(l10n.used, state.balance.used.toString(), false)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildSummaryTile(l10n.pending, state.balance.pending.toString(), false, isOrange: true)),
                const SizedBox(width: 12),
                Expanded(child: _buildSummaryTile(l10n.available, state.balance.available.toString(), true)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryTile(String label, String value, bool isHighlighted, {bool isOrange = false}) {
    // Assuming iconbgblue provides a gentle highlight color
    final highlightBg = AppColors.iconbgblue; 
    // And assuming we just use primaryBlue for highlighted text
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isHighlighted ? highlightBg : AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: isHighlighted ? Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)) : null,
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: isHighlighted ? AppColors.primaryBlue : AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isHighlighted 
                  ? AppColors.primaryBlue
                  : (isOrange ? AppColors.pending : AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(AppLocalizations l10n, LeaveState state) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.bordergrey, // light grey matching original Colors.grey[200]
                foregroundColor: AppColors.textPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(l10n.cancel, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: state.isLoading ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: state.isLoading
                  ? const CircularProgressIndicator(color: AppColors.white)
                  : Text(
                      widget.leave == null ? l10n.submitApplication : l10n.updateApplication,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.white),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHalfDayToggle(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(l10n.halfDay, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
        Switch(
          value: _isHalfDay,
          onChanged: (val) => setState(() => _isHalfDay = val),
          activeThumbColor: AppColors.white,
          activeTrackColor: AppColors.primaryBlue,
          inactiveThumbColor: AppColors.white,
          inactiveTrackColor: AppColors.bordergrey,
        ),
      ],
    );
  }

  Widget _buildDateRangeFields(AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.fromDate, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _DatePickerField(
                selectedDate: _fromDate,
                onTap: () => _selectDate(context, true),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.toDate, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _DatePickerField(
                selectedDate: _toDate,
                onTap: () => _selectDate(context, false),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const _DatePickerField({
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
          border: Border.all(color: AppColors.bordergrey),
          borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
              selectedDate == null ? l10n.selectDate : DateFormat('yyyy-MM-dd').format(selectedDate!),
              style: AppTextStyle.bodyMedium,
                ),
            const Icon(Icons.calendar_today, size: 20, color: AppColors.textSecondary),
              ],
            ),
          ),
    );
  }
  }


