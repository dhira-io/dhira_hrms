import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final IAuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, bool>> call(String email, String otp) async {
    return await repository.verifyOtp(email, otp);
  }
}
