import 'package:freezed_annotation/freezed_annotation.dart';

part 'approvals_access_entity.freezed.dart';

@freezed
abstract class ApprovalsAccessEntity with _$ApprovalsAccessEntity {
  const factory ApprovalsAccessEntity({
    required bool canAccess,
  }) = _ApprovalsAccessEntity;
}
