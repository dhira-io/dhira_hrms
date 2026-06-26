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
    final workingHoursData = json['working_hours'] ?? json['total_working_hours'] ?? json['hours'];
    double workingHours = 0.0;
    if (workingHoursData != null) {
      if (workingHoursData is num) {
        workingHours = workingHoursData.toDouble();
      } else if (workingHoursData is String) {
        if (workingHoursData.contains(':')) {
          final parts = workingHoursData.split(':');
          if (parts.length >= 2) {
            final h = double.tryParse(parts[0]) ?? 0.0;
            final m = double.tryParse(parts[1]) ?? 0.0;
            workingHours = h + (m / 60.0);
          }
        } else {
          workingHours = double.tryParse(workingHoursData) ?? 0.0;
        }
      } else if (workingHoursData is List && workingHoursData.isNotEmpty) {
        final first = workingHoursData.first;
        if (first is num) {
          workingHours = first.toDouble();
        } else if (first is String) {
          if (first.contains(':')) {
            final parts = first.split(':');
            if (parts.length >= 2) {
              final h = double.tryParse(parts[0]) ?? 0.0;
              final m = double.tryParse(parts[1]) ?? 0.0;
              workingHours = h + (m / 60.0);
            }
          } else {
            workingHours = double.tryParse(first) ?? 0.0;
          }
        }
      }
    }

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
