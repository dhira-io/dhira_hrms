import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/goal_entity.dart';
import '../repositories/i_performance_repository.dart';

class GetPmsGoalsUseCase {
  final IPerformanceRepository repository;

  GetPmsGoalsUseCase(this.repository);

  Future<Either<Failure, List<GoalEntity>>> call(String employeeId, String pmsCycleId) {
    return repository.getPmsGoals(employeeId, pmsCycleId);
  }
}
