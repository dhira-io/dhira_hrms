import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../bloc/leave_state.dart';
import 'leave_type_dropdown.dart';
import '../../../../shared/components/mandatory_label.dart';
import '../../../../shared/dialogs/app_dialogs.dart';

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
    if (_formKey.currentState!.validate()) {
      if (!_isHalfDay && (_fromDate == null || _toDate == null)) {
        AppDialogs.showAlertDialog(context, "Please select from and to dates");
        return;
      }
      if (_isHalfDay && _halfDayDate == null) {
        AppDialogs.showAlertDialog(context, "Please select half-day date");
        return;
      }
      if (_leaveType == null) {
        AppDialogs.showAlertDialog(context, "Please select leave type");
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
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _isHalfDay,
                    onChanged: (val) => setState(() => _isHalfDay = val ?? false),
                  ),
                  const Text('Half Day'),
                ],
              ),
              if (_isHalfDay) ...[
                const MandatoryLabel(labelText: 'Half Day Date'),
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
                          const MandatoryLabel(labelText: 'From Date'),
                          _DatePickerField(
                            selectedDate: _fromDate,
                            onTap: () => _selectDate(context, true),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MandatoryLabel(labelText: 'To Date'),
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
              const SizedBox(height: 20),
              const MandatoryLabel(labelText: 'Reason'),
              TextFormField(
                controller: _reasonController,
                maxLines: 3,
                decoration: const InputDecoration(hintText: 'Enter reason for leave'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff1100CC), foregroundColor: Colors.white),
                  child: isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('SUBMIT'),
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
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedDate == null ? 'Select Date' : DateFormat('yyyy-MM-dd').format(selectedDate!)),
            const Icon(Icons.calendar_today, size: 16),
          ],
        ),
      ),
    );
  }
}
