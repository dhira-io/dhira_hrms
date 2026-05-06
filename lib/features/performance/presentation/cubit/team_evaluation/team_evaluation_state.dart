import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/team_evaluation_entity.dart';

part 'team_evaluation_state.freezed.dart';

@freezed
abstract class TeamEvaluationState with _$TeamEvaluationState {
  const factory TeamEvaluationState.initial() = _Initial;
  const factory TeamEvaluationState.loading() = _Loading;
  const factory TeamEvaluationState.success(List<TeamEvaluationEntity> evaluations) = _Success;
  const factory TeamEvaluationState.failure(String message) = _Failure;
}
