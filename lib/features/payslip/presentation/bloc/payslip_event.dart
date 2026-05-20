import 'package:freezed_annotation/freezed_annotation.dart';

part 'payslip_event.freezed.dart';

@freezed
class PayslipEvent with _$PayslipEvent {
  const factory PayslipEvent.fetchPayslips({
    required String employeeId,
    @Default(0) int start,
    @Default(50) int limit,
  }) = FetchPayslips;

  const factory PayslipEvent.fetchPayslipDetail({
    required String name,
  }) = FetchPayslipDetail;
}
