import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, UserEntity>> signIn(String email, String password) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final UserModel userModel = await remoteDataSource.signIn(email, password);
        final userEntity = userModel.toEntity();

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(StorageConstants.userEmail, userEntity.email);
        await prefs.setString(StorageConstants.userFullname, userEntity.fullName);
        await prefs.setString(StorageConstants.empId, userEntity.empId);
        if (userEntity.department != null) {
          await prefs.setString(StorageConstants.department, userEntity.department!);
        }
        if (userEntity.approver != null) {
          await prefs.setString(StorageConstants.leaveApproverName, userEntity.approver!);
        }

        return Right(userEntity);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.logout();
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    return networkInfo.connectedAndRun(() async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final email = prefs.getString(StorageConstants.userEmail);
        if (email == null) return const Left(CacheFailure("No user session found"));

        final userModel = await remoteDataSource.getEmployeeDetails(email);
        
        var userEntity = userModel.toEntity();
        if (userEntity.approver == null) {
          userEntity = userEntity.copyWith(approver: prefs.getString(StorageConstants.leaveApproverName));
        }
        if (userEntity.department == null) {
          userEntity = userEntity.copyWith(department: prefs.getString(StorageConstants.department));
        }

        return Right(userEntity);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<bool> isSessionActive() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(StorageConstants.cookies);
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.forgotPassword(email);
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, UserEntity>> microsoftSSO() async {
    return networkInfo.connectedAndRun(() async {
      try {
        final UserModel userModel = await remoteDataSource.microsoftSSO();
        final userEntity = userModel.toEntity();

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(StorageConstants.userEmail, userEntity.email);
        await prefs.setString(StorageConstants.userFullname, userEntity.fullName);
        await prefs.setString(StorageConstants.empId, userEntity.empId);
        if (userEntity.department != null) {
          await prefs.setString(StorageConstants.department, userEntity.department!);
        }
        if (userEntity.approver != null) {
          await prefs.setString(StorageConstants.leaveApproverName, userEntity.approver!);
        }

        return Right(userEntity);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(String email, String otp) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final result = await remoteDataSource.verifyOtp(email, otp);
        return Right(result);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> resendOtp(String email) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final result = await remoteDataSource.resendOtp(email);
        return Right(result);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }
}
