import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class MicrosoftSSOUseCase {
  final IAuthRepository repository;

  MicrosoftSSOUseCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.initiateMicrosoftSSO();
  }
}
