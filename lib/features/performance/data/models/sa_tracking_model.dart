import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/sa_tracking_entity.dart';

part 'sa_tracking_model.freezed.dart';
part 'sa_tracking_model.g.dart';

@freezed
abstract class SaTrackingModel with _$SaTrackingModel {
  const factory SaTrackingModel({
    required String name,
    @Default([]) List<SaSessionModel> sessions,
    @Default([]) List<SaQuestionModel> questions,
  }) = _SaTrackingModel;

  factory SaTrackingModel.fromJson(Map<String, dynamic> json) =>
      _$SaTrackingModelFromJson(json);

  const SaTrackingModel._();

  SaTrackingEntity toEntity() => SaTrackingEntity(
    name: name,
    sessions: sessions.map((e) => e.toEntity()).toList(),
    questions: questions.map((e) => e.toEntity()).toList(),
  );
}

@freezed
abstract class SaSessionModel with _$SaSessionModel {
  const factory SaSessionModel({
    required String name,
    @Default('') String session,
    @JsonKey(name: 'session_start') @Default('') String sessionStart,
    @JsonKey(name: 'session_end') @Default('') String sessionEnd,
    @JsonKey(name: 'completed_tasks') @Default('') String completedTasks,
  }) = _SaSessionModel;

  factory SaSessionModel.fromJson(Map<String, dynamic> json) =>
      _$SaSessionModelFromJson(json);

  const SaSessionModel._();

  SaSessionEntity toEntity() => SaSessionEntity(
    name: name,
    session: session,
    sessionStart: sessionStart,
    sessionEnd: sessionEnd,
    completedTasks: completedTasks,
  );
}

@freezed
abstract class SaQuestionModel with _$SaQuestionModel {
  const factory SaQuestionModel({
    required String name,
    @Default('') String key,
    @Default('') String session,
    @Default('') String question,
    @Default('') String rating,
    @JsonKey(name: 'last_modified') @Default('') String lastModified,
  }) = _SaQuestionModel;

  factory SaQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$SaQuestionModelFromJson(json);

  const SaQuestionModel._();

  SaQuestionEntity toEntity() => SaQuestionEntity(
    name: name,
    key: key,
    session: session,
    question: question,
    rating: rating,
    lastModified: lastModified,
  );
}
