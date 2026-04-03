import 'package:freezed_annotation/freezed_annotation.dart';

part 'org_chart_node_entity.freezed.dart';

@freezed
abstract class OrgChartNodeEntity with _$OrgChartNodeEntity {
  const factory OrgChartNodeEntity({
    required String id,
    required String name,
    required String role,
    @Default([]) List<OrgChartNodeEntity> children,
  }) = _OrgChartNodeEntity;
}
