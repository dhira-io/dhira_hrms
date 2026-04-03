import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      await prefs.setString('user_email', userEntity.email);
      await prefs.setString('user_fullname', userEntity.fullName);
      await prefs.setString('empid', userEntity.empId);

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
      final email = prefs.getString('user_email');
      if (email == null) return const Left(CacheFailure("No user session found"));

      final userModel = await remoteDataSource.getEmployeeDetails(email);
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? "Failed to fetch current user"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<bool> isSessionActive() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('cookies');
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
      await prefs.setString('user_email', userEntity.email);
      await prefs.setString('user_fullname', userEntity.fullName);
      await prefs.setString('empid', userEntity.empId);

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
