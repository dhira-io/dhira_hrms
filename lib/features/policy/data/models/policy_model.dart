import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/policy/domain/entities/policy_entity.dart';

part 'policy_model.freezed.dart';
part 'policy_model.g.dart';

@freezed
abstract class PolicyResponseModel with _$PolicyResponseModel {
  const factory PolicyResponseModel({required PolicyMessageModel message}) =
      _PolicyResponseModel;

  factory PolicyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PolicyResponseModelFromJson(json);
}

@freezed
abstract class PolicyMessageModel with _$PolicyMessageModel {
  const factory PolicyMessageModel({required List<PolicyModel> policies}) =
      _PolicyMessageModel;

  factory PolicyMessageModel.fromJson(Map<String, dynamic> json) =>
      _$PolicyMessageModelFromJson(json);
}

@freezed
abstract class PolicyModel with _$PolicyModel {
  const factory PolicyModel({
    required String id,
    required String title,
    required String description,
    @JsonKey(name: 'file_url') required String fileUrl,
  }) = _PolicyModel;

  factory PolicyModel.fromJson(Map<String, dynamic> json) =>
      _$PolicyModelFromJson(json);
}

extension PolicyModelMapper on PolicyModel {
  PolicyEntity toEntity() => PolicyEntity(
    id: id,
    title: title,
    description: description,
    fileUrl: fileUrl,
  );
}
