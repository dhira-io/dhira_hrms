import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_summary_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_eligible_date_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/constants/compensatory_leave_constants.dart';

part 'compensatory_leave_state.freezed.dart';

enum CompensatoryLeaveStatus { initial, loading, loaded, success, failure }

@freezed
class CompensatoryLeaveState with _$CompensatoryLeaveState {
  const factory CompensatoryLeaveState({
    @Default(CompensatoryLeaveStatus.initial) CompensatoryLeaveStatus status,
    String? initialCompensatoryLeaveId,
    CompensatoryLeaveSummaryEntity? summary,
    @Default([]) List<CompensatoryLeaveEligibleDateEntity> eligibleDates,
    CompensatoryLeaveEligibleDateEntity? selectedDate,
    @Default([]) List<ProjectEntity> projects,
    ProjectEntity? selectedProject,
    @Default(CompensatoryLeaveConstants.timesheetFillAuto) String timesheetFill,
    @Default("") String taskDescription,
    @Default("") String reason,
    @Default(CompensatoryLeaveConstants.workTypeWeekend) String workType,
    @Default(0.0) double workedHours,
    @Default(false) bool isActionLoading,
    String? errorMessage,
  }) = _CompensatoryLeaveState;
}

