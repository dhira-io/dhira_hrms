import 'package:equatable/equatable.dart';

class PayslipEntity extends Equatable {
  final String name;
  final String employee;
  final String employeeName;
  final String company;
  final String postingDate;
  final String status;
  final double netPay;
  final String startDate;
  final String endDate;

  const PayslipEntity({
    required this.name,
    required this.employee,
    required this.employeeName,
    required this.company,
    required this.postingDate,
    required this.status,
    required this.netPay,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [
    name,
    employee,
    employeeName,
    company,
    postingDate,
    status,
    netPay,
    startDate,
    endDate,
  ];
}

class SalaryComponentEntity extends Equatable {
  final String component;
  final double amount;

  const SalaryComponentEntity({required this.component, required this.amount});

  @override
  List<Object?> get props => [component, amount];
}

class PayslipDetailEntity extends Equatable {
  final String name;
  final String employee;
  final String employeeName;
  final String company;
  final String postingDate;
  final String status;
  final double netPay;
  final String startDate;
  final String endDate;
  final String designation;
  final String branch;
  final String bankName;
  final String bankAccountNo;
  final String panNumber;
  final String pfNumber;
  final double workingDays;
  final double presentDays;
  final double absentDays;
  final double leaves;
  final List<SalaryComponentEntity> earnings;
  final List<SalaryComponentEntity> deductions;
  final double totalEarnings;
  final double totalDeductions;
  final double annualTaxableIncome;
  final double standardDeduction;
  final double totalIncomeTax;
  final String totalInWords;

  const PayslipDetailEntity({
    required this.name,
    required this.employee,
    required this.employeeName,
    required this.company,
    required this.postingDate,
    required this.status,
    required this.netPay,
    required this.startDate,
    required this.endDate,
    required this.designation,
    required this.branch,
    required this.bankName,
    required this.bankAccountNo,
    required this.panNumber,
    required this.pfNumber,
    required this.workingDays,
    required this.presentDays,
    required this.absentDays,
    required this.leaves,
    required this.earnings,
    required this.deductions,
    required this.totalEarnings,
    required this.totalDeductions,
    required this.annualTaxableIncome,
    required this.standardDeduction,
    required this.totalIncomeTax,
    required this.totalInWords,
  });

  @override
  List<Object?> get props => [
    name,
    employee,
    employeeName,
    company,
    postingDate,
    status,
    netPay,
    startDate,
    endDate,
    designation,
    branch,
    bankName,
    bankAccountNo,
    panNumber,
    pfNumber,
    workingDays,
    presentDays,
    absentDays,
    leaves,
    earnings,
    deductions,
    totalEarnings,
    totalDeductions,
    annualTaxableIncome,
    standardDeduction,
    totalIncomeTax,
    totalInWords,
  ];
}
