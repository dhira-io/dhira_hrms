import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/organization_entity.dart';
import '../../domain/entities/org_chart_node_entity.dart';

part 'organization_state.freezed.dart';

@freezed
class OrganizationState with _$OrganizationState {
  const factory OrganizationState.initial() = _Initial;
  const factory OrganizationState.loading() = _Loading;
  const factory OrganizationState.organizationsLoaded(List<OrganizationEntity> organizations) = _OrganizationsLoaded;
  const factory OrganizationState.chartLoaded(OrgChartNodeEntity rootNode) = _ChartLoaded;
  const factory OrganizationState.error(String message) = _Error;
}
