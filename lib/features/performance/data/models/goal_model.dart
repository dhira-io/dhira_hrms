import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/goal_entity.dart';
import 'kra_model.dart';
import 'kpi_model.dart';

part 'goal_model.freezed.dart';
part 'goal_model.g.dart';

@freezed
abstract class GoalModel with _$GoalModel {
  const factory GoalModel({
    required String name,
    @Default('Draft') String status,
    @JsonKey(name: 'employee') @Default('') String employeeId,
    @Default([]) List<KraModel> kras,
    @Default([]) List<KpiModel> kpis,
  }) = _GoalModel;

  factory GoalModel.fromJson(Map<String, dynamic> json) =>
      _$GoalModelFromJson(json);

  factory GoalModel.fromEntity(GoalEntity entity) => GoalModel(
        name: entity.name,
        status: entity.status,
        employeeId: entity.employeeId,
        kras: entity.kras.map((e) => KraModel.fromEntity(e)).toList(),
        kpis: entity.kpis.map((e) => KpiModel.fromEntity(e)).toList(),
      );

  const GoalModel._();

  GoalEntity toEntity() => GoalEntity(
        name: name,
        status: status,
        employeeId: employeeId,
        kras: kras.map((e) => e.toEntity()).toList(),
        kpis: kpis.map((e) => e.toEntity()).toList(),
      );
}
