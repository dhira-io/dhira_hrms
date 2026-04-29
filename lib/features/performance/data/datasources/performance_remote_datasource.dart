import '../../../../core/network/dio_client.dart';
import '../constants/performance_api_constants.dart';
import '../models/performance_model.dart';

abstract class IPerformanceRemoteDataSource {
  Future<PerformanceModel> getPerformanceSummary(String employeeId);
}

class PerformanceRemoteDataSourceImpl implements IPerformanceRemoteDataSource {
  final DioClient dioClient;

  PerformanceRemoteDataSourceImpl(this.dioClient);

  @override
  Future<PerformanceModel> getPerformanceSummary(String employeeId) async {
    final response = await dioClient.get(
      PerformanceApiConstants.getPerformanceSummary,
      queryParameters: {'employee': employeeId},
    );
    return PerformanceModel.fromJson(response.data['message']);
  }
}
