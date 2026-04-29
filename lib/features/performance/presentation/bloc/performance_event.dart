import 'package:freezed_annotation/freezed_annotation.dart';

part 'performance_event.freezed.dart';

@freezed
abstract class PerformanceEvent with _$PerformanceEvent {
  const factory PerformanceEvent.started() = PerformanceStarted;
  const factory PerformanceEvent.fetchRequested(String employeeId) = PerformanceFetchRequested;
}
