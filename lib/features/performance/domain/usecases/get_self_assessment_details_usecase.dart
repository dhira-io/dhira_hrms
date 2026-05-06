import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/self_assessment_entity.dart';
import '../repositories/i_performance_repository.dart';

class GetSelfAssessmentDetailsUseCase {
  final IPerformanceRepository repository;

  GetSelfAssessmentDetailsUseCase(this.repository);

  Future<Either<Failure, SelfAssessmentEntity>> call(
    String selfAssessmentId,
    String evaluationId,
  ) {
    return repository.getSelfAssessmentDetails(selfAssessmentId, evaluationId);
  }
}
