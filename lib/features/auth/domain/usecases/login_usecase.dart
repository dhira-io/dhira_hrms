import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String email, String password) async {
    // Basic validation before calling the repository
    if (email.isEmpty || password.isEmpty) {
      return const Left(ValidationFailure("Email and password cannot be empty"));
    }
    return await repository.signIn(email, password);
  }
}
