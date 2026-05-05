import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/team_evaluation_entity.dart';
import '../../../domain/usecases/get_employee_info_usecase.dart';
import '../../../domain/usecases/get_team_evaluations_usecase.dart';
import 'team_evaluation_state.dart';

class TeamEvaluationCubit extends Cubit<TeamEvaluationState> {
  final GetTeamEvaluationsUseCase getTeamEvaluationsUseCase;
  final GetEmployeeInfoUseCase getEmployeeInfoUseCase;

  TeamEvaluationCubit(
    this.getTeamEvaluationsUseCase,
    this.getEmployeeInfoUseCase,
  ) : super(const TeamEvaluationState.initial());

  Future<void> fetchEvaluations() async {
    emit(const TeamEvaluationState.loading());
    final result = await getTeamEvaluationsUseCase();
    
    await result.fold(
      (failure) async => emit(TeamEvaluationState.failure(failure.message)),
      (evaluations) async {
        emit(TeamEvaluationState.success(evaluations));
        
        // Fetch employee info one by one to show individual shimmer completion
        for (int i = 0; i < evaluations.length; i++) {
          final eval = evaluations[i];
          
          // Skip if already fetched or not needed
          if (eval.employeeName != null && eval.employeeStatus != null) continue;

          final infoResult = await getEmployeeInfoUseCase(eval.employee);
          
          infoResult.fold(
            (failure) {
              // If fails, use the employee ID as the name to stop shimmering
              _updateEmployeeInfo(eval.name, eval.employee, 'Unknown');
            },
            (info) {
              _updateEmployeeInfo(eval.name, info['name']!, info['status']!);
            },
          );
        }
      },
    );
  }

  void _updateEmployeeInfo(String evaluationId, String name, String status) {
    state.mapOrNull(
      success: (successState) {
        final updatedList = List<TeamEvaluationEntity>.from(successState.evaluations);
        final index = updatedList.indexWhere((e) => e.name == evaluationId);
        if (index != -1) {
          updatedList[index] = updatedList[index].copyWith(
            employeeName: name,
            employeeStatus: status,
          );
          emit(TeamEvaluationState.success(updatedList));
        }
      },
    );
  }
}
