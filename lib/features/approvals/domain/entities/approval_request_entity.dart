// lib/features/approvals/domain/entities/approval_request_entity.dart
import 'package:equatable/equatable.dart';

enum ApprovalCategory { team, raised }

class ApprovalRequestEntity extends Equatable {
  final String id;
  final String employeeName;
  final String employeeRole;
  final String? profileImage;
  final String status;
  final ApprovalCategory category;
  final Map<String, String> displayDetails; // Key: Label, Value: Content

  const ApprovalRequestEntity({
    required this.id,
    required this.employeeName,
    required this.employeeRole,
    this.profileImage,
    required this.status,
    required this.category,
    required this.displayDetails,
  });

  @override
  List<Object?> get props => [id, status, category];
}