import 'package:freezed_annotation/freezed_annotation.dart';

part 'kpi_entity.freezed.dart';

@freezed
abstract class KpiEntity with _$KpiEntity {
  const factory KpiEntity({
    required String name,
    required String title,
    @Default('') String kra,
    @Default('') String description,
    @Default(0.0) double weightage,
    @Default(0.0) double target,
  }) = _KpiEntity;
}
