import 'package:dhira_hrms/core/constants/storage_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/string_utils.dart';

import '../bloc/leave_bloc.dart';
import '../bloc/leave_state.dart';
import '../bloc/leave_event.dart';
import '../widgets/leave_apply_form.dart';

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
  String? _userImage;

  @override
  void initState() {
    super.initState();
    
    final localStorage = Get.find<LocalStorageService>();
    _gender = localStorage.getGender() ?? "";
    _effectiveEmployeeId = widget.employeeId.isEmpty 
        ? (localStorage.getEmpId() ?? "") 
        : widget.employeeId;

    final cookieMap = localStorage.getCookieMap();
    if (cookieMap != null && cookieMap['user_image'] != null && cookieMap['user_image'].toString().isNotEmpty) {
      _userImage = cookieMap['user_image'].toString();
    }

    _leaveBloc = LeaveBloc(
      getLeaveTypesUseCase: Get.find<GetLeaveTypesUseCase>(),
      getLeaveBalanceUseCase: Get.find<GetLeaveBalanceUseCase>(),
      getLeaveStatisticsUseCase: Get.find<GetLeaveStatisticsUseCase>(),
      submitLeaveUseCase: Get.find<SubmitLeaveUseCase>(),
      updateLeaveUseCase: Get.find<UpdateLeaveUseCase>(),
      getOverlapLeavesUseCase: Get.find<GetOverlapLeavesUseCase>(),
      uploadFileUseCase: Get.find<UploadFileUseCase>(),
    );

    _leaveBloc.add(const LeaveEvent.typesRequested());
    _leaveBloc.add(LeaveEvent.balanceRequested(
      employeeId: _effectiveEmployeeId,
      todayDate: DateTimeUtils.todayDate(),
      gender: _gender,
    ));
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
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          behavior: HitTestBehavior.opaque,
          child: SafeArea(
            child: BlocListener<LeaveBloc, LeaveState>(
            listener: (context, state) {
              if (state.success) {
                ToastUtils.showSuccess(l10n.leaveSubmitSuccess);
                Get.find<BottomNavCubit>().changeIndex(BottomNavCubit.approvalsIndex);
                Get.find<ApprovalsBloc>().add(const ApprovalsEvent.categoryChanged(
                  ApprovalType.leave,
                  ApprovalCategory.raised,
                ));
                context.go(AppRouter.dashboardPath);
              }
              if (state.errorMessage != null) {
                ToastUtils.showError(state.errorMessage!);
              }
            },
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              color: AppColors.of(context).primary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20, vertical: AppConstants.p16),
                  child: Column(
                    children: [
                      LeaveApplyForm(employeeId: _effectiveEmployeeId, leave: widget.leave),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    )
   );
  }

  Future<void> _onRefresh() async {
    _leaveBloc.add(const LeaveEvent.typesRequested(isRefresh: true));
    _leaveBloc.add(LeaveEvent.balanceRequested(
      employeeId: _effectiveEmployeeId,
      todayDate: DateTimeUtils.todayDate(),
      gender: _gender,
      isRefresh: true,
    ));
    final now = DateTime.now();
    _leaveBloc.add(LeaveEvent.statisticsRequested(
      employeeId: _effectiveEmployeeId,
      fromDate: now.firstDayOfMonth.format(),
      toDate: now.lastDayOfMonth.format(),
      isRefresh: true,
    ));
    // Wait a bit for the animation to look nice if it finishes too fast
    await Future.delayed(const Duration(milliseconds: 800));
  }
}