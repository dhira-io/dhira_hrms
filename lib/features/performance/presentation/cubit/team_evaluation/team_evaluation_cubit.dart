import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_team_evaluations_usecase.dart';
import 'team_evaluation_state.dart';

class TeamEvaluationCubit extends Cubit<TeamEvaluationState> {
  final GetTeamEvaluationsUseCase getTeamEvaluationsUseCase;

  TeamEvaluationCubit(this.getTeamEvaluationsUseCase) : super(const TeamEvaluationState.initial());

  Future<void> fetchEvaluations() async {
    emit(const TeamEvaluationState.loading());
    final result = await getTeamEvaluationsUseCase();
    result.fold(
      (failure) => emit(TeamEvaluationState.failure(failure.message)),
      (evaluations) => emit(TeamEvaluationState.success(evaluations)),
    );
  }
}
