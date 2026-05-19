import 'package:dhira_hrms/core/routing/app_router.dart';
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
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
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
import 'package:go_router/go_router.dart';
import '../../../presentation/bloc/approvals_bloc.dart';
import '../../../presentation/bloc/approvals_event.dart';
import '../../../domain/entities/approval_type.dart';
import '../../../domain/entities/approval_request_entity.dart';

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
    _leaveApprovalBloc.add(LeaveApprovalEvent.balanceRequested(
      employeeId: _effectiveEmployeeId,
      todayDate: DateTimeUtils.todayDate(),
      gender: _gender,
    ));

    // Initial statistics for current month
    final now = DateTime.now();
    _leaveApprovalBloc.add(LeaveApprovalEvent.statisticsRequested(
      employeeId: _effectiveEmployeeId,
      fromDate: now.firstDayOfMonth.format(),
      toDate: now.lastDayOfMonth.format(),
    ));
  }

  @override
  void dispose() {
    _leaveApprovalBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return BlocProvider<LeaveApprovalBloc>.value(
      value: _leaveApprovalBloc,
      child: Scaffold(
        backgroundColor: AppColors.of(context).background,
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

  const LeaveEditSliverAppBar({
    super.key,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 120,
      backgroundColor: AppColors.of(context).background,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close, color: AppColors.of(context).onSurface),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
        title: Text(
          l10n.editLeave,
          style: AppTextStyle.h3.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.of(context).onSurface,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.of(context).primaryFixed,
                AppColors.of(context).background,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
