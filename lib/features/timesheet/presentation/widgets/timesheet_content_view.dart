import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/features/timesheet/presentation/widgets/timesheet_new_header.dart';
import 'package:dhira_hrms/features/timesheet/presentation/widgets/timesheet_weekly_range.dart';
import 'package:dhira_hrms/features/timesheet/presentation/widgets/timesheet_daily_progress.dart';
import 'package:dhira_hrms/features/timesheet/presentation/widgets/timesheet_task_section.dart';

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
            padding: const EdgeInsets.all(AppConstants.p12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TimesheetNewHeader(),
                SizedBox(height: 6.h),
                const TimesheetWeeklyRange(),
                SizedBox(height: 6.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.of(context).tableBorder,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const TimesheetDailyProgress(),
                      SizedBox(height: 8.h),
                      const TimesheetTaskSection(),
                    ],
                  ),
                ),
                SizedBox(height: 10.h), // Padding for bottom submit bar
              ],
            ),
          ),
        );
      },
    );
  }
}
