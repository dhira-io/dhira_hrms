import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../domain/usecases/get_timesheets_usecase.dart';
import '../../domain/usecases/get_single_timesheet_usecase.dart';
import '../../domain/usecases/get_projects_usecase.dart';
import '../../domain/usecases/create_timesheet_usecase.dart';
import '../../domain/usecases/update_timesheet_usecase.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import 'timesheet_event.dart';
import 'timesheet_state.dart';

class TimesheetBloc extends Bloc<TimesheetEvent, TimesheetState> {
  final GetTimesheetsUseCase getTimesheetsUseCase;
  final GetSingleTimesheetUseCase getSingleTimesheetUseCase;
  final GetProjectsUseCase getProjectsUseCase;
  final CreateTimesheetUseCase createTimesheetUseCase;
  final UpdateTimesheetUseCase updateTimesheetUseCase;
  final IAuthRepository authRepository;

  int _start = 0;
  final int _limit = 10;
  String? _currentEmployeeId;

  TimesheetBloc({
    required this.getTimesheetsUseCase,
    required this.getSingleTimesheetUseCase,
    required this.getProjectsUseCase,
    required this.createTimesheetUseCase,
    required this.updateTimesheetUseCase,
    required this.authRepository,
  }) : super(const TimesheetState.initial()) {
    on<TimesheetEvent>((event, emit) async {
      await event.map(
        started: (e) async => await _onStarted(e.id, emit),
        userInitRequested: (_) async => await _onUserInitRequested(emit),
        loadMoreRequested: (e) async => await _onLoadMoreRequested(e.id, emit),
        fetchDetailsRequested: (e) async => await _onFetchDetailsRequested(e.timesheetId, emit),
        fromDateChanged: (e) async => emit(state.copyWith(editFromDate: e.date)),
        toDateChanged: (e) async => emit(state.copyWith(editToDate: e.date)),
        assignmentsChanged: (e) async => emit(state.copyWith(editAssignments: e.assignments)),
        submitRequested: (e) async => await _onSubmitRequested(
          e.employee, e.department, e.approver, e.fromDate, e.toDate, e.assignments, emit),
        updateRequested: (e) async => await _onUpdateRequested(
          e.name, e.employee, e.department, e.approver, e.approved, e.hoursTotal, e.assignments, emit),
      );
    });
  }

  Future<void> _onUserInitRequested(Emitter<TimesheetState> emit) async {
    final userResult = await authRepository.getCurrentUser();
    final projectsResult = await getProjectsUseCase();

    final user = userResult.fold((_) => null, (u) => u);
    final projects = projectsResult.getOrElse(() => []);

    if (user != null) {
      if (state.editFromDate == null) {
        final now = DateTime.now();
        final from = now.subtract(Duration(days: now.weekday - DateTime.monday));
        final to = from.add(const Duration(days: 4));
        emit(state.copyWith(user: user, editFromDate: from, editToDate: to, projects: projects));
      } else {
        emit(state.copyWith(user: user, projects: projects));
      }
    } else {
      emit(state.copyWith(projects: projects));
    }
  }

  Future<void> _onStarted(String id, Emitter<TimesheetState> emit) async {
    emit(TimesheetState.loading(
      user: state.user,
      editFromDate: state.editFromDate,
      editToDate: state.editToDate,
      editAssignments: state.editAssignments,
      projects: state.projects,
    ));
    _currentEmployeeId = id;
    _start = 0;
    final result = await getTimesheetsUseCase(employee: id, start: _start, limit: _limit);
    result.fold(
      (failure) => emit(TimesheetState.error(
        message: failure.message, 
        user: state.user,
        editFromDate: state.editFromDate,
        editToDate: state.editToDate,
        editAssignments: state.editAssignments,
        projects: state.projects,
      )),
      (timesheets) {
        _start += timesheets.length;
        emit(TimesheetState.loaded(
          timesheets: timesheets,
          hasMore: timesheets.length == _limit,
          user: state.user,
          editFromDate: state.editFromDate,
          editToDate: state.editToDate,
          editAssignments: state.editAssignments,
          projects: state.projects,
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
        final result = await getTimesheetsUseCase(employee: id, start: _start, limit: _limit);
        result.fold(
          (failure) => emit(TimesheetState.error(
            message: failure.message, 
            user: state.user,
            editFromDate: state.editFromDate,
            editToDate: state.editToDate,
            editAssignments: state.editAssignments,
            projects: state.projects,
          )),
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
    emit(TimesheetState.loading(
      user: state.user,
      editFromDate: state.editFromDate,
      editToDate: state.editToDate,
      editAssignments: state.editAssignments,
      projects: state.projects,
    ));
    final detailsResult = await getSingleTimesheetUseCase(timesheetId);
    final projectsResult = await getProjectsUseCase();

    detailsResult.fold(
      (failure) => emit(TimesheetState.error(
        message: failure.message, 
        user: state.user,
        editFromDate: state.editFromDate,
        editToDate: state.editToDate,
        editAssignments: state.editAssignments,
        projects: state.projects,
      )),
      (timesheet) {
        projectsResult.fold(
          (failure) => emit(TimesheetState.error(
            message: failure.message, 
            user: state.user,
            editFromDate: state.editFromDate,
            editToDate: state.editToDate,
            editAssignments: state.editAssignments,
          )),
          (projects) => emit(TimesheetState.detailLoaded(
            timesheet: timesheet, 
            projects: projects, 
            user: state.user,
            editFromDate: DateTime.parse(timesheet.fromDate ?? DateTime.now().toIso8601String()),
            editToDate: DateTime.parse(timesheet.toDate ?? DateTime.now().toIso8601String()),
            editAssignments: List.from(timesheet.projectAssignments ?? []),
          )),
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
    emit(TimesheetState.loading(
      user: state.user,
      editFromDate: state.editFromDate,
      editToDate: state.editToDate,
      editAssignments: state.editAssignments,
      projects: state.projects,
    ));
    final result = await createTimesheetUseCase(
      employee: employee,
      department: department,
      approver: approver,
      fromDate: fromDate,
      toDate: toDate,
      assignments: assignments,
    );
    result.fold(
      (failure) => emit(TimesheetState.error(
        message: failure.message, 
        user: state.user,
        editFromDate: state.editFromDate,
        editToDate: state.editToDate,
        editAssignments: state.editAssignments,
        projects: state.projects,
      )),
      (success) {
        if (success) {
          emit(TimesheetState.success(
            message: "Timesheet created successfully", 
            user: state.user,
            editFromDate: state.editFromDate,
            editToDate: state.editToDate,
            editAssignments: state.editAssignments,
            projects: state.projects,
          ));
          if (_currentEmployeeId != null) {
            add(TimesheetEvent.started(_currentEmployeeId!));
          }
        } else {
          emit(TimesheetState.error(
            message: "Submission failed", 
            user: state.user,
            editFromDate: state.editFromDate,
            editToDate: state.editToDate,
            editAssignments: state.editAssignments,
            projects: state.projects,
          ));
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
    emit(TimesheetState.loading(
      user: state.user,
      editFromDate: state.editFromDate,
      editToDate: state.editToDate,
      editAssignments: state.editAssignments,
      projects: state.projects,
    ));
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
      (failure) => emit(TimesheetState.error(
        message: failure.message, 
        user: state.user,
        editFromDate: state.editFromDate,
        editToDate: state.editToDate,
        editAssignments: state.editAssignments,
        projects: state.projects,
      )),
      (success) {
        if (success) {
          emit(TimesheetState.success(
            message: "Timesheet updated successfully", 
            user: state.user,
            editFromDate: state.editFromDate,
            editToDate: state.editToDate,
            editAssignments: state.editAssignments,
            projects: state.projects,
          ));
          if (_currentEmployeeId != null) {
            add(TimesheetEvent.started(_currentEmployeeId!));
          }
        } else {
          emit(TimesheetState.error(
            message: "Update failed", 
            user: state.user,
            editFromDate: state.editFromDate,
            editToDate: state.editToDate,
            editAssignments: state.editAssignments,
            projects: state.projects,
          ));
        }
      },
    );
  }
}
