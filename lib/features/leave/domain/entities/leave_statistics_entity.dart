import 'package:equatable/equatable.dart';

class LeaveStatisticsEntity extends Equatable {
  final bool success;
  final String employee;
  final String employeeName;
  final LeavePeriodEntity period;
  final LeaveStatsEntity statistics;
  final LeaveDetailsEntity details;

  const LeaveStatisticsEntity({
    required this.success,
    required this.employee,
    required this.employeeName,
    required this.period,
    required this.statistics,
    required this.details,
  });

  @override
  List<Object?> get props => [success, employee, employeeName, period, statistics, details];
}

class LeavePeriodEntity extends Equatable {
  final String fromDate;
  final String toDate;

  const LeavePeriodEntity({
    required this.fromDate,
    required this.toDate,
  });

  @override
  List<Object?> get props => [fromDate, toDate];
}

class LeaveStatsEntity extends Equatable {
  final double appliedDays;
  final double approvedDays;
  final double pendingDays;
  final double cancelledDays;
  final int totalApplications;

  const LeaveStatsEntity({
    required this.appliedDays,
    required this.approvedDays,
    required this.pendingDays,
    required this.cancelledDays,
    required this.totalApplications,
  });

  @override
  List<Object?> get props => [appliedDays, approvedDays, pendingDays, cancelledDays, totalApplications];
}

class LeaveDetailsEntity extends Equatable {
  final List<dynamic> appliedLeaves;
  final List<dynamic> approvedLeaves;
  final List<dynamic> pendingLeaves;
  final List<dynamic> cancelledLeaves;

  const LeaveDetailsEntity({
    required this.appliedLeaves,
    required this.approvedLeaves,
    required this.pendingLeaves,
    required this.cancelledLeaves,
  });

  @override
  List<Object?> get props => [appliedLeaves, approvedLeaves, pendingLeaves, cancelledLeaves];
}
