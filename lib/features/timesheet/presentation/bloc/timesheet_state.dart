import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../../auth/domain/entities/user_entity.dart';

import '../../domain/entities/timesheet_overview_entity.dart';

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
  }) = _Loaded;

  const factory TimesheetState.detailLoaded({
    required TimesheetEntity timesheet,
    required List<ProjectEntity> projects,
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    DateTime? selectedDate,
    @Default([]) List<TimesheetEntity> timesheets,
    @Default(false) bool hasMore,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default(false) bool isActionLoading,
    String? activeTimesheetId,
    TimesheetOverviewEntity? overview,
  }) = _DetailLoaded;

  const factory TimesheetState.success({
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
}

