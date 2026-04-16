import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile_project_assignment_entity.dart';

part 'profile_project_assignment_model.freezed.dart';
part 'profile_project_assignment_model.g.dart';

@freezed
abstract class ProfileProjectAssignmentModel with _$ProfileProjectAssignmentModel {
  const factory ProfileProjectAssignmentModel({
    @JsonKey(name: 'project_name') required String projectName,
    @JsonKey(name: 'project_lead') String? projectLead,
    @JsonKey(name: 'start_date') String? startDate,
    @JsonKey(name: 'end_date') String? endDate,
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
