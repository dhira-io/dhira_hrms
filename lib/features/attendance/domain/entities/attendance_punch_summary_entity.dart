class AttendancePunchSummaryEntity {
  final bool hasRecord;
  final String? firstIn;
  final String? lastOut;
  final double workingHours;
  final int totalLogs;

  const AttendancePunchSummaryEntity({
    required this.hasRecord,
    this.firstIn,
    this.lastOut,
    required this.workingHours,
    required this.totalLogs,
  });
}
