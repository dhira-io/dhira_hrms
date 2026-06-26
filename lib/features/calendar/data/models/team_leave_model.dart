import '../../domain/entities/team_leave_entity.dart';

class TeamLeaveModel {
  final Map<String, dynamic> employee;
  final String leaveType;
  final String fromDate;
  final String toDate;

  const TeamLeaveModel({
    required this.employee,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
  });

  factory TeamLeaveModel.fromJson(Map<String, dynamic> json) {
    return TeamLeaveModel(
      employee: json['employee'] as Map<String, dynamic>? ?? {},
      leaveType: json['leave_type'] as String? ?? '',
      fromDate: json['from_date'] as String? ?? '',
      toDate: json['to_date'] as String? ?? '',
    );
  }

  TeamLeaveEntity toEntity() {
    return TeamLeaveEntity(
      employeeName: employee['name'] ?? '',
      leaveType: leaveType,
      fromDate: fromDate,
      toDate: toDate,
      employee: employee['id'] ?? '',
      designation: employee['designation'],
      image: employee['image'],
    );
  }
}
