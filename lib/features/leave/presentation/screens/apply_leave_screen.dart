import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/services/local_storage_service.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_state.dart';
import '../bloc/leave_event.dart';
import '../widgets/leave_apply_form.dart';
import '../widgets/leave_stats_grid.dart';
import '../widgets/leave_balance_overview_card.dart';
import '../../../../core/utils/date_time_utils.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/widgets/common_app_bar.dart';
import '../../../dashboard/presentation/bloc/bottom_nav_cubit.dart';
import '../../../approvals/presentation/bloc/approvals_bloc.dart';
import '../../../approvals/presentation/bloc/approvals_event.dart';
import '../../../approvals/domain/entities/approval_type.dart';
import '../../../approvals/domain/entities/approval_request_entity.dart';
import '../widgets/leave_apply/leave_stepper_header.dart';
import '../widgets/leave_apply/leave_review_step.dart';
import '../widgets/leave_apply/leave_confirmation_step.dart';
import '../utils/leave_form_utils.dart';

import '../../domain/usecases/get_leave_types_usecase.dart';
import '../../domain/usecases/get_leave_balance_usecase.dart';
import '../../domain/usecases/get_leave_statistics_usecase.dart';
import '../../domain/usecases/submit_leave_usecase.dart';
import '../../domain/usecases/update_leave_usecase.dart';
import '../../domain/usecases/get_overlap_leaves_usecase.dart';
import '../../domain/usecases/upload_file_usecase.dart';

class ApplyLeaveScreen extends StatefulWidget {
  final String employeeId;
  final LeaveEntity? leave;
  const ApplyLeaveScreen({super.key, required this.employeeId, this.leave});

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  late final LeaveBloc _leaveBloc;
  late final String _gender;
  late final String _effectiveEmployeeId;
  late final String _empName;
  late String _approverName;
  String _reason = "";

  @override
  void initState() {
    super.initState();

    final localStorage = Get.find<LocalStorageService>();
    _gender = localStorage.getGender() ?? "";
    _empName = localStorage.getEmpName() ?? "";
    _effectiveEmployeeId = widget.employeeId.isEmpty
        ? (localStorage.getEmpId() ?? "")
        : widget.employeeId;

    _leaveBloc = context.read<LeaveBloc>();

    // Trigger initial data fetches in post-frame to avoid UI flickering and lifecycle issues
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final now = DateTime.now();
        _leaveBloc.add(
          LeaveEvent.statisticsRequested(
            employeeId: _effectiveEmployeeId,
            fromDate: now.firstDayOfMonth.format(),
            toDate: now.lastDayOfMonth.format(),
          ),
        );

        _leaveBloc.add(
          LeaveEvent.balanceRequested(
            employeeId: _effectiveEmployeeId,
            todayDate: DateTimeUtils.todayDate(),
            gender: _gender,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _leaveBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    _approverName = Get.find<LocalStorageService>().getApproverName() ?? l10n.notAvailable;
    
    return Scaffold(
      backgroundColor: AppColors.of(context).surface,
        appBar: CommonAppBar(
          title: widget.leave != null ? l10n.editLeave : l10n.applyLeave,
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            behavior: HitTestBehavior.opaque,
            child: BlocConsumer<LeaveBloc, LeaveState>(
              listenWhen: (previous, current) =>
                  (previous.success != current.success && current.success) ||
                  (previous.errorMessage != current.errorMessage &&
                      current.errorMessage != null),
              listener: (context, state) {
                if (state.success) {
                  _leaveBloc.add(const LeaveEvent.stepChanged(2));
                  // Clear success to avoid repeated trigger if needed, or just stay on step 2
                }

                if (state.errorMessage != null) {
                  ToastUtils.showError(state.errorMessage!);
                  // Clear error state after showing toast to allow repeated errors
                  _leaveBloc.add(const LeaveEvent.clearError());
                }
              },
              builder: (context, state) {
                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  color: AppColors.of(context).primary,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.p20),
                      child: Column(
                        children: [
                        LeaveStepperHeader(currentStep: state.currentStep),
                        const SizedBox(height: AppConstants.p24),
                        if (state.currentStep == 0)
                          LeaveApplyForm(
                            employeeId: _effectiveEmployeeId,
                            leave: widget.leave,
                            empName: _empName,
                            gender: _gender,
                            onNext: (reason) {
                              setState(() {
                                _reason = reason;
                              });
                              _leaveBloc.add(const LeaveEvent.stepChanged(1));
                            },
                          )
                        else if (state.currentStep == 1)
                          LeaveReviewStep(
                            state: state,
                            reason: _reason,
                            approverName: _approverName,
                            onSubmit: () => _submitForm(state),
                            onBack: () => _leaveBloc.add(const LeaveEvent.stepChanged(0)),
                          )
                        else if (state.currentStep == 2)
                          LeaveConfirmationStep(
                            onMyRequests: () {
                              Get.find<BottomNavCubit>().changeIndex(BottomNavCubit.approvalsIndex);
                              Get.find<ApprovalsBloc>().add(
                                const ApprovalsEvent.categoryChanged(ApprovalType.leave, ApprovalCategory.raised),
                              );
                              context.go(AppRouter.dashboardPath);
                            },
                            onBackToHome: () {
                              context.go(AppRouter.dashboardPath);
                            },
                          ),
                        SizedBox(height: 100.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    // Start listening BEFORE adding the event to avoid race conditions
    final refreshFuture = _leaveBloc.stream
        .firstWhere((state) => !state.isLoading)
        .timeout(const Duration(seconds: 20));

    _leaveBloc.add(
      LeaveEvent.refreshRequested(
        employeeId: _effectiveEmployeeId,
        gender: _gender,
      ),
    );

    try {
      await refreshFuture;
    } catch (_) {
      // Safety timeout
    }
  }

  void _submitForm(LeaveState state) {
    final fromStr = (state.fromDate ?? DateTime.now()).format();
    final toStr = (state.toDate ?? DateTime.now()).format();
    final totalDays = LeaveFormUtils.computeTotalDays(
      fromDate: state.fromDate,
      toDate: state.toDate,
      isHalfDay: state.isHalfDay,
    );

    if (widget.leave == null) {
      _leaveBloc.add(
        LeaveEvent.applyRequested(
          employeeId: _effectiveEmployeeId,
          employeeName: _empName.isNotEmpty ? _empName : AppLocalizations.of(context)!.user,
          leaveType: state.selectedLeaveType!,
          fromDate: fromStr,
          toDate: toStr,
          reason: _reason,
          halfDay: state.isHalfDay ? 1 : 0,
          halfDayDate: state.isHalfDay && state.halfDayDate != null
              ? state.halfDayDate!.format()
              : null,
          halfDaySegment: state.isHalfDay ? state.daySegment : null,
          totalleavedays: totalDays,
          emergencyContactNumber: state.addEmergencyContact ? state.emergencyContactNumber : null,
        ),
      );
    } else {
      _leaveBloc.add(
        LeaveEvent.updateRequested(
          leaveId: widget.leave!.name,
          fromDate: fromStr,
          toDate: toStr,
          reason: _reason,
          halfDay: state.isHalfDay ? 1 : 0,
          halfDayDate: state.isHalfDay && state.halfDayDate != null
              ? state.halfDayDate!.format()
              : null,
          halfDaySegment: state.isHalfDay ? state.daySegment : null,
          totalleavedays: totalDays,
          emergencyContactNumber: state.addEmergencyContact ? state.emergencyContactNumber : null,
        ),
      );
    }
  }
}
