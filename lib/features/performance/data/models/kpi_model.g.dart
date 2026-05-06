// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kpi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KpiModelImpl _$$KpiModelImplFromJson(Map<String, dynamic> json) =>
    _$KpiModelImpl(
      name: json['name'] as String?,
      title: json['kpi'] as String? ?? '',
      kra: json['kras'] as String? ?? '',
      description: json['description'] as String? ?? '',
      weightage: (json['weightage'] as num?)?.toDouble() ?? 0.0,
      target: (json['target'] as num?)?.toDouble() ?? 0.0,
      idx: (json['idx'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$KpiModelImplToJson(_$KpiModelImpl instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      'kpi': instance.title,
      'kras': instance.kra,
      'description': instance.description,
      'weightage': instance.weightage,
      'target': instance.target,
      'idx': instance.idx,
    };
