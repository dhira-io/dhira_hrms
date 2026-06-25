import 'package:dhira_hrms/core/network/dio_client.dart';
import 'package:dhira_hrms/features/calendar/data/constants/calendar_api_constants.dart';
import 'package:dhira_hrms/features/calendar/data/models/calendar_model.dart';

abstract class ICalendarRemoteDataSource {
  Future<Map<String, String>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  });

  Future<CalendarSummaryModel> getCalendarSummary({
    required String employee,
    required int month,
    required int year,
  });
}

class CalendarRemoteDataSourceImpl implements ICalendarRemoteDataSource {
  final DioClient dioClient;

  CalendarRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Map<String, String>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {
    final response = await dioClient.post(
      CalendarApiConstants.getCalendarEvents,
      data: {
        "employee": employee,
        "from_date": fromDate,
        "to_date": toDate,
      },
    );
    
    final Map<String, dynamic> data = response.data['message'] ?? {};
    final Map<String, String> events = {};
    data.forEach((key, value) {
      events[key] = value.toString();
    });
    
    return events;
  }

  @override
  Future<CalendarSummaryModel> getCalendarSummary({
    required String employee,
    required int month,
    required int year,
  }) async {
    final response = await dioClient.post(
      CalendarApiConstants.getAttendanceMonthSummary,
      data: {
        "employee": employee,
        "month": month,
        "year": year,
      },
    );
    
    final Map<String, dynamic> messageData = response.data['message'] ?? {};
    return CalendarSummaryModel.fromJson(messageData);
  }
}
