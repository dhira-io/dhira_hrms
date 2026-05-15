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
    emit(SelfAssessmentState.loading(selectedKra: state.selectedKra));
    final result = await getSelfAssessmentDetailsUseCase(
      selfAssessmentId,
      evaluationId,
    );

    result.fold(
      (failure) => emit(
        SelfAssessmentState.failure(
          failure.message,
          selectedKra: state.selectedKra,
        ),
      ),
      (details) => emit(
        SelfAssessmentState.success(
          details,
          selectedKra:
              state.selectedKra ??
              (details.goalReviews.isNotEmpty
                  ? details.goalReviews.first.kras
                  : null),
        ),
      ),
    );
  }

  void selectKra(String kra) {
    state.maybeWhen(
      success: (details, _) => emit(
        SelfAssessmentState.success(details, selectedKra: kra),
      ),
      saving: (details, _) => emit(
        SelfAssessmentState.saving(details, selectedKra: kra),
      ),
      saveSuccess: (details, _) => emit(
        SelfAssessmentState.saveSuccess(details, selectedKra: kra),
      ),
      submitting: (details, _) => emit(
        SelfAssessmentState.submitting(details, selectedKra: kra),
      ),
      submitSuccess: (details, _) => emit(
        SelfAssessmentState.submitSuccess(details, selectedKra: kra),
      ),
      orElse: () {},
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
    final currentSelectedKra = state.selectedKra;

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

    final data = {"docstatus": isSubmit ? 1 : 0, "goal_ratings": goalRatings};

    if (isSubmit) {
      emit(SelfAssessmentState.submitting(details, selectedKra: currentSelectedKra));
    } else {
      emit(SelfAssessmentState.saving(details, selectedKra: currentSelectedKra));
    }

    final result = await updateEvaluationUseCase(details.name, data);

    result.fold(
      (failure) => emit(
        SelfAssessmentState.failure(
          failure.message,
          selectedKra: currentSelectedKra,
        ),
      ),
      (_) {
        if (isSubmit) {
          emit(SelfAssessmentState.submitSuccess(details, selectedKra: currentSelectedKra));
        } else {
          emit(SelfAssessmentState.saveSuccess(details, selectedKra: currentSelectedKra));
        }
      },
    );
  }

  void updateLocalGoalFeedback(GoalReviewEntity updatedGoal) {
    state.maybeWhen(
      success: (details, kra) => _emitUpdatedLocalGoal(details, updatedGoal, kra),
      saving: (details, kra) => _emitUpdatedLocalGoal(details, updatedGoal, kra),
      saveSuccess: (details, kra) => _emitUpdatedLocalGoal(details, updatedGoal, kra),
      submitting: (details, kra) => _emitUpdatedLocalGoal(details, updatedGoal, kra),
      submitSuccess: (details, kra) => _emitUpdatedLocalGoal(details, updatedGoal, kra),
      orElse: () {},
    );
  }

  void _emitUpdatedLocalGoal(
    SelfAssessmentEntity details,
    GoalReviewEntity updatedGoal,
    String? selectedKra,
  ) {
    final updatedGoalReviews = details.goalReviews.map((g) {
      return g.name == updatedGoal.name ? updatedGoal : g;
    }).toList();
    emit(
      SelfAssessmentState.success(
        details.copyWith(goalReviews: updatedGoalReviews),
        selectedKra: selectedKra,
      ),
    );
  }
}

