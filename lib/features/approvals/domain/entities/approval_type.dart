enum ApprovalType {
  leave,
  attendance,
  timesheet,
  compOff;

  String get apiKey {
    switch (this) {
      case ApprovalType.leave:
        return 'leave';
      case ApprovalType.attendance:
        return 'attendance';
      case ApprovalType.timesheet:
        return 'timesheet';
      case ApprovalType.compOff:
        return 'comp_off';
    }
  }
}
