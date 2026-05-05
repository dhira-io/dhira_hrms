import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/self_assessment_entity.dart';
import '../../../domain/usecases/get_self_assessment_details_usecase.dart';
import '../../../domain/usecases/update_evaluation_usecase.dart';

part 'self_assessment_state.dart';
part 'self_assessment_cubit.freezed.dart';

class SelfAssessmentCubit extends Cubit<SelfAssessmentState> {
  final GetSelfAssessmentDetailsUseCase getSelfAssessmentDetailsUseCase;
  final UpdateEvaluationUseCase updateEvaluationUseCase;

  SelfAssessmentCubit(
    this.getSelfAssessmentDetailsUseCase,
    this.updateEvaluationUseCase,
  ) : super(const SelfAssessmentState.initial());

  Future<void> fetchSelfAssessment(
    String selfAssessmentId,
    String evaluationId,
  ) async {
    emit(const SelfAssessmentState.loading());
    final result = await getSelfAssessmentDetailsUseCase(
      selfAssessmentId,
      evaluationId,
    );
    
    result.fold(
      (failure) => emit(SelfAssessmentState.failure(failure.message)),
      (details) => emit(SelfAssessmentState.success(details)),
    );
  }

  Future<void> saveManagerFeedback({bool isSubmit = false}) async {
    final currentState = state;
    if (currentState is! _Success &&
        currentState is! _Saving &&
        currentState is! _SaveSuccess &&
        currentState is! _Submitting &&
        currentState is! _SubmitSuccess) return;

    final details = (currentState as dynamic).details as SelfAssessmentEntity;

    final goalRatings = details.goalReviews.map((goal) {
      return {
        "name": goal.name,
        "goal": goal.goal,
        "weightage": goal.weightage,
        "target": goal.target,
        "achieved": goal.achieved,
        "self_rating": goal.selfRating,
        "employee_comment": goal.employeeComment,
        "manager_rating": goal.managerRating,
        "manager_percentage": goal.managerPercentage,
        "manager_comment": goal.managerComment,
        "weighted_score": goal.weightedScore,
        "parent": details.name,
        "parentfield": "goal_ratings",
        "parenttype": "PMS Evaluation",
        "doctype": "Goal Ratings",
        "docstatus": isSubmit ? 1 : 0,
      };
    }).toList();

    final data = {
      "docstatus": isSubmit ? 1 : 0,
      "goal_ratings": goalRatings,
    };

    if (isSubmit) {
      emit(SelfAssessmentState.submitting(details));
    } else {
      emit(SelfAssessmentState.saving(details));
    }

    final result = await updateEvaluationUseCase(details.name, data);

    result.fold(
      (failure) => emit(SelfAssessmentState.failure(failure.message)),
      (_) {
        if (isSubmit) {
          emit(SelfAssessmentState.submitSuccess(details));
        } else {
          emit(SelfAssessmentState.saveSuccess(details));
        }
      },
    );
  }

  void updateLocalGoalFeedback(GoalReviewEntity updatedGoal) {
    state.maybeWhen(
      success: (details) {
        final updatedGoalReviews = details.goalReviews.map((g) {
          return g.name == updatedGoal.name ? updatedGoal : g;
        }).toList();
        emit(SelfAssessmentState.success(details.copyWith(goalReviews: updatedGoalReviews)));
      },
      orElse: () {},
    );
  }
}

