import 'package:dhira_hrms/core/constants/app_constants.dart';

class SelfAssessmentRatingPolicy {
  const SelfAssessmentRatingPolicy._();

  static double parseRating(String rating) {
    if (rating.isEmpty) return 0;
    final match = RegExp(r'\d+').firstMatch(rating);
    if (match == null) return 0;
    return double.tryParse(match.group(0)!) ?? 0;
  }

  static List<double> progressValues(int rating) {
    switch (rating) {
      case 1:
        return [0, 18, 35, 53, 70];
      case 2:
        return [71, 73, 76, 78, 80];
      case 3:
        return [81, 85, 88, 92, 95];
      case 4:
        return [96, 98, 101, 103, 105];
      default:
        return PerformanceRatingRanges.defaultSteps;
    }
  }
}
