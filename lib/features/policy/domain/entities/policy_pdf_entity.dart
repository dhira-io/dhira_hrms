import 'package:freezed_annotation/freezed_annotation.dart';

part 'policy_pdf_entity.freezed.dart';

@freezed
abstract class PolicyPdfEntity with _$PolicyPdfEntity {
  const factory PolicyPdfEntity({
    required String fileName,
    required String fileBytes,
  }) = _PolicyPdfEntity;
}
