//Timesheet List api response
class TimesheetListModel {
  final String name;
  final String employee;
  final String employeeName;
  final double hoursTotal;
  final String fromDate;
  final String toDate;
  final int docStatus;
  final double expectedHoursTotal;
  final double remainingHours;
  final double totalSpentHours;
  final String approver;
  final String approverName;

  TimesheetListModel({
    required this.name,
    required this.employee,
    required this.employeeName,
    required this.hoursTotal,
    required this.fromDate,
    required this.toDate,
    required this.docStatus,
    required this.expectedHoursTotal,
    required this.remainingHours,
    required this.totalSpentHours,
    required this.approver,
    required this.approverName,
  });

  factory TimesheetListModel.fromJson(Map<String, dynamic> json) {
    return TimesheetListModel(
      name: json['name'] ?? '',
      employee: json['employee'] ?? '',
      employeeName: json['employee_name'] ?? '',
      hoursTotal: (json['hours_total'] ?? 0).toDouble(),
      fromDate: json['from_date'] ?? '',
      toDate: json['to_date'] ?? '',
      docStatus: json['docstatus'] ?? 0,
      expectedHoursTotal: (json['expected_hours_total'] ?? 0).toDouble(),
      remainingHours: (json['remaining_hours'] ?? 0).toDouble(),
      totalSpentHours: (json['total_spent_hours'] ?? 0).toDouble(),
      approver: json['approver'] ?? '',
      approverName: json['approver_name'] ?? '',

    );
  }
}
