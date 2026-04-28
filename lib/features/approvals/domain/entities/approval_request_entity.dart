import 'package:equatable/equatable.dart';
import 'approval_type.dart';

enum ApprovalCategory { team, raised }

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
  });

  @override
  List<Object?> get props => [id, status, category, type, availableActions];
}