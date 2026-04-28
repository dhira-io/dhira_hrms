import '../../domain/entities/attendance_regularization_entity.dart';

class AttendanceRegularizationModel extends AttendanceRegularizationEntity {
  const AttendanceRegularizationModel({
    required super.date,
    required super.requestType,
    required super.requestedInTime,
    required super.requestedOutTime,
    required super.routeToHR,
    required super.reason,
    super.supportingDocuments,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'docstatus': 0,
      'doctype': 'Attendance Regularization Request',
      'attendance_date': date.toIso8601String().split('T')[0],
      'manual_in_time': requestedInTime,
      'manual_out_time': requestedOutTime,
      'reason_category': requestType,
      'employee_remarks': reason,
      'routed_to_hr': routeToHR ? 1 : 0,
    };

    if (supportingDocuments != null && supportingDocuments!.isNotEmpty) {
      map['supporting_document'] = supportingDocuments!.first;
    }

    return map;
  }

  factory AttendanceRegularizationModel.fromEntity(
      AttendanceRegularizationEntity entity) {
    return AttendanceRegularizationModel(
      date: entity.date,
      requestType: entity.requestType,
      requestedInTime: entity.requestedInTime,
      requestedOutTime: entity.requestedOutTime,
      routeToHR: entity.routeToHR,
      reason: entity.reason,
      supportingDocuments: entity.supportingDocuments,
    );
  }
}
