import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/performance/data/models/self_assessment_model.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';
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
        final models = await remoteDataSource.getPmsGoals(
          employeeId,
          pmsCycleId,
        );
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
  Future<Either<Failure, List<TeamEvaluationEntity>>>
  getTeamEvaluations() async {
    return networkInfo.connectedAndRun(() async {
      try {
        final models = await remoteDataSource.getTeamEvaluations();
        return Right(models.map((e) => e.toEntity()).toList());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, Map<String, String>>> getEmployeeInfo(
    String employeeId,
  ) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final info = await remoteDataSource.getEmployeeInfo(employeeId);
        return Right(info);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, SelfAssessmentEntity>> getSelfAssessmentDetails(
    String selfAssessmentId,
    String evaluationId,
  ) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final evalModelFuture = remoteDataSource.getEvaluationDetails(
          evaluationId,
        );
        final saModelFuture = selfAssessmentId.isNotEmpty 
            ? remoteDataSource.getSelfAssessmentDetails(selfAssessmentId)
            : Future.value(null); 
        final attachmentsFuture = remoteDataSource.getAttachments(
          selfAssessmentId,
        );

        final results = await Future.wait([
          evalModelFuture,
          saModelFuture,
          attachmentsFuture,
        ]);

        final evalModel = results[0] as SelfAssessmentModel;
        final saModel = (selfAssessmentId.isNotEmpty && results[1] != null) 
            ? results[1] as SelfAssessmentModel 
            : evalModel;
        final attachments = results[2] as List<FileAttachmentModel>;

        final mergedGoalReviews = evalModel.goalReviews.map((evalGoal) {
          final saGoal = saModel.goalReviews.firstWhere(
            (g) => g.goal.trim().toLowerCase() == evalGoal.goal.trim().toLowerCase(),
            orElse: () => evalGoal,
          );
          return evalGoal.copyWith(
            kras: saGoal.kras.isNotEmpty ? saGoal.kras : evalGoal.kras,
            weightage: saGoal.weightage > 0 ? saGoal.weightage : evalGoal.weightage,
          );
        }).toList();

        final mergedEvalModel = evalModel.copyWith(
          goalReviews: mergedGoalReviews,
          attachments: attachments,
        );

        return Right(mergedEvalModel.toEntity());
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, void>> updateEvaluation(
    String evaluationId,
    Map<String, dynamic> data,
  ) async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.updateEvaluation(evaluationId, data);
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }
}

