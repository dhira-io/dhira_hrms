import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile_entities.dart';

abstract class IProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile(String identifier);
  Future<Either<Failure, bool>> updateAvatar(String filePath, String identifier);
  Future<Either<Failure, bool>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String logoutAllSessions,
  });
  Future<Either<Failure, bool>> updateProfileDetails({
    required String identifier,
    required String companyEmail,
    required String phone,
    required String emergencyContact,
    required String currentAddress,
    required String permanentAddress,
  });
}
