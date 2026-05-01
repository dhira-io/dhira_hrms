import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/kpi_entity.dart';

part 'kpi_model.freezed.dart';
part 'kpi_model.g.dart';

@freezed
abstract class KpiModel with _$KpiModel {
  const factory KpiModel({
    required String name,
    @JsonKey(name: 'kpi') @Default('') String title,
    @JsonKey(name: 'kras') @Default('') String kra,
    @Default('') String description,
    @Default(0.0) double weightage,
    @Default(0.0) double target,
  }) = _KpiModel;

  factory KpiModel.fromJson(Map<String, dynamic> json) =>
      _$KpiModelFromJson(json);

  factory KpiModel.fromEntity(KpiEntity entity) => KpiModel(
        name: entity.name,
        title: entity.title,
        kra: entity.kra,
        description: entity.description,
        weightage: entity.weightage,
        target: entity.target,
      );

  const KpiModel._();

  KpiEntity toEntity() => KpiEntity(
        name: name,
        title: title,
        kra: kra,
        description: description,
        weightage: weightage,
        target: target,
      );
}
