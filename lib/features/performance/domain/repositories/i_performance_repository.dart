import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';
import '../../../../core/error/failures.dart';
import '../entities/pms_cycle_entity.dart';
import '../entities/goal_entity.dart';
import '../entities/team_evaluation_entity.dart';
import '../entities/sa_tracking_entity.dart';

abstract class IPerformanceRepository {
  Future<Either<Failure, String?>> getJobFamily(String employeeId);
  Future<Either<Failure, PmsCycleEntity?>> getActivePmsCycle();
  Future<Either<Failure, List<GoalEntity>>> getPmsGoals(
    String employeeId,
    String pmsCycleId,
  );
  Future<Either<Failure, GoalEntity>> getGoalDetails(String goalName);
  Future<Either<Failure, GoalEntity>> updateGoal(GoalEntity goal);
  Future<Either<Failure, List<String>>> getKraList(String jobFamily);
  Future<Either<Failure, List<TeamEvaluationEntity>>> getTeamEvaluations();
  Future<Either<Failure, Map<String, String>>> getEmployeeInfo(
    String employeeId,
  );
  Future<Either<Failure, SelfAssessmentEntity>> getSelfAssessmentDetails(
    String selfAssessmentId,
    String evaluationId,
  );
  Future<Either<Failure, void>> updateEvaluation(
    String evaluationId,
    Map<String, dynamic> data,
  );
  Future<Either<Failure, void>> updateSelfAssessment(
    String selfAssessmentId,
    Map<String, dynamic> data,
  );
  Future<Either<Failure, bool>> checkManagerStatus(String employeeId);
  Future<Either<Failure, String?>> getActiveSelfAssessmentId(String employeeId);
  Future<Either<Failure, SaTrackingEntity>> getSaTracking(String selfAssessmentId);
  Future<Either<Failure, void>> updateSaTracking(
    String selfAssessmentId,
    Map<String, dynamic> data,
  );
  Future<Either<Failure, String>> uploadSaAttachment({
    required String filePath,
    required String fileName,
    required String selfAssessmentId,
  });
  Future<Either<Failure, void>> deleteSaAttachment(String fileId);
}

