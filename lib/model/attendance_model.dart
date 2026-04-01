// models/attendance_models.dart

class CalendarEvent {
  final DateTime date;
  final String status;

  CalendarEvent({
    required this.date,
    required this.status,
  });
}

class LogEntry {
  final String date;
  final String dayName;
  final String monthAbbr;
  final String dayNumber;
  final String status;
  final String? inTime;
  final String? outTime;
  final double? workingHours;
  final String label;

  LogEntry({
    required this.date,
    required this.dayName,
    required this.monthAbbr,
    required this.dayNumber,
    required this.status,
    this.inTime,
    this.outTime,
    this.workingHours,
    required this.label,
  });

  factory LogEntry.fromJson(Map<String, dynamic> json) {
    return LogEntry(
      date: json['date'] ?? '',
      dayName: json['day_name'] ?? '',
      monthAbbr: json['month_abbr'] ?? '',
      dayNumber: json['day_number'] ?? '',
      status: json['status'] ?? '',
      inTime: json['in_time']?.toString(),
      outTime: json['out_time']?.toString(),
      workingHours: (json['working_hours'] is num)
          ? (json['working_hours'] as num).toDouble()
          : null,
      label: json['label'] ?? '',
    );
  }
}
