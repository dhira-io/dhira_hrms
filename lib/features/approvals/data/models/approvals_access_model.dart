import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/approvals_access_entity.dart';

part 'approvals_access_model.freezed.dart';
part 'approvals_access_model.g.dart';

@freezed
abstract class ApprovalsAccessModel with _$ApprovalsAccessModel {
  const factory ApprovalsAccessModel({
    required bool success,
    @JsonKey(name: 'can_access') required bool canAccess,
  }) = _ApprovalsAccessModel;

  const ApprovalsAccessModel._();

  factory ApprovalsAccessModel.fromJson(Map<String, dynamic> json) =>
      _$ApprovalsAccessModelFromJson(json);

  ApprovalsAccessEntity toEntity() {
    return ApprovalsAccessEntity(
      canAccess: canAccess,
    );
  }
}
