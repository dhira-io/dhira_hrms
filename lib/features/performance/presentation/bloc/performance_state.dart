import 'package:dhira_hrms/features/performance/domain/entities/kpi_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/goal_entity.dart';

part 'performance_state.freezed.dart';

@freezed
abstract class PerformanceState with _$PerformanceState {
  const factory PerformanceState.initial({
    String? jobFamily,
    String? pmsCycle,
    String? pmsCycleId,
    @Default([]) List<GoalEntity> goals,
    GoalEntity? selectedGoal,
    @Default(false) bool isLoading,
    @Default(false) bool isActionLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isSubmitting,
    String? errorMessage,
  }) = PerformanceInitial;

  const factory PerformanceState.loading({
    String? jobFamily,
    String? pmsCycle,
    String? pmsCycleId,
    @Default([]) List<GoalEntity> goals,
    GoalEntity? selectedGoal,
    @Default(true) bool isLoading,
    @Default(false) bool isActionLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isSubmitting,
    String? errorMessage,
  }) = PerformanceLoading;

  const factory PerformanceState.loaded({
    String? jobFamily,
    String? pmsCycle,
    String? pmsCycleId,
    @Default([]) List<GoalEntity> goals,
    GoalEntity? selectedGoal,
    @Default(false) bool isLoading,
    @Default(false) bool isActionLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isSubmitting,
    String? errorMessage,
  }) = PerformanceLoaded;

  const factory PerformanceState.error({
    String? jobFamily,
    String? pmsCycle,
    String? pmsCycleId,
    @Default([]) List<GoalEntity> goals,
    GoalEntity? selectedGoal,
    @Default(false) bool isLoading,
    @Default(false) bool isActionLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isSubmitting,
    required String errorMessage,
  }) = PerformanceError;

  const PerformanceState._();

  double get totalWeightage {
    if (selectedGoal == null) return 0.0;
    return selectedGoal!.kras.fold(0.0, (sum, kra) => sum + kra.weightage);
  }

  double get totalProgress {
    return (totalWeightage / 100.0).clamp(0.0, 1.0);
  }

  Map<String, double> get kraWeightages {
    if (selectedGoal == null) return {};
    return {for (var kra in selectedGoal!.kras) kra.name: kra.weightage};
  }

  Map<String, List<KpiEntity>> get kraGroups {
    if (selectedGoal == null) return {};
    final Map<String, List<KpiEntity>> groups = {
      for (var kra in selectedGoal!.kras) kra.name: []
    };
    for (var kpi in selectedGoal!.kpis) {
      if (groups.containsKey(kpi.kra)) {
        groups[kpi.kra]!.add(kpi);
      }
    }
    return groups;
  }
}
