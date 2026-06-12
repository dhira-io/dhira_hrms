import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/policy_entity.dart';
import '../entities/policy_pdf_entity.dart';

abstract class IPolicyRepository {
  Future<Either<Failure, List<PolicyEntity>>> getPolicies();
  Future<Either<Failure, PolicyPdfEntity>> getPolicyPdf(String fileUrl);
}
