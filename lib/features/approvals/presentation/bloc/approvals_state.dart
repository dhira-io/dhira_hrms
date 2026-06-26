import 'package:freezed_annotation/freezed_annotation.dart';
import 'approvals_success_data.dart';

part 'approvals_state.freezed.dart';

enum ApprovalsStatus { initial, loading, success, failure }

@freezed
class ApprovalsState with _$ApprovalsState {
  const factory ApprovalsState({
    @Default(ApprovalsStatus.initial) ApprovalsStatus status,
    ApprovalsSuccessData? data,
    String? errorMessage,
  }) = _ApprovalsState;
}
