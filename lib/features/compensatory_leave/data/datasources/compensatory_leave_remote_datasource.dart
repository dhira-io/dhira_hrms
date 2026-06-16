import 'package:dhira_hrms/core/network/dio_client.dart';
import 'package:dhira_hrms/features/compensatory_leave/data/constants/compensatory_leave_api_constants.dart';
import 'package:dhira_hrms/features/compensatory_leave/data/models/compensatory_leave_summary_model.dart';
import 'package:dhira_hrms/features/compensatory_leave/data/models/compensatory_leave_eligible_date_model.dart';
import 'package:dhira_hrms/features/compensatory_leave/data/models/compensatory_leave_request_model.dart';

abstract class ICompensatoryLeaveRemoteDataSource {
  Future<CompensatoryLeaveSummaryModel> getCompensatoryLeaveSummary(
    String employeeId,
  );
  Future<List<CompensatoryLeaveEligibleDateModel>> getEligibleDates(
    String employeeId,
    String fromDate,
    String toDate,
  );
  Future<bool> submitCompensatoryLeaveRequest(
    CompensatoryLeaveRequestModel request,
  );
}

class CompensatoryLeaveRemoteDataSourceImpl
    implements ICompensatoryLeaveRemoteDataSource {
  final DioClient dioClient;

  CompensatoryLeaveRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<CompensatoryLeaveSummaryModel> getCompensatoryLeaveSummary(
    String employeeId,
  ) async {
    final response = await dioClient.get(
      CompensatoryLeaveApiConstants.getSummary,
      queryParameters: {'employee': employeeId},
    );
    final data = response.data;
    final message = data is Map<String, dynamic> ? data['message'] : null;
    final result = (message is Map<String, dynamic> && message['data'] != null)
        ? (message['data'] as Map<String, dynamic>)
        : <String, dynamic>{};
    return CompensatoryLeaveSummaryModel.fromJson(result);
  }

  @override
  Future<List<CompensatoryLeaveEligibleDateModel>> getEligibleDates(
    String employeeId,
    String fromDate,
    String toDate,
  ) async {
    final response = await dioClient.post(
      CompensatoryLeaveApiConstants.getEligibleDates,
      data: {'employee': employeeId, 'from_date': fromDate, 'to_date': toDate},
    );
    final message = response.data['message'];
    final List data =
        (message is Map<String, dynamic> && message['eligible_dates'] is List)
        ? message['eligible_dates']
        : [];
    return data
        .map(
          (e) => CompensatoryLeaveEligibleDateModel.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  @override
  Future<bool> submitCompensatoryLeaveRequest(
    CompensatoryLeaveRequestModel request,
  ) async {
    final response = await dioClient.post(
      CompensatoryLeaveApiConstants.submitRequest,
      data: request.toJson(),
    );
    final message = response.data['message'];
    if (message != null &&
        (message['success'] == true || message['name'] != null)) {
      return true;
    }
    return response.data != null;
  }
}
