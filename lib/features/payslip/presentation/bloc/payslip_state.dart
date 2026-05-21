import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/payslip_entities.dart';

part 'payslip_state.freezed.dart';

@freezed
class PayslipState with _$PayslipState {
  const PayslipState._();

  const factory PayslipState({
    @Default([]) List<PayslipEntity> payslips,
    PayslipDetailEntity? detail,
    @Default(false) bool isListLoading,
    @Default(false) bool isDetailLoading,
    String? listError,
    String? detailError,
    String? selectedYear,
    String? selectedMonth,
  }) = _PayslipState;

  List<String> get years {
    final years = payslips
        .map((p) => p.startDate.substring(0, 4))
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));
    return years;
  }

  List<String> get months {
    return payslips
        .where((p) => selectedYear == null || p.startDate.startsWith(selectedYear!))
        .map((p) {
          final date = DateTime.tryParse(p.startDate);
          return date != null ? DateTimeUtils.formatToMonthAbbr(date) : '';
        })
        .where((m) => m.isNotEmpty)
        .toSet()
        .toList();
  }

  List<PayslipEntity> get filteredPayslips {
    return payslips.where((p) {
      final date = DateTime.tryParse(p.startDate);
      if (date == null) return false;
      final yearMatch = selectedYear == null || p.startDate.startsWith(selectedYear!);
      final monthMatch = selectedMonth == null || DateTimeUtils.formatToMonthAbbr(date) == selectedMonth;
      return yearMatch && monthMatch;
    }).toList();
  }

  double get ytdTotal {
    final now = DateTime.now();
    return payslips
        .where((p) {
          final d = DateTime.tryParse(p.startDate);
          return d != null && d.year == now.year;
        })
        .fold(0.0, (sum, p) => sum + p.netPay);
  }
}
