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

import '../bloc/leave_bloc.dart';
import '../bloc/leave_state.dart';
import '../bloc/leave_event.dart';
import '../widgets/leave_apply_form.dart';

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
    if (_gender.isEmpty || _effectiveEmployeeId.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider<LeaveBloc>.value(
      value: _leaveBloc,
      child: Scaffold(
        backgroundColor: AppColors.surface, // Match modern off-white aesthetic
        body: SafeArea(
          child: BlocListener<LeaveBloc, LeaveState>(
            listener: (context, state) {
              if (state.success) {
                ToastUtils.showSuccess(l10n.leaveSubmitSuccess);
                context.pop(true);
              }
              if (state.errorMessage != null) {
                ToastUtils.showError(state.errorMessage!);
              }
            },
            child: CustomScrollView(
              slivers: [
                _ApplyLeaveSliverAppBar(leave: widget.leave),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.p20, vertical: AppConstants.p16),
                  sliver: SliverToBoxAdapter(
                    child: LeaveApplyForm(employeeId: _effectiveEmployeeId, leave: widget.leave),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100), // Space for bottom nav or padding
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ApplyLeaveSliverAppBar extends StatelessWidget {
  final LeaveEntity? leave;
  const _ApplyLeaveSliverAppBar({this.leave});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SliverAppBar(
      pinned: true,
      floating: false,
      elevation: 0,
      backgroundColor: AppColors.surface.withValues(alpha: 0.8), // Glass effect base
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ColorFilter.mode(
            AppColors.surface.withValues(alpha: 0.8),
            BlendMode.srcOver,
          ),
          child: Container(),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.primaryContainer),
        onPressed: () => context.pop(),
      ),
      title: Text(
        leave != null ? l10n.editLeave : l10n.applyLeave,
        style: AppTextStyle.h2.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.onSurface,
        ),
      ),
    );
  }
}

