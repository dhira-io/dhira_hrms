// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/payslip_entities.dart';

part 'payslip_detail_model.freezed.dart';
part 'payslip_detail_model.g.dart';

@freezed
class SalaryComponentModel with _$SalaryComponentModel {
  const factory SalaryComponentModel({
    @JsonKey(name: 'salary_component') required String component,
    required double amount,
  }) = _SalaryComponentModel;

  const SalaryComponentModel._();

  factory SalaryComponentModel.fromJson(Map<String, dynamic> json) =>
      _$SalaryComponentModelFromJson(json);

  SalaryComponentEntity toEntity() {
    return SalaryComponentEntity(
      component: component,
      amount: amount,
    );
  }
}

@freezed
class PayslipDetailModel with _$PayslipDetailModel {
  const factory PayslipDetailModel({
    required String name,
    required String employee,
    @JsonKey(name: 'employee_name') required String employeeName,
    required String company,
    @JsonKey(name: 'posting_date') required String postingDate,
    required String status,
    @JsonKey(name: 'net_pay') required double netPay,
    @JsonKey(name: 'start_date') required String startDate,
    @JsonKey(name: 'end_date') required String endDate,
    @Default('') String designation,
    @Default('') String branch,
    @JsonKey(name: 'bank_name') @Default('') String bankName,
    @JsonKey(name: 'bank_account_no') @Default('') String bankAccountNo,
    @JsonKey(name: 'custom_pan_number') @Default('') String panNumber,
    @JsonKey(name: 'custom_pf_number') @Default('') String pfNumber,
    @JsonKey(name: 'total_working_days') @Default(0.0) double workingDays,
    @JsonKey(name: 'payment_days') @Default(0.0) double presentDays,
    @JsonKey(name: 'absent_days') @Default(0.0) double absentDays,
    @JsonKey(name: 'leave_without_pay') @Default(0.0) double leaves,
    @Default([]) List<SalaryComponentModel> earnings,
    @Default([]) List<SalaryComponentModel> deductions,
    @JsonKey(name: 'gross_pay') @Default(0.0) double totalEarnings,
    @JsonKey(name: 'total_deduction') @Default(0.0) double totalDeductions,
    @JsonKey(name: 'annual_taxable_amount') @Default(0.0) double annualTaxableIncome,
    @JsonKey(name: 'standard_tax_exemption_amount') @Default(0.0) double standardDeduction,
    @JsonKey(name: 'total_income_tax') @Default(0.0) double totalIncomeTax,
    @JsonKey(name: 'total_in_words') @Default('') String totalInWords,
  }) = _PayslipDetailModel;

  const PayslipDetailModel._();

  factory PayslipDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PayslipDetailModelFromJson(json);

  PayslipDetailEntity toEntity() {
    return PayslipDetailEntity(
      name: name,
      employee: employee,
      employeeName: employeeName,
      company: company,
      postingDate: postingDate,
      status: status,
      netPay: netPay,
      startDate: startDate,
      endDate: endDate,
      designation: designation,
      branch: branch,
      bankName: bankName,
      bankAccountNo: bankAccountNo,
      panNumber: panNumber,
      pfNumber: pfNumber,
      workingDays: workingDays,
      presentDays: presentDays,
      absentDays: absentDays,
      leaves: leaves,
      earnings: earnings.map((e) => e.toEntity()).toList(),
      deductions: deductions.map((e) => e.toEntity()).toList(),
      totalEarnings: totalEarnings,
      totalDeductions: totalDeductions,
      annualTaxableIncome: annualTaxableIncome,
      standardDeduction: standardDeduction,
      totalIncomeTax: totalIncomeTax,
      totalInWords: totalInWords,
    );
  }
}
