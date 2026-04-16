// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    _ProfileModel(
      fullName: json['full_name'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      deskTheme: json['desk_theme'] as String?,
      userImage: json['user_image'] as String?,
      birthDate: json['birth_date'] as String?,
      gender: json['gender'] as String?,
      designation: json['designation'] as String?,
      company: json['company'] as String?,
      department: json['department'] as String?,
      reportsTo: json['reports_to'] as String?,
      employmentType: json['employment_type'] as String?,
      companyEmail: json['company_email'] as String?,
      phone: json['cell_number'] as String?,
      emergencyContact: json['emergency_contact_name'] as String?,
      projectAssignments: (json['project_assignments'] as List<dynamic>?)
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
      'full_name': instance.fullName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'desk_theme': instance.deskTheme,
      'user_image': instance.userImage,
      'birth_date': instance.birthDate,
      'gender': instance.gender,
      'designation': instance.designation,
      'company': instance.company,
      'department': instance.department,
      'reports_to': instance.reportsTo,
      'employment_type': instance.employmentType,
      'company_email': instance.companyEmail,
      'cell_number': instance.phone,
      'emergency_contact_name': instance.emergencyContact,
      'project_assignments': instance.projectAssignments,
      'name': instance.empId,
    };
