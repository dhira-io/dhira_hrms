import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_assignment_entity.freezed.dart';

@freezed
abstract class ProjectAssignmentEntity with _$ProjectAssignmentEntity {
  const factory ProjectAssignmentEntity({
    String? name,
    String? parent,
    required String project,
    String? date,
    @Default(0.0) double expectedHours,
    @Default(0.0) double spentHours,
    String? description,
    String? status,
    String? taskData,
  }) = _ProjectAssignmentEntity;

  const ProjectAssignmentEntity._();
}
