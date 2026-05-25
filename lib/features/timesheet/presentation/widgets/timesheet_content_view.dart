import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'timesheet_bottom_actions.dart';
import 'timesheet_stats_bento.dart';
import 'timesheet_task_section.dart';
import 'timesheet_week_selector.dart';

class TimesheetContentView extends StatelessWidget {
  final String timesheetId;

  const TimesheetContentView({
    super.key,
    required this.timesheetId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimesheetBloc, TimesheetState>(
      buildWhen: (previous, current) =>
          previous.hasDraftTasksInSelectedWeek != current.hasDraftTasksInSelectedWeek ||
          previous.isSubmitWeeklyLoading != current.isSubmitWeeklyLoading,
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            final timesheetBloc = context.read<TimesheetBloc>();
            final selected = timesheetBloc.state.selectedDate ?? DateTime.now();

            final startOfWeek = selected.subtract(
              Duration(days: selected.weekday - 1),
            );

            final dominantMonth = DateTimeUtils.getDominantMonthOfWeek(startOfWeek);
            final dominantYear = DateTimeUtils.getDominantYearOfWeek(startOfWeek);

            timesheetBloc.add(
              TimesheetEvent.fetchOverviewRequested(
                month: dominantMonth,
                year: dominantYear,
              ),
            );
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppConstants.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TimesheetBentoStats(),
                const TimesheetWeekSelector(),
                const SizedBox(height: AppConstants.p24),
                TimesheetTaskSection(timesheetId: timesheetId),
                if (state.hasDraftTasksInSelectedWeek) ...[
                  const SizedBox(height: AppConstants.p24),
                  TimesheetBottomActions(
                    isLoading: state.isSubmitWeeklyLoading,
                    onSubmit: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.read<TimesheetBloc>().add(
                        const TimesheetEvent.submitWeeklyRequested(),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
