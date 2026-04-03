import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_type_entity.freezed.dart';

@freezed
abstract class LeaveTypeEntity with _$LeaveTypeEntity {
  const factory LeaveTypeEntity({
    required String name,
    required String leaveTypeName,
  }) = _LeaveTypeEntity;

  const LeaveTypeEntity._();
}
