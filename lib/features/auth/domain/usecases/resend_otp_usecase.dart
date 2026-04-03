import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class ResendOtpUseCase {
  final IAuthRepository repository;

  ResendOtpUseCase(this.repository);

  Future<Either<Failure, bool>> call(String email) async {
    return await repository.resendOtp(email);
  }
}
