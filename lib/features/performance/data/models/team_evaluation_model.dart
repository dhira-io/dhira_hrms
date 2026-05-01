import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/team_evaluation_entity.dart';

part 'team_evaluation_model.freezed.dart';
part 'team_evaluation_model.g.dart';

@freezed
abstract class TeamEvaluationModel with _$TeamEvaluationModel {
  const factory TeamEvaluationModel({
    required String name,
    required String employee,
    required String department,
    required String cycle,
    required int docstatus,
    required DateTime creation,
    required DateTime modified,
    @JsonKey(name: 'overall_rating') required double overallRating,
    @JsonKey(name: 'goal_score') required double goalScore,
    @JsonKey(name: 'self_assesment') required String selfAssessment,
    required String manager,
  }) = _TeamEvaluationModel;

  factory TeamEvaluationModel.fromJson(Map<String, dynamic> json) =>
      _$TeamEvaluationModelFromJson(json);

  const TeamEvaluationModel._();

  TeamEvaluationEntity toEntity() => TeamEvaluationEntity(
        name: name,
        employee: employee,
        department: department,
        cycle: cycle,
        docstatus: docstatus,
        creation: creation,
        modified: modified,
        overallRating: overallRating,
        goalScore: goalScore,
        selfAssessment: selfAssessment,
        manager: manager,
      );
}
