import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
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
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isLoading || widget.onSubmit == null
              ? null
              : () {
                  setState(() {
                    _isLoading = true;
                  });
                  widget.onSubmit!();
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.of(context).primary,
            padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
            elevation: 0,
          ),
          child: _isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.of(context).white,
                  ),
                )
              : Text(l10n.submitWeeklyTimesheet, style: AppTextStyle.button),
        ),
      ),
    );
  }
}
