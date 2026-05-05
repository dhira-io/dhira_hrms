import 'package:dhira_hrms/features/performance/domain/entities/kpi_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/constants/app_constants.dart';
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
    String? errorMessage,
    @Default(false) bool isManager,
  }) = PerformanceInitial;

  const factory PerformanceState.loading({
    String? jobFamily,
    String? pmsCycle,
    String? pmsCycleId,
    @Default([]) List<GoalEntity> goals,
    GoalEntity? selectedGoal,
    String? errorMessage,
    @Default(false) bool isManager,
  }) = PerformanceLoading;

  const factory PerformanceState.loaded({
    String? jobFamily,
    String? pmsCycle,
    String? pmsCycleId,
    @Default([]) List<GoalEntity> goals,
    GoalEntity? selectedGoal,
    String? errorMessage,
    @Default(false) bool isManager,
  }) = PerformanceLoaded;

  const factory PerformanceState.saving({
    String? jobFamily,
    String? pmsCycle,
    String? pmsCycleId,
    @Default([]) List<GoalEntity> goals,
    GoalEntity? selectedGoal,
    String? errorMessage,
    @Default(false) bool isManager,
  }) = PerformanceSaving;

  const factory PerformanceState.submitting({
    String? jobFamily,
    String? pmsCycle,
    String? pmsCycleId,
    @Default([]) List<GoalEntity> goals,
    GoalEntity? selectedGoal,
    String? errorMessage,
    @Default(false) bool isManager,
  }) = PerformanceSubmitting;

  const factory PerformanceState.error({
    String? jobFamily,
    String? pmsCycle,
    String? pmsCycleId,
    @Default([]) List<GoalEntity> goals,
    GoalEntity? selectedGoal,
    required String errorMessage,
    @Default(false) bool isManager,
  }) = PerformanceError;

  const PerformanceState._();

  bool get isLoading => this is PerformanceLoading;
  bool get isSaving => this is PerformanceSaving;
  bool get isSubmitting => this is PerformanceSubmitting;
  bool get isEditable => selectedGoal?.status == PerformanceStatus.draft;

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
