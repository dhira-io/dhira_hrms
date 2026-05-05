import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/pms_cycle_entity.dart';

part 'pms_cycle_model.freezed.dart';
part 'pms_cycle_model.g.dart';

@freezed
abstract class PmsCycleModel with _$PmsCycleModel {
  const factory PmsCycleModel({
    required String name,
    @JsonKey(name: 'cycle_name') required String cycleName,
  }) = _PmsCycleModel;

  factory PmsCycleModel.fromJson(Map<String, dynamic> json) =>
      _$PmsCycleModelFromJson(json);

  const PmsCycleModel._();

  PmsCycleEntity toEntity() => PmsCycleEntity(
        name: name,
        cycleName: cycleName,
      );
}
