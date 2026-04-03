import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class MicrosoftSSOUseCase {
  final IAuthRepository repository;

  MicrosoftSSOUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call() async {
    return await repository.microsoftSSO();
  }
}
