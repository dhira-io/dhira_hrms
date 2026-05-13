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



  static ApprovalType fromIndex(int index) {
    switch (index) {
      case 0: return ApprovalType.leave;
      case 1: return ApprovalType.attendance;
      case 2: return ApprovalType.timesheet;
      case 3: return ApprovalType.compOff;
      default: return ApprovalType.leave;
    }
  }
}
