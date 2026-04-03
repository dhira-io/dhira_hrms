import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile_entities.dart';

abstract class IProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile(String email);
  Future<Either<Failure, bool>> updateAvatar(String filePath, String email);
  Future<Either<Failure, bool>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String logoutAllSessions,
  });
}
