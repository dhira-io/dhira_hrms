import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/project_assignment_entity.dart';

part 'project_assignment_model.freezed.dart';
part 'project_assignment_model.g.dart';

@freezed
abstract class ProjectAssignmentModel with _$ProjectAssignmentModel {
  const factory ProjectAssignmentModel({
    String? name,
    String? parent,
    required String project,
    String? date,
    @JsonKey(name: 'expected_hours') @Default(0.0) double expectedHours,
    @JsonKey(name: 'spent_hours') @Default(0.0) double spentHours,
    String? description,
    @JsonKey(name: 'hours_details') String? hoursDetails,
    @JsonKey(name: 'raised_by') String? raisedBy,
    int? completed,
    int? approved,
    @JsonKey(name: 'applicable_for_compensatory_off') int? applicableForCompensatoryOff,
    String? status,
    @JsonKey(name: 'task_data') String? taskData,
  }) = _ProjectAssignmentModel;

  const ProjectAssignmentModel._();

  factory ProjectAssignmentModel.fromJson(Map<String, dynamic> json) => _$ProjectAssignmentModelFromJson(json);

  static ProjectAssignmentModel fromEntity(ProjectAssignmentEntity entity) {
    return ProjectAssignmentModel(
      name: entity.name,
      parent: entity.parent,
      project: entity.project,
      date: entity.date,
      expectedHours: entity.expectedHours,
      spentHours: entity.spentHours,
      description: entity.description,
      status: entity.status,
      taskData: entity.taskData,
    );
  }

  ProjectAssignmentEntity toEntity() {
    return ProjectAssignmentEntity(
      name: name,
      parent: parent,
      project: project,
      date: date,
      expectedHours: expectedHours,
      spentHours: spentHours,
      description: description,
      status: status,
      taskData: taskData,
    );
  }
}
