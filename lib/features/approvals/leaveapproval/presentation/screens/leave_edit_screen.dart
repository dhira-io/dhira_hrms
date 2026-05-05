import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/widgets/leave_edit_form.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:dhira_hrms/features/leave/domain/usecases/get_leave_balance_usecase.dart';
import 'package:dhira_hrms/features/leave/domain/usecases/get_leave_types_usecase.dart';
import 'package:dhira_hrms/features/leave/domain/usecases/get_overlap_leaves_usecase.dart';
import 'package:dhira_hrms/features/leave/domain/usecases/update_leave_usecase.dart';
import 'package:dhira_hrms/features/leave/domain/usecases/upload_file_usecase.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_bloc.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_event.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/bloc/leave_approval_state.dart';
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
      getLeaveTypesUseCase: Get.find<GetLeaveTypesUseCase>(),
      getLeaveBalanceUseCase: Get.find<GetLeaveBalanceUseCase>(),
      updateLeaveUseCase: Get.find<UpdateLeaveUseCase>(),
      getOverlapLeavesUseCase: Get.find<GetOverlapLeavesUseCase>(),
      uploadFileUseCase: Get.find<UploadFileUseCase>(),
    );

    _leaveApprovalBloc.add(const LeaveApprovalEvent.typesRequested());
    _leaveApprovalBloc.add(LeaveApprovalEvent.balanceRequested(
      employeeId: _effectiveEmployeeId,
      todayDate: DateTimeUtils.todayDate(),
      gender: _gender,
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
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocListener<LeaveApprovalBloc, LeaveApprovalState>(
            listener: (context, state) {
              if (state.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.leaveSubmitSuccess), backgroundColor: AppColors.success),
                );
                Navigator.of(context).pop(true);
              }
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!), backgroundColor: AppColors.error),
                );
              }
            },
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildSliverAppBar(l10n),
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
                  child: SizedBox(height: 40),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(AppLocalizations l10n) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 120,
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close, color: AppColors.onSurface),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
        title: Text(
          l10n.editLeave,
          style: AppTextStyle.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryFixed,
                AppColors.white,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
