class LeaveRequestModel {
  String employeeName;
  String department;
  String approver;
  String leaveType;
  DateTime startDate;
  DateTime endDate;
  String reason;

  LeaveRequestModel({
    required this.employeeName,
    required this.department,
    required this.approver,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
  });
}
