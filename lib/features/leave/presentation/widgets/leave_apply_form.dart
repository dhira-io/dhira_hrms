import 'package:dhira_hrms/core/constants/storage_constants.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../bloc/leave_state.dart';
import 'leave_stats_grid.dart';
import 'leave_balance_overview_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashed_border_painter.dart';

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
  String? _daySegment;

  String _empName = "";

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
      _daySegment = widget.leave!.halfDaySegment;
      _reasonController.text = widget.leave!.description ?? ""; 
    }
  }

  Future<void> _loadEmpDetails() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _empName = prefs.getString(StorageConstants.empName) ?? "";
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
          // Clear dependent dates as per user requirement
          _toDate = null;
          _halfDayDate = null;
        } else {
          _toDate = picked;
        }

        // Handle half-day date constraint
        if (_isHalfDay) {
          if (_fromDate != null && _toDate != null) {
            if (_fromDate == _toDate) {
              _halfDayDate = _fromDate;
            } else if (_halfDayDate != null) {
              if (_halfDayDate!.isBefore(_fromDate!) || _halfDayDate!.isAfter(_toDate!)) {
                _halfDayDate = null;
              }
            }
          }
        }
      });
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
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
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
              _buildSectionTitle(l10n.requestDetails),
              const SizedBox(height: AppConstants.p16),
              _buildFormFields(l10n, state),
              const SizedBox(height: AppConstants.p24),
              _buildGuidelines(l10n),
              const SizedBox(height: AppConstants.p32),
              _buildActionButtons(l10n, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.h3.copyWith(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.bold,
        color: AppColors.onSurface,
      ),
    );
  }

  Widget _buildFormFields(AppLocalizations l10n, LeaveState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Leave Type
        _buildLabel(l10n.leaveType),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppConstants.r12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              value: _leaveType,
              items: state.leaveTypes.map((type) {
                return DropdownMenuItem(
                  value: type.name,
                  child: Text(type.name, style: AppTextStyle.bodyMedium),
                );
              }).toList(),
              onChanged: (val) => setState(() => _leaveType = val),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                filled: true,
                fillColor: Colors.transparent,
              ),
              icon: const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.arrow_drop_down, color: AppColors.outline),
              ),
              validator: (val) => val == null ? l10n.required : null,
            ),
          ),
        ),
        const SizedBox(height: AppConstants.p20),

        // Date Range
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel(l10n.fromDate),
                  _buildDatePickerField(
                    _fromDate == null ? "" : _fromDate!.format(),
                    () => _selectDate(context, true),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppConstants.p16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel(l10n.toDate),
                  _buildDatePickerField(
                    _toDate == null ? "" : _toDate!.format(),
                    () => _selectDate(context, false),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.p20),

        // Half Day Toggle
        Container(
          padding: const EdgeInsets.all(AppConstants.p16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppConstants.r12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.wb_sunny_outlined, color: AppColors.onSurfaceVariant),
                  const SizedBox(width: AppConstants.p12),
                  Text(
                    l10n.halfDayToggle,
                    style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: _isHalfDay,
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
                    activeColor: Colors.white,
                    activeTrackColor: AppColors.primary,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: AppColors.outlineVariant.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),

          if (_isHalfDay) ...[
            const SizedBox(height: AppConstants.p16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel(l10n.halfDayDate),
                      _buildDatePickerField(
                        _halfDayDate == null ? "" : _halfDayDate!.format(),
                        (_fromDate != null && _toDate != null && _fromDate == _toDate) 
                            ? null // Read-only if same date
                            : () => _selectHalfDayDate(context),
                        isReadOnly: (_fromDate != null && _toDate != null && _fromDate == _toDate),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppConstants.p16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Day Segment"), // Using hardcoded for now or use l10n
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(AppConstants.r12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            value: _daySegment,
                            items: ["First Half", "Second Half"].map((segment) {
                              return DropdownMenuItem(
                                value: segment,
                                child: Text(segment, style: AppTextStyle.bodyMedium),
                              );
                            }).toList(),
                            onChanged: (val) => setState(() => _daySegment = val),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                            icon: const Icon(Icons.arrow_drop_down, color: AppColors.outline),
                            validator: (val) => val == null && _isHalfDay ? l10n.required : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        const SizedBox(height: AppConstants.p20),

        // Reason
        _buildLabel(l10n.reasonForLeave),
        TextFormField(
          controller: _reasonController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Please provide a brief reason for your leave...",
            hintStyle: AppTextStyle.bodyMedium.copyWith(color: AppColors.outline.withOpacity(0.5)),
            filled: true,
            fillColor: AppColors.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.r12),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (val) => val == null || val.isEmpty ? l10n.required : null,
        ),
        const SizedBox(height: AppConstants.p20),

        // Supporting Docs
        _buildLabel(l10n.supportingDocuments),
        CustomPaint(
          painter: DashedBorderPainter(color: AppColors.outlineVariant),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.p24),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest.withOpacity(0.5),
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
                child: const Icon(Icons.cloud_upload_outlined, color: AppColors.primary),
              ),
              const SizedBox(height: AppConstants.p12),
              Text(
                l10n.dragAndDrop,
                style: AppTextStyle.bodySmall.copyWith(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: AppConstants.p8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.primary,
                  elevation: 0,
                  side: BorderSide(color: AppColors.primary.withOpacity(0.2)),
                  shape: const StadiumBorder(),
                ),
                child: Text(l10n.browseFiles, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
        const SizedBox(height: AppConstants.p20),

        // Medical Warning
        Container(
          padding: const EdgeInsets.all(AppConstants.p16),
          decoration: BoxDecoration(
            color: AppColors.tertiaryContainer.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.r12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded, color: AppColors.tertiaryContainer, size: 20),
              const SizedBox(width: AppConstants.p12),
              Expanded(
                child: Text(
                  l10n.medicalWarning,
                  style: AppTextStyle.bodySmall.copyWith(color: AppColors.tertiary, height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
      child: Text(
        label,
        style: AppTextStyle.bodySmall.copyWith(
          color: AppColors.onSurfaceVariant,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDatePickerField(String text, VoidCallback? onTap, {bool isReadOnly = false}) {
    return InkWell(
      onTap: isReadOnly ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p14),
        decoration: BoxDecoration(
          color: isReadOnly ? AppColors.surfaceContainerLow : AppColors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppConstants.r12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: AppTextStyle.bodyMedium.copyWith(color: isReadOnly ? AppColors.outline : AppColors.onSurface)),
            Icon(Icons.calendar_month, color: isReadOnly ? AppColors.outline.withOpacity(0.5) : AppColors.outline, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelines(AppLocalizations l10n) {
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
        _buildGuidelineItem(l10n.guideline1),
        const SizedBox(height: AppConstants.p8),
        _buildGuidelineItem(l10n.guideline2),
      ],
    );
  }

  Widget _buildGuidelineItem(String text) {
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

  Widget _buildActionButtons(AppLocalizations l10n, LeaveState state) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryContainer,
              foregroundColor: AppColors.onSecondaryContainer,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r12)),
            ),
            child: Text(l10n.cancel, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: AppConstants.p16),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryContainer],
              ),
              borderRadius: BorderRadius.circular(AppConstants.r12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: state.isLoading ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r12)),
              ),
              child: state.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : Text(l10n.submitRequest, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
    );
  }
}


