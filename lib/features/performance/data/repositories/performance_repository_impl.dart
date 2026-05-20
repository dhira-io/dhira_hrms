import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/performance/data/models/self_assessment_model.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/pms_cycle_entity.dart';
import '../../domain/entities/goal_entity.dart';
import '../../domain/entities/team_evaluation_entity.dart';
import '../../domain/entities/sa_tracking_entity.dart';
import '../../domain/repositories/i_performance_repository.dart';
import '../datasources/performance_remote_datasource.dart';

class PerformanceRepositoryImpl implements IPerformanceRepository {
  final IPerformanceRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PerformanceRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String?>> getJobFamily(String employeeId) async {
    return networkInfo.executeSafely(
      () => remoteDataSource.getJobFamily(employeeId),
    );
  }

  @override
  Future<Either<Failure, PmsCycleEntity?>> getActivePmsCycle() async {
    return networkInfo.executeSafely(() async {
      final model = await remoteDataSource.getActivePmsCycle();
      return model?.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<GoalEntity>>> getPmsGoals(
    String employeeId,
    String pmsCycleId,
  ) async {
    return networkInfo.executeSafely(() async {
      final models = await remoteDataSource.getPmsGoals(
        employeeId,
        pmsCycleId,
      );
      return models.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, GoalEntity>> getGoalDetails(String goalName) async {
    return networkInfo.executeSafely(() async {
      final model = await remoteDataSource.getGoalDetails(goalName);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, GoalEntity>> updateGoal(GoalEntity goal) async {
    return networkInfo.executeSafely(() async {
      final model = await remoteDataSource.updateGoal(goal);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<String>>> getKraList(String jobFamily) async {
    return networkInfo.executeSafely(
      () => remoteDataSource.getKraList(jobFamily),
    );
  }

  @override
  Future<Either<Failure, List<TeamEvaluationEntity>>>
  getTeamEvaluations() async {
    return networkInfo.executeSafely(() async {
      final models = await remoteDataSource.getTeamEvaluations();
      return models.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Map<String, String>>> getEmployeeInfo(
    String employeeId,
  ) async {
    return networkInfo.executeSafely(
      () => remoteDataSource.getEmployeeInfo(employeeId),
    );
  }

  @override
  Future<Either<Failure, SelfAssessmentEntity>> getSelfAssessmentDetails(
    String selfAssessmentId,
    String evaluationId,
  ) async {
    return networkInfo.executeSafely(() async {
      SelfAssessmentModel? evalModel;
      SelfAssessmentModel? saModel;
      List<FileAttachmentModel> attachments = [];

      final List<Future> futures = [];
      
      // Track which index belongs to which result
      int evalIndex = -1;
      int saIndex = -1;
      int attachIndex = -1;

      if (evaluationId.isNotEmpty) {
        evalIndex = futures.length;
        futures.add(remoteDataSource.getEvaluationDetails(evaluationId));
      }

      if (selfAssessmentId.isNotEmpty) {
        saIndex = futures.length;
        futures.add(remoteDataSource.getSelfAssessmentDetails(selfAssessmentId));
        
        attachIndex = futures.length;
        futures.add(remoteDataSource.getAttachments(selfAssessmentId));
      }

      if (futures.isEmpty) {
        throw Exception("Both evaluationId and selfAssessmentId are empty");
      }

      final results = await Future.wait(futures);

      if (evalIndex != -1) evalModel = results[evalIndex] as SelfAssessmentModel;
      if (saIndex != -1) saModel = results[saIndex] as SelfAssessmentModel;
      if (attachIndex != -1) {
        attachments = results[attachIndex] as List<FileAttachmentModel>;
      }

      // Determine the base model and merge if both exist
      SelfAssessmentModel finalModel;

      if (evalModel != null && saModel != null) {
        // Merge SA data into Evaluation data
        final mergedGoalReviews = evalModel.goalReviews.map((evalGoal) {
          final saGoal = saModel!.goalReviews.firstWhere(
            (g) =>
                g.goal.trim().toLowerCase() ==
                evalGoal.goal.trim().toLowerCase(),
            orElse: () => evalGoal,
          );
          return evalGoal.copyWith(
            kras: saGoal.kras.isNotEmpty ? saGoal.kras : evalGoal.kras,
            weightage:
                saGoal.weightage > 0 ? saGoal.weightage : evalGoal.weightage,
            selfRating: saGoal.selfRating,
            employeeComment: saGoal.selfComment,
            achieved: saGoal.progress,
          );
        }).toList();

        finalModel = evalModel.copyWith(
          goalReviews: mergedGoalReviews,
          attachments: attachments,
        );
      } else if (evalModel != null) {
        finalModel = evalModel.copyWith(attachments: attachments);
      } else if (saModel != null) {
        finalModel = saModel.copyWith(attachments: attachments);
      } else {
        throw Exception("Failed to fetch assessment data");
      }

      return finalModel.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> updateEvaluation(
    String evaluationId,
    Map<String, dynamic> data,
  ) async {
    return networkInfo.executeSafely(
      () => remoteDataSource.updateEvaluation(evaluationId, data),
    );
  }

  @override
  Future<Either<Failure, void>> updateSelfAssessment(
    String selfAssessmentId,
    Map<String, dynamic> data,
  ) async {
    return networkInfo.executeSafely(
      () => remoteDataSource.updateSelfAssessment(selfAssessmentId, data),
    );
  }

  @override
  Future<Either<Failure, bool>> checkManagerStatus(String employeeId) async {
    return networkInfo.executeSafely(
      () => remoteDataSource.checkManagerStatus(employeeId),
    );
  }

  @override
  Future<Either<Failure, String?>> getActiveSelfAssessmentId(String employeeId) async {
    return networkInfo.executeSafely(
      () => remoteDataSource.getActiveSelfAssessmentId(employeeId),
    );
  }

  @override
  Future<Either<Failure, SaTrackingEntity>> getSaTracking(String selfAssessmentId) async {
    return networkInfo.executeSafely(
      () => remoteDataSource.getSaTracking(selfAssessmentId).then((m) => m.toEntity()),
    );
  }

  @override
  Future<Either<Failure, void>> updateSaTracking(
    String selfAssessmentId,
    Map<String, dynamic> data,
  ) async {
    return networkInfo.executeSafely(
      () => remoteDataSource.updateSaTracking(selfAssessmentId, data),
    );
  }

  @override
  Future<Either<Failure, String>> uploadSaAttachment({
    required String filePath,
    required String fileName,
    required String selfAssessmentId,
  }) async {
    return networkInfo.executeSafely(
      () => remoteDataSource.uploadSaAttachment(
        filePath: filePath,
        fileName: fileName,
        selfAssessmentId: selfAssessmentId,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> deleteSaAttachment(String fileId) async {
    return networkInfo.executeSafely(
      () => remoteDataSource.deleteSaAttachment(fileId),
    );
  }
}
