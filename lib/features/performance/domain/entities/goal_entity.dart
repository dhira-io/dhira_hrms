import 'package:freezed_annotation/freezed_annotation.dart';
import 'kra_entity.dart';
import 'kpi_entity.dart';

part 'goal_entity.freezed.dart';

@freezed
abstract class GoalEntity with _$GoalEntity {
  const factory GoalEntity({
    required String name,
    @Default('Draft') String status,
    @Default('') String employeeId,
    @Default([]) List<KraEntity> kras,
    @Default([]) List<KpiEntity> kpis,
  }) = _GoalEntity;
}
