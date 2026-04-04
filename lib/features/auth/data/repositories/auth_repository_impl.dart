import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> signIn(String email, String password) async {
    try {
      final UserModel userModel = await remoteDataSource.signIn(email, password);
      final userEntity = userModel.toEntity();

      // Persist some basic user info locally for sessions
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
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "Server Error"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      // Clear local session data
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "Logout Failed"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString(StorageConstants.userEmail);
      if (email == null) return const Left(CacheFailure("No user session found"));

      final userModel = await remoteDataSource.getEmployeeDetails(email);
      
      // Patch the approver and department from local storage if missing from remote
      var userEntity = userModel.toEntity();
      if (userEntity.approver == null) {
        userEntity = userEntity.copyWith(approver: prefs.getString(StorageConstants.leaveApproverName));
      }
      if (userEntity.department == null) {
        userEntity = userEntity.copyWith(department: prefs.getString(StorageConstants.department));
      }

      return Right(userEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "Failed to fetch current user"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<bool> isSessionActive() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(StorageConstants.cookies);
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      await remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "Password reset request failed"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> microsoftSSO() async {
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
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "SSO Failed"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(String email, String otp) async {
    try {
      final result = await remoteDataSource.verifyOtp(email, otp);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "OTP Verification Failed"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> resendOtp(String email) async {
    try {
      final result = await remoteDataSource.resendOtp(email);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "Resend OTP Failed"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
