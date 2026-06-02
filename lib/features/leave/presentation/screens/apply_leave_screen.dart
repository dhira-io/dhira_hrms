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

  @override
  void initState() {
    super.initState();

    final localStorage = Get.find<LocalStorageService>();
    _gender = localStorage.getGender() ?? "";
    _effectiveEmployeeId = widget.employeeId.isEmpty
        ? (localStorage.getEmpId() ?? "")
        : widget.employeeId;

    _leaveBloc = LeaveBloc(
      getLeaveTypesUseCase: Get.find<GetLeaveTypesUseCase>(),
      getLeaveBalanceUseCase: Get.find<GetLeaveBalanceUseCase>(),
      getLeaveStatisticsUseCase: Get.find<GetLeaveStatisticsUseCase>(),
      submitLeaveUseCase: Get.find<SubmitLeaveUseCase>(),
      updateLeaveUseCase: Get.find<UpdateLeaveUseCase>(),
      getOverlapLeavesUseCase: Get.find<GetOverlapLeavesUseCase>(),
      uploadFileUseCase: Get.find<UploadFileUseCase>(),
    );

    // Trigger initial data fetches immediately to avoid UI flickering
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

  @override
  void dispose() {
    _leaveBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider<LeaveBloc>.value(
      value: _leaveBloc,
      child: Scaffold(
        backgroundColor: AppColors.of(context).surface,
        appBar: CommonAppBar(
          title: widget.leave != null ? l10n.editLeave : l10n.applyLeave,
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            behavior: HitTestBehavior.opaque,
            child: BlocListener<LeaveBloc, LeaveState>(
              listenWhen: (previous, current) =>
                  (previous.success != current.success && current.success) ||
                  (previous.errorMessage != current.errorMessage &&
                      current.errorMessage != null),
              listener: (context, state) {
                if (state.success) {
                  ToastUtils.showSuccess(l10n.leaveSubmitSuccess);
                  Get.find<BottomNavCubit>().changeIndex(
                    BottomNavCubit.approvalsIndex,
                  );
                  Get.find<ApprovalsBloc>().add(
                    const ApprovalsEvent.categoryChanged(
                      ApprovalType.leave,
                      ApprovalCategory.raised,
                    ),
                  );
                  context.go(AppRouter.dashboardPath);
                }

                if (state.errorMessage != null) {
                  ToastUtils.showError(state.errorMessage!);
                  // Clear error state after showing toast to allow repeated errors
                  _leaveBloc.add(const LeaveEvent.clearError());
                }
              },
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                color: AppColors.of(context).primary,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.p20),
                    child: Column(
                      children: [
                        // Stats and Balance are now independent "Smart" widgets
                        LeaveStatsGrid(employeeId: _effectiveEmployeeId),
                        const SizedBox(height: AppConstants.p20),
                        LeaveBalanceOverviewCard(
                          employeeId: _effectiveEmployeeId,
                          gender: _gender,
                        ),
                        const SizedBox(height: AppConstants.p24),
                        LeaveApplyForm(
                          employeeId: _effectiveEmployeeId,
                          leave: widget.leave,
                          empName:
                              Get.find<LocalStorageService>().getEmpName() ??
                              "",
                          gender: _gender,
                        ),
                              SizedBox(height: 100.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
}
