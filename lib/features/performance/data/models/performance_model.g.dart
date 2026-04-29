// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PerformanceModel _$PerformanceModelFromJson(Map<String, dynamic> json) =>
    _PerformanceModel(
      employeeId: json['employee_id'] as String,
      score: (json['performance_score'] as num).toDouble(),
      period: json['review_period'] as String,
    );

Map<String, dynamic> _$PerformanceModelToJson(_PerformanceModel instance) =>
    <String, dynamic>{
      'employee_id': instance.employeeId,
      'performance_score': instance.score,
      'review_period': instance.period,
    };
