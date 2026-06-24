import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_event.dart';
import '../bloc/leave_state.dart';
import 'leave_apply/leave_overlap_section.dart';
import 'leave_apply/leave_form_fields.dart';
import '../utils/leave_form_utils.dart';
import 'package:dhira_hrms/core/utils/file_validation_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'leave_form_skeleton.dart';

class LeaveApplyForm extends StatefulWidget {
  final String employeeId;
  final LeaveEntity? leave;
  final String empName;
  final String gender;
  final String initialReason;
  final ValueChanged<String> onNext;
  final Future<void> Function() onRefresh;

  const LeaveApplyForm({
    super.key,
    required this.employeeId,
    this.leave,
    required this.empName,
    required this.gender,
    this.initialReason = "",
    required this.onNext,
    required this.onRefresh,
  });

  @override
  State<LeaveApplyForm> createState() => LeaveApplyFormState();
}

class LeaveApplyFormState extends State<LeaveApplyForm> {
  final _formKey = GlobalKey<FormState>();
  final _toDateKey = GlobalKey<FormFieldState<DateTime>>();
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<LeaveBloc>();
    
    _reasonController.addListener(() {
      setState(() {});
    });

    // Initialize form state from BLoC
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Trigger types fetch if empty
        if (bloc.state.leaveTypes.isEmpty &&
            !bloc.state.isLoading &&
            !bloc.state.isInitialLoading) {
          bloc.add(const LeaveEvent.typesRequested());
        }

        bloc.add(
          LeaveEvent.formInitialized(
            leave: widget.leave,
            employeeName: widget.empName,
            gender: widget.gender,
          ),
        );

        if (widget.leave != null) {
          _checkOverlap();
        }
      }
    });

    if (widget.initialReason.isNotEmpty) {
      _reasonController.text = widget.initialReason;
    } else if (widget.leave != null) {
      _reasonController.text = widget.leave!.description ?? "";
    }
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

    final today = DateUtils.dateOnly(DateTime.now());
    final DateTime firstDate;
    final DateTime lastDate;
    final DateTime initial;

    if (isFromDate) {
      final bounds = LeaveFormUtils.getFromDateBounds(state.selectedLeaveType);
      firstDate = bounds.firstDate;
      lastDate = bounds.lastDate;
      initial =
          (state.fromDate != null &&
              !state.fromDate!.isBefore(firstDate) &&
              !state.fromDate!.isAfter(lastDate))
          ? state.fromDate!
          : (today.isBefore(firstDate)
                ? firstDate
                : (today.isAfter(lastDate) ? lastDate : today));
    } else {
      firstDate = state.fromDate!;
      lastDate = today.add(const Duration(days: 365));
      initial = (state.toDate != null && !state.toDate!.isBefore(firstDate))
          ? state.toDate!
          : firstDate;
    }

    final holidays = LeaveFormUtils.extractHolidays(state.statistics);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: firstDate,
      lastDate: lastDate,
      selectableDayPredicate: (day) => !DateTimeUtils.isWeekend(day),
    );

    if (picked == null) return;

    if (LeaveFormUtils.isWeekendOrHoliday(picked, holidays)) {
      if (!context.mounted) return;
      ToastUtils.showError(AppLocalizations.of(context)!.weekendHolidayError);
      return;
    }

    bloc.add(LeaveEvent.dateSelected(isFrom: isFromDate, date: picked));

    // We need to wait for the state update or use the computed values for immediate side effects
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkOverlap();
    });
  }

  void _checkOverlap() {
    final state = context.read<LeaveBloc>().state;
    if (state.fromDate != null && state.toDate != null) {
      context.read<LeaveBloc>().add(
        const LeaveEvent.overlapHiddenStatusChanged(false),
      );
      context.read<LeaveBloc>().add(
        LeaveEvent.overlapLeavesRequested(
          employeeId: widget.employeeId,
          fromDate: state.fromDate!.format(),
          toDate: state.toDate!.format(),
        ),
      );
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
    if (picked != null) {
      bloc.add(LeaveEvent.halfDayDateSelected(picked));
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
      bloc.add(LeaveEvent.uploadFileRequested(file: result.files.single));
    }
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      final bloc = context.read<LeaveBloc>();
      bloc.add(const LeaveEvent.overlapHiddenStatusChanged(true));
      widget.onNext(_reasonController.text);
    }
  }

  bool get _isNextButtonEnabled {
    final state = context.read<LeaveBloc>().state;
    final isMandatoryFilled = state.selectedLeaveType != null &&
        state.fromDate != null &&
        (state.isHalfDay ? state.daySegment != null : state.toDate != null) &&
        _reasonController.text.trim().length >= 10;
        
    final requiresDocs = LeaveFormUtils.requiresSupportingDocs(
      leaveType: state.selectedLeaveType,
      totalDays: LeaveFormUtils.computeTotalDays(
        fromDate: state.fromDate,
        toDate: state.toDate,
        isHalfDay: state.isHalfDay,
      ),
    );

    if (state.isInitialLoading || state.isUploading) return false;
    if (requiresDocs && state.uploadedFileUrl == null) return false;
    return isMandatoryFilled;
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
            children: [
              Expanded(
                child: Builder(
                  builder: (context) {
                    final content = SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstants.p16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          if (state.isInitialLoading)
                            const LeaveFormSkeleton()
                          else if (state.leaveTypes.isEmpty)
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 40.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.wifi_off_rounded, size: 48.w, color: AppColors.of(context).outline),
                                    SizedBox(height: 16.h),
                                    Text(
                                      l10n.noInternetConnection,
                                      style: AppTextStyle.bodyLarge.copyWith(color: AppColors.of(context).onSurface, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      l10n.pleaseCheckYourInternetConnection,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.bodyMedium.copyWith(color: AppColors.of(context).outline),
                                    ),
                                    SizedBox(height: 24.h),
                                    CommonButton(
                                      text: l10n.retry,
                                      onPressed: widget.onRefresh,
                                      variant: ButtonVariant.outlined,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else ...[
                            Container(
                              padding: EdgeInsets.all(AppConstants.p16.w),
                              decoration: BoxDecoration(
                                color: AppColors.of(context).slateBg,
                                borderRadius: BorderRadius.circular(AppConstants.r12.r),
                                border: Border.all(
                                  color: AppColors.of(context).slateBorder,
                                ),
                              ),
                              child: LeaveFormFields(
                                state: state,
                                gender: widget.gender,
                                totalDays: totalDays,
                                requiresDocs: requiresDocs,
                                reasonController: _reasonController,
                                toDateKey: _toDateKey,
                                callbacks: LeaveFormCallbacks(
                                  onSelectDate: _selectDate,
                                  onSelectHalfDayDate: _selectHalfDayDate,
                                  onPickAndUploadFile: _pickAndUploadFile,
                                ),
                              ),
                            ),
                            SizedBox(height: AppConstants.p16.h),
                            LeaveOverlapSection(
                              overlapLeaves: state.overlapLeaves,
                              hideOverlapAfterSubmit: state.hideOverlapAfterSubmit,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                  
                  if (state.leaveTypes.isEmpty && !state.isInitialLoading) {
                    return RefreshIndicator(
                      onRefresh: widget.onRefresh,
                      color: AppColors.of(context).primary,
                      child: content,
                    );
                  }
                  return content;
                },
              ),
            ),
              Container(
                padding: const EdgeInsets.all(AppConstants.p20),
                decoration: BoxDecoration(
                  color: AppColors.of(context).surface,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.of(context).outline.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: SizedBox(
                    width: double.infinity,
                    child: CommonButton(
                      text: l10n.nextText,
                      onPressed: _isNextButtonEnabled ? _handleNext : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
