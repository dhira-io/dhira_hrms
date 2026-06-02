import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/profile_entities.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements IProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile(String identifier) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getProfile(identifier);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> updateAvatar(
    String filePath,
    String identifier,
  ) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final success = await remoteDataSource.updateAvatar(
          filePath,
          identifier,
        );
        return Right(success);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> deleteProfileImage(String employeeId) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final success = await remoteDataSource.deleteProfileImage(employeeId);
        return Right(success);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String logoutAllSessions,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final success = await remoteDataSource.changePassword(
          oldPassword: oldPassword,
          newPassword: newPassword,
          logoutAllSessions: logoutAllSessions,
        );
        return Right(success);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> updateProfileDetails({
    required String identifier,
    required String personalEmail,
    required String phone,
    required String emergencyContact,
    required String currentAddress,
    required String permanentAddress,
    String? dateOfBirth,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final success = await remoteDataSource.updateProfileDetails(
          identifier: identifier,
          personalEmail: personalEmail,
          phone: phone,
          emergencyContact: emergencyContact,
          currentAddress: currentAddress,
          permanentAddress: permanentAddress,
          dateOfBirth: dateOfBirth,
        );
        return Right(success);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }
}
