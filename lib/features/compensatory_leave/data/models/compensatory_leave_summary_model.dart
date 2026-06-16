import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/compensatory_leave/domain/entities/compensatory_leave_summary_entity.dart';

part 'compensatory_leave_summary_model.freezed.dart';
part 'compensatory_leave_summary_model.g.dart';

@freezed
class CompensatoryLeaveSummaryModel with _$CompensatoryLeaveSummaryModel {
  const factory CompensatoryLeaveSummaryModel({
    @JsonKey(name: 'available_balance') required double availableBalance,
    @JsonKey(name: 'pending_for_approval') required double raisedRequest,
    @JsonKey(name: 'expiring_soon') required double expiringSoon,
  }) = _CompensatoryLeaveSummaryModel;

  const CompensatoryLeaveSummaryModel._();

  factory CompensatoryLeaveSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$CompensatoryLeaveSummaryModelFromJson(json);

  CompensatoryLeaveSummaryEntity toEntity() {
    return CompensatoryLeaveSummaryEntity(
      availableBalance: availableBalance,
      raisedRequest: raisedRequest,
      expiringSoon: expiringSoon,
    );
  }
}
