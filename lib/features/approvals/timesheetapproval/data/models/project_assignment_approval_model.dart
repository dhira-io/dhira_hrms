import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/project_assignment_approval_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_assignment_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_assignment_approval_model.freezed.dart';
part 'project_assignment_approval_model.g.dart';

@freezed
abstract class ProjectAssignmentApprovalModel with _$ProjectAssignmentApprovalModel {
  const factory ProjectAssignmentApprovalModel({
    @JsonKey(name: 'row_id') String? name,
    String? parent,
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
    @JsonKey(name: 'task_data') String? taskData,
  }) = _ProjectAssignmentApprovalModel;

  const ProjectAssignmentApprovalModel._();

  factory ProjectAssignmentApprovalModel.fromJson(Map<String, dynamic> json) => _$ProjectAssignmentApprovalModelFromJson(json);

  static ProjectAssignmentApprovalModel fromEntity(ProjectAssignmentEntity entity) {
    return ProjectAssignmentApprovalModel(
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

  ProjectAssignmentApprovalEntity toEntity() {
    return ProjectAssignmentApprovalEntity(
      name: name,
      parent: parent,
      project: project,
      date: date,
      expectedHours: expectedHours,
      spentHours: spentHours,
      description: description,
      hoursDetails: hoursDetails,
      raisedBy: raisedBy,
      status: status,
      docStatus: docStatus ?? 0,
      taskData: taskData,
    );
  }
}
