import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/features/policy/domain/entities/policy_entity.dart';
import 'package:dhira_hrms/features/policy/domain/entities/policy_pdf_entity.dart';

abstract class IPolicyRepository {
  Future<Either<Failure, List<PolicyEntity>>> getPolicies();
  Future<Either<Failure, PolicyPdfEntity>> getPolicyPdf(String fileUrl);
}
