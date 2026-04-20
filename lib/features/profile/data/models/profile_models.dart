import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile_entities.dart';
import 'profile_project_assignment_model.dart';

part 'profile_models.freezed.dart';
part 'profile_models.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    @JsonKey(name: 'employee_name') required String fullName,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'user_id') required String email,
    @JsonKey(name: 'desk_theme') String? deskTheme,
    @JsonKey(name: 'image') String? userImage,
    @JsonKey(name: 'date_of_birth') String? birthDate,
    String? gender,
    String? designation,
    String? company,
    String? department,
    @JsonKey(name: 'reports_to') String? reportsTo,
    @JsonKey(name: 'status') String? employmentType,
    @JsonKey(name: 'company_email') String? companyEmail,
    @JsonKey(name: 'cell_number') String? phone,
    @JsonKey(name: 'blood_group') String? bloodGroup,
    @JsonKey(name: 'date_of_joining') String? dateOfJoining,
    @JsonKey(name: 'employee') String? employee,
    @JsonKey(name: 'custom_payroll_id') String? customPayrollId,
    @JsonKey(name: 'custom_report_to_name') String? reportsToName,
    @JsonKey(name: 'custom_organization_department') String? orgDepartment,
    @JsonKey(name: 'custom_division') String? division,
    @JsonKey(name: 'marital_status') String? maritalStatus,
    @JsonKey(name: 'doctype') String? docType,
    @JsonKey(name: 'naming_series') String? namingSeries,
    @JsonKey(name: 'emergency_contact_name') String? emergencyContact,
    @JsonKey(name: 'custom_employee_assignment') List<ProfileProjectAssignmentModel>? projectAssignments,
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
      bloodGroup: bloodGroup,
      dateOfJoining: dateOfJoining,
      employee: employee,
      customPayrollId: customPayrollId,
      reportsToName: reportsToName,
      orgDepartment: orgDepartment,
      division: division,
      maritalStatus: maritalStatus,
      docType: docType,
      namingSeries: namingSeries,
      emergencyContact: emergencyContact,
      projectAssignments: projectAssignments?.map((e) => e.toEntity()).toList(),
      empId: empId,
    );
  }
}
