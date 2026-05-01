import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/goal_entity.dart';
import '../repositories/i_performance_repository.dart';

class UpdateGoalUseCase {
  final IPerformanceRepository repository;

  UpdateGoalUseCase(this.repository);

  Future<Either<Failure, GoalEntity>> call(GoalEntity goal) {
    return repository.updateGoal(goal);
  }
}
