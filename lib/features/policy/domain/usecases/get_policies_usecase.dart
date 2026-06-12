import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/policy_entity.dart';
import '../repositories/i_policy_repository.dart';

class GetPoliciesUseCase implements UseCase<List<PolicyEntity>, NoParams> {
  final IPolicyRepository repository;

  GetPoliciesUseCase(this.repository);

  @override
  Future<Either<Failure, List<PolicyEntity>>> call(NoParams params) async {
    return await repository.getPolicies();
  }
}
