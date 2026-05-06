import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/team_evaluation_entity.dart';

part 'team_evaluation_filter_state.freezed.dart';

@freezed
abstract class TeamEvaluationFilterState with _$TeamEvaluationFilterState {
  const factory TeamEvaluationFilterState({
    @Default([]) List<TeamEvaluationEntity> allEvaluations,
    @Default([]) List<TeamEvaluationEntity> filteredEvaluations,
    @Default('All Department') String selectedDepartment,
    @Default('All Status') String selectedStatus,
    @Default('') String searchQuery,
    @Default(['All Department']) List<String> departments,
    @Default(['All Status', 'Submitted', 'Pending']) List<String> statuses,
    @Default(0) int totalCount,
    @Default(0) int submittedCount,
    @Default(0) int pendingCount,
  }) = _TeamEvaluationFilterState;
}
