// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoalModel _$GoalModelFromJson(Map<String, dynamic> json) => _GoalModel(
  name: json['name'] as String,
  status: json['status'] as String? ?? 'Draft',
  employeeId: json['employee'] as String? ?? '',
  kras:
      (json['kras'] as List<dynamic>?)
          ?.map((e) => KraModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  kpis:
      (json['kpis'] as List<dynamic>?)
          ?.map((e) => KpiModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$GoalModelToJson(_GoalModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': instance.status,
      'employee': instance.employeeId,
      'kras': instance.kras,
      'kpis': instance.kpis,
    };
