import '../../domain/entities/leave_history_entity.dart';

class LeaveHistoryModel {
  final String name;
  final String employee;
  final String employeeName;
  final String leaveType;
  final String fromDate;
  final String toDate;
  final String status;
  final String? leaveApprover;
  final int docstatus;
  final String? leaveApproverName;
  final double totalLeaveDays;

  const LeaveHistoryModel({
    required this.name,
    required this.employee,
    required this.employeeName,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.status,
    this.leaveApprover,
    required this.docstatus,
    this.leaveApproverName,
    required this.totalLeaveDays,
  });

  factory LeaveHistoryModel.fromJson(Map<String, dynamic> json) {
    return LeaveHistoryModel(
      name: json['name'] as String? ?? '',
      employee: json['employee'] as String? ?? '',
      employeeName: json['employee_name'] as String? ?? '',
      leaveType: json['leave_type'] as String? ?? '',
      fromDate: json['from_date'] as String? ?? '',
      toDate: json['to_date'] as String? ?? '',
      status: json['status'] as String? ?? '',
      leaveApprover: json['leave_approver'] as String?,
      docstatus: (json['docstatus'] as num?)?.toInt() ?? 0,
      leaveApproverName: json['leave_approver_name'] as String?,
      totalLeaveDays: (json['total_leave_days'] as num?)?.toDouble() ?? 0.0,
    );
  }

  LeaveHistoryEntity toEntity() {
    return LeaveHistoryEntity(
      name: name,
      employee: employee,
      employeeName: employeeName,
      leaveType: leaveType,
      fromDate: fromDate,
      toDate: toDate,
      status: status,
      leaveApprover: leaveApprover,
      docstatus: docstatus,
      leaveApproverName: leaveApproverName,
      totalLeaveDays: totalLeaveDays,
    );
  }
}
