import 'package:freezed_annotation/freezed_annotation.dart';

part 'approvals_event.freezed.dart';

@freezed
class ApprovalsEvent with _$ApprovalsEvent {
  const factory ApprovalsEvent.started() = Started;
  const factory ApprovalsEvent.refreshSummary() = RefreshSummary;
}
