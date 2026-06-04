import 'package:freezed_annotation/freezed_annotation.dart';
import 'approvals_success_data.dart';

part 'approvals_state.freezed.dart';

@freezed
class ApprovalsState with _$ApprovalsState {
  const factory ApprovalsState.initial() = Initial;
  const factory ApprovalsState.loading() = Loading;
  const factory ApprovalsState.success(ApprovalsSuccessData data) = Success;
  const factory ApprovalsState.failure(String message) = Failure;
}
