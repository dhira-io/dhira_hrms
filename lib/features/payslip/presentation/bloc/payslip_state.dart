import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/payslip_entities.dart';

part 'payslip_state.freezed.dart';

@freezed
class PayslipState with _$PayslipState {
  const factory PayslipState({
    @Default([]) List<PayslipEntity> payslips,
    PayslipDetailEntity? detail,
    @Default(false) bool isListLoading,
    @Default(false) bool isDetailLoading,
    String? listError,
    String? detailError,
  }) = _PayslipState;
}
