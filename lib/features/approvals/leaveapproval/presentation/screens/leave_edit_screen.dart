import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/usecases/get_leave_balance_approval_usecase.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/usecases/get_leave_statistics_approval_usecase.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/usecases/get_leave_types_approval_usecase.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/usecases/get_overlap_leaves_approval_usecase.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/usecases/update_leave_approval_usecase.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/usecases/upload_leave_file_usecase.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/widgets/leave_edit_form.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_bloc.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_event.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_state.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';

class LeaveEditScreen extends StatefulWidget {
  final String employeeId;
  final LeaveEntity leave;

  const LeaveEditScreen({
    super.key,
    required this.employeeId,
    required this.leave,
  });

  @override
  State<LeaveEditScreen> createState() => _LeaveEditScreenState();
}

class _LeaveEditScreenState extends State<LeaveEditScreen> {
  late final LeaveApprovalBloc _leaveApprovalBloc;
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

    _leaveApprovalBloc = LeaveApprovalBloc(
      getLeaveTypesUseCase: Get.find<GetLeaveTypesApprovalUseCase>(),
      getLeaveBalanceUseCase: Get.find<GetLeaveBalanceApprovalUseCase>(),
      updateLeaveUseCase: Get.find<UpdateLeaveApprovalUseCase>(),
      getOverlapLeavesUseCase: Get.find<GetOverlapLeavesApprovalUseCase>(),
      uploadFileUseCase: Get.find<UploadLeaveFileUseCase>(),
      getLeaveStatisticsUseCase: Get.find<GetLeaveStatisticsApprovalUseCase>(),
    );

    _leaveApprovalBloc.add(const LeaveApprovalEvent.typesRequested());
    _leaveApprovalBloc.add(
      LeaveApprovalEvent.balanceRequested(
        employeeId: _effectiveEmployeeId,
        todayDate: DateTimeUtils.todayDate(),
        gender: _gender,
      ),
    );

    // Initial statistics for current month
    final now = DateTime.now();
    _leaveApprovalBloc.add(
      LeaveApprovalEvent.statisticsRequested(
        employeeId: _effectiveEmployeeId,
        fromDate: now.firstDayOfMonth.format(),
        toDate: now.lastDayOfMonth.format(),
      ),
    );
  }

  @override
  void dispose() {
    _leaveApprovalBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider<LeaveApprovalBloc>.value(
      value: _leaveApprovalBloc,
      child: Scaffold(
        backgroundColor: colors.background,
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          behavior: HitTestBehavior.opaque,
          child: SafeArea(
            child: BlocListener<LeaveApprovalBloc, LeaveApprovalState>(
              listener: (context, state) {
                if (state.success) {
                  ToastUtils.showSuccess(l10n.leaveSubmitSuccess);
                  Navigator.of(context).pop(true);
                }
                if (state.errorMessage != null) {
                  ToastUtils.showError(state.errorMessage!);
                }
              },
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  LeaveEditSliverAppBar(l10n: l10n),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.p20,
                      vertical: AppConstants.p16,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: LeaveEditForm(
                        employeeId: _effectiveEmployeeId,
                        leave: widget.leave,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppConstants.p40),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LeaveEditSliverAppBar extends StatelessWidget {
  final AppLocalizations l10n;

  const LeaveEditSliverAppBar({super.key, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return SliverAppBar(
      pinned: true,
      expandedHeight: 120,
      backgroundColor: colors.background,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close, color: colors.onSurface),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 56.w, bottom: 16.h),
        title: Text(
          l10n.editLeave,
          style: AppTextStyle.h3.copyWith(
            fontWeight: FontWeight.bold,
            color: colors.onSurface,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colors.primaryFixed,
                colors.background,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
