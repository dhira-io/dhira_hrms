import 'package:dhira_hrms/features/performance/domain/entities/kra_entity.dart';
import 'package:dhira_hrms/features/performance/domain/entities/kpi_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'performance_event.freezed.dart';

@freezed
abstract class PerformanceEvent with _$PerformanceEvent {
  const factory PerformanceEvent.started() = PerformanceStarted;
  const factory PerformanceEvent.fetchRequested(String employeeId) =
      PerformanceFetchRequested;
  const factory PerformanceEvent.kraUpdated({
    required KraEntity oldKra,
    required String newName,
    required double newWeightage,
  }) = PerformanceKraUpdated;
  const factory PerformanceEvent.kraDeleted(KraEntity kra) =
      PerformanceKraDeleted;
  const factory PerformanceEvent.kraCreated({
    required String name,
    required double weightage,
  }) = PerformanceKraCreated;
  const factory PerformanceEvent.kpiUpdated({
    required KpiEntity oldKpi,
    required double newWeightage,
  }) = PerformanceKpiUpdated;
  const factory PerformanceEvent.kpiDeleted(KpiEntity kpi) =
      PerformanceKpiDeleted;
  const factory PerformanceEvent.kpiCreated({
    required String title,
    required double weightage,
    required String kra,
  }) = PerformanceKpiCreated;
  const factory PerformanceEvent.goalSaved({
    required AppLocalizations l10n,
  }) = PerformanceGoalSaved;
  const factory PerformanceEvent.goalSubmitted({
    required AppLocalizations l10n,
  }) = PerformanceGoalSubmitted;
}
