import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/payslip_entities.dart';

part 'payslip_model.freezed.dart';
part 'payslip_model.g.dart';

@freezed
class PayslipModel with _$PayslipModel {
  const factory PayslipModel({
    required String name,
    required String employee,
    @JsonKey(name: 'employee_name') required String employeeName,
    required String company,
    @JsonKey(name: 'posting_date') required String postingDate,
    required String status,
    @JsonKey(name: 'net_pay') required double netPay,
    @JsonKey(name: 'start_date') required String startDate,
    @JsonKey(name: 'end_date') required String endDate,
  }) = _PayslipModel;

  const PayslipModel._();

  factory PayslipModel.fromJson(Map<String, dynamic> json) =>
      _$PayslipModelFromJson(json);

  PayslipEntity toEntity() {
    return PayslipEntity(
      name: name,
      employee: employee,
      employeeName: employeeName,
      company: company,
      postingDate: postingDate,
      status: status,
      netPay: netPay,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
