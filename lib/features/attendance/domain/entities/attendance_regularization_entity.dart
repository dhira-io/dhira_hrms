import 'package:equatable/equatable.dart';

class AttendanceRegularizationEntity extends Equatable {
  final DateTime date;
  final String requestType;
  final String requestedInTime;
  final String requestedOutTime;
  final bool routeToHR;
  final String reason;
  final List<String>? supportingDocuments;

  const AttendanceRegularizationEntity({
    required this.date,
    required this.requestType,
    required this.requestedInTime,
    required this.requestedOutTime,
    required this.routeToHR,
    required this.reason,
    this.supportingDocuments,
  });

  @override
  List<Object?> get props => [
        date,
        requestType,
        requestedInTime,
        requestedOutTime,
        routeToHR,
        reason,
        supportingDocuments,
      ];
}
