import 'package:freezed_annotation/freezed_annotation.dart';

part 'policy_entity.freezed.dart';

@freezed
abstract class PolicyEntity with _$PolicyEntity {
  const factory PolicyEntity({
    required String id,
    required String title,
    required String description,
    required String fileUrl,
  }) = _PolicyEntity;
}
