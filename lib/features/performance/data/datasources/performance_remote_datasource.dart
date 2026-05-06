import 'package:dhira_hrms/features/performance/data/models/self_assessment_model.dart';

import '../../../../core/network/dio_client.dart';
import '../constants/performance_api_constants.dart';
import '../models/pms_cycle_model.dart';
import '../models/goal_model.dart';
import '../models/team_evaluation_model.dart';
import '../../domain/entities/goal_entity.dart';

abstract class IPerformanceRemoteDataSource {
  Future<String?> getJobFamily(String employeeId);
  Future<PmsCycleModel?> getActivePmsCycle();
  Future<List<GoalModel>> getPmsGoals(String employeeId, String pmsCycleId);
  Future<GoalModel> getGoalDetails(String goalName);
  Future<GoalModel> updateGoal(GoalEntity goal);
  Future<List<String>> getKraList(String jobFamily);
  Future<List<TeamEvaluationModel>> getTeamEvaluations();
  Future<Map<String, String>> getEmployeeInfo(String employeeId);
  Future<SelfAssessmentModel> getSelfAssessmentDetails(String selfAssessmentId);
  Future<SelfAssessmentModel> getEvaluationDetails(String evaluationId);
  Future<List<FileAttachmentModel>> getAttachments(String selfAssessmentId);
  Future<void> updateEvaluation(String evaluationId, Map<String, dynamic> data);
  Future<bool> checkManagerStatus(String employeeId);
}

class PerformanceRemoteDataSourceImpl implements IPerformanceRemoteDataSource {
  final DioClient dioClient;

  PerformanceRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<String?> getJobFamily(String employeeId) async {
    final response = await dioClient.get(
      PerformanceApiConstants.getJobFamily,
      queryParameters: {
        'filters': '[["name","=","$employeeId"]]',
        'fields': '["${PerformanceApiConstants.fieldJobFamily}"]',
      },
    );
    final List data = response.data['data'] ?? [];
    if (data.isNotEmpty) {
      return data[0][PerformanceApiConstants.fieldJobFamily] as String?;
    }
    return null;
  }

  @override
  Future<PmsCycleModel?> getActivePmsCycle() async {
    final response = await dioClient.get(
      PerformanceApiConstants.getPmsCycle,
      queryParameters: {
        'filters': '[["status","=","${PerformanceApiConstants.statusActive}"]]',
        'fields': '["name","cycle_name"]',
      },
    );
    final List data = response.data['data'] ?? [];
    if (data.isNotEmpty) {
      return PmsCycleModel.fromJson(data[0]);
    }
    return null;
  }

  @override
  Future<List<GoalModel>> getPmsGoals(
    String employeeId,
    String pmsCycleId,
  ) async {
    final response = await dioClient.get(
      PerformanceApiConstants.getPmsGoals,
      queryParameters: {
        'filters':
            '[["employee","=","$employeeId"],["pms_cycle","=","$pmsCycleId"]]',
        'fields': '["name"]',
      },
    );
    final List data = response.data['data'] ?? [];
    return data.map((e) => GoalModel.fromJson(e)).toList();
  }

  @override
  Future<GoalModel> getGoalDetails(String goalName) async {
    final response = await dioClient.get(
      "${PerformanceApiConstants.getPmsGoals}/$goalName",
    );
    return GoalModel.fromJson(response.data['data']);
  }

  @override
  Future<GoalModel> updateGoal(GoalEntity goal) async {
    final model = GoalModel.fromEntity(goal);
    final response = await dioClient.put(
      "${PerformanceApiConstants.getPmsGoals}/${goal.name}",
      data: {'data': model.toJson()},
    );
    return GoalModel.fromJson(response.data['data']);
  }

  @override
  Future<List<String>> getKraList(String jobFamily) async {
    final response = await dioClient.get(
      PerformanceApiConstants.getKras,
      queryParameters: {
        'filters': '[["job_family","=","$jobFamily"]]',
        'fields': '["name"]',
      },
    );
    final List data = response.data['data'] ?? [];
    return data.map((e) => e['name'] as String).toList();
  }

  @override
  Future<List<TeamEvaluationModel>> getTeamEvaluations() async {
    final response = await dioClient.get(
      PerformanceApiConstants.getTeamEvaluations,
      queryParameters: {
        'fields':
            '["name","employee","department","cycle","docstatus","creation","modified","overall_rating","goal_score","self_assesment","manager"]',
      },
    );
    final List data = response.data['data'] ?? [];
    return data.map((e) => TeamEvaluationModel.fromJson(e)).toList();
  }

  @override
  Future<Map<String, String>> getEmployeeInfo(String employeeId) async {
    final response = await dioClient.get(
      "${PerformanceApiConstants.getJobFamily}/$employeeId",
    );
    final data = response.data['data'];
    return {
      'name': data[PerformanceApiConstants.fieldEmployeeName] as String,
      'status': data[PerformanceApiConstants.fieldStatus] as String,
    };
  }

  @override
  Future<SelfAssessmentModel> getSelfAssessmentDetails(
    String selfAssessmentId,
  ) async {
    final response = await dioClient.get(
      "${PerformanceApiConstants.getSelfAssessment}/$selfAssessmentId",
    );
    return SelfAssessmentModel.fromJson(response.data['data']);
  }

  @override
  Future<SelfAssessmentModel> getEvaluationDetails(
    String evaluationId,
  ) async {
    final response = await dioClient.get(
      "${PerformanceApiConstants.getTeamEvaluations}/$evaluationId",
    );
    return SelfAssessmentModel.fromJson(response.data['data']);
  }

  @override
  Future<List<FileAttachmentModel>> getAttachments(
    String selfAssessmentId,
  ) async {
    final response = await dioClient.get(
      PerformanceApiConstants.getFiles,
      queryParameters: {
        'filters':
            '[["attached_to_doctype","=","${PerformanceApiConstants.doctypeSelfAssessment}"],["attached_to_name","=","$selfAssessmentId"]]',
        'fields': '["name","file_name","file_url"]',
      },
    );
    final List data = response.data['data'] ?? [];
    return data.map((e) => FileAttachmentModel.fromJson(e)).toList();
  }

  @override
  Future<void> updateEvaluation(
    String evaluationId,
    Map<String, dynamic> data,
  ) async {
    await dioClient.put(
      "${PerformanceApiConstants.getTeamEvaluations}/$evaluationId",
      data: data,
    );
  }

  @override
  Future<bool> checkManagerStatus(String employeeId) async {
    final response = await dioClient.get(
      PerformanceApiConstants.getTeamEvaluations,
      queryParameters: {
        'filters': '[["manager","=","$employeeId"]]',
        'limit': 1,
      },
    );
    final List data = response.data['data'] ?? [];
    return data.isNotEmpty;
  }
}



