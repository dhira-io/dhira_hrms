import '../../data/constants/attendance_regularization_api_constants.dart';

enum AttendanceRegularizationRequestType {
  missedPunch,
  systemError,
  networkIssues,
  onFieldDuty;

  String get apiCode {
    switch (this) {
      case AttendanceRegularizationRequestType.missedPunch:
        return AttendanceRegularizationRequestTypeConstants.forgotToPunch;
      case AttendanceRegularizationRequestType.systemError:
        return AttendanceRegularizationRequestTypeConstants.systemError;
      case AttendanceRegularizationRequestType.networkIssues:
        return AttendanceRegularizationRequestTypeConstants.networkIssue;
      case AttendanceRegularizationRequestType.onFieldDuty:
        return AttendanceRegularizationRequestTypeConstants.onFieldDuty;
    }
  }

  String get apiReason {
    switch (this) {
      case AttendanceRegularizationRequestType.missedPunch:
        return AttendanceRegularizationReason.missedPunch;
      case AttendanceRegularizationRequestType.systemError:
        return AttendanceRegularizationReason.systemError;
      case AttendanceRegularizationRequestType.networkIssues:
        return AttendanceRegularizationReason.networkIssue;
      case AttendanceRegularizationRequestType.onFieldDuty:
        return AttendanceRegularizationReason.onFieldDuty;
    }
  }
}
