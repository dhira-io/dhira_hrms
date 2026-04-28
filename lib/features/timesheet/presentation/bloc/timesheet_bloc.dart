import 'dart:developer' show log;

import 'package:dhira_hrms/features/timesheet/domain/entities/project_assignment_entity.dart' show ProjectAssignmentEntity;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/usecases/get_projects_usecase.dart';
import '../../domain/usecases/create_timesheet_usecase.dart';
import '../../domain/usecases/update_timesheet_usecase.dart';
import '../../domain/usecases/get_week_wise_timesheet_usecase.dart';
import '../../domain/usecases/delete_timesheet_entry_usecase.dart';
import '../../domain/usecases/get_timesheet_overview_usecase.dart';
import '../../../auth/domain/entities/user_entity.dart';
import 'timesheet_event.dart';
import 'timesheet_state.dart';
import 'timesheet_success_type.dart';

class TimesheetBloc extends Bloc<TimesheetEvent, TimesheetState> {
  final GetProjectsUseCase getProjectsUseCase;
  final CreateTimesheetUseCase createTimesheetUseCase;
  final UpdateTimesheetUseCase updateTimesheetUseCase;
  final GetWeekWiseTimesheetUseCase getWeekWiseTimesheetUseCase;
  final DeleteTimesheetEntryUseCase deleteTimesheetEntryUseCase;
  final GetTimesheetOverviewUseCase getTimesheetOverviewUseCase;
  final LocalStorageService localStorageService;

  TimesheetBloc({
    required this.getProjectsUseCase,
    required this.createTimesheetUseCase,
    required this.updateTimesheetUseCase,
    required this.getWeekWiseTimesheetUseCase,
    required this.deleteTimesheetEntryUseCase,
    required this.getTimesheetOverviewUseCase,
    required this.localStorageService,
  }) : super(const TimesheetState.initial()) {
    on<TimesheetEvent>((event, emit) async {
      await event.maybeMap(
        started: (e) => _onStarted(e as dynamic, emit),
        userInitRequested: (e) => _onUserInitRequested(e as dynamic, emit),
        fromDateChanged: (e) async => emit(_ensureNonErrorState(state.copyWith(editFromDate: e.date))),
        toDateChanged: (e) async => emit(_ensureNonErrorState(state.copyWith(editToDate: e.date))),
        assignmentsChanged: (e) async => emit(_ensureNonErrorState(state.copyWith(editAssignments: e.assignments))),
        daySelected: (e) async => emit(_ensureNonErrorState(state.copyWith(selectedDate: e.date))),
        submitRequested: (e) => _onSubmitRequested(e as dynamic, emit),
        updateRequested: (e) => _onUpdateRequested(e as dynamic, emit),
        submitWeeklyRequested: (_) => _onSubmitWeeklyRequested(const TimesheetEvent.submitWeeklyRequested() as dynamic, emit),
        fetchMonthWiseRequested: (e) => _onFetchMonthWiseRequested(e as dynamic, emit),
        deleteEntryRequested: (e) => _onDeleteEntryRequested(e as dynamic, emit),
        fetchOverviewRequested: (e) => _onFetchOverviewRequested(e as dynamic, emit),
        editTaskRequested: (e) async => emit(state.copyWith(
          editingTask: (e as dynamic).task,
          editingIndex: (e as dynamic).index,
        )),
        editTaskCleared: (_) async => emit(state.copyWith(
          editingTask: null,
          editingIndex: null,
        )),
        orElse: () async {},
      );
    });
  }

  TimesheetState _recalculateDerivedState(TimesheetState s) {
    // 1. assignmentsForSelectedDay
    List<ProjectAssignmentEntity> forDay = [];
    final selectedDate = s.selectedDate;
    if (selectedDate != null) {
      forDay = s.editAssignments.where((a) {
        if (a.date == null) return false;
        final d = DateTime.tryParse(a.date!);
        if (d == null) return false;
        return d.year == selectedDate.year &&
            d.month == selectedDate.month &&
            d.day == selectedDate.day;
      }).toList();
    }

    // 2. currentWeekActiveId
    String? activeId;
    if (selectedDate != null && s.editAssignments.isNotEmpty) {
      final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));
      final weekStart = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
      final weekEnd = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59);

      for (var a in s.editAssignments) {
        if (a.date == null || a.parent == null) continue;
        final d = DateTime.tryParse(a.date!);
        if (d != null && d.isAfter(weekStart.subtract(const Duration(seconds: 1))) && d.isBefore(weekEnd)) {
          activeId = a.parent;
          break;
        }
      }
    }

    // 3. formattedOverviewWeeks
    String formattedWeeks = "";
    final meta = s.overview?.weekMeta;
    if (meta != null) {
      final filled = meta['filled'];
      if (filled is List && filled.isNotEmpty) {
        formattedWeeks = filled.map((item) {
          if (item is Map && item.containsKey('label')) return item['label'].toString();
          return "Week $item";
        }).join(", ");
      }
    }

    return s.copyWith(
      assignmentsForSelectedDay: forDay,
      currentWeekActiveId: activeId,
      formattedOverviewWeeks: formattedWeeks,
      // Editing state should be preserved by default unless copyWith explicitly overrides it
    );
  }

  TimesheetState _ensureNonErrorState(TimesheetState s) {
    final newState = s.maybeMap(
      error: (e) => TimesheetState.initial(
        user: e.user,
        editFromDate: e.editFromDate,
        editToDate: e.editToDate,
        timesheets: e.timesheets,
        hasMore: e.hasMore,
        editAssignments: e.editAssignments,
        projects: e.projects,
        overview: e.overview,
        editingTask: e.editingTask,
        editingIndex: e.editingIndex,
      ),
      orElse: () => s,
    );
    return _recalculateDerivedState(newState);
  }

  Future<void> _onUserInitRequested(TimesheetUserInitRequested event, Emitter<TimesheetState> emit) async {
    final projectsResult = await getProjectsUseCase();
    final projects = projectsResult.getOrElse(() => []);

    final user = UserEntity(
      empId: localStorageService.getEmpId() ?? '',
      fullName: localStorageService.getUserFullname() ?? '',
      email: '',
      department: localStorageService.getDepartment(),
      approver: localStorageService.getApprover(),
    );

    emit(_recalculateDerivedState(state.copyWith(user: user, projects: projects)));
  }

  Future<void> _onStarted(TimesheetStarted event, Emitter<TimesheetState> emit) async {
    final now = DateTime.now();
    
    // Only set initial dates if they aren't already present (Caching)
    if (state.selectedDate == null) {
      final from = now.subtract(Duration(days: now.weekday - 1));
      final to = from.add(const Duration(days: 6));

      emit(_recalculateDerivedState(state.copyWith(
        editFromDate: from,
        editToDate: to,
        selectedDate: now,
      )));
    }

    // Handle user init if missing
    if (state.user == null) {
      await _onUserInitRequested(const TimesheetEvent.userInitRequested() as TimesheetUserInitRequested, emit);
    }

    // Only fetch data if we don't have cached assignments
    if (state.editAssignments.isEmpty) {
      final date = state.selectedDate ?? now;
      add(TimesheetEvent.fetchMonthWiseRequested(month: date.month, year: date.year));
      add(TimesheetEvent.fetchOverviewRequested(month: date.month, year: date.year));
    }
  }

  Future<void> _onSubmitRequested(TimesheetSubmitRequested event, Emitter<TimesheetState> emit) async {
    final previousState = state;

    emit(_recalculateDerivedState(state.maybeMap(
      loaded: (s) => s.copyWith(isActionLoading: true),
      initial: (s) => s.copyWith(isActionLoading: true),
      orElse: () => state,
    )));

    final result = await createTimesheetUseCase(
      employee: event.employee,
      department: event.department,
      approver: event.approver,
      fromDate: event.fromDate,
      toDate: event.toDate,
      assignments: event.assignments,
      docStatus: event.docStatus,
    );

    await result.fold(
      (failure) async => emit(_recalculateDerivedState(previousState.copyWith(isActionLoading: false))),
      (serverName) async {
        emit(_recalculateDerivedState(TimesheetState.success(
          message: event.docStatus == 0 ? "Task added to day" : "Timesheet submitted successfully",
          successType: event.docStatus == 0 ? TimesheetSuccessType.taskAdded : TimesheetSuccessType.timesheetSubmitted,
          user: state.user,
          timesheets: state.timesheets,
          editFromDate: state.editFromDate,
          editToDate: state.editToDate,
          selectedDate: state.selectedDate,
          editAssignments: state.editAssignments,
          projects: state.projects,
          activeTimesheetId: serverName.isNotEmpty ? serverName : null,
          overview: state.overview,
          editingTask: null,
          editingIndex: null,
        )));

        final date = state.selectedDate ?? DateTime.now();
        add(TimesheetEvent.fetchMonthWiseRequested(month: date.month, year: date.year));
      },
    );
  }

  Future<void> _onUpdateRequested(TimesheetUpdateRequested event, Emitter<TimesheetState> emit) async {
    final previousState = state;

    emit(_recalculateDerivedState(state.maybeMap(
      loaded: (s) => s.copyWith(isActionLoading: true),
      initial: (s) => s.copyWith(isActionLoading: true),
      orElse: () => state,
    )));

    final result = await updateTimesheetUseCase(
      name: event.name,
      employee: event.employee,
      department: event.department,
      approver: event.approver,
      approved: event.approved,
      fromDate: event.fromDate,
      toDate: event.toDate,
      hoursTotal: event.hoursTotal,
      assignments: event.assignments,
    );

    await result.fold(
      (failure) async => emit(_recalculateDerivedState(previousState.copyWith(isActionLoading: false))),
      (serverName) async {
        final resolvedName = serverName.isNotEmpty ? serverName : event.name;

        emit(_recalculateDerivedState(TimesheetState.success(
          message: event.approved == 0 ? "Task updated successfully" : "Timesheet submitted successfully",
          successType: event.approved == 0 ? TimesheetSuccessType.taskUpdated : TimesheetSuccessType.timesheetSubmitted,
          user: state.user,
          timesheets: state.timesheets,
          editFromDate: state.editFromDate,
          editToDate: state.editToDate,
          selectedDate: state.selectedDate,
          editAssignments: state.editAssignments,
          projects: state.projects,
          activeTimesheetId: resolvedName,
          overview: state.overview,
          editingTask: null,
          editingIndex: null,
        )));

        final date = state.selectedDate ?? DateTime.now();
        add(TimesheetEvent.fetchMonthWiseRequested(month: date.month, year: date.year));
      },
    );
  }

  Future<void> _onSubmitWeeklyRequested(TimesheetSubmitWeeklyRequested event, Emitter<TimesheetState> emit) async {
    final user = state.user;
    final from = state.editFromDate;
    final to = state.editToDate;
    final assignments = state.editAssignments;

    if (from == null || to == null) return;

    final filteredAssignments = assignments.where((a) {
      if (a.date == null) return false;
      final d = DateTime.tryParse(a.date!);
      if (d == null) return false;
      final dateOnly = DateTime(d.year, d.month, d.day);
      final fromOnly = DateTime(from.year, from.month, from.day);
      final toOnly = DateTime(to.year, to.month, to.day);
      return (dateOnly.isAtSameMomentAs(fromOnly) || dateOnly.isAfter(fromOnly)) &&
             (dateOnly.isAtSameMomentAs(toOnly) || dateOnly.isBefore(toOnly));
    }).toList();

    final hasDraftTasks = filteredAssignments.any((a) => a.status?.toLowerCase() == "draft");

    if (!hasDraftTasks) {
      emit(_recalculateDerivedState(TimesheetState.error(
        message: "No Draft task found for week",
        user: state.user,
        editFromDate: state.editFromDate,
        editToDate: state.editToDate,
        selectedDate: state.selectedDate,
        timesheets: state.timesheets,
        editAssignments: state.editAssignments,
        projects: state.projects,
        activeTimesheetId: state.activeTimesheetId,
        overview: state.overview,
      )));
      return;
    }

    final effectiveId = state.currentWeekActiveId;

    if (effectiveId == null) {
      add(TimesheetEvent.submitRequested(
        employee: user?.empId ?? "",
        department: user?.department ?? "",
        approver: user?.approver ?? "",
        fromDate: from.format(),
        toDate: to.format(),
        assignments: filteredAssignments,
        docStatus: 1,
      ));
    } else {
      add(TimesheetEvent.updateRequested(
        name: effectiveId,
        employee: user?.empId ?? "",
        department: user?.department ?? "",
        approver: user?.approver ?? "",
        fromDate: from.format(),
        toDate: to.format(),
        approved: 1,
        hoursTotal: filteredAssignments.fold(0.0, (sum, item) => sum + item.spentHours),
        assignments: filteredAssignments,
      ));
    }
  }

  Future<void> _onFetchMonthWiseRequested(TimesheetFetchMonthWiseRequested event, Emitter<TimesheetState> emit) async {
    emit(_recalculateDerivedState(TimesheetState.loading(
      user: state.user,
      editFromDate: state.editFromDate,
      editToDate: state.editToDate,
      selectedDate: state.selectedDate,
      timesheets: state.timesheets,
      hasMore: state.hasMore,
      editAssignments: state.editAssignments,
      projects: state.projects,
      activeTimesheetId: state.activeTimesheetId,
      overview: state.overview,
    )));

    final result = await getWeekWiseTimesheetUseCase(month: event.month, year: event.year);

    result.fold(
      (failure) => emit(_recalculateDerivedState(TimesheetState.error(
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
        overview: state.overview,
      ))),
      (assignments) {
        emit(_recalculateDerivedState(TimesheetState.loaded(
          timesheets: state.timesheets,
          hasMore: state.hasMore,
          user: state.user,
          editFromDate: state.editFromDate,
          editToDate: state.editToDate,
          selectedDate: state.selectedDate,
          editAssignments: assignments,
          projects: state.projects,
          activeTimesheetId: state.activeTimesheetId,
          overview: state.overview,
        )));
      },
    );
  }

  Future<void> _onDeleteEntryRequested(TimesheetDeleteEntryRequested event, Emitter<TimesheetState> emit) async {
    final previousState = state;

    emit(_recalculateDerivedState(state.maybeMap(
      loaded: (s) => s.copyWith(isActionLoading: true),
      initial: (s) => s.copyWith(isActionLoading: true),
      orElse: () => state,
    )));

    final result = await deleteTimesheetEntryUseCase(
      name: event.name,
      parent: event.parent,
      date: event.date,
    );

    await result.fold(
      (failure) async => emit(_recalculateDerivedState(previousState.copyWith(isActionLoading: false))),
      (_) async {
        final updatedAssignments = state.editAssignments.where((a) => a.name != event.name).toList();

        emit(_recalculateDerivedState(TimesheetState.success(
          message: "Task deleted successfully",
          successType: TimesheetSuccessType.taskDeleted,
          user: state.user,
          timesheets: state.timesheets,
          editFromDate: state.editFromDate,
          editToDate: state.editToDate,
          selectedDate: state.selectedDate,
          editAssignments: updatedAssignments,
          projects: state.projects,
          activeTimesheetId: state.activeTimesheetId,
          overview: state.overview,
          editingTask: null,
          editingIndex: null,
        )));

        final date = state.selectedDate ?? DateTime.now();
        add(TimesheetEvent.fetchMonthWiseRequested(month: date.month, year: date.year));
      },
    );
  }

  Future<void> _onFetchOverviewRequested(TimesheetFetchOverviewRequested event, Emitter<TimesheetState> emit) async {
    final result = await getTimesheetOverviewUseCase(month: event.month, year: event.year);

    result.fold(
      (failure) {
        assert(() {
          log('TimesheetBloc: overview fetch failed — ${failure.message}', name: 'Timesheet');
          return true;
        }());
      },
      (overview) => emit(_recalculateDerivedState(state.copyWith(overview: overview))),
    );
  }
}
