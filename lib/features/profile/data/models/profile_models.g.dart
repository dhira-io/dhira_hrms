// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    _ProfileModel(
      fullName: json['employee_name'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['user_id'] as String,
      deskTheme: json['desk_theme'] as String?,
      userImage: json['image'] as String?,
      birthDate: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      designation: json['designation'] as String?,
      company: json['company'] as String?,
      department: json['department'] as String?,
      reportsTo: json['reports_to'] as String?,
      employmentType: json['status'] as String?,
      companyEmail: json['company_email'] as String?,
      phone: json['cell_number'] as String?,
      bloodGroup: json['blood_group'] as String?,
      dateOfJoining: json['date_of_joining'] as String?,
      employee: json['employee'] as String?,
      customPayrollId: json['custom_payroll_id'] as String?,
      reportsToName: json['custom_report_to_name'] as String?,
      orgDepartment: json['custom_organization_department'] as String?,
      division: json['custom_division'] as String?,
      maritalStatus: json['marital_status'] as String?,
      docType: json['doctype'] as String?,
      namingSeries: json['naming_series'] as String?,
      emergencyContact: json['emergency_contact_name'] as String?,
      projectAssignments: (json['custom_employee_assignment'] as List<dynamic>?)
          ?.map(
            (e) => ProfileProjectAssignmentModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      empId: json['name'] as String?,
    );

Map<String, dynamic> _$ProfileModelToJson(_ProfileModel instance) =>
    <String, dynamic>{
      'employee_name': instance.fullName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'user_id': instance.email,
      'desk_theme': instance.deskTheme,
      'image': instance.userImage,
      'date_of_birth': instance.birthDate,
      'gender': instance.gender,
      'designation': instance.designation,
      'company': instance.company,
      'department': instance.department,
      'reports_to': instance.reportsTo,
      'status': instance.employmentType,
      'company_email': instance.companyEmail,
      'cell_number': instance.phone,
      'blood_group': instance.bloodGroup,
      'date_of_joining': instance.dateOfJoining,
      'employee': instance.employee,
      'custom_payroll_id': instance.customPayrollId,
      'custom_report_to_name': instance.reportsToName,
      'custom_organization_department': instance.orgDepartment,
      'custom_division': instance.division,
      'marital_status': instance.maritalStatus,
      'doctype': instance.docType,
      'naming_series': instance.namingSeries,
      'emergency_contact_name': instance.emergencyContact,
      'custom_employee_assignment': instance.projectAssignments,
      'name': instance.empId,
    };
