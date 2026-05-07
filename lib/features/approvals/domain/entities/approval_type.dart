enum ApprovalType {
  leave,
  attendance,
  timesheet,
  compOff;

  String get doctype {
    switch (this) {
      case ApprovalType.leave:
        return 'Leave Application';
      case ApprovalType.attendance:
        return 'Attendance Regularization Request';
      case ApprovalType.timesheet:
        return 'Employee Timesheet';
      case ApprovalType.compOff:
        return 'Compensatory Leave Request';
    }
  }
}
