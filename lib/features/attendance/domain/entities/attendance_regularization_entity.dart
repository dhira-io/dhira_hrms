import 'package:equatable/equatable.dart';

class AttendanceRegularizationEntity extends Equatable {
  final DateTime date;
  final String employee;
  final String requestType;
  final String requestedInTime;
  final String requestedOutTime;
  final bool routeToHR;
  final String reason;
  final String? supportingDocument;

  const AttendanceRegularizationEntity({
    required this.date,
    required this.employee,
    required this.requestType,
    required this.requestedInTime,
    required this.requestedOutTime,
    required this.routeToHR,
    required this.reason,
    this.supportingDocument,
  });

  @override
  List<Object?> get props => [
        date,
        employee,
        requestType,
        requestedInTime,
        requestedOutTime,
        routeToHR,
        reason,
        supportingDocument,
      ];
}
