import 'package:freezed_annotation/freezed_annotation.dart';

part 'compensatory_leave_eligible_date_entity.freezed.dart';

@freezed
abstract class CompensatoryLeaveEligibleDateEntity
    with _$CompensatoryLeaveEligibleDateEntity {
  const factory CompensatoryLeaveEligibleDateEntity({
    required String date,
    required String displayLabel,
    required double workedHours,
    required String workType,
  }) = _CompensatoryLeaveEligibleDateEntity;

  const CompensatoryLeaveEligibleDateEntity._();
}
