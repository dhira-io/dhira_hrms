import 'package:equatable/equatable.dart';
import 'approval_type.dart';

enum ApprovalCategory { team, raised }

class ConflictingLeaveEntity extends Equatable {
  final String employeeName;
  final String employeeRole;
  final String? profileImage;
  final String leaveType;
  final String status;

  const ConflictingLeaveEntity({
    required this.employeeName,
    required this.employeeRole,
    this.profileImage,
    required this.leaveType,
    required this.status,
  });

  @override
  List<Object?> get props => [employeeName, employeeRole, profileImage, leaveType, status];
}

class ApprovalRequestEntity extends Equatable {
  final String id;
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

  const ApprovalRequestEntity({
    required this.id,
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
  });

  @override
  List<Object?> get props => [
        id,
        status,
        category,
        type,
        availableActions,
        isMainApprover,
        conflictingLeaves,
        fromDate,
        toDate,
      ];
}