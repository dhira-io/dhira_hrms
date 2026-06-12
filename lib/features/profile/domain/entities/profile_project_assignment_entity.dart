import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_project_assignment_entity.freezed.dart';

@freezed
abstract class ProfileProjectAssignmentEntity
    with _$ProfileProjectAssignmentEntity {
  const factory ProfileProjectAssignmentEntity({
    required String projectName,
    String? projectLead,
    String? reportTo,
    String? startDate,
    String? endDate,
    String? role,
    double? allocation,
    String? status,
  }) = _ProfileProjectAssignmentEntity;

  const ProfileProjectAssignmentEntity._();
}
