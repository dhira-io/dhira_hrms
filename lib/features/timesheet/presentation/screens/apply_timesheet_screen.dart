import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_state.dart';
import '../widgets/timesheet_apply_form.dart';

class ApplyTimesheetScreen extends StatelessWidget {
  final String timesheetId;
  const ApplyTimesheetScreen({super.key, required this.timesheetId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider<TimesheetBloc>.value(
      value: Get.find<TimesheetBloc>(),
      child: BlocListener<TimesheetBloc, TimesheetState>(
    listenWhen: (previous, current) {
      return previous.maybeMap(loading: (_) => true, orElse: () => false) &&
          current.maybeMap(loaded: (_) => true, orElse: () => false);
    },
    listener: (context, state) {
      state.maybeWhen(
        loaded: (
            timesheets,
            hasMore,
            isFetchingMore,
            user,
            from,
            to,
            assignments,
            projects,
            ) {
          ToastUtils.showSuccess("Saved successfully");
          context.pop();
        },
        error: (message, _, __, ___, ____, _____, ______, _______) {
          ToastUtils.showError(message);
        },
        orElse: () {},
      );
    },

    // 🔥 ADD THIS PART (this was missing)
    child: Scaffold(
      appBar: AppBar(
        title: Text(
          timesheetId == "0"
              ? l10n.logTime
              : l10n.editTimesheet,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.p16),
        child: TimesheetApplyForm(timesheetId: timesheetId),
      ),
    ),
    )

    );
  }
}

