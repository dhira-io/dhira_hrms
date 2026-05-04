import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/timesheet_overview_entity.dart';
import 'timesheet_success_type.dart';

part 'timesheet_state.freezed.dart';

@freezed
abstract class TimesheetState with _$TimesheetState {
  const factory TimesheetState.initial({
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    DateTime? selectedDate,
    @Default([]) List<TimesheetEntity> timesheets,
    @Default(false) bool hasMore,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
    @Default(false) bool isActionLoading,
    String? activeTimesheetId,
    TimesheetOverviewEntity? overview,
    @Default([]) List<ProjectAssignmentEntity> assignmentsForSelectedDay,
    String? currentWeekActiveId,
    @Default("") String formattedOverviewWeeks,
    ProjectAssignmentEntity? editingTask,
    int? editingIndex,
    @Default(0.0) double weeklyTotalHours,
    @Default({}) Set<DateTime> taskDays,
    @Default({}) Set<DateTime> holidayDays,
    @Default("") String currentWeekRangeText,
    @Default([]) List<DateTime> holidays,
  }) = _Initial;

  const factory TimesheetState.loading({
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    DateTime? selectedDate,
    @Default([]) List<TimesheetEntity> timesheets,
    @Default(false) bool hasMore,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
    @Default(false) bool isActionLoading,
    String? activeTimesheetId,
    TimesheetOverviewEntity? overview,
    @Default([]) List<ProjectAssignmentEntity> assignmentsForSelectedDay,
    String? currentWeekActiveId,
    @Default("") String formattedOverviewWeeks,
    ProjectAssignmentEntity? editingTask,
    int? editingIndex,
    @Default(0.0) double weeklyTotalHours,
    @Default({}) Set<DateTime> taskDays,
    @Default({}) Set<DateTime> holidayDays,
    @Default("") String currentWeekRangeText,
    @Default([]) List<DateTime> holidays,
  }) = _Loading;

  const factory TimesheetState.loaded({
    required List<TimesheetEntity> timesheets,
    @Default(false) bool hasMore,
    @Default(false) bool isFetchingMore,
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    DateTime? selectedDate,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
    @Default(false) bool isActionLoading,
    String? activeTimesheetId,
    TimesheetOverviewEntity? overview,
    @Default([]) List<ProjectAssignmentEntity> assignmentsForSelectedDay,
    String? currentWeekActiveId,
    @Default("") String formattedOverviewWeeks,
    ProjectAssignmentEntity? editingTask,
    int? editingIndex,
    @Default(0.0) double weeklyTotalHours,
    @Default({}) Set<DateTime> taskDays,
    @Default({}) Set<DateTime> holidayDays,
    @Default("") String currentWeekRangeText,
    @Default([]) List<DateTime> holidays,
  }) = _Loaded;

  const factory TimesheetState.success({
    required String message,
    TimesheetSuccessType? successType,
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    DateTime? selectedDate,
    @Default([]) List<TimesheetEntity> timesheets,
    @Default(false) bool hasMore,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
    @Default(false) bool isActionLoading,
    String? activeTimesheetId,
    TimesheetOverviewEntity? overview,
    @Default([]) List<ProjectAssignmentEntity> assignmentsForSelectedDay,
    String? currentWeekActiveId,
    @Default("") String formattedOverviewWeeks,
    ProjectAssignmentEntity? editingTask,
    int? editingIndex,
    @Default(0.0) double weeklyTotalHours,
    @Default({}) Set<DateTime> taskDays,
    @Default({}) Set<DateTime> holidayDays,
    @Default("") String currentWeekRangeText,
    @Default([]) List<DateTime> holidays,
  }) = _Success;

  const factory TimesheetState.error({
    required String message,
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    DateTime? selectedDate,
    @Default([]) List<TimesheetEntity> timesheets,
    @Default(false) bool hasMore,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
    @Default(false) bool isActionLoading,
    String? activeTimesheetId,
    TimesheetOverviewEntity? overview,
    @Default([]) List<ProjectAssignmentEntity> assignmentsForSelectedDay,
    String? currentWeekActiveId,
    @Default("") String formattedOverviewWeeks,
    ProjectAssignmentEntity? editingTask,
    int? editingIndex,
    @Default(0.0) double weeklyTotalHours,
    @Default({}) Set<DateTime> taskDays,
    @Default({}) Set<DateTime> holidayDays,
    @Default("") String currentWeekRangeText,
    @Default([]) List<DateTime> holidays,
  }) = _Error;

  const TimesheetState._();

  @override
  UserEntity? get user;
  @override
  DateTime? get editFromDate;
  @override
  DateTime? get editToDate;
  @override
  DateTime? get selectedDate;
  @override
  List<TimesheetEntity> get timesheets;
  @override
  bool get hasMore;
  @override
  List<ProjectAssignmentEntity> get editAssignments;
  @override
  List<ProjectEntity> get projects;
  @override
  bool get isActionLoading;
  @override
  String? get activeTimesheetId;
  @override
  TimesheetOverviewEntity? get overview;
  @override
  List<ProjectAssignmentEntity> get assignmentsForSelectedDay;
  @override
  String? get currentWeekActiveId;
  @override
  String get formattedOverviewWeeks;
  ProjectAssignmentEntity? get editingTask;
  int? get editingIndex;
  double get weeklyTotalHours;
  Set<DateTime> get taskDays;
  Set<DateTime> get holidayDays;
  String get currentWeekRangeText;
  List<DateTime> get holidays;
}
