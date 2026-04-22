import 'package:equatable/equatable.dart';

class DashboardStatsEntity extends Equatable {
  final int daysPresent;
  final double leaveBalance;
  final String nextHoliday;
  final String nextHolidayDate;

  const DashboardStatsEntity({
    required this.daysPresent,
    required this.leaveBalance,
    required this.nextHoliday,
    required this.nextHolidayDate,
  });

  @override
  List<Object?> get props => [
        daysPresent,
        leaveBalance,
        nextHoliday,
        nextHolidayDate,
      ];
}
