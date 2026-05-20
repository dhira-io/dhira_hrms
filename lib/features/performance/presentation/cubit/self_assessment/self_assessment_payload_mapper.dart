import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/features/performance/domain/entities/self_assessment_entity.dart';

class SelfAssessmentPayloadMapper {
  const SelfAssessmentPayloadMapper._();

  static Map<String, dynamic> updatePayload({
    required SelfAssessmentEntity details,
    required bool isSubmit,
  }) {
    final docStatus = isSubmit
        ? AppConstants.docStatusSubmitted
        : AppConstants.docStatusDraft;

    return {
      'data': {
        PerformanceApiKeys.name: details.name,
        PerformanceApiKeys.employee: details.employee,
        PerformanceApiKeys.employeeName: details.employeeName,
        PerformanceApiKeys.department: details.department,
        PerformanceApiKeys.cycle: details.cycle,
        PerformanceApiKeys.goal: details.goal,
        PerformanceApiKeys.submissionDate:
            details.submissionDate.toIso8601String().split('T').first,
        PerformanceApiKeys.docType: PerformanceApiKeys.pmsSelfAssessment,
        PerformanceApiKeys.docStatus: docStatus,
        PerformanceApiKeys.goalReview: _goalReviews(details, docStatus),
        PerformanceApiKeys.competencyReview:
            _competencyReviews(details, docStatus),
        PerformanceApiKeys.timeline: _timeline(details, docStatus),
        PerformanceApiKeys.achievements: details.achievements,
        PerformanceApiKeys.challenges: details.challenges,
        PerformanceApiKeys.developmentNeeds: details.developmentNeeds,
      },
    };
  }

  static List<Map<String, dynamic>> _goalReviews(
    SelfAssessmentEntity details,
    int docStatus,
  ) {
    return details.goalReviews.asMap().entries.map((entry) {
      final index = entry.key;
      final goal = entry.value;

      return {
        PerformanceApiKeys.name: goal.name,
        PerformanceApiKeys.goal: goal.goal,
        PerformanceApiKeys.index: index + 1,
        PerformanceApiKeys.kras: goal.kras,
        PerformanceApiKeys.weightage: goal.weightage,
        PerformanceApiKeys.target: goal.target,
        PerformanceApiKeys.progress: goal.progress,
        PerformanceApiKeys.selfRating: _formattedRating(goal.selfRating),
        PerformanceApiKeys.selfComment: goal.selfComment,
        PerformanceApiKeys.parent: details.name,
        PerformanceApiKeys.parentField: PerformanceApiKeys.goalReview,
        PerformanceApiKeys.parentType: PerformanceApiKeys.pmsSelfAssessment,
        PerformanceApiKeys.docType: PerformanceApiKeys.goalReviewDocType,
        PerformanceApiKeys.docStatus: docStatus,
      };
    }).toList();
  }

  static List<Map<String, dynamic>> _competencyReviews(
    SelfAssessmentEntity details,
    int docStatus,
  ) {
    return details.competencyReviews.asMap().entries.map((entry) {
      final index = entry.key;
      final competency = entry.value;

      return {
        PerformanceApiKeys.name: competency.name,
        PerformanceApiKeys.index: index + 1,
        PerformanceApiKeys.competency: competency.competency,
        PerformanceApiKeys.parent: details.name,
        PerformanceApiKeys.parentField: PerformanceApiKeys.competencyReview,
        PerformanceApiKeys.parentType: PerformanceApiKeys.pmsSelfAssessment,
        PerformanceApiKeys.docType: PerformanceApiKeys.competencyReviewDocType,
        PerformanceApiKeys.docStatus: docStatus,
      };
    }).toList();
  }

  static List<Map<String, dynamic>> _timeline(
    SelfAssessmentEntity details,
    int docStatus,
  ) {
    return details.timeline.asMap().entries.map((entry) {
      final index = entry.key;
      final stage = entry.value;

      return {
        PerformanceApiKeys.name: stage.name,
        PerformanceApiKeys.index: index + 1,
        PerformanceApiKeys.stageName: stage.stageName,
        PerformanceApiKeys.date: stage.date.toIso8601String().split('T').first,
        PerformanceApiKeys.status: stage.status,
        PerformanceApiKeys.parent: details.name,
        PerformanceApiKeys.parentField: PerformanceApiKeys.timeline,
        PerformanceApiKeys.parentType: PerformanceApiKeys.pmsSelfAssessment,
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
