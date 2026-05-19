import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/error/failures.dart';

class PerformanceErrorUtils {
  const PerformanceErrorUtils._();

  static String pageErrorMessage(Failure failure) {
    if (failure.isServerSideError) {
      return AppConstants.serverErrorStateKey;
    }
    return failure.message;
  }

  static bool isServerErrorMessage(String? message) {
    return message == AppConstants.serverErrorStateKey;
  }
}
