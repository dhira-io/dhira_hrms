import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/goal_entity.dart';
import '../repositories/i_performance_repository.dart';

class GetGoalDetailsUseCase {
  final IPerformanceRepository repository;

  GetGoalDetailsUseCase(this.repository);

  Future<Either<Failure, GoalEntity>> call(String goalName) {
    return repository.getGoalDetails(goalName);
  }
}
