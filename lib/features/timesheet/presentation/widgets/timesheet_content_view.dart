import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_assignment_entity.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'timesheet_bottom_actions.dart';
import 'timesheet_stats_bento.dart';
import 'timesheet_task_section.dart';
import 'timesheet_week_selector.dart';

class TimesheetContentView extends StatelessWidget {
  final TimesheetState state;
  final Function(ProjectAssignmentEntity, int) onEdit;
  final Function(ProjectAssignmentEntity) onDelete;
  final VoidCallback onSubmitWeekly;
  final RefreshCallback onRefresh;

  const TimesheetContentView({
    super.key,
    required this.state,
    required this.onEdit,
    required this.onDelete,
    required this.onSubmitWeekly,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = state.status == TimesheetStateStatus.loading;

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppConstants.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TimesheetBentoStats(
              editAssignments: state.editAssignments,
              selectedDate: state.selectedDate ?? DateTime.now(),
              weekMeta: state.formattedOverviewWeeks,
              overview: state.overview,
              isLoading: isLoading,
            ),
            TimesheetWeekSelector(
              selectedDate: state.selectedDate ?? DateTime.now(),
              overview: WeeklyTimesheetOverview(
                assignments: state.editAssignments,
                totalWeeklyHours: state.weeklyTotalHours,
                taskDays: state.taskDays,
                holidayDays: state.holidayDays,
                rangeText: state.currentWeekRangeText,
              ),
              onDateSelected: (date) {
                context.read<TimesheetBloc>().add(
                  TimesheetEvent.daySelected(date),
                );
              },
              onPreviousWeek: () {
                FocusManager.instance.primaryFocus?.unfocus();
                context.read<TimesheetBloc>().add(
                  const TimesheetEvent.previousWeekRequested(),
                );
              },
              onNextWeek: () {
                FocusManager.instance.primaryFocus?.unfocus();
                context.read<TimesheetBloc>().add(
                  const TimesheetEvent.nextWeekRequested(),
                );
              },
            ),
            const SizedBox(height: AppConstants.p24),
            TimesheetTaskSection(
              assignments: state.assignmentsForSelectedDay,
              selectedDate: state.selectedDate,
              isLoading: isLoading,
              onEdit: onEdit,
              onDelete: onDelete,
            ),
            if (state.hasDraftTasksInSelectedWeek) ...[
              const SizedBox(height: AppConstants.p24),
              TimesheetBottomActions(
                isLoading: state.isSubmitWeeklyLoading,
                onSubmit: onSubmitWeekly,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
