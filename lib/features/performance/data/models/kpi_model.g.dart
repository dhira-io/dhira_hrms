// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kpi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KpiModel _$KpiModelFromJson(Map<String, dynamic> json) => _KpiModel(
  name: json['name'] as String,
  title: json['kpi'] as String? ?? '',
  kra: json['kras'] as String? ?? '',
  description: json['description'] as String? ?? '',
  weightage: (json['weightage'] as num?)?.toDouble() ?? 0.0,
  target: (json['target'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$KpiModelToJson(_KpiModel instance) => <String, dynamic>{
  'name': instance.name,
  'kpi': instance.title,
  'kras': instance.kra,
  'description': instance.description,
  'weightage': instance.weightage,
  'target': instance.target,
};
