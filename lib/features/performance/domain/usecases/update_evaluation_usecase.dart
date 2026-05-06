import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_performance_repository.dart';

class UpdateEvaluationUseCase {
  final IPerformanceRepository repository;

  UpdateEvaluationUseCase(this.repository);

  Future<Either<Failure, void>> call(
    String evaluationId,
    Map<String, dynamic> data,
  ) {
    return repository.updateEvaluation(evaluationId, data);
  }
}
