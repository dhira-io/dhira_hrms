import 'package:freezed_annotation/freezed_annotation.dart';
import 'profile_project_assignment_entity.dart';

part 'profile_entities.freezed.dart';

@freezed
abstract class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    required String fullName,
    required String firstName,
    required String lastName,
    required String email,
    String? deskTheme,
    String? userImage,
    String? birthDate,
    String? gender,
    String? designation,
    String? company,
    String? department,
    String? reportsTo,
    String? employmentType,
    String? companyEmail,
    String? personalEmail,
    String? phone,
    String? bloodGroup,
    String? dateOfJoining,
    String? employee,
    String? customPayrollId,
    String? reportsToName,
    String? orgDepartment,
    String? division,
    String? maritalStatus,
    String? docType,
    String? namingSeries,
    String? emergencyContact,
    String? emergencyContactName,
    String? nationality,
    List<ProfileProjectAssignmentEntity>? projectAssignments,
    String? empId,
    String? currentAddress,
    String? permanentAddress,
    String? currentLocation,
    String? professionalSummary,
    String? awardsAndAchievements,
  }) = _ProfileEntity;

  const ProfileEntity._();
}
