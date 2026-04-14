import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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
        backgroundColor: Colors.grey[50], // Match modern off-white aesthetic
        appBar: AppBar(
          title: Text(
            leave == null ? "Apply For Leave" : "Edit Leave Application",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[50],
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: BlocListener<LeaveBloc, LeaveState>(
          listener: (context, state) {
            if (state.success) {
              ToastUtils.showSuccess("Leave application submitted successfully");
              Navigator.pop(context);
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

