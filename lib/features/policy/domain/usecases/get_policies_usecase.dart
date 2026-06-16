import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/core/usecases/usecase.dart';
import 'package:dhira_hrms/features/policy/domain/entities/policy_entity.dart';
import 'package:dhira_hrms/features/policy/domain/repositories/i_policy_repository.dart';

class GetPoliciesUseCase implements UseCase<List<PolicyEntity>, NoParams> {
  final IPolicyRepository repository;

  GetPoliciesUseCase(this.repository);

  @override
  Future<Either<Failure, List<PolicyEntity>>> call(NoParams params) async {
    return await repository.getPolicies();
  }
}
