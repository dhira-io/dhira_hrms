import 'package:equatable/equatable.dart';
import 'approval_type.dart';

enum ApprovalCategory { team, raised }

extension ApprovalCategoryX on ApprovalCategory {
  int getIndex(bool canAccess) {
    if (!canAccess) return 0; // Only Raised exists
    return this == ApprovalCategory.team ? 0 : 1;
  }

  static ApprovalCategory fromIndex(int index, bool canAccess) {
    if (!canAccess) return ApprovalCategory.raised;
    return index == 0 ? ApprovalCategory.team : ApprovalCategory.raised;
  }
}

class ConflictingLeaveEntity extends Equatable {
  final String employeeName;
  final String employeeRole;
  final String? profileImage;
  final String leaveType;
  final String status;
  final String fromDate;
  final String toDate;

  const ConflictingLeaveEntity({
    required this.employeeName,
    required this.employeeRole,
    this.profileImage,
    required this.leaveType,
    required this.status,
    required this.fromDate,
    required this.toDate,
  });

  @override
  List<Object?> get props => [
        employeeName,
        employeeRole,
        profileImage,
        leaveType,
        status,
        fromDate,
        toDate,
      ];
}

class ApprovalRequestEntity extends Equatable {
  final String id;
  final String? employeeId;
  final String employeeName;
  final String employeeRole;
  final String? profileImage;
  final String status;
  final ApprovalCategory category;
  final ApprovalType type; // Used for button logic in the UI
  final List<String> availableActions;
  final Map<String, String> displayDetails;
  final bool isMainApprover;
  final List<ConflictingLeaveEntity> conflictingLeaves;
  final DateTime? fromDate;
  final DateTime? toDate;
  final bool isHalfDay;
  final String? halfDaySegment;
  final String? halfDayDate;
  final String? customHalfDetails;
  final String? fileUrl;

  const ApprovalRequestEntity({
    required this.id,
    this.employeeId,
    required this.employeeName,
    required this.employeeRole,
    this.profileImage,
    required this.status,
    required this.category,
    required this.type,
    required this.availableActions,
    required this.displayDetails,
    this.isMainApprover = false,
    this.conflictingLeaves = const [],
    this.fromDate,
    this.toDate,
    this.isHalfDay = false,
    this.halfDaySegment,
    this.halfDayDate,
    this.customHalfDetails,
    this.fileUrl,
  });

  @override
  List<Object?> get props => [
        id,
        employeeId,
        status,
        category,
        type,
        availableActions,
        isMainApprover,
        conflictingLeaves,
        fromDate,
        toDate,
        isHalfDay,
        halfDaySegment,
        halfDayDate,
        customHalfDetails,
        fileUrl,
      ];
}