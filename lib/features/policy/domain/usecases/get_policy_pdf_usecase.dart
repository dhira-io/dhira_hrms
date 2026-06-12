import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/policy_pdf_entity.dart';
import '../repositories/i_policy_repository.dart';

class GetPolicyPdfUseCase {
  final IPolicyRepository repository;

  GetPolicyPdfUseCase(this.repository);

  Future<Either<Failure, PolicyPdfEntity>> call(String fileUrl) {
    return repository.getPolicyPdf(fileUrl);
  }
}
