// lib/features/approvals/presentation/bloc/approvals_event.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/approval_type.dart';

part 'approvals_event.freezed.dart';

@freezed
class ApprovalsEvent with _$ApprovalsEvent {
  const factory ApprovalsEvent.started() = Started;

  const factory ApprovalsEvent.refreshSummary() = RefreshSummary;

  // The 'CategoryChanged' here is what the Bloc looks for
  const factory ApprovalsEvent.categoryChanged(ApprovalType type) = CategoryChanged;
}