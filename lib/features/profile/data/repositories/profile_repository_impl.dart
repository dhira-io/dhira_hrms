import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/profile_entities.dart';
import '../../domain/entities/resume_entity.dart';
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
  Future<Either<Failure, String>> updateAvatar(
    String filePath,
    String identifier,
  ) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final message = await remoteDataSource.updateAvatar(
          filePath,
          identifier,
        );
        return Right(message);
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
    String? emergencyContactName,
    String? nationality,
    required String currentAddress,
    required String permanentAddress,
    String? currentLocation,
    String? dateOfBirth,
  }) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final success = await remoteDataSource.updateProfileDetails(
          identifier: identifier,
          personalEmail: personalEmail,
          phone: phone,
          emergencyContact: emergencyContact,
          emergencyContactName: emergencyContactName,
          nationality: nationality,
          currentAddress: currentAddress,
          permanentAddress: permanentAddress,
          currentLocation: currentLocation,
          dateOfBirth: dateOfBirth,
        );
        return Right(success);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, ResumeEntity>> getEmployeeResume(String employeeId) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getEmployeeResume(employeeId);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, List<String>>> searchSkills(String query) async {
    try {
      if (await networkInfo.isConnected) {
        final skills = await remoteDataSource.searchSkills(query);
        return Right(skills);
      } else {
        return const Left(NetworkFailure("No internet connection"));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> searchDesignations(String query) async {
    try {
      if (await networkInfo.isConnected) {
        final designations = await remoteDataSource.searchDesignations(query);
        return Right(designations);
      } else {
        return const Left(NetworkFailure("No internet connection"));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SubSkillEntity>>> getSubSkills(String skillName) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.getSubSkills(skillName);
        return Right(models.map((e) => e.toEntity()).toList());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, void>> upsertResumeRow(String employeeId, String section, String rowDataJson, {String? rowName}) async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.upsertResumeRow(employeeId, section, rowDataJson, rowName: rowName);
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, void>> deleteResumeRow(String employeeId, String section, String rowName) async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.deleteResumeRow(employeeId, section, rowName);
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, void>> updateEmployeeResume(String employeeId, String resumeDataJson) async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.updateEmployeeResume(employeeId, resumeDataJson);
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, void>> updateEmployeeSubSkills(String employeeId, String subSkillsJson) async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.updateEmployeeSubSkills(employeeId, subSkillsJson);
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }
}
