import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/project_assignment_entity.dart';

part 'project_assignment_model.freezed.dart';
part 'project_assignment_model.g.dart';

@freezed
abstract class ProjectAssignmentModel with _$ProjectAssignmentModel {
  const factory ProjectAssignmentModel({
    String? name,
    required String project,
    @JsonKey(name: 'expected_hours') @Default(0.0) double expectedHours,
    @JsonKey(name: 'spent_hours') @Default(0.0) double spentHours,
    String? description,
  }) = _ProjectAssignmentModel;

  const ProjectAssignmentModel._();

  factory ProjectAssignmentModel.fromJson(Map<String, dynamic> json) => _$ProjectAssignmentModelFromJson(json);

  static ProjectAssignmentModel fromEntity(ProjectAssignmentEntity entity) {
    return ProjectAssignmentModel(
      name: entity.name,
      project: entity.project,
      expectedHours: entity.expectedHours,
      spentHours: entity.spentHours,
      description: entity.description,
    );
  }

  ProjectAssignmentEntity toEntity() {
    return ProjectAssignmentEntity(
      name: name,
      project: project,
      expectedHours: expectedHours,
      spentHours: spentHours,
      description: description,
    );
  }
}
