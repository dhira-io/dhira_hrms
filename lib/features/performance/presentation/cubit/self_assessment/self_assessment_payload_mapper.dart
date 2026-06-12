import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';

class SelfAssessmentPayloadMapper {
  const SelfAssessmentPayloadMapper._();

  static Map<String, dynamic> updatePayload({
    required SelfAssessmentEntity details,
    required bool isSubmit,
    bool isEvaluation = false,
  }) {
    final docStatus = isSubmit
        ? AppConstants.docStatusSubmitted
        : AppConstants.docStatusDraft;

    final docType = isEvaluation
        ? PerformanceApiKeys.pmsEvaluation
        : PerformanceApiKeys.pmsSelfAssessment;

    final goalReviewsKey = isEvaluation
        ? PerformanceApiKeys.goalRatings
        : PerformanceApiKeys.goalReview;

    final competencyReviewsKey = isEvaluation
        ? 'competency_ratings'
        : PerformanceApiKeys.competencyReview;

    final Map<String, dynamic> payloadData;

    if (isEvaluation) {
      payloadData = <String, dynamic>{
        PerformanceApiKeys.docStatus: docStatus,
        goalReviewsKey: _goalReviews(details, docStatus, isEvaluation),
      };
    } else {
      payloadData = <String, dynamic>{
        PerformanceApiKeys.name: details.name,
        PerformanceApiKeys.employee: details.employee,
        PerformanceApiKeys.employeeName: details.employeeName,
        PerformanceApiKeys.department: details.department,
        PerformanceApiKeys.cycle: details.cycle,
        PerformanceApiKeys.goal: details.goal,
        PerformanceApiKeys.submissionDate: details.submissionDate
            .toIso8601String()
            .split('T')
            .first,
        PerformanceApiKeys.docType: docType,
        PerformanceApiKeys.docStatus: docStatus,
        goalReviewsKey: _goalReviews(details, docStatus, isEvaluation),
        competencyReviewsKey: _competencyReviews(
          details,
          docStatus,
          isEvaluation,
        ),
        PerformanceApiKeys.timeline: _timeline(
          details,
          docStatus,
          isEvaluation,
        ),
        PerformanceApiKeys.achievements: details.achievements,
        PerformanceApiKeys.challenges: details.challenges,
        PerformanceApiKeys.developmentNeeds: details.developmentNeeds,
      };
    }

    return {'data': payloadData};
  }

  static List<Map<String, dynamic>> _goalReviews(
    SelfAssessmentEntity details,
    int docStatus,
    bool isEvaluation,
  ) {
    return details.goalReviews.asMap().entries.map((entry) {
      final index = entry.key;
      final goal = entry.value;

      final parentType = isEvaluation
          ? PerformanceApiKeys.pmsEvaluation
          : PerformanceApiKeys.pmsSelfAssessment;

      final parentField = isEvaluation
          ? PerformanceApiKeys.goalRatings
          : PerformanceApiKeys.goalReview;

      final docType = isEvaluation
          ? PerformanceApiKeys.goalRatingsDocType
          : PerformanceApiKeys.goalReviewDocType;

      final map = {
        PerformanceApiKeys.name: goal.name,
        PerformanceApiKeys.goal: goal.goal,
        PerformanceApiKeys.index: index + 1,
        PerformanceApiKeys.kras: goal.kras,
        PerformanceApiKeys.weightage: goal.weightage,
        PerformanceApiKeys.target: goal.target,
        PerformanceApiKeys.progress: goal.progress,
        PerformanceApiKeys.selfRating: _formattedRating(goal.selfRating),
        PerformanceApiKeys.parent: details.name,
        PerformanceApiKeys.parentField: parentField,
        PerformanceApiKeys.parentType: parentType,
        PerformanceApiKeys.docType: docType,
        PerformanceApiKeys.docStatus: docStatus,
      };

      if (isEvaluation) {
        map['achieved'] = goal.achieved;
        map['employee_comment'] = goal.employeeComment.isNotEmpty
            ? goal.employeeComment
            : goal.selfComment;
        map['manager_rating'] = _formattedRating(goal.managerRating);
        map['manager_comment'] = goal.managerComment;
        map['manager_percentage'] = goal.managerPercentage;
        map['weighted_score'] = goal.weightedScore;
      } else {
        map[PerformanceApiKeys.selfComment] = goal.selfComment;
      }

      return map;
    }).toList();
  }

  static List<Map<String, dynamic>> _competencyReviews(
    SelfAssessmentEntity details,
    int docStatus,
    bool isEvaluation,
  ) {
    return details.competencyReviews.asMap().entries.map((entry) {
      final index = entry.key;
      final competency = entry.value;

      final parentType = isEvaluation
          ? PerformanceApiKeys.pmsEvaluation
          : PerformanceApiKeys.pmsSelfAssessment;

      final parentField = isEvaluation
          ? 'competency_ratings'
          : PerformanceApiKeys.competencyReview;

      final docType = isEvaluation
          ? 'Competency Ratings'
          : PerformanceApiKeys.competencyReviewDocType;

      return {
        PerformanceApiKeys.name: competency.name,
        PerformanceApiKeys.index: index + 1,
        PerformanceApiKeys.competency: competency.competency,
        PerformanceApiKeys.parent: details.name,
        PerformanceApiKeys.parentField: parentField,
        PerformanceApiKeys.parentType: parentType,
        PerformanceApiKeys.docType: docType,
        PerformanceApiKeys.docStatus: docStatus,
      };
    }).toList();
  }

  static List<Map<String, dynamic>> _timeline(
    SelfAssessmentEntity details,
    int docStatus,
    bool isEvaluation,
  ) {
    return details.timeline.asMap().entries.map((entry) {
      final index = entry.key;
      final stage = entry.value;

      final parentType = isEvaluation
          ? PerformanceApiKeys.pmsEvaluation
          : PerformanceApiKeys.pmsSelfAssessment;

      return {
        PerformanceApiKeys.name: stage.name,
        PerformanceApiKeys.index: index + 1,
        PerformanceApiKeys.stageName: stage.stageName,
        PerformanceApiKeys.date: stage.date.toIso8601String().split('T').first,
        PerformanceApiKeys.status: stage.status,
        PerformanceApiKeys.parent: details.name,
        PerformanceApiKeys.parentField: PerformanceApiKeys.timeline,
        PerformanceApiKeys.parentType: parentType,
        PerformanceApiKeys.docType: PerformanceApiKeys.pmsCycleTimeline,
        PerformanceApiKeys.docStatus: docStatus,
      };
    }).toList();
  }

  static String _formattedRating(String rating) {
    switch (rating) {
      case AppConstants.rating1:
        return '1 - Needs Improvement';
      case AppConstants.rating2:
        return '2 - Below Expectations';
      case AppConstants.rating3:
        return '3 - Meets Expectations';
      case AppConstants.rating4:
        return '4 - Exceeds Expectations';
      default:
        return rating;
    }
  }
}
