import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_entity.freezed.dart';

@freezed
abstract class TaskEntity with _$TaskEntity {
  const factory TaskEntity({
    required String id,
    required String title,
    required String description,
    required String status,
    required DateTime dueDate,
    required String priority,
  }) = _TaskEntity;
}
