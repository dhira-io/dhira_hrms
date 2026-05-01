import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_evaluation_entity.freezed.dart';

@freezed
abstract class TeamEvaluationEntity with _$TeamEvaluationEntity {
  const factory TeamEvaluationEntity({
    required String name,
    required String employee,
    required String department,
    required String cycle,
    required int docstatus,
    required DateTime creation,
    required DateTime modified,
    required double overallRating,
    required double goalScore,
    required String selfAssessment,
    required String manager,
  }) = _TeamEvaluationEntity;
}
