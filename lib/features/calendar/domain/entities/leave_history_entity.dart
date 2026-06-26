class LeaveHistoryEntity {
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

  const LeaveHistoryEntity({
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
}
