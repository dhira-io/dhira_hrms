import '../../domain/entities/timesheet_overview_entity.dart';

class TimesheetOverviewModel {
  final int filled;
  final int pendingApproval;
  final int correctionNeeded;
  final int upcomingToSubmit;
  final int approved;
  final int totalWeeks;
  final Map<String, dynamic> weekMeta;

  TimesheetOverviewModel({
    required this.filled,
    required this.pendingApproval,
    required this.correctionNeeded,
    required this.upcomingToSubmit,
    required this.approved,
    required this.totalWeeks,
    required this.weekMeta,
  });

  factory TimesheetOverviewModel.fromJson(Map<String, dynamic> json) {
    return TimesheetOverviewModel(
      filled: json['filled'] ?? 0,
      pendingApproval: json['pending_approval'] ?? 0,
      correctionNeeded: json['correction_needed'] ?? 0,
      upcomingToSubmit: json['upcoming_to_submit'] ?? 0,
      approved: json['approved'] ?? 0,
      totalWeeks: json['total_weeks'] ?? 0,
      weekMeta: json['week_meta'] ?? {},
    );
  }

  TimesheetOverviewEntity toEntity() {
    return TimesheetOverviewEntity(
      filled: filled,
      pendingApproval: pendingApproval,
      correctionNeeded: correctionNeeded,
      upcomingToSubmit: upcomingToSubmit,
      approved: approved,
      totalWeeks: totalWeeks,
      weekMeta: weekMeta,
    );
  }
}
