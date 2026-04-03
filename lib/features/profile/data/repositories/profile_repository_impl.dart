import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/profile_entities.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements IProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile(String email) async {
    try {
      final model = await remoteDataSource.getProfile(email);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "Failed to fetch profile"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateAvatar(String filePath, String email) async {
    try {
      final success = await remoteDataSource.updateAvatar(filePath, email);
      return Right(success);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "Upload failed"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String logoutAllSessions,
  }) async {
    try {
      final success = await remoteDataSource.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        logoutAllSessions: logoutAllSessions,
      );
      return Right(success);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "Password change failed"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
