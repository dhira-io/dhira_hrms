import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/leave_entities.dart';
import '../../domain/entities/overlap_leave_entity.dart';

part 'leave_state.freezed.dart';

@freezed
abstract class LeaveState with _$LeaveState {
  const LeaveState._();

  const factory LeaveState({
    @Default([]) List<LeaveTypeEntity> leaveTypes,
    @Default(LeaveBalanceEntity(totalAllocated: 0, used: 0, pending: 0, approved: 0, rejected: 0, applied: 0, available: 0)) LeaveBalanceEntity balance,
    LeaveStatisticsEntity? statistics,
    @Default(false) bool isInitialLoading,
    @Default(false) bool isLoading,
    @Default('') String currentEmpId,
    @Default('') String userEmail,
    String? errorMessage,
    String? statsError,
    String? balanceError,
    @Default([]) List<OverlapLeaveEntity> overlapLeaves,
    @Default('') String employeeName,
    @Default('') String gender,
    @Default(false) bool hideOverlapAfterSubmit,
    @Default(false) bool loadingOverlap,
    @Default(false) bool success,
    @Default(false) bool isUploading,
    String? uploadedFileUrl,
    String? uploadError,
    DateTime? fromDate,
    DateTime? toDate,
    @Default(false) bool isHalfDay,
    DateTime? halfDayDate,
    String? daySegment,
    String? selectedFileName,
    String? selectedLeaveType,
    @Default(0) int uploadCount,
  }) = _LeaveState;
}
