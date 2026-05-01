// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kra_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KraModel _$KraModelFromJson(Map<String, dynamic> json) => _KraModel(
  docName: json['name'] as String?,
  name: json['kra'] as String,
  weightage: (json['weightage'] as num?)?.toDouble() ?? 0.0,
  idx: (json['idx'] as num?)?.toInt(),
);

Map<String, dynamic> _$KraModelToJson(_KraModel instance) => <String, dynamic>{
  'name': instance.docName,
  'kra': instance.name,
  'weightage': instance.weightage,
  'idx': instance.idx,
};
