class LeaveListModel {
  final String name;
  final String employee;
  final String employeeName;
  final String leaveType;
  final String fromDate;
  final String toDate;
  final String status;
  final String? leaveapprover;
  final int docstatus;
  final String? leaveapproverName;
  final double? totalleavedays;

  LeaveListModel({
    required this.name,
    required this.employee,
    required this.employeeName,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.status,
    this.leaveapprover,
    required this.docstatus,
    this.leaveapproverName,
    this.totalleavedays,
  });

  factory LeaveListModel.fromJson(Map<String, dynamic> json) {
    return LeaveListModel(
      name: json['name'] as String,
      employee: json['employee'] as String,
      employeeName: json['employee_name'] as String,
      leaveType: json['leave_type'] as String,
      fromDate: json['from_date'] as String,
      toDate: json['to_date'] as String,
      status: json['status'] as String,
      leaveapprover: json['leave_approver'] as String?,
      docstatus: json['docstatus'],
      leaveapproverName: json['leave_approver_name'] as String?,
      totalleavedays: json['total_leave_days'],
    );
  }
}
