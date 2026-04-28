// lib/features/approvals/domain/entities/approval_request_entity.dart
import 'package:equatable/equatable.dart';

class ApprovalRequestEntity extends Equatable {
  final String id;
  final String employeeName;
  final String employeeRole;
  final String? profileImage;
  final String requestType; // e.g., 'Sick Leave'
  final String dateRange;
  final String duration;
  final String status;

  const ApprovalRequestEntity({
    required this.id,
    required this.employeeName,
    required this.employeeRole,
    this.profileImage,
    required this.requestType,
    required this.dateRange,
    required this.duration,
    required this.status,
  });

  @override
  List<Object?> get props => [id, status];
}