import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../bloc/leave_state.dart';
import 'leave_stats_grid.dart';
import 'leave_balance_overview_card.dart';
import 'leave_apply/leave_overlap_section.dart';
import 'leave_apply/leave_request_guidelines.dart';
import 'leave_apply/leave_form_action_buttons.dart';
import 'leave_apply/leave_form_elements.dart';
import 'leave_apply/leave_form_fields.dart';
import '../utils/leave_form_utils.dart';
import 'package:dhira_hrms/core/utils/file_validation_utils.dart';
import 'package:file_picker/file_picker.dart';

class LeaveApplyForm extends StatefulWidget {
  final String employeeId;
  final LeaveEntity? leave;
  final String empName;
  final String gender;

  const LeaveApplyForm({
    super.key,
    required this.employeeId,
    this.leave,
    required this.empName,
    required this.gender,
  });

  @override
  State<LeaveApplyForm> createState() => _LeaveApplyFormState();
}

class _LeaveApplyFormState extends State<LeaveApplyForm> {
  final _formKey = GlobalKey<FormState>();
  final _toDateKey = GlobalKey<FormFieldState<DateTime>>();
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    // Fetch initial leave statistics for the current month
     WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final now = DateTime.now();
        final bloc = context.read<LeaveBloc>();
        bloc.add(LeaveEvent.statisticsRequested(
          employeeId: widget.employeeId,
          fromDate: now.firstDayOfMonth.format(),
          toDate: now.lastDayOfMonth.format(),
        ));

        if (widget.leave != null) {
          bloc.add(LeaveEvent.formInitialized(leave: widget.leave));
          _reasonController.text = widget.leave!.description ?? "";
          _checkOverlap();
        }
      }
    });
  }

  void _refreshStatistics() {
    final state = context.read<LeaveBloc>().state;
    if (state.fromDate != null && state.toDate != null) {
      context.read<LeaveBloc>().add(LeaveEvent.statisticsRequested(
            employeeId: widget.employeeId,
            fromDate: state.fromDate!.format(),
            toDate: state.toDate!.format(),
          ));
    }
    _refreshBalance();
  }

  void _refreshBalance() {
    final fromDate = context.read<LeaveBloc>().state.fromDate;
    context.read<LeaveBloc>().add(LeaveEvent.balanceRequested(
          employeeId: widget.employeeId,
          todayDate: (fromDate ?? DateTime.now()).format(),
          gender: widget.gender,
        ));
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final bloc = context.read<LeaveBloc>();
    final state = bloc.state;

    if (!isFromDate && state.fromDate == null) {
      ToastUtils.showInfo(AppLocalizations.of(context)!.selectFromDateFirst);
      return;
    }

    final DateTime firstDate;
    final DateTime lastDate;
    final DateTime initial;

    if (isFromDate) {
      final bounds = LeaveFormUtils.getFromDateBounds(state.selectedLeaveType);
      firstDate = bounds.firstDate;
      lastDate = bounds.lastDate;
      initial = LeaveFormUtils.computeInitialDate(
        currentDate: state.fromDate,
        firstDate: firstDate,
        lastDate: lastDate,
      );
    } else {
      final bounds = LeaveFormUtils.getToDateBounds(state.fromDate!);
      firstDate = bounds.firstDate;
      lastDate = bounds.lastDate;
      initial = LeaveFormUtils.computeToDateInitial(
        toDate: state.toDate,
        fromDate: state.fromDate!,
      );
    }

    final holidays = LeaveFormUtils.extractHolidays(state.statistics);

    final l10n = AppLocalizations.of(context)!;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: firstDate,
      lastDate: lastDate,
      selectableDayPredicate: (day) => !DateTimeUtils.isWeekend(day),
    );

    if (picked == null || !mounted) return;

    if (LeaveFormUtils.isWeekendOrHoliday(picked, holidays)) {
      ToastUtils.showError(l10n.weekendHolidayError);
      return;
    }

    bloc.add(LeaveEvent.dateSelected(isFromDate: isFromDate, date: picked));
    
    // We need to wait for the state update or use the computed values for immediate side effects
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _refreshStatistics();
        _checkOverlap();
      }
    });
  }

  void _checkOverlap() {
    final state = context.read<LeaveBloc>().state;
    if (state.fromDate != null && state.toDate != null) {
      context.read<LeaveBloc>().add(const LeaveEvent.overlapHiddenStatusChanged(false));
      context.read<LeaveBloc>().add(LeaveEvent.overlapLeavesRequested(
            employeeId: widget.employeeId,
            fromDate: state.fromDate!.format(),
            toDate: state.toDate!.format(),
          ));
    }
  }

  Future<void> _selectHalfDayDate(BuildContext context) async {
    final bloc = context.read<LeaveBloc>();
    final state = bloc.state;
    if (state.fromDate == null || state.toDate == null) return;
    if (state.fromDate == state.toDate) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: state.halfDayDate ?? state.fromDate!,
      firstDate: state.fromDate!,
      lastDate: state.toDate!,
    );
    if (picked != null && mounted) {
      bloc.add(LeaveEvent.halfDayDateSelected(picked));
      _refreshStatistics();
    }
  }

  Future<void> _pickAndUploadFile() async {
    final bloc = context.read<LeaveBloc>();
    final l10n = AppLocalizations.of(context)!;
    
    if (!FileValidationUtils.canUploadMore(
      currentCount: bloc.state.uploadCount,
      l10n: l10n,
    )) {
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: FileValidationUtils.leaveAllowedExtensions,
    );

    if (result != null && result.files.single.path != null) {
      bloc.add(LeaveEvent.uploadFileRequested(
        file: result.files.single,
        employeeId: widget.employeeId,
      ));
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final bloc = context.read<LeaveBloc>();
      final state = bloc.state;
      bloc.add(const LeaveEvent.overlapHiddenStatusChanged(true));
      
      final fromStr = (state.fromDate ?? DateTime.now()).format();
      final toStr = (state.toDate ?? DateTime.now()).format();
      final totalDays = LeaveFormUtils.computeTotalDays(
        fromDate: state.fromDate,
        toDate: state.toDate,
        isHalfDay: state.isHalfDay,
      );

      if (widget.leave == null) {
        bloc.add(LeaveEvent.applyRequested(
          employeeId: widget.employeeId,
          employeeName: widget.empName.isEmpty ? AppLocalizations.of(context)!.user : widget.empName,
          leaveType: state.selectedLeaveType!,
          fromDate: fromStr,
          toDate: toStr,
          reason: _reasonController.text,
          halfDay: state.isHalfDay ? 1 : 0,
          halfDayDate: state.isHalfDay && state.halfDayDate != null ? state.halfDayDate!.format() : null,
          halfDaySegment: state.isHalfDay ? state.daySegment : null,
          totalleavedays: totalDays,
        ));
      } else {
        bloc.add(LeaveEvent.updateRequested(
          leaveId: widget.leave!.name,
          fromDate: fromStr,
          toDate: toStr,
          reason: _reasonController.text,
          halfDay: state.isHalfDay ? 1 : 0,
          halfDayDate: state.isHalfDay && state.halfDayDate != null ? state.halfDayDate!.format() : null,
          halfDaySegment: state.isHalfDay ? state.daySegment : null,
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
        final totalDays = LeaveFormUtils.computeTotalDays(
          fromDate: state.fromDate,
          toDate: state.toDate,
          isHalfDay: state.isHalfDay,
        );
        final requiresDocs = LeaveFormUtils.requiresSupportingDocs(
          leaveType: state.selectedLeaveType,
          totalDays: totalDays,
        );

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
              LeaveFormFields(
                state: state,
                gender: widget.gender,
                totalDays: totalDays,
                requiresDocs: requiresDocs,
                reasonController: _reasonController,
                toDateKey: _toDateKey,
                onSelectDate: _selectDate,
                onSelectHalfDayDate: _selectHalfDayDate,
                onPickAndUploadFile: _pickAndUploadFile,
              ),
              const SizedBox(height: AppConstants.p24),
              const LeaveRequestGuidelines(),
              const SizedBox(height: AppConstants.p24),
              LeaveOverlapSection(
                overlapLeaves: state.overlapLeaves,
                hideOverlapAfterSubmit: state.hideOverlapAfterSubmit,
              ),
              const SizedBox(height: AppConstants.p32),
              LeaveFormActionButtons(
                onCancel: () => Navigator.pop(context),
                onSubmit: _submitForm,
                isLoading: state.isLoading,
                isSubmitDisabled: state.isLoading ||
                    state.isUploading ||
                    (requiresDocs && state.uploadedFileUrl == null),
              ),
            ],
          ),
        );
      },
    );
  }

}
