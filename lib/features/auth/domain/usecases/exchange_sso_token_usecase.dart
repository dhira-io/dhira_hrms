import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class ExchangeSSOTokenUseCase {
  final IAuthRepository repository;

  ExchangeSSOTokenUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String apiKey, String apiSecret) async {
    return await repository.exchangeSSOToken(apiKey, apiSecret);
  }
}
