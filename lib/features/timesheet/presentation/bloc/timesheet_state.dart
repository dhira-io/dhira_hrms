import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/timesheet_entities.dart';

part 'timesheet_state.freezed.dart';

@freezed
class TimesheetState with _$TimesheetState {
  const factory TimesheetState.initial() = _Initial;
  const factory TimesheetState.loading() = _Loading;
  const factory TimesheetState.loaded({
    required List<TimesheetEntity> timesheets,
    @Default(false) bool hasMore,
    @Default(false) bool isFetchingMore,
  }) = _Loaded;
  const factory TimesheetState.detailLoaded({
    required TimesheetEntity timesheet,
    required List<ProjectEntity> projects,
  }) = _DetailLoaded;
  const factory TimesheetState.success(String message) = _Success;
  const factory TimesheetState.error(String message) = _Error;
}
