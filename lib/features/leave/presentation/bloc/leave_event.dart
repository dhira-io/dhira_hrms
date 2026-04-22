import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_event.freezed.dart';

@freezed
abstract class LeaveEvent with _$LeaveEvent {
  const LeaveEvent._();

  const factory LeaveEvent.applyRequested({
    required String employeeId,
    required String employeeName,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays,
  }) = _ApplyRequested;

  const factory LeaveEvent.updateRequested({
    required String leaveId,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays,
  }) = _UpdateRequested;

  const factory LeaveEvent.typesRequested() = _TypesRequested;
  const factory LeaveEvent.balanceRequested({required String employeeId, required String todayDate}) = _BalanceRequested;
}
