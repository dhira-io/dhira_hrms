import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/project_assignment_entity.dart';

part 'project_assignment_model.freezed.dart';
part 'project_assignment_model.g.dart';

@freezed
abstract class ProjectAssignmentModel with _$ProjectAssignmentModel {
  const factory ProjectAssignmentModel({
    @JsonKey(name: 'row_id') String? name,
    required String project,
    String? date,
    @JsonKey(name: 'expected_time') @Default(0.0) double expectedHours,
    @JsonKey(name: 'actual_time') @Default(0.0) double spentHours,
    String? description,
    @JsonKey(name: 'task') String? hoursDetails,
    @JsonKey(name: 'raised_by') String? raisedBy,
    int? completed,
    int? approved,
    @JsonKey(name: 'applicable_for_compensatory_off') int? applicableForCompensatoryOff,
    String? status,
    @JsonKey(name: 'docstatus') int? docStatus,
  }) = _ProjectAssignmentModel;

  const ProjectAssignmentModel._();

  factory ProjectAssignmentModel.fromJson(Map<String, dynamic> json) => _$ProjectAssignmentModelFromJson(json);

  static ProjectAssignmentModel fromEntity(ProjectAssignmentEntity entity) {
    return ProjectAssignmentModel(
      name: entity.name,
      project: entity.project,
      date: entity.date,
      expectedHours: entity.expectedHours,
      spentHours: entity.spentHours,
      description: entity.description,
      hoursDetails: entity.hoursDetails,
      raisedBy: entity.raisedBy,
      status: entity.status,
      docStatus: entity.docStatus,
    );
  }

  ProjectAssignmentEntity toEntity() {
    return ProjectAssignmentEntity(
      name: name,
      project: project,
      date: date,
      expectedHours: expectedHours,
      spentHours: spentHours,
      description: description,
      hoursDetails: hoursDetails,
      raisedBy: raisedBy,
      status: status,
      docStatus: docStatus ?? 0,
    );
  }
}
