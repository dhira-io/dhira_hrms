import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_state.dart';
import '../widgets/leave_apply_form.dart';

class ApplyLeaveScreen extends StatelessWidget {
  final String employeeId;
  final LeaveEntity? leave;
  const ApplyLeaveScreen({super.key, required this.employeeId, this.leave});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider.value(
      value: Get.find<LeaveBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(leave == null ? l10n.applyLeave : "Edit Leave Application"),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        body: BlocListener<LeaveBloc, LeaveState>(
          listener: (context, state) {
            if (state.success) {
              ToastUtils.showSuccess("Leave application submitted successfully");
              context.pop();
            }
            if (state.errorMessage != null) {
              ToastUtils.showError(state.errorMessage!);
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.p20),
            child: LeaveApplyForm(employeeId: employeeId, leave: leave),
          ),
        ),
      ),
    );
  }
}

