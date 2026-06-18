import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/performance/presentation/cubit/self_assessment/self_assessment_rating_policy.dart';

class SelfAssessmentViewHelpers {
  const SelfAssessmentViewHelpers._();

  static double parseRating(String rating) {
    return SelfAssessmentRatingPolicy.parseRating(rating);
  }

  static List<double> progressValues(int rating) {
    return SelfAssessmentRatingPolicy.progressValues(rating);
  }

  static String formatSessionDate(String sessionStart) {
    final startDt = DateTime.tryParse(sessionStart);
    if (startDt == null) return sessionStart;

    return DateTimeUtils.formatDate(
      startDt,
      pattern: AppConstants.dateFormatDayMonthYear,
    );
  }

  static String formatSessionTime(String sessionStart, String sessionEnd) {
    final startDt = DateTime.tryParse(sessionStart);
    if (startDt == null) return AppConstants.emptyString;

    final startTime = DateTimeUtils.formatDate(
      startDt,
      pattern: AppConstants.timeFormat12hrPadded,
    ).toLowerCase();

    if (sessionEnd.isEmpty) {
      return '$startTime - ${AppConstants.placeholderText}';
    }

    final endDt = DateTime.tryParse(sessionEnd);
    if (endDt == null) return '$startTime - ${AppConstants.placeholderText}';

    final endTime = DateTimeUtils.formatDate(
      endDt,
      pattern: AppConstants.timeFormat12hrPadded,
    ).toLowerCase();

    if (DateTimeUtils.isSameDay(startDt, endDt)) {
      return '$startTime - $endTime';
    }

    final endDate = DateTimeUtils.formatDate(
      endDt,
      pattern: AppConstants.dateFormatDayMonthYear,
    );
    return '$startTime - $endDate, $endTime';
  }

  static String formatQuestionTime(String lastModified) {
    final dt = DateTime.tryParse(lastModified);
    if (dt == null) return lastModified;

    return DateTimeUtils.formatDate(
      dt,
      pattern: AppConstants.timeFormat12hrPadded,
    ).toLowerCase();
  }

  static String ratingOutOfFour(String rating) {
    if (rating.isEmpty) return '0';
    return rating.split(' ').first;
  }
}
