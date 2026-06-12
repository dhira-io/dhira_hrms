import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile_project_assignment_entity.dart';

part 'profile_project_assignment_model.freezed.dart';
part 'profile_project_assignment_model.g.dart';

@freezed
abstract class ProfileProjectAssignmentModel
    with _$ProfileProjectAssignmentModel {
  const factory ProfileProjectAssignmentModel({
    @JsonKey(name: 'project_name') required String projectName,
    @JsonKey(name: 'report_to_name') String? projectLead,
    @JsonKey(name: 'report_to') String? reportTo,
    @JsonKey(name: 'start_date') String? startDate,
    @JsonKey(name: 'end_date') String? endDate,
    @JsonKey(name: 'role') String? role,
    @JsonKey(name: 'allocation') double? allocation,
    @JsonKey(name: 'status') String? status,
  }) = _ProfileProjectAssignmentModel;

  const ProfileProjectAssignmentModel._();

  factory ProfileProjectAssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileProjectAssignmentModelFromJson(json);

  ProfileProjectAssignmentEntity toEntity() {
    return ProfileProjectAssignmentEntity(
      projectName: projectName,
      projectLead: projectLead,
      reportTo: reportTo,
      startDate: startDate,
      endDate: endDate,
      role: role,
      allocation: allocation,
      status: status,
    );
  }
}
