import 'package:freezed_annotation/freezed_annotation.dart';

part 'pms_cycle_entity.freezed.dart';

@freezed
abstract class PmsCycleEntity with _$PmsCycleEntity {
  const factory PmsCycleEntity({
    required String name,
    required String cycleName,
  }) = _PmsCycleEntity;
}
