import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/usecases/usecase.dart';
import 'package:dhira_hrms/features/policy/domain/usecases/get_policies_usecase.dart';
import 'package:dhira_hrms/features/policy/presentation/bloc/policy_event.dart';
import 'package:dhira_hrms/features/policy/presentation/bloc/policy_state.dart';
import 'package:dhira_hrms/features/policy/domain/entities/policy_entity.dart';

class PolicyBloc extends Bloc<PolicyEvent, PolicyState> {
  final GetPoliciesUseCase getPoliciesUseCase;

  PolicyBloc({required this.getPoliciesUseCase}) : super(const PolicyState()) {
    on<PolicyStarted>(_onStarted);
    on<PolicyRefresh>(_onRefresh);
    on<PolicySearchQueryChanged>(_onSearchQueryChanged);
    on<PolicyToggleViewMode>(_onToggleViewMode);
  }

  Future<void> _onStarted(
    PolicyStarted event,
    Emitter<PolicyState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      isGridView: false,
      searchQuery: '',
    ));
    await _fetchPolicies(emit);
  }

  Future<void> _onRefresh(
    PolicyRefresh event,
    Emitter<PolicyState> emit,
  ) async {
    emit(state.copyWith(isActionLoading: true, errorMessage: null));
    await _fetchPolicies(emit);
    emit(state.copyWith(isActionLoading: false));
  }

  Future<void> _fetchPolicies(Emitter<PolicyState> emit) async {
    final result = await getPoliciesUseCase(NoParams());
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (policies) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: null,
            policies: policies,
            filteredPolicies: _filterPolicies(policies, state.searchQuery),
          ),
        );
      },
    );
  }

  void _onSearchQueryChanged(
    PolicySearchQueryChanged event,
    Emitter<PolicyState> emit,
  ) {
    final query = event.query;
    emit(
      state.copyWith(
        searchQuery: query,
        filteredPolicies: _filterPolicies(state.policies, query),
      ),
    );
  }

  void _onToggleViewMode(
    PolicyToggleViewMode event,
    Emitter<PolicyState> emit,
  ) {
    emit(state.copyWith(isGridView: !state.isGridView));
  }

  List<PolicyEntity> _filterPolicies(
    List<PolicyEntity> policies,
    String query,
  ) {
    if (query.isEmpty) return policies;
    final lowerQuery = query.toLowerCase();
    return policies.where((policy) {
      final titleLower = policy.title.toLowerCase();
      if (lowerQuery.length == 1) {
        final words = titleLower.split(RegExp(r'\s+'));
        return words.any((word) => word.startsWith(lowerQuery));
      }
      return titleLower.contains(lowerQuery);
    }).toList();
  }
}
