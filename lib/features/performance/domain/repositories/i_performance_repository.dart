import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/pms_cycle_entity.dart';
import '../entities/goal_entity.dart';
import '../entities/team_evaluation_entity.dart';

abstract class IPerformanceRepository {
  Future<Either<Failure, String?>> getJobFamily(String employeeId);
  Future<Either<Failure, PmsCycleEntity?>> getActivePmsCycle();
  Future<Either<Failure, List<GoalEntity>>> getPmsGoals(String employeeId, String pmsCycleId);
  Future<Either<Failure, GoalEntity>> getGoalDetails(String goalName);
  Future<Either<Failure, GoalEntity>> updateGoal(GoalEntity goal);
  Future<Either<Failure, List<String>>> getKraList(String jobFamily);
  Future<Either<Failure, List<TeamEvaluationEntity>>> getTeamEvaluations();
}
