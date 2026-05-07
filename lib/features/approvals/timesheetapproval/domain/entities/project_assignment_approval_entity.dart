import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_assignment_approval_entity.freezed.dart';

@freezed
abstract class ProjectAssignmentApprovalEntity with _$ProjectAssignmentApprovalEntity {
  const factory ProjectAssignmentApprovalEntity({
    String? name,
    String? parent,
    required String project,
    String? date,
    @Default(0.0) double expectedHours,
    @Default(0.0) double spentHours,
    String? description,
    String? hoursDetails,
    String? raisedBy,
    String? status,
    @Default(0) int docStatus,
    String? taskData,
  }) = _ProjectAssignmentApprovalEntity;

  const ProjectAssignmentApprovalEntity._();
}
