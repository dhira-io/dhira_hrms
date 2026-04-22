import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_leave_entity.freezed.dart';

@freezed
abstract class TeamLeaveEntity with _$TeamLeaveEntity {
  const factory TeamLeaveEntity({
    required String employeeName,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String employee,
    String? designation,
    String? image,
  }) = _TeamLeaveEntity;
}
