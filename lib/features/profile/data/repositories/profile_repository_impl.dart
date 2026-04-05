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
  Future<Either<Failure, ProfileEntity>> getProfile(String email) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getProfile(email);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> updateAvatar(String filePath, String email) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final success = await remoteDataSource.updateAvatar(filePath, email);
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
}
