import 'package:dhira_hrms/features/auth/domain/entities/user_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_assignment_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/timesheet_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/timesheet_overview_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'timesheet_status.dart';
import 'timesheet_success_type.dart';

part 'timesheet_state.freezed.dart';

@freezed
class TimesheetState with _$TimesheetState {
  const factory TimesheetState({
    @Default(TimesheetStateStatus.initial) TimesheetStateStatus status,
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    DateTime? selectedDate,
    String? initialTimesheetId,
    @Default([]) List<TimesheetEntity> timesheets,
    @Default(false) bool hasMore,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
    @Default(false) bool isActionLoading,
    @Default(false) bool isSubmitWeeklyLoading,
    @Default(false) bool hasDraftTasksInSelectedWeek,
    String? activeTimesheetId,
    TimesheetOverviewEntity? overview,
    @Default([]) List<ProjectAssignmentEntity> assignmentsForSelectedDay,
    String? currentWeekActiveId,
    @Default("") String formattedOverviewWeeks,
    ProjectAssignmentEntity? editingTask,
    int? editingIndex,
    @Default("") String formTaskData,
    @Default("") String formDescription,
    @Default("") String formExpectedHours,
    @Default("") String formSpentHours,
    ProjectEntity? formSelectedProject,
    @Default(0.0) double weeklyTotalHours,
    @Default({}) Set<DateTime> taskDays,
    @Default({}) Set<DateTime> holidayDays,
    @Default("") String currentWeekRangeText,
    @Default([]) List<DateTime> holidays,
    @Default(false) bool isUploading,
    String? uploadedFileUrl,
    String? errorMessage,
    String? successMessage,
    TimesheetSuccessType? successType,
  }) = _TimesheetState;

  const TimesheetState._();
}
