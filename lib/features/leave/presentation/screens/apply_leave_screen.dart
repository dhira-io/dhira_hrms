import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/dialogs/app_dialogs.dart';
import '../bloc/leave_bloc.dart';
import '../bloc/leave_state.dart';
import '../widgets/leave_apply_form.dart';

class ApplyLeaveScreen extends StatelessWidget {
  final String employeeId;
  const ApplyLeaveScreen({super.key, required this.employeeId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider.value(
      value: Get.find<LeaveBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.applyLeave)),
        body: BlocListener<LeaveBloc, LeaveState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (message) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                Navigator.pop(context);
              },
              error: (message) => AppDialogs.showAlertDialog(context, message),
            );
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.p20),
            child: LeaveApplyForm(employeeId: employeeId),
          ),
        ),
      ),
    );
  }
}

