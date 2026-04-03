import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/dialogs/app_dialogs.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_state.dart';
import '../widgets/timesheet_apply_form.dart';

class ApplyTimesheetScreen extends StatelessWidget {
  final String timesheetId;
  const ApplyTimesheetScreen({super.key, required this.timesheetId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TimesheetBloc, TimesheetState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
            Navigator.pop(context);
          },
          error: (message) => AppDialogs.showAlertDialog(context, message),
        );
      },
      child: Scaffold(
        appBar: AppBar(title: Text(timesheetId == "0" ? 'Log Time' : 'Edit Timesheet')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: TimesheetApplyForm(timesheetId: timesheetId),
        ),
      ),
    );
  }
}
