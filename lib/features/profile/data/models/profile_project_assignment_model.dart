import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile_project_assignment_entity.dart';

part 'profile_project_assignment_model.freezed.dart';
part 'profile_project_assignment_model.g.dart';

@freezed
abstract class ProfileProjectAssignmentModel with _$ProfileProjectAssignmentModel {
  const factory ProfileProjectAssignmentModel({
    @JsonKey(name: 'project_name') required String projectName,
    @JsonKey(name: 'report_to_name') String? projectLead,
    @JsonKey(name: 'creation') String? startDate,
    @JsonKey(name: 'modified') String? endDate,
  }) = _ProfileProjectAssignmentModel;

  const ProfileProjectAssignmentModel._();

  factory ProfileProjectAssignmentModel.fromJson(Map<String, dynamic> json) => 
      _$ProfileProjectAssignmentModelFromJson(json);

  ProfileProjectAssignmentEntity toEntity() {
    return ProfileProjectAssignmentEntity(
      projectName: projectName,
      projectLead: projectLead,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
