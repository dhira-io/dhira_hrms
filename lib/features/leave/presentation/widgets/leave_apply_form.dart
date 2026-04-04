import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/components/mandatory_label.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../bloc/leave_state.dart';
import 'leave_type_dropdown.dart';

class LeaveApplyForm extends StatefulWidget {
  final String employeeId;

  const LeaveApplyForm({
    super.key,
    required this.employeeId,
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

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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
      });
    }
  }

  void _submitForm() {
    final l10n = AppLocalizations.of(context)!;
    if (_formKey.currentState!.validate()) {
      if (!_isHalfDay && (_fromDate == null || _toDate == null)) {
        ToastUtils.showError(l10n.selectDateRangeError);
        return;
      }
      if (_isHalfDay && _halfDayDate == null) {
        ToastUtils.showError(l10n.selectHalfDayDateError);
        return;
      }
      if (_leaveType == null) {
        ToastUtils.showError(l10n.selectLeaveTypeError);
        return;
      }

      context.read<LeaveBloc>().add(LeaveEvent.applyRequested(
            employeeId: widget.employeeId,
            leaveType: _leaveType!,
            fromDate: DateFormat('yyyy-MM-dd').format(_fromDate ?? DateTime.now()),
            toDate: DateFormat('yyyy-MM-dd').format(_toDate ?? DateTime.now()),
            reason: _reasonController.text,
            halfDay: _isHalfDay ? 1 : 0,
            halfDayDate: _isHalfDay && _halfDayDate != null ? DateFormat('yyyy-MM-dd').format(_halfDayDate!) : null,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<LeaveBloc, LeaveState>(
      builder: (context, state) {
        final isLoading = state == const LeaveState.loading();

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeaveTypeDropdown(
                value: _leaveType,
                onChanged: (val) => setState(() => _leaveType = val),
              ),
              const SizedBox(height: AppConstants.p20),
              Row(
                children: [
                  Checkbox(
                    value: _isHalfDay,
                    onChanged: (val) => setState(() => _isHalfDay = val ?? false),
                    activeColor: AppColors.primary,
                  ),
                  Text(l10n.halfDay, style: AppTextStyle.bodyLarge),
                ],
              ),
              if (_isHalfDay) ...[
                MandatoryLabel(labelText: l10n.halfDayDate),
                _DatePickerField(
                  selectedDate: _halfDayDate,
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now().add(const Duration(days: 90)),
                    );
                    if (picked != null) setState(() => _halfDayDate = picked);
                  },
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MandatoryLabel(labelText: l10n.fromDate),
                          _DatePickerField(
                            selectedDate: _fromDate,
                            onTap: () => _selectDate(context, true),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppConstants.p15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MandatoryLabel(labelText: l10n.toDate),
                          _DatePickerField(
                            selectedDate: _toDate,
                            onTap: () => _selectDate(context, false),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: AppConstants.p20),
              MandatoryLabel(labelText: l10n.reason),
              TextFormField(
                controller: _reasonController,
                maxLines: 3,
                style: AppTextStyle.bodyMedium,
                decoration: InputDecoration(hintText: l10n.enterReason),
                validator: (val) => val == null || val.isEmpty ? l10n.required : null,
              ),
              const SizedBox(height: AppConstants.p32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submitForm,
                  child: isLoading 
                    ? const CircularProgressIndicator(color: AppColors.surface) 
                    : Text(l10n.submit, style: AppTextStyle.button),
                ),
              ),
            ],
          ),
        );
      },
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
        padding: const EdgeInsets.all(AppConstants.p12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppConstants.r8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate == null ? l10n.selectDate : DateFormat('yyyy-MM-dd').format(selectedDate!),
              style: AppTextStyle.bodyMedium,
            ),
            const Icon(Icons.calendar_today, size: AppConstants.iconSmall),
          ],
        ),
      ),
    );
  }
}


