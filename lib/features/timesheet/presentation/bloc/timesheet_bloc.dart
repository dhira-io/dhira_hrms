import 'dart:developer' show log;

import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/usecases/usecase.dart';
import 'package:dhira_hrms/core/services/image_compress_service.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/auth/domain/entities/user_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_assignment_entity.dart'
    show ProjectAssignmentEntity;
import 'package:dhira_hrms/features/timesheet/domain/entities/timesheet_entities.dart'
    show ProjectEntity;
import 'package:dhira_hrms/features/timesheet/domain/usecases/create_timesheet_usecase.dart';
import 'package:dhira_hrms/features/timesheet/domain/usecases/delete_timesheet_entry_usecase.dart';
import 'package:dhira_hrms/features/timesheet/domain/usecases/delete_timesheet_usecase.dart';
import 'package:dhira_hrms/features/timesheet/domain/usecases/get_projects_usecase.dart';
import 'package:dhira_hrms/features/timesheet/domain/usecases/get_timesheet_overview_usecase.dart';
import 'package:dhira_hrms/features/timesheet/domain/usecases/get_week_wise_timesheet_usecase.dart';
import 'package:dhira_hrms/features/timesheet/domain/usecases/timesheet_upload_file_usecase.dart';
import 'package:dhira_hrms/features/timesheet/domain/usecases/update_timesheet_usecase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/features/timesheet/domain/constants/timesheet_constants.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_status.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_success_type.dart';

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
  }) : super(const TimesheetState()) {
    on<TimesheetStarted>(_onStarted);
    on<TimesheetUserInitRequested>(_onUserInitRequested);
    on<TimesheetFromDateChanged>(_onFromDateChanged);
    on<TimesheetToDateChanged>(_onToDateChanged);
    on<TimesheetAssignmentsChanged>(_onAssignmentsChanged);
    on<TimesheetDaySelected>(_onDaySelected);
    on<TimesheetSubmitRequested>(_onSubmitRequested);
    on<TimesheetUpdateRequested>(_onUpdateRequested);
    on<TimesheetUploadFileRequested>(_onUploadFileRequested);
    on<TimesheetClearUploadedFile>(_onClearUploadedFile);
    on<TimesheetSubmitWeeklyRequested>(_onSubmitWeeklyRequested);
    on<TimesheetFetchMonthWiseRequested>(_onFetchMonthWiseRequested);
    on<TimesheetDeleteEntryRequested>(_onDeleteEntryRequested);
    on<TimesheetDeleteTaskRequested>(_onDeleteTaskRequested);
    on<TimesheetDeleteTimesheetRequested>(_onDeleteTimesheetRequested);
    on<TimesheetFetchOverviewRequested>(_onFetchOverviewRequested);
    on<TimesheetEditTaskRequested>(_onEditTaskRequested);
    on<TimesheetEditTaskCleared>(_onEditTaskCleared);
    on<TimesheetSaveTaskRequested>(_onSaveTaskRequested);
    on<TimesheetFormTaskDataChanged>(_onFormTaskDataChanged);
    on<TimesheetFormDescriptionChanged>(_onFormDescriptionChanged);
    on<TimesheetFormExpectedHoursChanged>(_onFormExpectedHoursChanged);
    on<TimesheetFormSpentHoursChanged>(_onFormSpentHoursChanged);
    on<TimesheetFormProjectChanged>(_onFormProjectChanged);
    on<TimesheetPickAndUploadFileRequested>(_onPickAndUploadFileRequested);
    on<TimesheetPreviousWeekRequested>(_onPreviousWeekRequested);
    on<TimesheetNextWeekRequested>(_onNextWeekRequested);
    on<TimesheetRefreshRequested>(_onRefreshRequested);
  }

  void _onFromDateChanged(
    TimesheetFromDateChanged event,
    Emitter<TimesheetState> emit,
  ) {
    emit(_ensureNonErrorState(state.copyWith(editFromDate: event.date)));
  }

  void _onToDateChanged(
    TimesheetToDateChanged event,
    Emitter<TimesheetState> emit,
  ) {
    emit(_ensureNonErrorState(state.copyWith(editToDate: event.date)));
  }

  void _onAssignmentsChanged(
    TimesheetAssignmentsChanged event,
    Emitter<TimesheetState> emit,
  ) {
    emit(
      _ensureNonErrorState(state.copyWith(editAssignments: event.assignments)),
    );
  }

  void _onDeleteTaskRequested(
    TimesheetDeleteTaskRequested event,
    Emitter<TimesheetState> emit,
  ) {
    final task = event.task;
    final tasksForWeek = state.editAssignments
        .where((e) => e.parent == task.parent)
        .toList();

    final isLastTask = tasksForWeek.length == 1;
    if (isLastTask) {
      add(
        TimesheetEvent.deleteTimesheetRequested(
          timesheetName: task.parent ?? "",
        ),
      );
      return;
    }

    if (task.name != null) {
      add(
        TimesheetEvent.deleteEntryRequested(
          name: task.name!,
          parent: task.parent ?? "",
          date: task.date ?? "",
        ),
      );
    } else {
      final updated = List<ProjectAssignmentEntity>.from(state.editAssignments)
        ..remove(task);
      add(TimesheetEvent.assignmentsChanged(updated));
    }
  }

  void _onDaySelected(
    TimesheetDaySelected event,
    Emitter<TimesheetState> emit,
  ) {
    emit(
      _ensureNonErrorState(
        state.copyWith(
          selectedDate: event.date,
          editingTask: null,
          editingIndex: null,
        ),
      ),
    );
  }

  void _onEditTaskRequested(
    TimesheetEditTaskRequested event,
    Emitter<TimesheetState> emit,
  ) {
    ProjectEntity? matched;
    try {
      matched = state.projects.firstWhere(
        (p) => p.projectName == event.task.project,
      );
    } catch (_) {}

    emit(
      _ensureNonErrorState(
        state.copyWith(
          editingTask: event.task,
          editingIndex: event.index,
          formTaskData: event.task.taskData ?? '',
          formDescription: event.task.description ?? '',
          formExpectedHours: event.task.expectedHours.toString(),
          formSpentHours: event.task.spentHours.toString(),
          formSelectedProject: matched,
          uploadedFileUrl: event.task.attachments ?? '',
        ),
      ),
    );
  }

  void _onEditTaskCleared(
    TimesheetEditTaskCleared event,
    Emitter<TimesheetState> emit,
  ) {
    emit(
      _ensureNonErrorState(
        state.copyWith(
          editingTask: null,
          editingIndex: null,
          formTaskData: '',
          formDescription: '',
          formExpectedHours: '',
          formSpentHours: '',
          formSelectedProject: null,
          uploadedFileUrl: '',
        ),
      ),
    );
  }

  TimesheetState _recalculateDerivedState(TimesheetState s) {
    // 1. assignmentsForSelectedDay
    List<ProjectAssignmentEntity> forDay = [];
    final selectedDate = s.selectedDate;
    if (selectedDate != null) {
      forDay = s.editAssignments.where((a) {
        if (a.date == null) return false;
        final d = DateTime.tryParse(a.date!)?.toLocal();
        if (d == null) return false;
        return d.year == selectedDate.year &&
            d.month == selectedDate.month &&
            d.day == selectedDate.day;
      }).toList();
    }

    // 2. currentWeekActiveId
    String? activeId;
    if (selectedDate != null && s.editAssignments.isNotEmpty) {
      final startOfWeek = DateTimeUtils.getStartOfWeek(selectedDate);
      final endOfWeek = startOfWeek.add(const Duration(days: 6));
      final weekStart = DateTime(
        startOfWeek.year,
        startOfWeek.month,
        startOfWeek.day,
      );
      final weekEnd = DateTime(
        endOfWeek.year,
        endOfWeek.month,
        endOfWeek.day,
        23,
        59,
        59,
      );

      for (var a in s.editAssignments) {
        if (a.date == null || a.parent == null) continue;
        final d = DateTime.tryParse(a.date!)?.toLocal();
        if (d != null) {
          final assignmentDate = DateTime(d.year, d.month, d.day);

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
    bool hasDraft = false;

    if (selectedDate != null) {
      final startOfWeek = DateTimeUtils.getStartOfWeek(selectedDate);
      final endOfWeek = startOfWeek.add(const Duration(days: 6));
      final weekStart = DateTime(
        startOfWeek.year,
        startOfWeek.month,
        startOfWeek.day,
      );
      final weekEnd = DateTime(
        endOfWeek.year,
        endOfWeek.month,
        endOfWeek.day,
        23,
        59,
        59,
      );
      rangeText = DateTimeUtils.formatTimesheetWeekRange(selectedDate);

      final weeklyAssignments = s.editAssignments.where((a) {
        if (a.date == null) return false;
        final d = DateTime.tryParse(a.date!)?.toLocal();
        if (d == null) return false;
        return d.isAfter(weekStart.subtract(const Duration(seconds: 1))) &&
            d.isBefore(weekEnd);
      });

      weeklyTotal = weeklyAssignments.fold(
        0.0,
        (sum, item) => sum + item.spentHours,
      );

      tDays = weeklyAssignments
          .where((a) => a.spentHours > 0)
          .map((a) => DateTime.tryParse(a.date!)?.toLocal())
          .whereType<DateTime>()
          .map((d) => DateTime(d.year, d.month, d.day))
          .toSet();

      hasDraft = weeklyAssignments.any((a) {
        final status = a.status?.trim().toLowerCase();
        return status == TimesheetConstants.draftStatus || status == null;
      });
    }

    final hDays = s.holidays
        .map((d) => DateTime(d.year, d.month, d.day))
        .toSet();

    // 4. formattedOverviewWeeks
    String formattedWeeks = "";
    final meta = s.overview?.weekMeta;
    if (meta != null) {
      final filled = meta['filled'];
      if (filled is List && filled.isNotEmpty) {
        formattedWeeks = filled
            .map((item) {
              if (item is Map && item.containsKey('label')) {
                return item['label'].toString();
              }
              return "Week $item";
            })
            .join(", ");
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
      hasDraftTasksInSelectedWeek: hasDraft,
    );
  }

  TimesheetState _ensureNonErrorState(TimesheetState s) {
    final newState = s.copyWith(
      status: s.status == TimesheetStateStatus.error
          ? TimesheetStateStatus.initial
          : s.status,
      errorMessage: null,
      successMessage: null,
      successType: null,
    );
    return _recalculateDerivedState(newState);
  }

  Future<void> _initializeUserData(Emitter<TimesheetState> emit) async {
    final projectsResult = await getProjectsUseCase(NoParams());
    final projects = projectsResult.getOrElse(() => []);

    final user = UserEntity(
      empId: localStorageService.getEmpId() ?? '',
      fullName: localStorageService.getUserFullname() ?? '',
      email: '',
      department: localStorageService.getDepartment(),
      approver: localStorageService.getApprover(),
    );

    emit(
      _recalculateDerivedState(state.copyWith(user: user, projects: projects)),
    );
  }

  Future<void> _onUserInitRequested(
    TimesheetUserInitRequested event,
    Emitter<TimesheetState> emit,
  ) async {
    await _initializeUserData(emit);
  }

  Future<void> _onStarted(
    TimesheetStarted event,
    Emitter<TimesheetState> emit,
  ) async {
    final now = DateTime.now();

    // Only set initial dates if they aren't already present (Caching)
    if (state.selectedDate == null) {
      final from = DateTimeUtils.getStartOfWeek(now);
      final to = from.add(const Duration(days: 6));

      emit(
        _recalculateDerivedState(
          state.copyWith(
            editFromDate: from,
            editToDate: to,
            selectedDate: now,
            initialTimesheetId: event.timesheetId,
          ),
        ),
      );
    } else {
      emit(state.copyWith(initialTimesheetId: event.timesheetId));
    }

    // Handle user init if missing
    if (state.user == null) {
      await _initializeUserData(emit);
    }

    // Only fetch data if we don't have cached assignments
    if (state.editAssignments.isEmpty) {
      _refreshCurrentMonthData(state.selectedDate ?? now);
    }
  }

  /// Extracts the dominant month/year from [selectedDate] and dispatches
  /// both [fetchMonthWiseRequested] and [fetchOverviewRequested].
  void _refreshCurrentMonthData(DateTime selectedDate) {
    final startOfWeek = DateTimeUtils.getStartOfWeek(selectedDate);
    final dominantMonth = DateTimeUtils.getDominantMonthOfWeek(startOfWeek);
    final dominantYear = DateTimeUtils.getDominantYearOfWeek(startOfWeek);
    add(
      TimesheetEvent.fetchMonthWiseRequested(
        month: dominantMonth,
        year: dominantYear,
      ),
    );
    add(
      TimesheetEvent.fetchOverviewRequested(
        month: dominantMonth,
        year: dominantYear,
      ),
    );
  }

  Future<void> _onSubmitRequested(
    TimesheetSubmitRequested event,
    Emitter<TimesheetState> emit,
  ) async {
    final previousState = state;
    final isWeeklySubmit = event.docStatus == 1;

    emit(
      _ensureNonErrorState(state).copyWith(
        status: TimesheetStateStatus.initial,
        isActionLoading: !isWeeklySubmit,
        isSubmitWeeklyLoading: isWeeklySubmit,
      ),
    );

    final result = await createTimesheetUseCase(
      CreateTimesheetParams(
        employee: event.employee,
        department: event.department,
        approver: event.approver,
        fromDate: event.fromDate,
        toDate: event.toDate,
        assignments: event.assignments,
        docStatus: event.docStatus,
      ),
    );

    await result.fold(
      (failure) async => emit(
        _recalculateDerivedState(
          previousState.copyWith(
            isActionLoading: false,
            isSubmitWeeklyLoading: false,
            status: TimesheetStateStatus.error,
            errorMessage: failure.message,
          ),
        ),
      ),
      (serverName) async {
        emit(
          _recalculateDerivedState(
            state.copyWith(
              status: TimesheetStateStatus.success,
              successMessage: event.docStatus == 0
                  ? TimesheetConstants.taskAddedToDay
                  : TimesheetConstants.timesheetSubmittedSuccessfully,
              successType: event.docStatus == 0
                  ? TimesheetSuccessType.taskAdded
                  : TimesheetSuccessType.timesheetSubmitted,
              activeTimesheetId: serverName.isNotEmpty ? serverName : null,
              editingTask: null,
              editingIndex: null,
              isActionLoading: false,
              isSubmitWeeklyLoading: false,
            ),
          ),
        );

        final selected = state.selectedDate ?? DateTime.now();
        _refreshCurrentMonthData(selected);
      },
    );
  }

  Future<void> _onUpdateRequested(
    TimesheetUpdateRequested event,
    Emitter<TimesheetState> emit,
  ) async {
    final previousState = state;
    final isWeeklySubmit = event.approved == 1;

    emit(
      _ensureNonErrorState(state).copyWith(
        status: TimesheetStateStatus.initial,
        isActionLoading: !isWeeklySubmit,
        isSubmitWeeklyLoading: isWeeklySubmit,
      ),
    );

    final result = await updateTimesheetUseCase(
      UpdateTimesheetParams(
        name: event.name,
        employee: event.employee,
        department: event.department,
        approver: event.approver,
        approved: event.approved,
        fromDate: event.fromDate,
        toDate: event.toDate,
        hoursTotal: event.hoursTotal,
        assignments: event.assignments,
      ),
    );

    await result.fold(
      (failure) async => emit(
        _recalculateDerivedState(
          previousState.copyWith(
            isActionLoading: false,
            isSubmitWeeklyLoading: false,
            status: TimesheetStateStatus.error,
            errorMessage: failure.message,
          ),
        ),
      ),
      (serverName) async {
        final resolvedName = serverName.isNotEmpty ? serverName : event.name;

        emit(
          _recalculateDerivedState(
            state.copyWith(
              status: TimesheetStateStatus.success,
              successMessage: event.approved == 0
                  ? TimesheetConstants.taskUpdatedSuccessfully
                  : TimesheetConstants.timesheetSubmittedSuccessfully,
              successType: event.approved == 0
                  ? TimesheetSuccessType.taskUpdated
                  : TimesheetSuccessType.timesheetSubmitted,
              activeTimesheetId: resolvedName,
              editingTask: null,
              editingIndex: null,
              isActionLoading: false,
              isSubmitWeeklyLoading: false,
            ),
          ),
        );

        final selected = state.selectedDate ?? DateTime.now();
        _refreshCurrentMonthData(selected);
      },
    );
  }

  Future<void> _onSubmitWeeklyRequested(
    TimesheetSubmitWeeklyRequested event,
    Emitter<TimesheetState> emit,
  ) async {
    emit(_ensureNonErrorState(state).copyWith(isSubmitWeeklyLoading: true));

    final user = state.user;
    final assignments = state.editAssignments;
    final selectedDate = state.selectedDate ?? DateTime.now();

    final startOfWeek = DateTimeUtils.getStartOfWeek(selectedDate);
    final from = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    final to = from.add(const Duration(days: 6));

    final filteredAssignments = assignments.where((a) {
      if (a.date == null) return false;
      final d = DateTime.tryParse(a.date!)?.toLocal();
      if (d == null) return false;
      final dateOnly = DateTime(d.year, d.month, d.day);
      return (dateOnly.isAtSameMomentAs(from) || dateOnly.isAfter(from)) &&
          (dateOnly.isAtSameMomentAs(to) || dateOnly.isBefore(to));
    }).toList();

    final hasDraftTasks = filteredAssignments.any((a) {
      final status = a.status?.trim().toLowerCase();
      return status == TimesheetConstants.draftStatus || status == null;
    });

    if (!hasDraftTasks) {
      emit(
        _recalculateDerivedState(
          state.copyWith(
            status: TimesheetStateStatus.error,
            errorMessage: TimesheetConstants.noDraftTaskFound,
            isSubmitWeeklyLoading: false,
          ),
        ),
      );
      return;
    }

    final effectiveId = state.currentWeekActiveId;

    if (effectiveId == null) {
      add(
        TimesheetEvent.submitRequested(
          employee: user?.empId ?? "",
          department: user?.department ?? "",
          approver: user?.approver ?? "",
          fromDate: from.format(),
          toDate: to.format(),
          assignments: filteredAssignments,
          docStatus: 1,
        ),
      );
    } else {
      add(
        TimesheetEvent.updateRequested(
          name: effectiveId,
          employee: user?.empId ?? "",
          department: user?.department ?? "",
          approver: user?.approver ?? "",
          fromDate: from.format(),
          toDate: to.format(),
          approved: 1,
          hoursTotal: filteredAssignments.fold(
            0.0,
            (sum, item) => sum + item.spentHours,
          ),
          assignments: filteredAssignments,
        ),
      );
    }
  }

  Future<void> _onFetchMonthWiseRequested(
    TimesheetFetchMonthWiseRequested event,
    Emitter<TimesheetState> emit,
  ) async {
    emit(
      _recalculateDerivedState(
        state.copyWith(status: TimesheetStateStatus.loading),
      ),
    );

    final result = await getWeekWiseTimesheetUseCase(
      GetWeekWiseTimesheetParams(month: event.month, year: event.year),
    );

    result.fold(
      (failure) => emit(
        _recalculateDerivedState(
          state.copyWith(
            status: TimesheetStateStatus.error,
            errorMessage: failure.message,
          ),
        ),
      ),
      (assignments) {
        emit(
          _recalculateDerivedState(
            state.copyWith(
              status: TimesheetStateStatus.loaded,
              editAssignments: assignments,
              activeTimesheetId: assignments.isNotEmpty
                  ? assignments.first.parent
                  : null,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onDeleteEntryRequested(
    TimesheetDeleteEntryRequested event,
    Emitter<TimesheetState> emit,
  ) async {
    final previousState = state;

    emit(
      _recalculateDerivedState(
        state.copyWith(
          isActionLoading: true,
          status: TimesheetStateStatus.initial,
          successMessage: null,
          successType: null,
          errorMessage: null,
        ),
      ),
    );

    final result = await deleteTimesheetEntryUseCase(
      DeleteTimesheetEntryParams(
        name: event.name,
        parent: event.parent,
        date: event.date,
      ),
    );

    await result.fold(
      (failure) async => emit(
        _recalculateDerivedState(
          previousState.copyWith(
            isActionLoading: false,
            status: TimesheetStateStatus.error,
            errorMessage: failure.message,
          ),
        ),
      ),
      (_) async {
        final updatedAssignments = state.editAssignments
            .where((a) => a.name != event.name)
            .toList();

        emit(
          _recalculateDerivedState(
            state.copyWith(
              status: TimesheetStateStatus.success,
              successMessage: TimesheetConstants.taskDeletedSuccessfully,
              successType: TimesheetSuccessType.taskDeleted,
              editAssignments: updatedAssignments,
              editingTask: null,
              editingIndex: null,
              isActionLoading: false,
            ),
          ),
        );

        final selected = state.selectedDate ?? DateTime.now();
        _refreshCurrentMonthData(selected);
      },
    );
  }

  Future<void> _onDeleteTimesheetRequested(
    TimesheetDeleteTimesheetRequested event,
    Emitter<TimesheetState> emit,
  ) async {
    final previousState = state;

    emit(
      _recalculateDerivedState(
        state.copyWith(
          isActionLoading: true,
          status: TimesheetStateStatus.initial,
          successMessage: null,
          successType: null,
          errorMessage: null,
        ),
      ),
    );

    final result = await deleteTimesheetUseCase(
      DeleteTimesheetParams(timesheetName: event.timesheetName),
    );

    await result.fold(
      (failure) async => emit(
        _recalculateDerivedState(
          previousState.copyWith(
            isActionLoading: false,
            status: TimesheetStateStatus.error,
            errorMessage: failure.message,
          ),
        ),
      ),
      (_) async {
        final updatedAssignments = state.editAssignments
            .where((a) => a.parent != event.timesheetName)
            .toList();

        emit(
          _recalculateDerivedState(
            state.copyWith(
              status: TimesheetStateStatus.success,
              successMessage: TimesheetConstants.timesheetDeletedSuccessfully,
              successType: TimesheetSuccessType.timesheetDeleted,
              editAssignments: updatedAssignments,
              activeTimesheetId: null,
              editingTask: null,
              editingIndex: null,
              isActionLoading: false,
            ),
          ),
        );

        final selected = state.selectedDate ?? DateTime.now();
        _refreshCurrentMonthData(selected);
      },
    );
  }

  Future<void> _onClearUploadedFile(
    TimesheetClearUploadedFile event,
    Emitter<TimesheetState> emit,
  ) async {
    emit(_recalculateDerivedState(state.copyWith(uploadedFileUrl: "")));
  }

  Future<void> _onFetchOverviewRequested(
    TimesheetFetchOverviewRequested event,
    Emitter<TimesheetState> emit,
  ) async {
    final result = await getTimesheetOverviewUseCase(
      GetTimesheetOverviewParams(month: event.month, year: event.year),
    );

    result.fold(
      (failure) {
        log(
          '${TimesheetConstants.fetchOverviewErrorMsg}${failure.message}',
          name: TimesheetConstants.blocLogName,
          error: failure,
        );
      },
      (overview) {
        emit(_recalculateDerivedState(state.copyWith(overview: overview)));
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

    if (['jpg', 'jpeg', 'png'].contains(extension)) {
      final compressedFile = await imageCompressService.compressImage(
        event.filePath,
      );
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
        emit(
          _recalculateDerivedState(
            state.copyWith(isUploading: false, uploadedFileUrl: fileUrl),
          ),
        );
      },
    );
  }

  Future<void> _onSaveTaskRequested(
    TimesheetSaveTaskRequested event,
    Emitter<TimesheetState> emit,
  ) async {
    final task =
        event.task ??
        ProjectAssignmentEntity(
          name: state.editingTask?.name,
          project:
              state.formSelectedProject?.projectName ??
              state.editingTask?.project ??
              "",
          date: (state.selectedDate ?? DateTime.now()).toIso8601String(),
          taskData: state.formTaskData,
          description: state.formDescription,
          expectedHours: double.tryParse(state.formExpectedHours) ?? 0.0,
          spentHours: double.tryParse(state.formSpentHours) ?? 0.0,
          status: state.editingTask?.status ?? TimesheetStatus.draft,
          attachments: (state.uploadedFileUrl ?? "").isNotEmpty
              ? state.uploadedFileUrl
              : state.editingTask?.attachments,
        );
    final user = state.user;
    final selectedDate = state.selectedDate ?? DateTime.now();
    final from =
        state.editFromDate ??
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final to = state.editToDate ?? from.add(const Duration(days: 6));

    // 1. Validation Checks
    if (task.project.trim().isEmpty) {
      emit(
        _recalculateDerivedState(
          state.copyWith(
            status: TimesheetStateStatus.error,
            errorMessage: TimesheetConstants.selectProjectValidation,
          ),
        ),
      );
      return;
    }
    if (task.taskData == null || task.taskData!.trim().isEmpty) {
      emit(
        _recalculateDerivedState(
          state.copyWith(
            status: TimesheetStateStatus.error,
            errorMessage: TimesheetConstants.taskValidation,
          ),
        ),
      );
      return;
    }
    if (task.expectedHours <= 0.0) {
      emit(
        _recalculateDerivedState(
          state.copyWith(
            status: TimesheetStateStatus.error,
            errorMessage: TimesheetConstants.expectedHoursValidation,
          ),
        ),
      );
      return;
    }
    final isFutureDay = DateTimeUtils.isFutureDay(selectedDate);

    if (!isFutureDay && task.spentHours <= 0.0) {
      emit(
        _recalculateDerivedState(
          state.copyWith(
            status: TimesheetStateStatus.error,
            errorMessage: TimesheetConstants.actualHoursValidation,
          ),
        ),
      );
      return;
    }
    if (task.description == null || task.description!.trim().isEmpty) {
      emit(
        _recalculateDerivedState(
          state.copyWith(
            status: TimesheetStateStatus.error,
            errorMessage: TimesheetConstants.descriptionValidation,
          ),
        ),
      );
      return;
    }

    // 2. Change Detection Checks
    if (task.name != null) {
      ProjectAssignmentEntity? originalTask;
      try {
        originalTask = state.editAssignments.firstWhere(
          (a) => a.name == task.name,
        );
      } catch (_) {}

      if (originalTask != null) {
        final hasChanges =
            task.taskData != originalTask.taskData ||
            task.description != originalTask.description ||
            task.expectedHours != originalTask.expectedHours ||
            task.spentHours != originalTask.spentHours ||
            task.project != originalTask.project ||
            task.attachments != originalTask.attachments;

        if (!hasChanges) {
          emit(
            _recalculateDerivedState(
              state.copyWith(
                status: TimesheetStateStatus.error,
                errorMessage: TimesheetConstants.noChangesDone,
              ),
            ),
          );
          return;
        }
      }
    }

    final effectiveId =
        state.currentWeekActiveId ??
        ((event.timesheetId != "0" && event.timesheetId != "current")
            ? event.timesheetId
            : null);

    final onlyThisTask = [task];

    if (effectiveId == null) {
      add(
        TimesheetEvent.submitRequested(
          employee: user?.empId ?? "",
          department: user?.department ?? "",
          approver: user?.approver ?? "",
          fromDate: from.format(),
          toDate: to.format(),
          assignments: onlyThisTask,
          docStatus: 0,
        ),
      );
    } else {
      add(
        TimesheetEvent.updateRequested(
          name: effectiveId,
          employee: user?.empId ?? "",
          department: user?.department ?? "",
          approver: user?.approver ?? "",
          fromDate: from.format(),
          toDate: to.format(),
          approved: 0,
          hoursTotal: task.spentHours,
          assignments: onlyThisTask,
        ),
      );
    }

    add(const TimesheetEvent.clearUploadedFile());
  }

  Future<void> _onPreviousWeekRequested(
    TimesheetPreviousWeekRequested event,
    Emitter<TimesheetState> emit,
  ) async {
    final current = state.selectedDate ?? DateTime.now();
    final prevWeekDate = current.subtract(const Duration(days: 7));
    final startOfWeek = prevWeekDate.subtract(
      Duration(days: prevWeekDate.weekday - 1),
    );
    final dominantMonth = DateTimeUtils.getDominantMonthOfWeek(startOfWeek);
    final dominantYear = DateTimeUtils.getDominantYearOfWeek(startOfWeek);
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    final prevStartOfWeek = current.subtract(
      Duration(days: current.weekday - 1),
    );
    final prevDominantMonth = DateTimeUtils.getDominantMonthOfWeek(
      prevStartOfWeek,
    );
    final prevDominantYear = DateTimeUtils.getDominantYearOfWeek(
      prevStartOfWeek,
    );

    emit(
      _ensureNonErrorState(
        state.copyWith(
          selectedDate: prevWeekDate,
          editFromDate: startOfWeek,
          editToDate: endOfWeek,
        ),
      ),
    );

    if (dominantMonth != prevDominantMonth ||
        dominantYear != prevDominantYear) {
      _refreshCurrentMonthData(prevWeekDate);
    }
  }

  Future<void> _onNextWeekRequested(
    TimesheetNextWeekRequested event,
    Emitter<TimesheetState> emit,
  ) async {
    final current = state.selectedDate ?? DateTime.now();
    final nextWeekDate = current.add(const Duration(days: 7));
    final startOfWeek = nextWeekDate.subtract(
      Duration(days: nextWeekDate.weekday - 1),
    );
    final dominantMonth = DateTimeUtils.getDominantMonthOfWeek(startOfWeek);
    final dominantYear = DateTimeUtils.getDominantYearOfWeek(startOfWeek);
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    final prevStartOfWeek = current.subtract(
      Duration(days: current.weekday - 1),
    );
    final prevDominantMonth = DateTimeUtils.getDominantMonthOfWeek(
      prevStartOfWeek,
    );
    final prevDominantYear = DateTimeUtils.getDominantYearOfWeek(
      prevStartOfWeek,
    );

    emit(
      _ensureNonErrorState(
        state.copyWith(
          selectedDate: nextWeekDate,
          editFromDate: startOfWeek,
          editToDate: endOfWeek,
        ),
      ),
    );

    if (dominantMonth != prevDominantMonth ||
        dominantYear != prevDominantYear) {
      _refreshCurrentMonthData(nextWeekDate);
    }
  }

  Future<void> _onRefreshRequested(
    TimesheetRefreshRequested event,
    Emitter<TimesheetState> emit,
  ) async {
    _refreshCurrentMonthData(state.selectedDate ?? DateTime.now());
  }

  void _onFormTaskDataChanged(
    TimesheetFormTaskDataChanged event,
    Emitter<TimesheetState> emit,
  ) {
    emit(_ensureNonErrorState(state.copyWith(formTaskData: event.taskData)));
  }

  void _onFormDescriptionChanged(
    TimesheetFormDescriptionChanged event,
    Emitter<TimesheetState> emit,
  ) {
    emit(
      _ensureNonErrorState(state.copyWith(formDescription: event.description)),
    );
  }

  void _onFormExpectedHoursChanged(
    TimesheetFormExpectedHoursChanged event,
    Emitter<TimesheetState> emit,
  ) {
    emit(
      _ensureNonErrorState(
        state.copyWith(formExpectedHours: event.expectedHours),
      ),
    );
  }

  void _onFormSpentHoursChanged(
    TimesheetFormSpentHoursChanged event,
    Emitter<TimesheetState> emit,
  ) {
    emit(
      _ensureNonErrorState(state.copyWith(formSpentHours: event.spentHours)),
    );
  }

  void _onFormProjectChanged(
    TimesheetFormProjectChanged event,
    Emitter<TimesheetState> emit,
  ) {
    emit(
      _ensureNonErrorState(state.copyWith(formSelectedProject: event.project)),
    );
  }

  Future<void> _onPickAndUploadFileRequested(
    TimesheetPickAndUploadFileRequested event,
    Emitter<TimesheetState> emit,
  ) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null && result.files.first.path != null) {
      add(TimesheetEvent.uploadFileRequested(result.files.first.path!));
    }
  }
}
