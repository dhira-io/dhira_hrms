import 'package:freezed_annotation/freezed_annotation.dart';

part 'kra_entity.freezed.dart';

@freezed
abstract class KraEntity with _$KraEntity {
  const factory KraEntity({
    required String name,
    @Default(0.0) double weightage,
  }) = _KraEntity;
}
