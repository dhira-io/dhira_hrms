import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/project_entity.dart';

part 'project_model.freezed.dart';
part 'project_model.g.dart';

@freezed
abstract class ProjectModel with _$ProjectModel {
  const factory ProjectModel({
    required String name,
    @JsonKey(name: 'project_name') required String projectName,
  }) = _ProjectModel;

  const ProjectModel._();

  factory ProjectModel.fromJson(Map<String, dynamic> json) => _$ProjectModelFromJson(json);

  ProjectEntity toEntity() {
    return ProjectEntity(
      name: name,
      projectName: projectName,
    );
  }
}
