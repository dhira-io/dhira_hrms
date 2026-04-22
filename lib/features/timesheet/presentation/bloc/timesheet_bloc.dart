import '../../../../core/constants/storage_constants.dart';
import '../../domain/entities/timesheet_entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_projects_usecase.dart';
import '../../domain/usecases/create_timesheet_usecase.dart';
import '../../domain/usecases/update_timesheet_usecase.dart';
import '../../domain/usecases/get_week_wise_timesheet_usecase.dart';
import '../../domain/usecases/delete_timesheet_entry_usecase.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/date_time_utils.dart';
import 'timesheet_event.dart';
import 'timesheet_state.dart';

class TimesheetBloc extends Bloc<TimesheetEvent, TimesheetState> {
  final GetProjectsUseCase getProjectsUseCase;
  final CreateTimesheetUseCase createTimesheetUseCase;
  final UpdateTimesheetUseCase updateTimesheetUseCase;
  final GetWeekWiseTimesheetUseCase getWeekWiseTimesheetUseCase;
  final DeleteTimesheetEntryUseCase deleteTimesheetEntryUseCase;
  final IAuthRepository authRepository;
  final SharedPreferences sharedPreferences;

  String? _currentEmployeeId;

  TimesheetBloc({
    required this.getProjectsUseCase,
    required this.createTimesheetUseCase,
    required this.updateTimesheetUseCase,
    required this.getWeekWiseTimesheetUseCase,
    required this.deleteTimesheetEntryUseCase,
    required this.authRepository,
    required this.sharedPreferences,
  }) : super(const TimesheetState.initial()) {
    on<TimesheetEvent>((event, emit) async {
      await event.map(
        started: (_) async => await _onStarted(emit),
        userInitRequested: (_) async => await _onUserInitRequested(emit),
        fromDateChanged: (e) async => emit(_ensureNonErrorState(state.copyWith(editFromDate: e.date))),
        toDateChanged: (e) async => emit(_ensureNonErrorState(state.copyWith(editToDate: e.date))),
        assignmentsChanged: (e) async => emit(_ensureNonErrorState(state.copyWith(editAssignments: e.assignments))),
        daySelected: (e) async => emit(_ensureNonErrorState(state.copyWith(selectedDate: e.date))),
        submitRequested: (e) async => await _onSubmitRequested(
          e.employee, e.department, e.approver, e.fromDate, e.toDate, e.assignments, e.docStatus, emit),
        updateRequested: (e) async => await _onUpdateRequested(
          e.name, e.employee, e.department, e.approver, e.fromDate, e.toDate, e.approved, e.hoursTotal, e.assignments, emit),
        fetchMonthWiseRequested: (e) async => await _onFetchMonthWiseRequested(e.month, e.year, emit),
        deleteEntryRequested: (e) async => await _onDeleteEntryRequested(e.name, e.parent, e.date, emit),
      );
    });
  }

  TimesheetState _ensureNonErrorState(TimesheetState s) {
    return s.maybeMap(
      error: (e) => TimesheetState.initial(
        user: e.user,
        editFromDate: e.editFromDate,
        editToDate: e.editToDate,
        timesheets: e.timesheets,
        hasMore: e.hasMore,
        editAssignments: e.editAssignments,
        projects: e.projects,
      ),
      orElse: () => s,
    );
  }

  Future<void> _onUserInitRequested(Emitter<TimesheetState> emit) async {
    final userResult = await authRepository.getCurrentUser();
    final projectsResult = await getProjectsUseCase();

    final user = userResult.fold((_) => null, (u) => u);
    final projects = projectsResult.getOrElse(() => []);

    emit(state.copyWith(
      user: user,
      projects: projects,
    ));
  }

  Future<void> _onStarted(Emitter<TimesheetState> emit) async {
    final now = DateTime.now();
    final from = now.subtract(Duration(days: now.weekday - 1));
    final to = from.add(const Duration(days: 6));

    emit(state.copyWith(
      editFromDate: from,
      editToDate: to,
      selectedDate: now,
    ));

    add(const TimesheetEvent.userInitRequested());
    add(TimesheetEvent.fetchMonthWiseRequested(month: now.month, year: now.year));
  }

  Future<void> _onSubmitRequested(
    String employee,
    String department,
    String approver,
    String fromDate,
    String toDate,
    List<ProjectAssignmentEntity> assignments,
    int docStatus,
    Emitter<TimesheetState> emit
  ) async {
    final previousState = state;

    emit(state.maybeMap(
      loaded: (s) => s.copyWith(isActionLoading: true),
      initial: (s) => s.copyWith(isActionLoading: true),
      orElse: () => state,
    ));
    final result = await createTimesheetUseCase(
      employee: employee,
      department: department,
      approver: approver,
      fromDate: fromDate,
      toDate: toDate,
      assignments: assignments,
      docStatus: docStatus,
    );
    await result.fold(
      (failure) async => emit(TimesheetState.error(
        message: failure.message, 
        user: state.user,
        editFromDate: state.editFromDate,
        editToDate: state.editToDate,
        editAssignments: state.editAssignments,
        projects: state.projects,
        timesheets: state.timesheets,
        hasMore: state.hasMore,
      )),
      (serverName) async {
        // 1. Emit success toast state
        emit(TimesheetState.success(
          message: docStatus == 0 ? "Task added to day" : "Timesheet submitted successfully",
          user: state.user,
          timesheets: state.timesheets,
          editFromDate: state.editFromDate,
          editToDate: state.editToDate,
          selectedDate: state.selectedDate,
          editAssignments: assignments,
          projects: state.projects,
          activeTimesheetId: serverName.isNotEmpty ? serverName : null,
        ));

        // 2. Automatically refresh the month data to sync IDs and state
        final date = state.selectedDate ?? DateTime.now();
        await _onFetchMonthWiseRequested(date.month, date.year, emit);
      },
    );
  }

  Future<void> _onUpdateRequested(
    String name,
    String employee,
    String department,
    String approver,
    String fromDate,
    String toDate,
    int approved,
    double hoursTotal,
    List<ProjectAssignmentEntity> assignments,
    Emitter<TimesheetState> emit
  ) async {
    final previousState = state;

    emit(state.maybeMap(
      loaded: (s) => s.copyWith(isActionLoading: true),
      initial: (s) => s.copyWith(isActionLoading: true),
      orElse: () => state, 
    ));
    final result = await updateTimesheetUseCase(
      name: name,
      employee: employee,
      department: department,
      approver: approver,
      approved: approved,
      fromDate: fromDate,
      toDate: toDate,
      hoursTotal: hoursTotal,
      assignments: assignments,
    );
    await result.fold(
      (failure) async => emit(TimesheetState.error(
        message: failure.message,
        user: state.user,
        editFromDate: state.editFromDate,
        editToDate: state.editToDate,
        editAssignments: state.editAssignments,
        projects: state.projects,
        timesheets: state.timesheets,
        hasMore: state.hasMore,
      )),
      (serverName) async {
        final resolvedName = serverName.isNotEmpty ? serverName : name;
        
        // 1. Emit success toast state
        emit(TimesheetState.success(
          message: approved == 0 ? "Task updated successfully" : "Timesheet submitted successfully",
          user: state.user,
          timesheets: state.timesheets,
          editFromDate: state.editFromDate,
          editToDate: state.editToDate,
          selectedDate: state.selectedDate,
          editAssignments: assignments,
          projects: state.projects,
          activeTimesheetId: resolvedName,
        ));

        // 2. Automatically refresh the month data to sync IDs and state
        final date = state.selectedDate ?? DateTime.now();
        await _onFetchMonthWiseRequested(date.month, date.year, emit);
      },
    );
  }

  Future<void> _onFetchMonthWiseRequested(int month, int year, Emitter<TimesheetState> emit) async {
    emit(TimesheetState.loading(
      user: state.user,
      editFromDate: state.editFromDate,
      editToDate: state.editToDate,
      selectedDate: state.selectedDate,
      timesheets: state.timesheets,
      hasMore: state.hasMore,
      editAssignments: state.editAssignments,
      projects: state.projects,
      activeTimesheetId: state.activeTimesheetId,
    ));

    final result = await getWeekWiseTimesheetUseCase(month: month, year: year);

    result.fold(
      (failure) => emit(TimesheetState.error(
        message: failure.message,
        user: state.user,
        editFromDate: state.editFromDate,
        editToDate: state.editToDate,
        selectedDate: state.selectedDate,
        timesheets: state.timesheets,
        hasMore: state.hasMore,
        editAssignments: state.editAssignments,
        projects: state.projects,
        activeTimesheetId: state.activeTimesheetId,
      )),
      (assignments) => emit(TimesheetState.loaded(
        timesheets: state.timesheets,
        hasMore: state.hasMore,
        user: state.user,
        editFromDate: state.editFromDate,
        editToDate: state.editToDate,
        selectedDate: state.selectedDate,
        editAssignments: assignments,
        projects: state.projects,
        activeTimesheetId: state.activeTimesheetId,
      )),
    );
  }

  Future<void> _onDeleteEntryRequested(
    String name,
    String parent,
    String date,
    Emitter<TimesheetState> emit
  ) async {
    final previousState = state;
    emit(state.maybeMap(
      loaded: (s) => s.copyWith(isActionLoading: true),
      initial: (s) => s.copyWith(isActionLoading: true),
      orElse: () => state,
    ));

    final result = await deleteTimesheetEntryUseCase(
      name: name,
      parent: parent,
      date: date,
    );

    await result.fold(
      (failure) async => emit(TimesheetState.error(
        message: failure.message,
        user: state.user,
        editFromDate: state.editFromDate,
        editToDate: state.editToDate,
        selectedDate: state.selectedDate,
        timesheets: state.timesheets,
        hasMore: state.hasMore,
        editAssignments: state.editAssignments,
        projects: state.projects,
        activeTimesheetId: state.activeTimesheetId,
      )),
      (_) async {
        // 1. Optimistic local update: Remove the item immediately
        final updatedAssignments = state.editAssignments.where((a) => a.name != name).toList();
        
        // 2. Emit success with updated local list to give immediate feedback
        emit(TimesheetState.success(
          message: "Task deleted successfully",
          user: state.user,
          timesheets: state.timesheets,
          editFromDate: state.editFromDate,
          editToDate: state.editToDate,
          selectedDate: state.selectedDate,
          editAssignments: updatedAssignments,
          projects: state.projects,
          activeTimesheetId: state.activeTimesheetId,
        ));

        // 3. Automatically refresh from server to ensure perfect sync
        final date = state.selectedDate ?? DateTime.now();
        await _onFetchMonthWiseRequested(date.month, date.year, emit);
      },
    );
  }
}
