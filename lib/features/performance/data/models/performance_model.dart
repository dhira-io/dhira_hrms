import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/performance_entity.dart';

part 'performance_model.freezed.dart';
part 'performance_model.g.dart';

@freezed
abstract class PerformanceModel with _$PerformanceModel {
  const factory PerformanceModel({
    @JsonKey(name: 'employee_id') required String employeeId,
    @JsonKey(name: 'performance_score') required double score,
    @JsonKey(name: 'review_period') required String period,
  }) = _PerformanceModel;

  factory PerformanceModel.fromJson(Map<String, dynamic> json) =>
      _$PerformanceModelFromJson(json);
}

extension PerformanceModelX on PerformanceModel {
  PerformanceEntity toEntity() => PerformanceEntity(
        employeeId: employeeId,
        score: score,
        period: period,
      );
}
