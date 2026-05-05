import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/constants/leave_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_bloc.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_event.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_state.dart';
import 'package:dhira_hrms/features/leave/presentation/widgets/dashed_border_painter.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

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

  @override
  void initState() {
    super.initState();
    _leaveType = widget.leave.leaveType;
    _fromDate = DateTime.tryParse(widget.leave.fromDate);
    _toDate = DateTime.tryParse(widget.leave.toDate);
    _isHalfDay = widget.leave.halfDay == 1;
    _halfDayDate = widget.leave.halfDayDate != null ? DateTime.tryParse(widget.leave.halfDayDate!) : null;
    _daySegment = widget.leave.halfDaySegment;
    _reasonController.text = widget.leave.description ?? "";
  }

  double get _totalDays {
    if (_fromDate == null || _toDate == null) return 0;
    if (_isHalfDay) return 0.5;
    return _toDate!.difference(_fromDate!).inDays.toDouble() + 1.0;
  }

  bool get _isSickLeave => _leaveType == LeaveTypes.sickLeave;
  bool get _requiresSupportingDocs => _isSickLeave && _totalDays > 2;

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final today = DateUtils.dateOnly(DateTime.now());
    final firstDate = isFromDate ? today.subtract(const Duration(days: 365)) : (_fromDate ?? today);
    final lastDate = today.add(const Duration(days: 365));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? (_fromDate ?? today) : (_toDate ?? _fromDate ?? today),
      firstDate: firstDate,
      lastDate: lastDate,
      selectableDayPredicate: (day) => day.weekday != DateTime.saturday && day.weekday != DateTime.sunday,
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
          if (_toDate != null && _toDate!.isBefore(picked)) {
            _toDate = null;
          }
        } else {
          _toDate = picked;
        }
      });
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
              _buildCardSection(
                title: l10n.requestDetails,
                child: Column(
                  children: [
                    _buildLeaveTypeDropdown(l10n, state),
                    const SizedBox(height: AppConstants.p20),
                    _buildDateRangePickers(l10n),
                    const SizedBox(height: AppConstants.p20),
                    _buildHalfDayToggle(l10n),
                    if (_isHalfDay) ...[
                      const SizedBox(height: AppConstants.p16),
                      _buildHalfDayDetails(l10n),
                    ],
                    const SizedBox(height: AppConstants.p20),
                    _buildReasonField(l10n),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.p24),
              if (_requiresSupportingDocs) ...[
                _buildCardSection(
                  title: l10n.supportingDocuments,
                  child: _buildFileUploadSection(l10n, state),
                ),
                const SizedBox(height: AppConstants.p24),
              ],
              _buildGuidelines(l10n),
              const SizedBox(height: AppConstants.p32),
              _buildActionButtons(l10n, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCardSection({required String title, required Widget child}) {
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

  Widget _buildLeaveTypeDropdown(AppLocalizations l10n, LeaveApprovalState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(l10n.leaveType),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppConstants.r12),
            border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
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
              decoration: const InputDecoration(border: InputBorder.none),
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary),
              validator: (val) => val == null ? l10n.required : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateRangePickers(AppLocalizations l10n) {
    return Row(
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
    );
  }

  Widget _buildHalfDayToggle(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppConstants.r12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.wb_sunny_rounded, color: _isHalfDay ? AppColors.primary : AppColors.outline, size: 20),
              const SizedBox(width: AppConstants.p12),
              Text(l10n.halfDayToggle, style: AppTextStyle.bodyMedium),
            ],
          ),
          Switch.adaptive(
            value: _isHalfDay,
            onChanged: (val) => setState(() => _isHalfDay = val),
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildHalfDayDetails(AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel(l10n.daySegment),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.p12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                  border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    value: _daySegment,
                    items: [l10n.firstHalf, l10n.secondHalf].map((s) => DropdownMenuItem(value: s, child: Text(s, style: AppTextStyle.bodySmall))).toList(),
                    onChanged: (val) => setState(() => _daySegment = val),
                    decoration: const InputDecoration(border: InputBorder.none),
                    validator: (val) => val == null && _isHalfDay ? l10n.required : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReasonField(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(l10n.reasonForLeave),
        TextFormField(
          controller: _reasonController,
          maxLines: 3,
          style: AppTextStyle.bodyMedium,
          decoration: InputDecoration(
            hintText: l10n.provideReasonHint,
            filled: true,
            fillColor: AppColors.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.r12),
              borderSide: BorderSide(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.r12),
              borderSide: BorderSide(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
            ),
          ),
          validator: (val) => val == null || val.isEmpty ? l10n.required : null,
        ),
      ],
    );
  }

  Widget _buildFileUploadSection(AppLocalizations l10n, LeaveApprovalState state) {
    return CustomPaint(
      painter: DashedBorderPainter(color: AppColors.outlineVariant),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppConstants.p20),
        child: Column(
          children: [
            Icon(state.uploadedFileUrl != null ? Icons.verified_rounded : Icons.cloud_upload_rounded, color: state.uploadedFileUrl != null ? AppColors.success : AppColors.primary, size: 40),
            const SizedBox(height: AppConstants.p12),
            Text(_selectedFileName ?? l10n.dragAndDrop, style: AppTextStyle.bodySmall, textAlign: TextAlign.center),
            const SizedBox(height: AppConstants.p12),
            ElevatedButton(
              onPressed: state.isUploading ? null : _pickAndUploadFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
              ),
              child: Text(state.isUploading ? "..." : l10n.browseFiles),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
      child: Text(label, style: AppTextStyle.labelMedium.copyWith(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDatePickerField(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.r12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p14),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppConstants.r12),
          border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: AppTextStyle.bodyMedium),
            const Icon(Icons.calendar_today_rounded, color: AppColors.primary, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelines(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.leaveRequestGuidelines.toUpperCase(), style: AppTextStyle.labelSmall.copyWith(color: AppColors.outline, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
        const SizedBox(height: AppConstants.p12),
        _buildGuidelineItem(l10n.guideline1),
        _buildGuidelineItem(l10n.guideline2),
      ],
    );
  }

  Widget _buildGuidelineItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 14),
          const SizedBox(width: AppConstants.p8),
          Expanded(child: Text(text, style: AppTextStyle.bodySmall.copyWith(color: AppColors.onSurfaceVariant, fontSize: 11))),
        ],
      ),
    );
  }

  Widget _buildActionButtons(AppLocalizations l10n, LeaveApprovalState state) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel, style: TextStyle(color: AppColors.onSurfaceVariant)),
          ),
        ),
        const SizedBox(width: AppConstants.p16),
        Expanded(
          child: ElevatedButton(
            onPressed: state.isLoading ? null : _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r12)),
              elevation: 0,
            ),
            child: state.isLoading 
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.white))
                : Text(l10n.saveChanges, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
