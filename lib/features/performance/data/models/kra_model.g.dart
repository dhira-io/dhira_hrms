// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kra_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KraModelImpl _$$KraModelImplFromJson(Map<String, dynamic> json) =>
    _$KraModelImpl(
      docName: json['name'] as String?,
      name: json['kra'] as String,
      weightage: (json['weightage'] as num?)?.toDouble() ?? 0.0,
      idx: (json['idx'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$KraModelImplToJson(_$KraModelImpl instance) =>
    <String, dynamic>{
      if (instance.docName case final value?) 'name': value,
      'kra': instance.name,
      'weightage': instance.weightage,
      'idx': instance.idx,
    };
