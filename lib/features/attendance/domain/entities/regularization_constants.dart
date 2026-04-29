import '../../data/constants/attendance_api_constants.dart';

enum RegularizationRequestType {
  missedPunch,
  systemError,
  networkIssues,
  onFieldDuty;

  String get apiCode {
    switch (this) {
      case RegularizationRequestType.missedPunch:
        return RegularizationRequestTypeConstants.forgotToPunch;
      case RegularizationRequestType.systemError:
        return RegularizationRequestTypeConstants.systemError;
      case RegularizationRequestType.networkIssues:
        return RegularizationRequestTypeConstants.networkIssue;
      case RegularizationRequestType.onFieldDuty:
        return RegularizationRequestTypeConstants.onFieldDuty;
    }
  }

  String get apiReason {
    switch (this) {
      case RegularizationRequestType.missedPunch:
        return RegularizationReason.missedPunch;
      case RegularizationRequestType.systemError:
        return RegularizationReason.systemError;
      case RegularizationRequestType.networkIssues:
        return RegularizationReason.networkIssue;
      case RegularizationRequestType.onFieldDuty:
        return RegularizationReason.onFieldDuty;
    }
  }
}
