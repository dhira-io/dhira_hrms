import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../l10n/app_localizations.dart';

part 'payslip_event.freezed.dart';

@freezed
class PayslipEvent with _$PayslipEvent {
  const factory PayslipEvent.fetchPayslips({
    @Default(0) int start,
    @Default(20) int limit,
  }) = FetchPayslips;

  const factory PayslipEvent.fetchPayslipDetail({
    required String name,
  }) = FetchPayslipDetail;

  const factory PayslipEvent.downloadPayslipPdf({
    required String name,
    required AppLocalizations l10n,
  }) = DownloadPayslipPdf;

  const factory PayslipEvent.updateFilter({
    String? selectedYear,
    String? selectedMonth,
  }) = UpdateFilter;
}
