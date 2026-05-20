import 'package:freezed_annotation/freezed_annotation.dart';

part 'sa_tracking_entity.freezed.dart';

@freezed
abstract class SaTrackingEntity with _$SaTrackingEntity {
  const factory SaTrackingEntity({
    required String name,
    required List<SaSessionEntity> sessions,
    required List<SaQuestionEntity> questions,
  }) = _SaTrackingEntity;
}

@freezed
abstract class SaSessionEntity with _$SaSessionEntity {
  const factory SaSessionEntity({
    required String name,
    required String session,
    required String sessionStart,
    required String sessionEnd,
    required String completedTasks,
  }) = _SaSessionEntity;
}

@freezed
abstract class SaQuestionEntity with _$SaQuestionEntity {
  const factory SaQuestionEntity({
    required String name,
    required String key,
    required String session,
    required String question,
    required String rating,
    required String lastModified,
  }) = _SaQuestionEntity;
}
