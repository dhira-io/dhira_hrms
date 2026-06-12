import 'package:freezed_annotation/freezed_annotation.dart';

part 'compensatory_leave_summary_entity.freezed.dart';

@freezed
abstract class CompensatoryLeaveSummaryEntity with _$CompensatoryLeaveSummaryEntity {
  const factory CompensatoryLeaveSummaryEntity({
    required double availableBalance,
    required double raisedRequest,
    required double expiringSoon,
  }) = _CompensatoryLeaveSummaryEntity;

  const CompensatoryLeaveSummaryEntity._();
}
