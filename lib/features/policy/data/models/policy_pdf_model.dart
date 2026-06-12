import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/policy/domain/entities/policy_pdf_entity.dart';

part 'policy_pdf_model.freezed.dart';
part 'policy_pdf_model.g.dart';

@freezed
abstract class PolicyPdfResponseModel with _$PolicyPdfResponseModel {
  const factory PolicyPdfResponseModel({required PolicyPdfModel message}) =
      _PolicyPdfResponseModel;

  factory PolicyPdfResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PolicyPdfResponseModelFromJson(json);
}

@freezed
abstract class PolicyPdfModel with _$PolicyPdfModel {
  const factory PolicyPdfModel({
    @JsonKey(name: 'file_name') required String fileName,
    @JsonKey(name: 'file_bytes') required String fileBytes,
  }) = _PolicyPdfModel;

  factory PolicyPdfModel.fromJson(Map<String, dynamic> json) =>
      _$PolicyPdfModelFromJson(json);
}

extension PolicyPdfModelMapper on PolicyPdfModel {
  PolicyPdfEntity toEntity() =>
      PolicyPdfEntity(fileName: fileName, fileBytes: fileBytes);
}
