import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class IAuthRepository {
  Future<Either<Failure, UserEntity>> signIn(String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<bool> isSessionActive();
  Future<Either<Failure, void>> forgotPassword(String email);
  Future<Either<Failure, UserEntity>> microsoftSSO();
  Future<Either<Failure, bool>> verifyOtp(String email, String otp);
  Future<Either<Failure, bool>> resendOtp(String email);
}
