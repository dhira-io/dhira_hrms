import 'package:freezed_annotation/freezed_annotation.dart';

part 'performance_entity.freezed.dart';

@freezed
abstract class PerformanceEntity with _$PerformanceEntity {
  const factory PerformanceEntity({
    required String employeeId,
    required double score,
    required String period,
  }) = _PerformanceEntity;
}
