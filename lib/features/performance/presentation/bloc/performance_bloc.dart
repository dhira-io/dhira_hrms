import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/performance/domain/entities/kpi_entity.dart';
import 'package:dhira_hrms/features/performance/domain/entities/kra_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../domain/entities/pms_cycle_entity.dart';
import '../../domain/entities/goal_entity.dart';
import '../../domain/usecases/get_job_family_usecase.dart';
import '../../domain/usecases/get_active_pms_cycle_usecase.dart';
import '../../domain/usecases/get_pms_goals_usecase.dart';
import '../../domain/usecases/get_goal_details_usecase.dart';
import '../../domain/usecases/update_goal_usecase.dart';
import 'performance_event.dart';
import 'performance_state.dart';

class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState> {
  final GetJobFamilyUseCase getJobFamilyUseCase;
  final GetActivePmsCycleUseCase getActivePmsCycleUseCase;
  final GetPmsGoalsUseCase getPmsGoalsUseCase;
  final GetGoalDetailsUseCase getGoalDetailsUseCase;
  final UpdateGoalUseCase updateGoalUseCase;
  final LocalStorageService localStorageService;

  PerformanceBloc({
    required this.getJobFamilyUseCase,
    required this.getActivePmsCycleUseCase,
    required this.getPmsGoalsUseCase,
    required this.getGoalDetailsUseCase,
    required this.updateGoalUseCase,
    required this.localStorageService,
  }) : super(const PerformanceState.initial()) {
    on<PerformanceStarted>(_onStarted);
    on<PerformanceFetchRequested>(_onFetchRequested);
    on<PerformanceKraUpdated>(_onKraUpdated);
    on<PerformanceKraDeleted>(_onKraDeleted);
    on<PerformanceKpiUpdated>(_onKpiUpdated);
    on<PerformanceKpiDeleted>(_onKpiDeleted);
    on<PerformanceKraCreated>(_onKraCreated);
    on<PerformanceKpiCreated>(_onKpiCreated);
    on<PerformanceGoalSaved>(_onGoalSaved);
    on<PerformanceGoalSubmitted>(_onGoalSubmitted);
  }

  Future<void> _onKpiUpdated(
    PerformanceKpiUpdated event,
    Emitter<PerformanceState> emit,
  ) async {
    if (state.selectedGoal != null) {
      final updatedKpis = state.selectedGoal!.kpis.map((kpi) {
        if (kpi == event.oldKpi) {
          return kpi.copyWith(weightage: event.newWeightage);
        }
        return kpi;
      }).toList();

      final updatedGoal = state.selectedGoal!.copyWith(kpis: updatedKpis);
      emit(state.copyWith(selectedGoal: updatedGoal));
    }
  }

  Future<void> _onKpiDeleted(
    PerformanceKpiDeleted event,
    Emitter<PerformanceState> emit,
  ) async {
    if (state.selectedGoal != null) {
      final updatedKpis = state.selectedGoal!.kpis
          .where((kpi) => kpi.name != event.kpi.name)
          .toList();

      final updatedGoal = state.selectedGoal!.copyWith(kpis: updatedKpis);
      emit(state.copyWith(selectedGoal: updatedGoal));
    }
  }

  Future<void> _onKraUpdated(
    PerformanceKraUpdated event,
    Emitter<PerformanceState> emit,
  ) async {
    if (state.selectedGoal != null) {
      // Update the KRA itself in the kras list (for consistency)
      final updatedKras = state.selectedGoal!.kras.map((kra) {
        if (kra.name == event.oldKra.name) {
          return kra.copyWith(
            name: event.newName,
            weightage: event.newWeightage,
          );
        }
        return kra;
      }).toList();

      // Update all KPIs belonging to this KRA with the new name
      final updatedKpis = state.selectedGoal!.kpis.map((kpi) {
        if (kpi.kra == event.oldKra.name) {
          return kpi.copyWith(kra: event.newName);
        }
        return kpi;
      }).toList();

      final updatedGoal = state.selectedGoal!.copyWith(
        kras: updatedKras,
        kpis: updatedKpis,
      );

      emit(state.copyWith(selectedGoal: updatedGoal));
    }
  }

  Future<void> _onKraDeleted(
    PerformanceKraDeleted event,
    Emitter<PerformanceState> emit,
  ) async {
    if (state.selectedGoal != null) {
      final updatedKras = state.selectedGoal!.kras
          .where((kra) => kra.name != event.kra.name)
          .toList();

      // Also delete all KPIs belonging to this KRA
      final updatedKpis = state.selectedGoal!.kpis
          .where((kpi) => kpi.kra != event.kra.name)
          .toList();

      final updatedGoal = state.selectedGoal!.copyWith(
        kras: updatedKras,
        kpis: updatedKpis,
      );

      emit(state.copyWith(selectedGoal: updatedGoal));
    }
  }

  Future<void> _onKraCreated(
    PerformanceKraCreated event,
    Emitter<PerformanceState> emit,
  ) async {
    if (state.selectedGoal != null) {
      final newKra = KraEntity(name: event.name, weightage: event.weightage);
      final updatedKras = [...state.selectedGoal!.kras, newKra];
      final updatedGoal = state.selectedGoal!.copyWith(kras: updatedKras);
      emit(state.copyWith(selectedGoal: updatedGoal));
    }
  }

  Future<void> _onKpiCreated(
    PerformanceKpiCreated event,
    Emitter<PerformanceState> emit,
  ) async {
    if (state.selectedGoal != null) {
      final newKpi = KpiEntity(
        name: DateTime.now().millisecondsSinceEpoch.toString(),
        title: event.title,
        weightage: event.weightage,
        kra: event.kra,
      );
      final updatedKpis = [...state.selectedGoal!.kpis, newKpi];
      final updatedGoal = state.selectedGoal!.copyWith(kpis: updatedKpis);
      emit(state.copyWith(selectedGoal: updatedGoal));
    }
  }

  Future<void> _onStarted(
    PerformanceStarted event,
    Emitter<PerformanceState> emit,
  ) async {
    final employeeId = localStorageService.getEmpId() ?? '';
    if (employeeId.isNotEmpty) {
      emit(
        PerformanceState.loading(
          jobFamily: state.jobFamily,
          pmsCycle: state.pmsCycle,
          pmsCycleId: state.pmsCycleId,
          goals: state.goals,
          selectedGoal: state.selectedGoal,
        ),
      );

      // Fetch job family and pms cycle in parallel
      final results = await Future.wait([
        getJobFamilyUseCase(employeeId),
        getActivePmsCycleUseCase(),
      ]);

      final jobFamilyResult = results[0] as Either<Failure, String?>;
      final pmsCycleResult = results[1] as Either<Failure, PmsCycleEntity?>;

      String? jobFamily;
      jobFamilyResult.fold((l) => null, (r) => jobFamily = r);

      PmsCycleEntity? pmsCycle;
      pmsCycleResult.fold((l) => null, (r) => pmsCycle = r);

      List<GoalEntity> goals = [];
      GoalEntity? selectedGoal;

      if (pmsCycle != null) {
        final goalsResult = await getPmsGoalsUseCase(
          employeeId,
          pmsCycle!.name,
        );
        await goalsResult.fold((l) async => null, (r) async {
          goals = r;
          if (goals.isNotEmpty) {
            // Fetch details for the first goal
            final detailsResult = await getGoalDetailsUseCase(goals.first.name);
            detailsResult.fold((l) => null, (r) => selectedGoal = r);
          }
        });
      }

      emit(
        PerformanceState.loaded(
          jobFamily: jobFamily,
          pmsCycle: pmsCycle?.cycleName,
          pmsCycleId: pmsCycle?.name,
          goals: goals,
          selectedGoal: selectedGoal,
        ),
      );
    } else {
      emit(const PerformanceState.error(errorMessage: 'Employee ID not found'));
    }
  }

  Future<void> _onFetchRequested(
    PerformanceFetchRequested event,
    Emitter<PerformanceState> emit,
  ) async {
    add(const PerformanceStarted());
  }

  Future<void> _onGoalSaved(
    PerformanceGoalSaved event,
    Emitter<PerformanceState> emit,
  ) async {
    if (state.selectedGoal == null) return;

    final goal = state.selectedGoal!;
    final l10n = event.l10n;

    // 0. Validation: KRA count must be between 3 and 10
    final kraCount = goal.kras.length;
    if (kraCount < 3 || kraCount > 10) {
      ToastUtils.showError(
        l10n.kraCountError(kraCount.toString()),
      );
      return;
    }

    // 1. Validation: Sum of all KRA weightages must be 100
    final totalKraWeightage = goal.kras.fold(
      0.0,
      (sum, kra) => sum + kra.weightage,
    );
    if (totalKraWeightage != 100) {
      ToastUtils.showError(
        l10n.totalKraWeightageError(totalKraWeightage.toInt().toString()),
      );
      return;
    }

    // 2. Validation: Sum of KPI weightages for each KRA must match KRA weightage
    for (var kra in goal.kras) {
      final kpiSum = goal.kpis
          .where((kpi) => kpi.kra == kra.name)
          .fold(0.0, (sum, kpi) => sum + kpi.weightage);

      if (kra.weightage != kpiSum) {
        ToastUtils.showError(
          l10n.kpiWeightageMismatchError(
            kpiSum.toInt().toString(),
            kra.name,
            kra.weightage.toInt().toString(),
          ),
        );
        return;
      }
    }

    emit(
      PerformanceState.saving(
        jobFamily: state.jobFamily,
        pmsCycle: state.pmsCycle,
        pmsCycleId: state.pmsCycleId,
        goals: state.goals,
        selectedGoal: state.selectedGoal,
      ),
    );

    final result = await updateGoalUseCase(goal);

    result.fold(
      (failure) {
        emit(
          PerformanceState.loaded(
            jobFamily: state.jobFamily,
            pmsCycle: state.pmsCycle,
            pmsCycleId: state.pmsCycleId,
            goals: state.goals,
            selectedGoal: state.selectedGoal,
            errorMessage: failure.message,
          ),
        );
        ToastUtils.showError(failure.message);
      },
      (updatedGoal) {
        emit(
          PerformanceState.loaded(
            jobFamily: state.jobFamily,
            pmsCycle: state.pmsCycle,
            pmsCycleId: state.pmsCycleId,
            goals: state.goals,
            selectedGoal: updatedGoal,
          ),
        );
        ToastUtils.showSuccess(l10n.goalSavedSuccess(updatedGoal.status));
      },
    );
  }

  Future<void> _onGoalSubmitted(
    PerformanceGoalSubmitted event,
    Emitter<PerformanceState> emit,
  ) async {
    if (state.selectedGoal == null) return;

    final goal = state.selectedGoal!;
    final l10n = event.l10n;

    // Reuse validations from Save
    // 0. Validation: KRA count must be between 3 and 10
    final kraCount = goal.kras.length;
    if (kraCount < 3 || kraCount > 10) {
      ToastUtils.showError(
        l10n.kraCountError(kraCount.toString()),
      );
      return;
    }

    // 1. Validation: Sum of all KRA weightages must be 100
    final totalKraWeightage = goal.kras.fold(
      0.0,
      (sum, kra) => sum + kra.weightage,
    );
    if (totalKraWeightage != 100) {
      ToastUtils.showError(
        l10n.totalKraWeightageError(totalKraWeightage.toInt().toString()),
      );
      return;
    }

    // 2. Validation: Sum of KPI weightages for each KRA must match KRA weightage
    for (var kra in goal.kras) {
      final kpiSum = goal.kpis
          .where((kpi) => kpi.kra == kra.name)
          .fold(0.0, (sum, kpi) => sum + kpi.weightage);

      if (kra.weightage != kpiSum) {
        ToastUtils.showError(
          l10n.kpiWeightageMismatchError(
            kpiSum.toInt().toString(),
            kra.name,
            kra.weightage.toInt().toString(),
          ),
        );
        return;
      }
    }

    emit(
      PerformanceState.submitting(
        jobFamily: state.jobFamily,
        pmsCycle: state.pmsCycle,
        pmsCycleId: state.pmsCycleId,
        goals: state.goals,
        selectedGoal: state.selectedGoal,
      ),
    );

    // Update status to Submitted
    final submittedGoal = goal.copyWith(status: PerformanceStatus.submitted);

    final result = await updateGoalUseCase(submittedGoal);

    result.fold(
      (failure) {
        emit(
          PerformanceState.loaded(
            jobFamily: state.jobFamily,
            pmsCycle: state.pmsCycle,
            pmsCycleId: state.pmsCycleId,
            goals: state.goals,
            selectedGoal: state.selectedGoal,
            errorMessage: failure.message,
          ),
        );
        ToastUtils.showError(failure.message);
      },
      (updatedGoal) {
        emit(
          PerformanceState.loaded(
            jobFamily: state.jobFamily,
            pmsCycle: state.pmsCycle,
            pmsCycleId: state.pmsCycleId,
            goals: state.goals,
            selectedGoal: updatedGoal,
          ),
        );
        ToastUtils.showSuccess(l10n.goalSavedSuccess(updatedGoal.status));
        add(const PerformanceStarted());
      },
    );
  }
}
