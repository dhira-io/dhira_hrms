import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/features/policy/domain/entities/policy_pdf_entity.dart';
import 'package:dhira_hrms/features/policy/domain/repositories/i_policy_repository.dart';

import 'package:dhira_hrms/core/usecases/usecase.dart';

class GetPolicyPdfUseCase implements UseCase<PolicyPdfEntity, String> {
  final IPolicyRepository repository;

  GetPolicyPdfUseCase(this.repository);

  @override
  Future<Either<Failure, PolicyPdfEntity>> call(String fileUrl) {
    return repository.getPolicyPdf(fileUrl);
  }
}
