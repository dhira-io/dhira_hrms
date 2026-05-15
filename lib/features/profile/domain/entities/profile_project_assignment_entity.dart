import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_project_assignment_entity.freezed.dart';

@freezed
abstract class ProfileProjectAssignmentEntity with _$ProfileProjectAssignmentEntity {
  const factory ProfileProjectAssignmentEntity({
    required String projectName,
    String? projectLead,
    String? startDate,
    String? endDate,
  }) = _ProfileProjectAssignmentEntity;

  const ProfileProjectAssignmentEntity._();
}
