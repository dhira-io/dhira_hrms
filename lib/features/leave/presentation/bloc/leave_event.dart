import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_event.freezed.dart';

@freezed
abstract class LeaveEvent with _$LeaveEvent {
  const LeaveEvent._();

  const factory LeaveEvent.started(String employeeId, String userEmail) = _Started;
  const factory LeaveEvent.refreshRequested(String employeeId, String userEmail) = _RefreshRequested;
  const factory LeaveEvent.loadMoreRequested(String employeeId, String userEmail) = _LoadMoreRequested;
  const factory LeaveEvent.searchChanged(String query) = _SearchChanged;
  const factory LeaveEvent.applyRequested({
    required String employeeId,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
  }) = _ApplyRequested;
  const factory LeaveEvent.updateRequested({
    required String leaveId,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
  }) = _UpdateRequested;
  const factory LeaveEvent.statusUpdateRequested({
    required String leaveApplicationName,
    required String newStatus,
  }) = _StatusUpdateRequested;
  const factory LeaveEvent.deleteRequested(String name, String employeeId) = _DeleteRequested;
  const factory LeaveEvent.cancelRequested(String name, String employeeId) = _CancelRequested;
  const factory LeaveEvent.balanceRequested(String employeeId, String todayDate) = _BalanceRequested;
}
