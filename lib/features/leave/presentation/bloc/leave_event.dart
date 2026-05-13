import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:file_picker/file_picker.dart';
import '../../domain/entities/leave_entity.dart';

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
  const factory LeaveEvent.balanceRequested({required String employeeId, required String todayDate, required String gender}) = _BalanceRequested;
  const factory LeaveEvent.statisticsRequested({
    required String employeeId,
    required String fromDate,
    required String toDate,
  }) = _StatisticsRequested;

  const factory LeaveEvent.overlapLeavesRequested({
    required String employeeId,
    required String fromDate,
    required String toDate,
  }) = _OverlapLeavesRequested;

  const factory LeaveEvent.uploadFileRequested({
    required PlatformFile file,
    required String employeeId,
  }) = _UploadFileRequested;

  const factory LeaveEvent.clearUploadStatus() = _ClearUploadStatus;

  const factory LeaveEvent.leaveTypeChanged(String? type) = _LeaveTypeChanged;
  const factory LeaveEvent.dateSelected({required bool isFromDate, required DateTime date}) = _DateSelected;
  const factory LeaveEvent.halfDayToggled(bool isHalfDay) = _HalfDayToggled;
  const factory LeaveEvent.halfDayDateSelected(DateTime date) = _HalfDayDateSelected;
  const factory LeaveEvent.daySegmentChanged(String? segment) = _DaySegmentChanged;
  const factory LeaveEvent.formInitialized({LeaveEntity? leave}) = _FormInitialized;
  const factory LeaveEvent.overlapHiddenStatusChanged(bool hide) = _OverlapHiddenStatusChanged;
}
