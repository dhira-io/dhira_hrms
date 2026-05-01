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
}

class PerformanceRemoteDataSourceImpl implements IPerformanceRemoteDataSource {
  final DioClient dioClient;

  PerformanceRemoteDataSourceImpl(this.dioClient);

  @override
  Future<String?> getJobFamily(String employeeId) async {
    final response = await dioClient.get(
      PerformanceApiConstants.getJobFamily,
      queryParameters: {
        'filters': '[["name","=","$employeeId"]]',
        'fields': '["custom_job_family"]',
      },
    );
    final List data = response.data['data'] ?? [];
    if (data.isNotEmpty) {
      return data[0]['custom_job_family'] as String?;
    }
    return null;
  }

  @override
  Future<PmsCycleModel?> getActivePmsCycle() async {
    final response = await dioClient.get(
      PerformanceApiConstants.getPmsCycle,
      queryParameters: {
        'filters': '[["status","=","Active"]]',
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
  Future<List<GoalModel>> getPmsGoals(String employeeId, String pmsCycleId) async {
    final response = await dioClient.get(
      PerformanceApiConstants.getPmsGoals,
      queryParameters: {
        'filters': '[["employee","=","$employeeId"],["pms_cycle","=","$pmsCycleId"]]',
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
        'fields': '["name","employee","department","cycle","docstatus","creation","modified","overall_rating","goal_score","self_assesment","manager"]',
      },
    );
    final List data = response.data['data'] ?? [];
    return data.map((e) => TeamEvaluationModel.fromJson(e)).toList();
  }
}
