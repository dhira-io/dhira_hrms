import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_summary_entity.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_eligible_date_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';

part 'compensatory_leave_state.freezed.dart';

@freezed
class CompensatoryLeaveState with _$CompensatoryLeaveState {
  const factory CompensatoryLeaveState.initial({
    String? initialCompensatoryLeaveId,
    CompensatoryLeaveSummaryEntity? summary,
    @Default([]) List<CompensatoryLeaveEligibleDateEntity> eligibleDates,
    CompensatoryLeaveEligibleDateEntity? selectedDate,
    @Default([]) List<ProjectEntity> projects,
    ProjectEntity? selectedProject,
    @Default("auto") String timesheetFill,
    @Default("") String taskDescription,
    @Default("") String reason,
    @Default("weekend") String workType,
    @Default(0.0) double workedHours,
    @Default(false) bool isActionLoading,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? errorMessage,
  }) = CompensatoryLeaveInitial;

  const factory CompensatoryLeaveState.loading({
    String? initialCompensatoryLeaveId,
    CompensatoryLeaveSummaryEntity? summary,
    @Default([]) List<CompensatoryLeaveEligibleDateEntity> eligibleDates,
    CompensatoryLeaveEligibleDateEntity? selectedDate,
    @Default([]) List<ProjectEntity> projects,
    ProjectEntity? selectedProject,
    @Default("auto") String timesheetFill,
    @Default("") String taskDescription,
    @Default("") String reason,
    @Default("weekend") String workType,
    @Default(0.0) double workedHours,
    @Default(false) bool isActionLoading,
    @Default(true) bool isLoading,
    @Default(false) bool isSuccess,
    String? errorMessage,
  }) = CompensatoryLeaveLoading;

  const factory CompensatoryLeaveState.loaded({
    String? initialCompensatoryLeaveId,
    required CompensatoryLeaveSummaryEntity summary,
    required List<CompensatoryLeaveEligibleDateEntity> eligibleDates,
    CompensatoryLeaveEligibleDateEntity? selectedDate,
    @Default([]) List<ProjectEntity> projects,
    ProjectEntity? selectedProject,
    @Default("auto") String timesheetFill,
    @Default("") String taskDescription,
    @Default("") String reason,
    @Default("weekend") String workType,
    @Default(0.0) double workedHours,
    @Default(false) bool isActionLoading,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? errorMessage,
  }) = CompensatoryLeaveLoaded;

  const factory CompensatoryLeaveState.success({
    String? initialCompensatoryLeaveId,
    required CompensatoryLeaveSummaryEntity summary,
    required List<CompensatoryLeaveEligibleDateEntity> eligibleDates,
    CompensatoryLeaveEligibleDateEntity? selectedDate,
    @Default([]) List<ProjectEntity> projects,
    ProjectEntity? selectedProject,
    @Default("auto") String timesheetFill,
    @Default("") String taskDescription,
    @Default("") String reason,
    @Default("weekend") String workType,
    @Default(0.0) double workedHours,
    @Default(false) bool isActionLoading,
    @Default(false) bool isLoading,
    @Default(true) bool isSuccess,
    String? errorMessage,
  }) = CompensatoryLeaveSuccess;

  const factory CompensatoryLeaveState.error({
    String? initialCompensatoryLeaveId,
    CompensatoryLeaveSummaryEntity? summary,
    @Default([]) List<CompensatoryLeaveEligibleDateEntity> eligibleDates,
    CompensatoryLeaveEligibleDateEntity? selectedDate,
    @Default([]) List<ProjectEntity> projects,
    ProjectEntity? selectedProject,
    @Default("auto") String timesheetFill,
    @Default("") String taskDescription,
    @Default("") String reason,
    @Default("weekend") String workType,
    @Default(0.0) double workedHours,
    @Default(false) bool isActionLoading,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    required String errorMessage,
  }) = CompensatoryLeaveError;
}

extension CompensatoryLeaveStateX on CompensatoryLeaveState {
  String? get initialCompensatoryLeaveId => maybeMap(
    orElse: () => null,
    initial: (s) => s.initialCompensatoryLeaveId,
    loading: (s) => s.initialCompensatoryLeaveId,
    loaded: (s) => s.initialCompensatoryLeaveId,
    success: (s) => s.initialCompensatoryLeaveId,
    error: (s) => s.initialCompensatoryLeaveId,
  );

  CompensatoryLeaveSummaryEntity? get summary => maybeMap(
    orElse: () => null,
    initial: (s) => s.summary,
    loading: (s) => s.summary,
    loaded: (s) => s.summary,
    success: (s) => s.summary,
    error: (s) => s.summary,
  );

  List<CompensatoryLeaveEligibleDateEntity> get eligibleDates => maybeMap(
    orElse: () => [],
    initial: (s) => s.eligibleDates,
    loading: (s) => s.eligibleDates,
    loaded: (s) => s.eligibleDates,
    success: (s) => s.eligibleDates,
    error: (s) => s.eligibleDates,
  );

  CompensatoryLeaveEligibleDateEntity? get selectedDate => maybeMap(
    orElse: () => null,
    initial: (s) => s.selectedDate,
    loading: (s) => s.selectedDate,
    loaded: (s) => s.selectedDate,
    success: (s) => s.selectedDate,
    error: (s) => s.selectedDate,
  );

  String get timesheetFill => maybeMap(
    orElse: () => "auto",
    initial: (s) => s.timesheetFill,
    loading: (s) => s.timesheetFill,
    loaded: (s) => s.timesheetFill,
    success: (s) => s.timesheetFill,
    error: (s) => s.timesheetFill,
  );

  String get taskDescription => maybeMap(
    orElse: () => "",
    initial: (s) => s.taskDescription,
    loading: (s) => s.taskDescription,
    loaded: (s) => s.taskDescription,
    success: (s) => s.taskDescription,
    error: (s) => s.taskDescription,
  );

  String get reason => maybeMap(
    orElse: () => "",
    initial: (s) => s.reason,
    loading: (s) => s.reason,
    loaded: (s) => s.reason,
    success: (s) => s.reason,
    error: (s) => s.reason,
  );

  String get workType => maybeMap(
    orElse: () => "weekend",
    initial: (s) => s.workType,
    loading: (s) => s.workType,
    loaded: (s) => s.workType,
    success: (s) => s.workType,
    error: (s) => s.workType,
  );

  double get workedHours => maybeMap(
    orElse: () => 0.0,
    initial: (s) => s.workedHours,
    loading: (s) => s.workedHours,
    loaded: (s) => s.workedHours,
    success: (s) => s.workedHours,
    error: (s) => s.workedHours,
  );

  bool get isActionLoading => maybeMap(
    orElse: () => false,
    initial: (s) => s.isActionLoading,
    loading: (s) => s.isActionLoading,
    loaded: (s) => s.isActionLoading,
    success: (s) => s.isActionLoading,
    error: (s) => s.isActionLoading,
  );

  bool get isLoading => maybeMap(
    orElse: () => false,
    initial: (s) => s.isLoading,
    loading: (s) => s.isLoading,
    loaded: (s) => s.isLoading,
    success: (s) => s.isLoading,
    error: (s) => s.isLoading,
  );

  bool get isSuccess => maybeMap(
    orElse: () => false,
    initial: (s) => s.isSuccess,
    loading: (s) => s.isSuccess,
    loaded: (s) => s.isSuccess,
    success: (s) => s.isSuccess,
    error: (s) => s.isSuccess,
  );

  String? get errorMessage => maybeMap(
    orElse: () => null,
    initial: (s) => s.errorMessage,
    loading: (s) => s.errorMessage,
    loaded: (s) => s.errorMessage,
    success: (s) => s.errorMessage,
    error: (s) => s.errorMessage,
  );

  List<ProjectEntity> get projects => maybeMap(
    orElse: () => [],
    initial: (s) => s.projects,
    loading: (s) => s.projects,
    loaded: (s) => s.projects,
    success: (s) => s.projects,
    error: (s) => s.projects,
  );

  ProjectEntity? get selectedProject => maybeMap(
    orElse: () => null,
    initial: (s) => s.selectedProject,
    loading: (s) => s.selectedProject,
    loaded: (s) => s.selectedProject,
    success: (s) => s.selectedProject,
    error: (s) => s.selectedProject,
  );
}
