import 'package:freezed_annotation/freezed_annotation.dart';

part 'policy_event.freezed.dart';

@freezed
abstract class PolicyEvent with _$PolicyEvent {
  const factory PolicyEvent.started() = PolicyStarted;
  const factory PolicyEvent.refresh() = PolicyRefresh;
  const factory PolicyEvent.searchQueryChanged(String query) =
      PolicySearchQueryChanged;
  const factory PolicyEvent.toggleViewMode() = PolicyToggleViewMode;
}
