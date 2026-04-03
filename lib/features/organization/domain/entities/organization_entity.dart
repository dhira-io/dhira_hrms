import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_entity.freezed.dart';

@freezed
abstract class OrganizationEntity with _$OrganizationEntity {
  const factory OrganizationEntity({
    required String id,
    required String name,
    required String department,
    required String location,
    required int employeeCount,
  }) = _OrganizationEntity;
}
