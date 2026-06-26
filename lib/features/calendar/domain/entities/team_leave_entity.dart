class TeamLeaveEntity {
  final String employeeName;
  final String leaveType;
  final String fromDate;
  final String toDate;
  final String employee;
  final String? designation;
  final String? image;

  const TeamLeaveEntity({
    required this.employeeName,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.employee,
    this.designation,
    this.image,
  });
}
