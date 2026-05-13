import 'dart:developer' show log;

import 'package:dhira_hrms/features/timesheet/domain/entities/project_assignment_entity.dart' show ProjectAssignmentEntity;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/utils/date_time_utils.dart';

import '../../domain/usecases/timesheet_upload_file_usecase.dart';
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
import '../../domain/usecases/delete_timesheet_usecase.dart';
import '../../../../core/services/image_compress_service.dart';
class TimesheetBloc extends Bloc<TimesheetEvent, TimesheetState> {
  final GetProjectsUseCase getProjectsUseCase;
  final CreateTimesheetUseCase createTimesheetUseCase;
  final UpdateTimesheetUseCase updateTimesheetUseCase;
  final GetWeekWiseTimesheetUseCase getWeekWiseTimesheetUseCase;
  final DeleteTimesheetEntryUseCase deleteTimesheetEntryUseCase;
  final DeleteTimesheetUseCase deleteTimesheetUseCase;
  final GetTimesheetOverviewUseCase getTimesheetOverviewUseCase;
  final LocalStorageService localStorageService;
  final TimesheetUploadFileUseCase uploadFileUseCase;
  final ImageCompressService imageCompressService;

  TimesheetBloc({
    required this.getProjectsUseCase,
    required this.createTimesheetUseCase,
    required this.updateTimesheetUseCase,
    required this.getWeekWiseTimesheetUseCase,
    required this.deleteTimesheetEntryUseCase,
    required this.deleteTimesheetUseCase,
    required this.getTimesheetOverviewUseCase,
    required this.localStorageService,
    required this.uploadFileUseCase,
    required this.imageCompressService,
  }) : super(const TimesheetState.initial()) {
    on<TimesheetEvent>((event, emit) async {
      await event.maybeMap(
        started: (e) => _onStarted(e as dynamic, emit),
        userInitRequested: (e) => _onUserInitRequested(e as dynamic, emit),
        fromDateChanged: (e) async => emit(_ensureNonErrorState(state.copyWith(editFromDate: e.date))),
        toDateChanged: (e) async => emit(_ensureNonErrorState(state.copyWith(editToDate: e.date))),
        assignmentsChanged: (e) async => emit(_ensureNonErrorState(state.copyWith(editAssignments: e.assignments))),
        daySelected: (e) async => emit(_ensureNonErrorState(state.copyWith(
          selectedDate: e.date,
          editingTask: null,
          editingIndex: null,
        ))),
        submitRequested: (e) => _onSubmitRequested(e as dynamic, emit),
        updateRequested: (e) => _onUpdateRequested(e as dynamic, emit),
        uploadFileRequested: (e) => _onUploadFileRequested(e, emit),
        clearUploadedFile: (e) => _onClearUploadedFile(e, emit),

        submitWeeklyRequested: (_) => _onSubmitWeeklyRequested(const TimesheetEvent.submitWeeklyRequested() as dynamic, emit),
        fetchMonthWiseRequested: (e) => _onFetchMonthWiseRequested(e as dynamic, emit),
        deleteEntryRequested: (e) => _onDeleteEntryRequested(e as dynamic, emit),
        deleteTimesheetRequested: (e) => _onDeleteTimesheetRequested(e as dynamic, emit),
        fetchOverviewRequested: (e) => _onFetchOverviewRequested(e as dynamic, emit),
        editTaskRequested: (e) async => emit(
          _ensureNonErrorState(
            state.copyWith(
              editingTask: (e as dynamic).task,
              editingIndex: (e as dynamic).index,
            ),
          ),
        ),
        editTaskCleared: (_) async => emit(
          _ensureNonErrorState(
            state.copyWith(
              editingTask: null,
              editingIndex: null,
            ),
          ),
        ),
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
        final d = DateTime.tryParse(a.date!)?.toLocal();
        if (d != null) {
          final assignmentDate =
          DateTime(d.year, d.month, d.day);

          if ((assignmentDate.isAtSameMomentAs(weekStart) ||
              assignmentDate.isAfter(weekStart)) &&
              (assignmentDate.isAtSameMomentAs(weekEnd) ||
                  assignmentDate.isBefore(weekEnd))) {
            activeId = a.parent;
            break;
          }
        }
      }
    }

    // 3. Derived Week Data
    double weeklyTotal = 0.0;
    Set<DateTime> tDays = {};
    String rangeText = "";

    if (selectedDate != null) {
      final startOfWeek = DateTimeUtils.getStartOfWeek(selectedDate);
      final endOfWeek = startOfWeek.add(const Duration(days: 6));
      final weekStart = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
      final weekEnd = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59);
      rangeText = DateTimeUtils.formatWeekRange(selectedDate);

      final weeklyAssignments = s.editAssignments.where((a) {
        if (a.date == null) return false;
        final d = DateTime.tryParse(a.date!)?.toLocal();
        if (d == null) return false;
        return d.isAfter(weekStart.subtract(const Duration(seconds: 1))) && d.isBefore(weekEnd);
      });

      weeklyTotal = weeklyAssignments.fold(0.0, (sum, item) => sum + item.spentHours);

      tDays = weeklyAssignments
          .where((a) => a.spentHours > 0)
          .map((a) => DateTime.tryParse(a.date!)?.toLocal())
          .whereType<DateTime>()
          .map((d) => DateTime(d.year, d.month, d.day))
          .toSet();
    }

    final hDays = s.holidays.map((d) => DateTime(d.year, d.month, d.day)).toSet();

    // 4. formattedOverviewWeeks
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
      weeklyTotalHours: weeklyTotal,
      taskDays: tDays,
      holidayDays: hDays,
      currentWeekRangeText: rangeText,
    );
  }

  TimesheetState _ensureNonErrorState(TimesheetState s) {
    final newState = s.maybeMap(
      error: (e) => TimesheetState.initial(
        user: e.user,
        editFromDate: e.editFromDate,
        editToDate: e.editToDate,
        selectedDate: e.selectedDate,
        timesheets: e.timesheets,
        hasMore: e.hasMore,
        editAssignments: e.editAssignments,
        projects: e.projects,
        isActionLoading: e.isActionLoading,
        isSubmitWeeklyLoading: e.isSubmitWeeklyLoading,
        activeTimesheetId: e.activeTimesheetId,
        overview: e.overview,
        assignmentsForSelectedDay: e.assignmentsForSelectedDay,
        currentWeekActiveId: e.currentWeekActiveId,
        formattedOverviewWeeks: e.formattedOverviewWeeks,
        editingTask: e.editingTask,
        editingIndex: e.editingIndex,
        weeklyTotalHours: e.weeklyTotalHours,
        taskDays: e.taskDays,
        holidayDays: e.holidayDays,
        currentWeekRangeText: e.currentWeekRangeText,
        holidays: e.holidays,
        isUploading: e.isUploading,
        uploadedFileUrl: e.uploadedFileUrl,
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
      final selected = state.selectedDate ?? now;

      final startOfWeek = selected.subtract(
        Duration(days: selected.weekday - 1),
      );

      final dominantMonth =
      DateTimeUtils.getDominantMonthOfWeek(startOfWeek);

      final dominantYear =
      DateTimeUtils.getDominantYearOfWeek(startOfWeek);

      add(TimesheetEvent.fetchMonthWiseRequested(
        month: dominantMonth,
        year: dominantYear,
      ));

      add(TimesheetEvent.fetchOverviewRequested(
        month: dominantMonth,
        year: dominantYear,
      ));
    }
  }

  Future<void> _onSubmitRequested(TimesheetSubmitRequested event, Emitter<TimesheetState> emit) async {
    final previousState = state;
    final isWeeklySubmit = event.docStatus == 1;

    // Use _ensureNonErrorState on the current state FIRST to clear any previous error,
    // then apply copyWith to avoid emitting an intermediate Error state.
    emit(_ensureNonErrorState(state).copyWith(
      isActionLoading: !isWeeklySubmit,
      isSubmitWeeklyLoading: isWeeklySubmit,
    ));

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
      (failure) async => emit(_recalculateDerivedState(previousState.copyWith(
        isActionLoading: false,
        isSubmitWeeklyLoading: false,
      ))),
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

        final selected = state.selectedDate ?? DateTime.now();

        final startOfWeek = selected.subtract(
          Duration(days: selected.weekday - 1),
        );

        final dominantMonth =
        DateTimeUtils.getDominantMonthOfWeek(startOfWeek);

        final dominantYear =
        DateTimeUtils.getDominantYearOfWeek(startOfWeek);

        add(TimesheetEvent.fetchMonthWiseRequested(
          month: dominantMonth,
          year: dominantYear,
        ));

        add(TimesheetEvent.fetchOverviewRequested(
          month: dominantMonth,
          year: dominantYear,
        ));

      },
    );
  }

  Future<void> _onUpdateRequested(TimesheetUpdateRequested event, Emitter<TimesheetState> emit) async {
    final previousState = state;
    final isWeeklySubmit = event.approved == 1;

    // Use _ensureNonErrorState on the current state FIRST to clear any previous error,
    // then apply copyWith to avoid emitting an intermediate Error state.
    emit(_ensureNonErrorState(state).copyWith(
      isActionLoading: !isWeeklySubmit,
      isSubmitWeeklyLoading: isWeeklySubmit,
    ));

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
      (failure) async => emit(_recalculateDerivedState(previousState.copyWith(
        isActionLoading: false,
        isSubmitWeeklyLoading: false,
      ))),
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


        final selected = state.selectedDate ?? DateTime.now();

        final startOfWeek = selected.subtract(
          Duration(days: selected.weekday - 1),
        );

        final dominantMonth =
        DateTimeUtils.getDominantMonthOfWeek(startOfWeek);

        final dominantYear =
        DateTimeUtils.getDominantYearOfWeek(startOfWeek);

        add(TimesheetEvent.fetchMonthWiseRequested(
          month: dominantMonth,
          year: dominantYear,
        ));

        add(TimesheetEvent.fetchOverviewRequested(
          month: dominantMonth,
          year: dominantYear,
        ));

      },
    );
  }

  Future<void> _onSubmitWeeklyRequested(TimesheetSubmitWeeklyRequested event, Emitter<TimesheetState> emit) async {
    // Transition to a non-error loading state FIRST to clear any previous error,
    // then apply copyWith to avoid emitting an intermediate Error state.
    emit(_ensureNonErrorState(state).copyWith(isSubmitWeeklyLoading: true));

    final user = state.user;

    final assignments = state.editAssignments;

    final selectedDate = state.selectedDate ?? DateTime.now();

    // Always derive from/to from selectedDate — don't rely on editFromDate/editToDate
    // which may be stale or null if the user never navigated weeks manually.
    final from = DateTime(
      selectedDate.subtract(Duration(days: selectedDate.weekday - 1)).year,
      selectedDate.subtract(Duration(days: selectedDate.weekday - 1)).month,
      selectedDate.subtract(Duration(days: selectedDate.weekday - 1)).day,
    );
    final to = DateTime(from.year, from.month, from.day + 6);

    final filteredAssignments = assignments.where((a) {
      if (a.date == null) return false;
      final d = DateTime.tryParse(a.date!)?.toLocal();
      if (d == null) return false;
      final dateOnly = DateTime(d.year, d.month, d.day);
      return (dateOnly.isAtSameMomentAs(from) || dateOnly.isAfter(from)) &&
             (dateOnly.isAtSameMomentAs(to)   || dateOnly.isBefore(to));
    }).toList();

    // Check for draft tasks — status field may be "Draft" or docstatus == 0
    final hasDraftTasks = filteredAssignments.any((a) {
      final status = a.status?.trim().toLowerCase();

      return status == "draft" || status == null;
    });

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
      editAssignments: const [], // Clear cache/old values when loading
      projects: state.projects,
      activeTimesheetId: state.activeTimesheetId,
      overview: state.overview,
      editingTask: state.editingTask,
      editingIndex: state.editingIndex,
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
          activeTimesheetId: assignments.isNotEmpty ? assignments.first.parent : null,
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

        final selected = state.selectedDate ?? DateTime.now();

        final startOfWeek = selected.subtract(
          Duration(days: selected.weekday - 1),
        );

        final dominantMonth =
        DateTimeUtils.getDominantMonthOfWeek(startOfWeek);

        final dominantYear =
        DateTimeUtils.getDominantYearOfWeek(startOfWeek);


        add(TimesheetEvent.fetchMonthWiseRequested(
          month: dominantMonth,
          year: dominantYear,
        ));

        add(TimesheetEvent.fetchOverviewRequested(
          month: dominantMonth,
          year: dominantYear,
        ));
      },
    );
  }

  Future<void> _onDeleteTimesheetRequested(
      TimesheetDeleteTimesheetRequested event,
      Emitter<TimesheetState> emit,
      ) async {

    final previousState = state;

    emit(_recalculateDerivedState(state.maybeMap(
      loaded: (s) => s.copyWith(isActionLoading: true),
      initial: (s) => s.copyWith(isActionLoading: true),
      orElse: () => state,
    )));

    final result = await deleteTimesheetUseCase(
      timesheetName: event.timesheetName,
    );

    await result.fold(
          (failure) async =>
          emit(_recalculateDerivedState(
            previousState.copyWith(isActionLoading: false),
          )),
          (_) async {

        final updatedAssignments = state.editAssignments
            .where((a) => a.parent != event.timesheetName)
            .toList();

        emit(_recalculateDerivedState(TimesheetState.success(
          message: "Timesheet deleted successfully",
          successType: TimesheetSuccessType.taskDeleted,
          user: state.user,
          timesheets: state.timesheets,
          editFromDate: state.editFromDate,
          editToDate: state.editToDate,
          selectedDate: state.selectedDate,
          editAssignments: updatedAssignments,
          projects: state.projects,
          activeTimesheetId: null,
          overview: state.overview,
          editingTask: null,
          editingIndex: null,
        )));

        final selected = state.selectedDate ?? DateTime.now();

        final startOfWeek = selected.subtract(
          Duration(days: selected.weekday - 1),
        );

        final dominantMonth =
        DateTimeUtils.getDominantMonthOfWeek(startOfWeek);

        final dominantYear =
        DateTimeUtils.getDominantYearOfWeek(startOfWeek);

        add(TimesheetEvent.fetchMonthWiseRequested(
          month: dominantMonth,
          year: dominantYear,
        ));

        add(TimesheetEvent.fetchOverviewRequested(
          month: dominantMonth,
          year: dominantYear,
        ));
      },
    );
  }
  Future<void>  _onClearUploadedFile(
      TimesheetClearUploadedFile event,
      Emitter<TimesheetState> emit,
      ) async {
    emit(
      _recalculateDerivedState(
        state.copyWith(
          uploadedFileUrl: "",
        ),
      ),
    );
  }
  Future<void> _onFetchOverviewRequested(TimesheetFetchOverviewRequested event, Emitter<TimesheetState> emit) async {
    final result = await getTimesheetOverviewUseCase(month: event.month, year: event.year);

    result.fold(
      (failure) {
        assert(() {

          return true;
        }());
      },
          (overview) {

        emit(
          _recalculateDerivedState(
            state.copyWith(overview: overview),
          ),
        );
      },

    );
  }

  Future<void> _onUploadFileRequested(
      TimesheetUploadFileRequested event,
      Emitter<TimesheetState> emit,
      ) async {

    emit(_recalculateDerivedState(state.copyWith(isUploading: true)));

    String pathToBeUploaded = event.filePath;
    final extension = event.filePath.split('.').last.toLowerCase();

    // Compress only if it's an image
    if (['jpg', 'jpeg', 'png'].contains(extension)) {
      final compressedFile = await imageCompressService.compressImage(event.filePath);
      if (compressedFile != null) {
        pathToBeUploaded = compressedFile.path;
      }
    }

    final result = await uploadFileUseCase(pathToBeUploaded);

    result.fold(
          (failure) {
        emit(_recalculateDerivedState(state.copyWith(isUploading: false)));
      },
          (fileUrl) {
        emit(_recalculateDerivedState(state.copyWith(
          isUploading: false,
          uploadedFileUrl: fileUrl,
        )));
      },
    );
  }
}
