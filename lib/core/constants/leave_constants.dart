class LeaveStatusConstants {
  static const String approved = 'Approved';
  static const String rejected = 'Rejected';
  static const String cancelled = 'Cancelled';
  static const String cancelledAlt = 'canceled';
  static const String open = 'Open';
  static const String pending = 'Pending';
}

class LeaveDocStatus {
  static const int draft = 0;
  static const int submitted = 1;
  static const int cancelled = 2;
}

class LeaveTypes {
  static const String sickLeave = 'Sick Leave';
  static const String casualLeave = 'Casual Leave';
  static const String maternityLeave = 'Maternity Leave';
  static const String paternityLeave = 'Paternity Leave';
  static const String bereavementLeave = 'Bereavement Leave';
  static const String compOff = 'Compensatory Off';
}

class LeaveErrorConstants {
  static const String submissionFailed = 'submissionFailed';
  static const String updateFailed = 'updateFailed';
  static const String uploadFailed = 'failedToUploadFile';
  static const String fetchStatisticsFailed = 'somethingWentWrong';
}
