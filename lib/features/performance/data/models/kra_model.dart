import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/kra_entity.dart';

part 'kra_model.freezed.dart';
part 'kra_model.g.dart';

@freezed
abstract class KraModel with _$KraModel {
  const factory KraModel({
    @JsonKey(name: 'name') String? docName,
    @JsonKey(name: 'kra') required String name,
    @Default(0.0) double weightage,
    int? idx,
  }) = _KraModel;

  factory KraModel.fromJson(Map<String, dynamic> json) =>
      _$KraModelFromJson(json);

  factory KraModel.fromEntity(KraEntity entity) => KraModel(
        name: entity.name,
        weightage: entity.weightage,
      );

  const KraModel._();

  KraEntity toEntity() => KraEntity(name: name, weightage: weightage);
}
