import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../domain/usecases/get_timesheets_usecase.dart';
import '../../domain/usecases/get_single_timesheet_usecase.dart';
import '../../domain/usecases/get_projects_usecase.dart';
import '../../domain/usecases/create_timesheet_usecase.dart';
import '../../domain/usecases/update_timesheet_usecase.dart';
import 'timesheet_event.dart';
import 'timesheet_state.dart';

class TimesheetBloc extends Bloc<TimesheetEvent, TimesheetState> {
  final GetTimesheetsUseCase getTimesheetsUseCase;
  final GetSingleTimesheetUseCase getSingleTimesheetUseCase;
  final GetProjectsUseCase getProjectsUseCase;
  final CreateTimesheetUseCase createTimesheetUseCase;
  final UpdateTimesheetUseCase updateTimesheetUseCase;

  int _start = 0;
  final int _limit = 10;
  String? _currentEmployeeId;

  TimesheetBloc({
    required this.getTimesheetsUseCase,
    required this.getSingleTimesheetUseCase,
    required this.getProjectsUseCase,
    required this.createTimesheetUseCase,
    required this.updateTimesheetUseCase,
  }) : super(const TimesheetState.initial()) {
    on<TimesheetEvent>((event, emit) async {
      await event.when(
        started: (id) => _onStarted(id, emit),
        loadMoreRequested: (id) => _onLoadMoreRequested(id, emit),
        fetchDetailsRequested: (id) => _onFetchDetailsRequested(id, emit),
        submitRequested: (emp, dept, app, from, to, assignments) => 
            _onSubmitRequested(emp, dept, app, from, to, assignments, emit),
        updateRequested: (name, emp, dept, app, approved, total, assignments) => 
            _onUpdateRequested(name, emp, dept, app, approved, total, assignments, emit),
      );
    });
  }

  Future<void> _onStarted(String id, Emitter<TimesheetState> emit) async {
    emit(const TimesheetState.loading());
    _currentEmployeeId = id;
    _start = 0;
    final result = await getTimesheetsUseCase(start: _start, limit: _limit);
    result.fold(
      (failure) => emit(TimesheetState.error(failure.message)),
      (timesheets) {
        _start += timesheets.length;
        emit(TimesheetState.loaded(
          timesheets: timesheets,
          hasMore: timesheets.length == _limit,
        ));
      },
    );
  }

  Future<void> _onLoadMoreRequested(String id, Emitter<TimesheetState> emit) async {
    _currentEmployeeId = id;
    await state.maybeMap(
      loaded: (currentState) async {
        if (currentState.isFetchingMore || !currentState.hasMore) return;

        emit(currentState.copyWith(isFetchingMore: true));
        final result = await getTimesheetsUseCase(start: _start, limit: _limit);
        result.fold(
          (failure) => emit(TimesheetState.error(failure.message)),
          (newTimesheets) {
            _start += newTimesheets.length;
            emit(currentState.copyWith(
              timesheets: [...currentState.timesheets, ...newTimesheets],
              isFetchingMore: false,
              hasMore: newTimesheets.length == _limit,
            ));
          },
        );
      },
      orElse: () async {},
    );
  }

  Future<void> _onFetchDetailsRequested(String timesheetId, Emitter<TimesheetState> emit) async {
    emit(const TimesheetState.loading());
    final detailsResult = await getSingleTimesheetUseCase(timesheetId);
    final projectsResult = await getProjectsUseCase();

    detailsResult.fold(
      (failure) => emit(TimesheetState.error(failure.message)),
      (timesheet) {
        projectsResult.fold(
          (failure) => emit(TimesheetState.error(failure.message)),
          (projects) => emit(TimesheetState.detailLoaded(timesheet: timesheet, projects: projects)),
        );
      },
    );
  }

  Future<void> _onSubmitRequested(
    String employee,
    String department,
    String approver,
    String fromDate,
    String toDate,
    List<ProjectAssignmentEntity> assignments,
    Emitter<TimesheetState> emit
  ) async {
    emit(const TimesheetState.loading());
    final result = await createTimesheetUseCase(
      employee: employee,
      department: department,
      approver: approver,
      fromDate: fromDate,
      toDate: toDate,
      assignments: assignments,
    );
    result.fold(
      (failure) => emit(TimesheetState.error(failure.message)),
      (success) {
        if (success) {
          emit(const TimesheetState.success("Timesheet created successfully"));
          if (_currentEmployeeId != null) {
            add(TimesheetEvent.started(_currentEmployeeId!));
          }
        } else {
          emit(const TimesheetState.error("Submission failed"));
        }
      },
    );
  }

  Future<void> _onUpdateRequested(
    String name,
    String employee,
    String department,
    String approver,
    int approved,
    double hoursTotal,
    List<ProjectAssignmentEntity> assignments,
    Emitter<TimesheetState> emit
  ) async {
    emit(const TimesheetState.loading());
    final result = await updateTimesheetUseCase(
      name: name,
      employee: employee,
      department: department,
      approver: approver,
      approved: approved,
      hoursTotal: hoursTotal,
      assignments: assignments,
    );
    result.fold(
      (failure) => emit(TimesheetState.error(failure.message)),
      (success) {
        if (success) {
          emit(const TimesheetState.success("Timesheet updated successfully"));
          if (_currentEmployeeId != null) {
            add(TimesheetEvent.started(_currentEmployeeId!));
          }
        } else {
          emit(const TimesheetState.error("Update failed"));
        }
      },
    );
  }
}
