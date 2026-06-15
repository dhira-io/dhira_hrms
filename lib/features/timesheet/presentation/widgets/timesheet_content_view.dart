import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'timesheet_new_header.dart';
import 'timesheet_weekly_range.dart';
import 'timesheet_daily_progress.dart';
import 'timesheet_task_section.dart';

class TimesheetContentView extends StatelessWidget {
  const TimesheetContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimesheetBloc, TimesheetState>(
      buildWhen: (previous, current) =>
          previous.hasDraftTasksInSelectedWeek !=
          current.hasDraftTasksInSelectedWeek,
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            final timesheetBloc = context.read<TimesheetBloc>();
            final selected = timesheetBloc.state.selectedDate ?? DateTime.now();

            final startOfWeek = selected.subtract(
              Duration(days: selected.weekday - 1),
            );

            final dominantMonth = DateTimeUtils.getDominantMonthOfWeek(
              startOfWeek,
            );
            final dominantYear = DateTimeUtils.getDominantYearOfWeek(
              startOfWeek,
            );

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
                const TimesheetNewHeader(),
                SizedBox(height: 24.h),
                const TimesheetWeeklyRange(),
                SizedBox(height: 24.h),
                const TimesheetDailyProgress(),
                SizedBox(height: 24.h),
                const TimesheetTaskSection(),
                SizedBox(height: 80.h), // Padding for bottom submit bar
              ],
            ),
          ),
        );
      },
    );
  }
}
