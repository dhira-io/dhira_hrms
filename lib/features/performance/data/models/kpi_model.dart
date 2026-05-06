import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/kpi_entity.dart';

part 'kpi_model.freezed.dart';
part 'kpi_model.g.dart';

@freezed
abstract class KpiModel with _$KpiModel {
  const factory KpiModel({
    @JsonKey(includeIfNull: false) String? name,
    @JsonKey(name: 'kpi') @Default('') String title,
    @JsonKey(name: 'kras') @Default('') String kra,
    @Default('') String description,
    @Default(0.0) double weightage,
    @Default(0.0) double target,
    int? idx,
  }) = _KpiModel;

  factory KpiModel.fromJson(Map<String, dynamic> json) =>
      _$KpiModelFromJson(json);

  factory KpiModel.fromEntity(KpiEntity entity) => KpiModel(
        name: (entity.id != null && !entity.id!.startsWith('new_')) ? entity.id : null,
        title: entity.title,
        kra: entity.kra,
        description: entity.description,
        weightage: entity.weightage,
        target: entity.target,
      );

  const KpiModel._();

  KpiEntity toEntity() => KpiEntity(
        id: name,
        title: title,
        kra: kra,
        description: description,
        weightage: weightage,
        target: target,
      );
}
