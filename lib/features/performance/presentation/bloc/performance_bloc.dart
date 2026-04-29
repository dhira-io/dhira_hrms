import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../domain/usecases/get_performance_summary_usecase.dart';
import 'performance_event.dart';
import 'performance_state.dart';

class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState> {
  final GetPerformanceSummaryUseCase getPerformanceSummaryUseCase;
  final LocalStorageService localStorageService;

  PerformanceBloc({
    required this.getPerformanceSummaryUseCase,
    required this.localStorageService,
  }) : super(const PerformanceState.initial()) {
    on<PerformanceStarted>(_onStarted);
    on<PerformanceFetchRequested>(_onFetchRequested);
  }

  Future<void> _onStarted(
    PerformanceStarted event,
    Emitter<PerformanceState> emit,
  ) async {
    final employeeId = localStorageService.getEmpId() ?? '';
    if (employeeId.isNotEmpty) {
      add(PerformanceFetchRequested(employeeId));
    } else {
      emit(const PerformanceState.error(errorMessage: 'Employee ID not found'));
    }
  }

  Future<void> _onFetchRequested(
    PerformanceFetchRequested event,
    Emitter<PerformanceState> emit,
  ) async {
    emit(const PerformanceState.loading());
    final result = await getPerformanceSummaryUseCase(event.employeeId);
    result.fold(
      (failure) => emit(PerformanceState.error(errorMessage: failure.message)),
      (summary) => emit(PerformanceState.loaded(summary: summary)),
    );
  }
}
