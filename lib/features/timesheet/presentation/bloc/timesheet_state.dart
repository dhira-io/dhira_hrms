import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../../auth/domain/entities/user_entity.dart';

part 'timesheet_state.freezed.dart';

@freezed
abstract class TimesheetState with _$TimesheetState {
  const factory TimesheetState.initial({
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
  }) = _Initial;

  const factory TimesheetState.loading({
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
  }) = _Loading;

  const factory TimesheetState.loaded({
    required List<TimesheetEntity> timesheets,
    @Default(false) bool hasMore,
    @Default(false) bool isFetchingMore,
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
  }) = _Loaded;

  const factory TimesheetState.detailLoaded({
    required TimesheetEntity timesheet,
    required List<ProjectEntity> projects,
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
  }) = _DetailLoaded;

  const factory TimesheetState.success({
    required String message,
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
  }) = _Success;

  const factory TimesheetState.error({
    required String message,
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
  }) = _Error;

  const TimesheetState._();

  @override
  UserEntity? get user;
  @override
  DateTime? get editFromDate;
  @override
  DateTime? get editToDate;
  @override
  List<ProjectAssignmentEntity> get editAssignments;
  @override
  List<ProjectEntity> get projects;
}
