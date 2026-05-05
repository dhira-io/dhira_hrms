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

  Future<void> updateEvaluation(
    String evaluationId,
    Map<String, dynamic> data,
  ) async {
    final currentState = state;
    if (currentState is! _Success && currentState is! _Saving && currentState is! _SaveSuccess) return;
    
    final details = (currentState as dynamic).details as SelfAssessmentEntity;
    
    emit(SelfAssessmentState.saving(details));
    
    final result = await updateEvaluationUseCase(evaluationId, data);
    
    result.fold(
      (failure) => emit(SelfAssessmentState.failure(failure.message)),
      (_) => emit(SelfAssessmentState.saveSuccess(details)),
    );
  }

  Future<void> submitEvaluation(
    String evaluationId,
    Map<String, dynamic> data,
  ) async {
    final currentState = state;
    if (currentState is! _Success &&
        currentState is! _Saving &&
        currentState is! _SaveSuccess &&
        currentState is! _Submitting &&
        currentState is! _SubmitSuccess) return;

    final details = (currentState as dynamic).details as SelfAssessmentEntity;

    emit(SelfAssessmentState.submitting(details));

    final result = await updateEvaluationUseCase(evaluationId, data);

    result.fold(
      (failure) => emit(SelfAssessmentState.failure(failure.message)),
      (_) => emit(SelfAssessmentState.submitSuccess(details)),
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

