import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_status.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimesheetBottomActions extends StatefulWidget {
  final VoidCallback? onSubmit;

  const TimesheetBottomActions({
    super.key,
    this.onSubmit,
  });

  @override
  State<TimesheetBottomActions> createState() => _TimesheetBottomActionsState();
}

class _TimesheetBottomActionsState extends State<TimesheetBottomActions> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<TimesheetBloc, TimesheetState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          (current.status == TimesheetStateStatus.success ||
              current.status == TimesheetStateStatus.error),
      listener: (context, state) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      },
      child: CommonButton(
        text: l10n.submitWeeklyTimesheet,
        width: double.infinity,
        isLoading: _isLoading,
        onPressed: widget.onSubmit != null
            ? () {
                setState(() {
                  _isLoading = true;
                });
                widget.onSubmit!();
              }
            : null,
      ),
    );
  }
}
