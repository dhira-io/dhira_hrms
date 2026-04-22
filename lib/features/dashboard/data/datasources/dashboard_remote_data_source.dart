import 'package:dhira_hrms/features/dashboard/data/models/dashboard_stats_model.dart';

import '../../../../core/network/dio_client.dart';
import '../constants/dashboard_api_constants.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardStatsModel> getDashboardStats(String employeeId);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final DioClient dioClient;

  DashboardRemoteDataSourceImpl(this.dioClient);

  @override
  Future<DashboardStatsModel> getDashboardStats(String employeeId) async {
    final response = await dioClient.get(
      DashboardApiConstants.getDashboardStats,
      queryParameters: {'employee': employeeId},
    );

    if (response.data['message']['success'] == true) {
      return DashboardStatsModel.fromJson(response.data['message']['data']);
    } else {
      throw Exception('Failed to fetch dashboard stats');
    }
  }
}
