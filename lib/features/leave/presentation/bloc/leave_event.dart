import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_event.freezed.dart';

@freezed
abstract class LeaveEvent with _$LeaveEvent {
  const LeaveEvent._();

  const factory LeaveEvent.started(String employeeId) = _Started;
  const factory LeaveEvent.loadMoreRequested(String employeeId) = _LoadMoreRequested;
  const factory LeaveEvent.applyRequested({
    required String employeeId,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
  }) = _ApplyRequested;
  const factory LeaveEvent.deleteRequested(String name, String employeeId) = _DeleteRequested;
  const factory LeaveEvent.cancelRequested(String name, String employeeId) = _CancelRequested;
}
