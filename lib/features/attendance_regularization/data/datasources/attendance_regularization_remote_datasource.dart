import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dhira_hrms/core/network/dio_client.dart';
import 'package:dhira_hrms/core/utils/secure_logger.dart';
import 'package:dhira_hrms/features/attendance/data/models/attendance_punch_summary_model.dart';
import '../constants/attendance_regularization_api_constants.dart';
import '../models/attendance_regularization_model.dart';

abstract class IAttendanceRegularizationRemoteDataSource {
  Future<void> submitRegularization(
    AttendanceRegularizationModel regularization,
  );
  Future<String> uploadFile({
    required String filePath,
    required String fileName,
  });
  Future<AttendancePunchSummaryModel> getAttendancePunchSummary({
    required String attendanceDate,
  });
}

class AttendanceRegularizationRemoteDataSourceImpl
    implements IAttendanceRegularizationRemoteDataSource {
  final DioClient dioClient;

  AttendanceRegularizationRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<void> submitRegularization(
    AttendanceRegularizationModel regularization,
  ) async {
    final payload = regularization.toJson();
    SecureLogger.i('Submitting regularization redesigned', payload);

    final formData = FormData.fromMap({
      'doc': jsonEncode(payload),
      'action': 'Save',
    });

    await dioClient.post(
      AttendanceRegularizationApiConstants.submitRegularization,
      data: formData,
    );
  }

  @override
  Future<String> uploadFile({
    required String filePath,
    required String fileName,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
      'doctype': 'Attendance Regularization Request',
      'docname':
          'new-attendance-regularization-request-${DateTime.now().millisecondsSinceEpoch}',
      'fieldname': 'supporting_document',
      'folder': 'Home',
      'is_private': 0,
    });

    final response = await dioClient.post(
      AttendanceRegularizationApiConstants.uploadFile,
      data: formData,
    );

    return response.data['message']['file_url'] as String;
  }

  @override
  Future<AttendancePunchSummaryModel> getAttendancePunchSummary({
    required String attendanceDate,
  }) async {
    final response = await dioClient.get(
      AttendanceRegularizationApiConstants.getAttendancePunchSummary,
      queryParameters: {'attendance_date': attendanceDate},
    );
    return AttendancePunchSummaryModel.fromJson(response.data['message'] ?? {});
  }
}
