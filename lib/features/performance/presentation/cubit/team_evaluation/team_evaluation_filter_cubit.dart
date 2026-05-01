import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/team_evaluation_entity.dart';
import 'team_evaluation_filter_state.dart';

class TeamEvaluationFilterCubit extends Cubit<TeamEvaluationFilterState> {
  TeamEvaluationFilterCubit() : super(const TeamEvaluationFilterState());

  void setInitialData(List<TeamEvaluationEntity> evaluations) {
    final departments = {
      'All Department',
      ...evaluations.map((e) => e.department)
    }.toList();

    final totalCount = evaluations.length;
    final submittedCount = evaluations.where((e) => e.docstatus == 1).length;
    final pendingCount = evaluations.where((e) => e.docstatus == 0).length;

    emit(state.copyWith(
      allEvaluations: evaluations,
      filteredEvaluations: evaluations,
      departments: departments,
      totalCount: totalCount,
      submittedCount: submittedCount,
      pendingCount: pendingCount,
    ));
    _filter();
  }

  void updateDepartment(String? department) {
    if (department == null) return;
    emit(state.copyWith(selectedDepartment: department));
    _filter();
  }

  void updateStatus(String? status) {
    if (status == null) return;
    emit(state.copyWith(selectedStatus: status));
    _filter();
  }

  void updateSearch(String query) {
    emit(state.copyWith(searchQuery: query));
    _filter();
  }

  void _filter() {
    List<TeamEvaluationEntity> filtered = state.allEvaluations;

    if (state.selectedDepartment != 'All Department') {
      filtered = filtered.where((e) => e.department == state.selectedDepartment).toList();
    }

    if (state.selectedStatus != 'All Status') {
      final statusInt = state.selectedStatus == 'Submitted' ? 1 : 0;
      filtered = filtered.where((e) => e.docstatus == statusInt).toList();
    }

    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      filtered = filtered.where((e) =>
          e.employee.toLowerCase().contains(query) ||
          e.name.toLowerCase().contains(query)).toList();
    }

    emit(state.copyWith(filteredEvaluations: filtered));
  }

  void resetFilters() {
    emit(state.copyWith(
      selectedDepartment: 'All Department',
      selectedStatus: 'All Status',
      searchQuery: '',
    ));
    _filter();
  }
}
