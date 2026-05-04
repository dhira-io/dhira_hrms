import 'package:freezed_annotation/freezed_annotation.dart';

part 'overlap_leave_entity.freezed.dart';

@freezed
abstract class OverlapLeaveEntity with _$OverlapLeaveEntity {
  const factory OverlapLeaveEntity({
    required String id,
    required String employeeId,
    required String employeeName,
    required String designation,
    String? image,
    String? department,
    List<String>? sharedProjects,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required double days,
    required String status,
    String? description,
  }) = _OverlapLeaveEntity;
}
