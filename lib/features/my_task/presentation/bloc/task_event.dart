import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_event.freezed.dart';

@freezed
class TaskEvent with _$TaskEvent {
  const factory TaskEvent.started() = _Started;
  const factory TaskEvent.loadTasksRequested({@Default(false) bool isRefresh}) = _LoadTasksRequested;
  const factory TaskEvent.loadMoreTasksRequested() = _LoadMoreTasksRequested;
}
