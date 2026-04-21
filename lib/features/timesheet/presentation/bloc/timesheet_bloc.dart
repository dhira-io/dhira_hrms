import '../../../../core/constants/storage_constants.dart';
import '../../domain/entities/timesheet_entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_timesheets_usecase.dart';
import '../../domain/usecases/get_single_timesheet_usecase.dart';
import '../../domain/usecases/get_projects_usecase.dart';
import '../../domain/usecases/create_timesheet_usecase.dart';
import '../../domain/usecases/update_timesheet_usecase.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'timesheet_event.dart';
import 'timesheet_state.dart';

class TimesheetBloc extends Bloc<TimesheetEvent, TimesheetState> {
  final GetTimesheetsUseCase getTimesheetsUseCase;
  final GetSingleTimesheetUseCase getSingleTimesheetUseCase;
  final GetProjectsUseCase getProjectsUseCase;
  final CreateTimesheetUseCase createTimesheetUseCase;
  final UpdateTimesheetUseCase updateTimesheetUseCase;
  final IAuthRepository authRepository;
  final SharedPreferences sharedPreferences;

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
    required this.sharedPreferences,
  }) : super(const TimesheetState.initial()) {
    on<TimesheetEvent>((event, emit) async {
      await event.map(
        started: (_) async => await _onStarted(emit),
        userInitRequested: (_) async => await _onUserInitRequested(emit),
        loadMoreRequested: (_) async => await _onLoadMoreRequested(emit),
        fetchDetailsRequested: (e) async => await _onFetchDetailsRequested(e.timesheetId, emit),
        fromDateChanged: (e) async => emit(_ensureNonErrorState(state.copyWith(editFromDate: e.date))),
        toDateChanged: (e) async => emit(_ensureNonErrorState(state.copyWith(editToDate: e.date))),
        assignmentsChanged: (e) async => emit(_ensureNonErrorState(state.copyWith(editAssignments: e.assignments))),
        daySelected: (e) async => emit(_ensureNonErrorState(state.copyWith(selectedDate: e.date))),
        submitRequested: (e) async => await _onSubmitRequested(
          e.employee, e.department, e.approver, e.fromDate, e.toDate, e.assignments, emit),
        updateRequested: (e) async => await _onUpdateRequested(
          e.name, e.employee, e.department, e.approver, e.fromDate, e.toDate, e.approved, e.hoursTotal, e.assignments, emit),
        loadCurrentWeekRequested: (_) async => await _onLoadCurrentWeekRequested(emit),
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
    print("🔥 STARTED EVENT HIT");
    final id = sharedPreferences.getString(StorageConstants.empId);
    if (id == null) {
      emit(TimesheetState.error(
        message: "Employee ID not found",
        user: state.user,
        editFromDate: state.editFromDate,
        editToDate: state.editToDate,
        editAssignments: state.editAssignments,
        projects: state.projects,
        timesheets: state.timesheets,
        hasMore: state.hasMore,
      ));
      return;
    }

    emit(TimesheetState.loading(
      user: state.user,
      editFromDate: state.editFromDate,
      editToDate: state.editToDate,
      editAssignments: state.editAssignments,
      projects: state.projects,
      timesheets: state.timesheets,
      hasMore: state.hasMore,
    ));
    _currentEmployeeId = id;
    _start = 0;
    final result = await getTimesheetsUseCase(employee: id, start: _start, limit: _limit);

    print("📦 API RESULT: $result");
    result.fold(
      (failure) => emit(TimesheetState.error(
        message: failure.message, 
        user: state.user,
        editFromDate: state.editFromDate,
        editToDate: state.editToDate,
        editAssignments: state.editAssignments,
        projects: state.projects,
        timesheets: state.timesheets,
        hasMore: state.hasMore,
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

  Future<void> _onLoadMoreRequested(Emitter<TimesheetState> emit) async {
    final id = _currentEmployeeId ?? sharedPreferences.getString(StorageConstants.empId);
    if (id == null) return;
    
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
            timesheets: state.timesheets,
            hasMore: state.hasMore,
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
    // emit(TimesheetState.loading(
    //   user: state.user,
    //   editFromDate: state.editFromDate,
    //   editToDate: state.editToDate,
    //   editAssignments: state.editAssignments,
    //   projects: state.projects,
    //   timesheets: state.timesheets,
    //   hasMore: state.hasMore,
    // ));
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
        timesheets: state.timesheets,
        hasMore: state.hasMore,
      )),
      (timesheet) {
        projectsResult.fold(
          (failure) => emit(TimesheetState.error(
            message: failure.message, 
            user: state.user,
            editFromDate: state.editFromDate,
            editToDate: state.editToDate,
            editAssignments: state.editAssignments,
            timesheets: state.timesheets,
            hasMore: state.hasMore,
          )),
          // (projects) => emit(TimesheetState.detailLoaded(
          //   timesheet: timesheet,
          //   projects: projects,
          //   user: state.user,
          //   editFromDate: DateTime.parse(timesheet.fromDate ?? DateTime.now().toIso8601String()),
          //   editToDate: DateTime.parse(timesheet.toDate ?? DateTime.now().toIso8601String()),
          //   editAssignments: List.from(timesheet.projectAssignments ?? []),
          //   timesheets: state.timesheets,
          //   hasMore: state.hasMore,
          // )),

            (projects) => emit(state.copyWith(
              projects: projects,
              editFromDate: DateTime.parse(
                timesheet.fromDate ?? DateTime.now().toIso8601String(),
              ),
              editToDate: DateTime.parse(
                timesheet.toDate ?? DateTime.now().toIso8601String(),
              ),
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
    final previousState = state;

    emit(TimesheetState.loading(
      user: state.user,
      editFromDate: state.editFromDate,
      editToDate: state.editToDate,
      editAssignments: state.editAssignments,
      projects: state.projects,
      timesheets: state.timesheets,
      hasMore: state.hasMore,
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
        timesheets: state.timesheets,
        hasMore: state.hasMore,
      )),
      (success) {
        if (success) {

          // ✅ 1. Update list FIRST
          previousState.maybeMap(
            loaded: (s) {
              final newItem = TimesheetEntity(
                name: "TEMP-${DateTime.now().millisecondsSinceEpoch}",
                employee: employee,
                employeeName: s.user?.fullName,
                hoursTotal: assignments.fold(0.0, (sum, e) => sum + e.spentHours),
                fromDate: fromDate,
                toDate: toDate,
                docStatus: 0,
                totalSpentHours: assignments.fold(0.0, (sum, e) => sum + e.spentHours),
              );

              emit(s.copyWith(
                timesheets: [newItem, ...s.timesheets],
              ));
            },
            orElse: () {},
          );

          // emit(TimesheetState.success(
          //   message: "Timesheet created successfully",
          //   user: state.user,
          //   editFromDate: state.editFromDate,
          //   editToDate: state.editToDate,
          //   editAssignments: state.editAssignments,
          //   projects: state.projects,
          //   timesheets: state.timesheets,
          //   hasMore: state.hasMore,
          // ));



          // if (_currentEmployeeId != null) {
          //   add(const TimesheetEvent.started());
          // }
        } else {
          emit(TimesheetState.error(
            message: "Submission failed", 
            user: state.user,
            editFromDate: state.editFromDate,
            editToDate: state.editToDate,
            editAssignments: state.editAssignments,
            projects: state.projects,
            timesheets: state.timesheets,
            hasMore: state.hasMore,
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
    String fromDate,
    String toDate,
    int approved,
    double hoursTotal,
    List<ProjectAssignmentEntity> assignments,
    Emitter<TimesheetState> emit
  ) async {
    final previousState = state;

    emit(TimesheetState.loading(
      user: state.user,
      editFromDate: state.editFromDate,
      editToDate: state.editToDate,
      editAssignments: state.editAssignments,
      projects: state.projects,
      timesheets: state.timesheets,
      hasMore: state.hasMore,
    ));
    final result = await updateTimesheetUseCase(
      name: name,
      employee: employee,
      department: department,
      approver: approver,
      fromDate: fromDate,
      toDate: toDate,
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
        timesheets: state.timesheets,
        hasMore: state.hasMore,
      )),
      (success) {
        if (success) {

          // ✅ update list
          previousState.maybeMap(
            loaded: (s) {
              final updatedList = s.timesheets.map((t) {
                if (t.name == name) {
                  return t.copyWith(
                    hoursTotal: hoursTotal,
                    fromDate: fromDate,
                    toDate: toDate,
                    totalSpentHours: assignments.fold(
                      0.0,
                          (sum, e) => sum + e.spentHours,
                    ),
                  );
                }
                return t;
              }).toList();

              emit(s.copyWith(timesheets: updatedList));
            },
            orElse: () {},
          );


          // emit(TimesheetState.success(
          //   message: "Timesheet updated successfully",
          //   user: state.user,
          //   editFromDate: state.editFromDate,
          //   editToDate: state.editToDate,
          //   editAssignments: state.editAssignments,
          //   projects: state.projects,
          //   timesheets: state.timesheets,
          //   hasMore: state.hasMore,
          // ));
          // if (_currentEmployeeId != null) {
          //   add(const TimesheetEvent.started());
          // }
        } else {
          emit(TimesheetState.error(
            message: "Update failed", 
            user: state.user,
            editFromDate: state.editFromDate,
            editToDate: state.editToDate,
            editAssignments: state.editAssignments,
            projects: state.projects,
            timesheets: state.timesheets,
            hasMore: state.hasMore,
          ));
        }
      },
    );
  }

  Future<void> _onLoadCurrentWeekRequested(Emitter<TimesheetState> emit) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    // Monday of current week
    final fromDate = today.subtract(Duration(days: today.weekday - 1));
    final toDate = fromDate.add(const Duration(days: 6));

    final fromStr = fromDate.format('yyyy-MM-dd');
    final toStr = toDate.format('yyyy-MM-dd');

    emit(TimesheetState.loading(
      user: state.user,
      editFromDate: state.editFromDate,
      editToDate: state.editToDate,
      editAssignments: state.editAssignments,
      projects: state.projects,
      timesheets: state.timesheets,
      hasMore: state.hasMore,
    ));

    final id = sharedPreferences.getString(StorageConstants.empId);
    if (id == null) {
      emit(TimesheetState.error(
        message: "Employee ID not found",
        user: state.user,
        timesheets: state.timesheets,
        hasMore: state.hasMore,
        projects: state.projects,
        editAssignments: state.editAssignments,
      ));
      return;
    }

    // Fetch initial page to find the current week's timesheet
    final result = await getTimesheetsUseCase(employee: id, start: 0, limit: 20);

    await result.fold(
      (failure) async => emit(TimesheetState.error(
        message: failure.message,
        user: state.user,
        timesheets: state.timesheets,
        hasMore: state.hasMore,
        projects: state.projects,
        editAssignments: state.editAssignments,
      )),
      (list) async {
        // Try to find a timesheet that matches the current week's dates
        final existing = list.where((t) => t.fromDate == fromStr && t.toDate == toStr).toList();

        if (existing.isNotEmpty) {
          // Load details for the existing one
          await _onFetchDetailsRequested(existing.first.name, emit);
        } else {
          // Initialize a new one for the current week
          final userResult = await authRepository.getCurrentUser();
          final user = userResult.fold((_) => null, (u) => u);
          final projectsResult = await getProjectsUseCase();
          final projects = projectsResult.getOrElse(() => []);

          emit(TimesheetState.loaded(
            timesheets: list,
            hasMore: list.length == 20,
            user: user,
            editFromDate: fromDate,
            editToDate: toDate,
            selectedDate: today,
            editAssignments: [],
            projects: projects,
          ));
        }
      },
    );
  }
}
