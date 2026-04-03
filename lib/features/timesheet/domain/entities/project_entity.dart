import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_entity.freezed.dart';

@freezed
abstract class ProjectEntity with _$ProjectEntity {
  const factory ProjectEntity({
    required String name,
    required String projectName,
  }) = _ProjectEntity;

  const ProjectEntity._();
}
