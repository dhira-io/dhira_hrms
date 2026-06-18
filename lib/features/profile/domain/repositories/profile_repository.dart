import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile_entities.dart';
import '../entities/resume_entity.dart';
import '../entities/country_code_entity.dart';
import '../../data/models/search_employee_model.dart';

abstract class IProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile(String identifier);
  Future<Either<Failure, String>> updateAvatar(
    String filePath,
    String identifier,
  );
  Future<Either<Failure, bool>> deleteProfileImage(String employeeId);
  Future<Either<Failure, bool>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String logoutAllSessions,
  });
  Future<Either<Failure, bool>> updateProfileDetails({
    required String identifier,
    required String personalEmail,
    required String phone,
    required String emergencyContact,
    String? emergencyContactName,
    String? nationality,
    required String currentAddress,
    required String permanentAddress,
    String? currentLocation,
    String? dateOfBirth,
  });

  // Resume operations
  Future<Either<Failure, ResumeEntity>> getEmployeeResume(String employeeId);
  Future<Either<Failure, List<String>>> searchSkills(String query);
  Future<Either<Failure, List<String>>> searchDesignations(String query);
  Future<Either<Failure, List<String>>> searchProjects(String query);
  Future<Either<Failure, List<SearchEmployeeModel>>> searchEmployees(String query);
  Future<Either<Failure, List<SubSkillEntity>>> getSubSkills(String skillName);
  Future<Either<Failure, List<String>>> searchLocations(String query);
  Future<Either<Failure, List<CountryCodeEntity>>> getCountryCodes();
  Future<Either<Failure, List<String>>> getNationalities();
  Future<Either<Failure, void>> upsertResumeRow(String employeeId, String section, String rowDataJson, {String? rowName});
  Future<Either<Failure, void>> deleteResumeRow(String employeeId, String section, String rowName);
  Future<Either<Failure, void>> updateEmployeeResume(String employeeId, String resumeDataJson);
  Future<Either<Failure, void>> updateEmployeeSubSkills(String employeeId, String subSkillsJson);
  Future<Either<Failure, void>> saveSubSkillsForSkill(String employeeId, String skillName, String subSkillsJson);
  Future<Either<Failure, void>> updateEmployeeProjectAssignments(String employeeId, String assignmentsJson);
}
