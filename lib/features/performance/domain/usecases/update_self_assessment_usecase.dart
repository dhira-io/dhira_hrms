import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_performance_repository.dart';

class UpdateSelfAssessmentUseCase {
  final IPerformanceRepository repository;

  UpdateSelfAssessmentUseCase(this.repository);

  Future<Either<Failure, void>> call(
    String selfAssessmentId,
    Map<String, dynamic> data,
  ) {
    return repository.updateSelfAssessment(selfAssessmentId, data);
  }
}
