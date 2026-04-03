import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/task_entity.dart';

part 'task_state.freezed.dart';

@freezed
class TaskState with _$TaskState {
  const factory TaskState.initial() = _Initial;
  const factory TaskState.loading() = _Loading;
  const factory TaskState.loaded({
    required List<TaskEntity> tasks,
    required bool hasReachedMax,
  }) = _Loaded;
  const factory TaskState.error(String message) = _Error;
}
