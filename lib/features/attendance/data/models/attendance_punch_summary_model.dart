import '../../domain/entities/attendance_punch_summary_entity.dart';

class AttendancePunchSummaryModel {
  final bool hasRecord;
  final String? firstIn;
  final String? lastOut;
  final double workingHours;
  final int totalLogs;

  const AttendancePunchSummaryModel({
    required this.hasRecord,
    this.firstIn,
    this.lastOut,
    required this.workingHours,
    required this.totalLogs,
  });

  factory AttendancePunchSummaryModel.fromJson(Map<String, dynamic> json) {
    final workingHoursData = json['working_hours'];
    final workingHours = workingHoursData is List && workingHoursData.isNotEmpty
        ? (workingHoursData.first as num?)?.toDouble() ?? 0
        : 0.0;

    return AttendancePunchSummaryModel(
      hasRecord: json['has_record'] == true,
      firstIn: json['first_in'] as String?,
      lastOut: json['last_out'] as String?,
      workingHours: workingHours,
      totalLogs: (json['total_logs'] as num?)?.toInt() ?? 0,
    );
  }

  AttendancePunchSummaryEntity toEntity() {
    return AttendancePunchSummaryEntity(
      hasRecord: hasRecord,
      firstIn: firstIn,
      lastOut: lastOut,
      workingHours: workingHours,
      totalLogs: totalLogs,
    );
  }
}
