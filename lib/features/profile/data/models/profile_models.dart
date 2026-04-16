import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile_entities.dart';
import 'profile_project_assignment_model.dart';

part 'profile_models.freezed.dart';
part 'profile_models.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String email,
    @JsonKey(name: 'desk_theme') String? deskTheme,
    @JsonKey(name: 'user_image') String? userImage,
    @JsonKey(name: 'birth_date') String? birthDate,
    String? gender,
    String? designation,
    String? company,
    String? department,
    @JsonKey(name: 'reports_to') String? reportsTo,
    @JsonKey(name: 'employment_type') String? employmentType,
    @JsonKey(name: 'company_email') String? companyEmail,
    @JsonKey(name: 'cell_number') String? phone,
    @JsonKey(name: 'emergency_contact_name') String? emergencyContact,
    @JsonKey(name: 'project_assignments') List<ProfileProjectAssignmentModel>? projectAssignments,
    @JsonKey(name: 'name') String? empId,
  }) = _ProfileModel;

  const ProfileModel._();

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

  ProfileEntity toEntity() {
    return ProfileEntity(
      fullName: fullName,
      firstName: firstName,
      lastName: lastName,
      email: email,
      deskTheme: deskTheme,
      userImage: userImage,
      birthDate: birthDate,
      gender: gender,
      designation: designation,
      company: company,
      department: department,
      reportsTo: reportsTo,
      employmentType: employmentType,
      companyEmail: companyEmail,
      phone: phone,
      emergencyContact: emergencyContact,
      projectAssignments: projectAssignments?.map((e) => e.toEntity()).toList(),
      empId: empId,
    );
  }
}
