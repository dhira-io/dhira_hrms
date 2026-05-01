import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/pms_cycle_entity.dart';
import '../../domain/entities/goal_entity.dart';
import '../../domain/entities/team_evaluation_entity.dart';
import '../../domain/repositories/i_performance_repository.dart';
import '../datasources/performance_remote_datasource.dart';

class PerformanceRepositoryImpl implements IPerformanceRepository {
  final IPerformanceRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PerformanceRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, String?>> getJobFamily(String employeeId) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final jobFamily = await remoteDataSource.getJobFamily(employeeId);
        return Right(jobFamily);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, PmsCycleEntity?>> getActivePmsCycle() async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getActivePmsCycle();
        return Right(model?.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, List<GoalEntity>>> getPmsGoals(
    String employeeId,
    String pmsCycleId,
  ) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.getPmsGoals(employeeId, pmsCycleId);
        return Right(models.map((e) => e.toEntity()).toList());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, GoalEntity>> getGoalDetails(String goalName) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.getGoalDetails(goalName);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, GoalEntity>> updateGoal(GoalEntity goal) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final model = await remoteDataSource.updateGoal(goal);
        return Right(model.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, List<String>>> getKraList(String jobFamily) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final list = await remoteDataSource.getKraList(jobFamily);
        return Right(list);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, List<TeamEvaluationEntity>>> getTeamEvaluations() async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.getTeamEvaluations();
        return Right(models.map((e) => e.toEntity()).toList());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }
}
