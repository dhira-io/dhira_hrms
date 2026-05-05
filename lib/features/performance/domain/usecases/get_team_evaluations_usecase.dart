import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/team_evaluation_entity.dart';
import '../repositories/i_performance_repository.dart';

class GetTeamEvaluationsUseCase {
  final IPerformanceRepository repository;

  GetTeamEvaluationsUseCase(this.repository);

  Future<Either<Failure, List<TeamEvaluationEntity>>> call() {
    return repository.getTeamEvaluations();
  }
}
