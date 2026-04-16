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
    String? phone,
    String? emergencyContact,
    List<ProfileProjectAssignmentEntity>? projectAssignments,
    String? empId,
  }) = _ProfileEntity;

  const ProfileEntity._();
}
