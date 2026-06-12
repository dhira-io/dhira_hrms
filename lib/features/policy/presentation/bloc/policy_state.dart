import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/policy/domain/entities/policy_entity.dart';

part 'policy_state.freezed.dart';

@freezed
abstract class PolicyState with _$PolicyState {
  const factory PolicyState({
    @Default(true) bool isLoading,
    @Default(false) bool isActionLoading,
    String? errorMessage,
    @Default([]) List<PolicyEntity> policies,
    @Default([]) List<PolicyEntity> filteredPolicies,
    @Default('') String searchQuery,
    @Default(false) bool isGridView,
  }) = _PolicyState;
}
