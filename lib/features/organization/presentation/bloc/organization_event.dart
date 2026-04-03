import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_event.freezed.dart';

@freezed
class OrganizationEvent with _$OrganizationEvent {
  const factory OrganizationEvent.started() = _Started;
  const factory OrganizationEvent.loadOrganizationsRequested() = _LoadOrganizationsRequested;
  const factory OrganizationEvent.loadChartRequested() = _LoadChartRequested;
}
