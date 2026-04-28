# Timesheet Feature — Complete Fix Instructions for AI

**Project:** `dhira_hrms` Flutter app  
**Feature scope:** `lib/features/timesheet/` (all layers)  
**Architecture:** Clean Architecture + BLoC + GetX DI + Freezed + Dartz Either  

Apply every fix below **in the order listed**. Each fix specifies the exact file, the exact text to find, and the exact replacement. Do not change anything outside what is specified. Run `flutter analyze` after all fixes are applied and resolve any new errors before committing.

---

## FIX 1 — Add missing accessors to `LocalStorageService`

**File:** `lib/core/services/local_storage_service.dart`

**Find:**
```dart
  // Employee ID Management
  String? getEmpId() {
    return _prefs.getString(_empIdKey);
  }

  // Gender Management
  String? getGender() {
    return _prefs.getString(StorageConstants.gender);
  }
```

**Replace with:**
```dart
  // Employee ID Management
  String? getEmpId() {
    return _prefs.getString(_empIdKey);
  }

  // User fullname
  String? getUserFullname() {
    return _prefs.getString(StorageConstants.userFullname);
  }

  // Department
  String? getDepartment() {
    return _prefs.getString(StorageConstants.department);
  }

  // Approver
  String? getApprover() {
    return _prefs.getString(StorageConstants.leaveApprover);
  }

  // Gender Management
  String? getGender() {
    return _prefs.getString(StorageConstants.gender);
  }
```

---

## FIX 2 — Rewrite `timesheet_bloc.dart` completely

**File:** `lib/features/timesheet/presentation/bloc/timesheet_bloc.dart`

**Replace the entire file content with:**

```dart
import 'dart:developer' show log;

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../domain/usecases/get_projects_usecase.dart';
import '../../domain/usecases/create_timesheet_usecase.dart';
import '../../domain/usecases/update_timesheet_usecase.dart';
import '../../domain/usecases/get_week_wise_timesheet_usecase.dart';
import '../../domain/usecases/delete_timesheet_entry_usecase.dart';
import '../../domain/usecases/get_timesheet_overview_usecase.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../../core/utils/date_time_utils.dart';
import 'timesheet_event.dart';
import 'timesheet_state.dart';

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
    on<_Started>(_onStarted);
    on<_UserInitRequested>(_onUserInitRequested);
    on<_FromDateChanged>((e, emit) => emit(_ensureNonErrorState(state.copyWith(editFromDate: e.date))));
    on<_ToDateChanged>((e, emit) => emit(_ensureNonErrorState(state.copyWith(editToDate: e.date))));
    on<_AssignmentsChanged>((e, emit) => emit(_ensureNonErrorState(state.copyWith(editAssignments: e.assignments))));
    on<_DaySelected>((e, emit) => emit(_ensureNonErrorState(state.copyWith(selectedDate: e.date))));
    on<_SubmitRequested>(_onSubmitRequested);
    on<_UpdateRequested>(_onUpdateRequested);
    on<_FetchMonthWiseRequested>(_onFetchMonthWiseRequested);
    on<_DeleteEntryRequested>(_onDeleteEntryRequested);
    on<_FetchOverviewRequested>(_onFetchOverviewRequested);
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
        overview: e.overview,
      ),
      orElse: () => s,
    );
  }

  Future<void> _onUserInitRequested(_UserInitRequested event, Emitter<TimesheetState> emit) async {
    final projectsResult = await getProjectsUseCase();
    final projects = projectsResult.getOrElse(() => []);

    final user = UserEntity(
      empId: localStorageService.getEmpId() ?? '',
      fullName: localStorageService.getUserFullname() ?? '',
      email: '',
      department: localStorageService.getDepartment(),
      approver: localStorageService.getApprover(),
    );

    emit(state.copyWith(user: user, projects: projects));
  }

  Future<void> _onStarted(_Started event, Emitter<TimesheetState> emit) async {
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
    add(TimesheetEvent.fetchOverviewRequested(month: now.month, year: now.year));
  }

  Future<void> _onSubmitRequested(_SubmitRequested event, Emitter<TimesheetState> emit) async {
    final previousState = state;

    emit(state.maybeMap(
      loaded: (s) => s.copyWith(isActionLoading: true),
      initial: (s) => s.copyWith(isActionLoading: true),
      orElse: () => state,
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
      (failure) async => emit(previousState.copyWith(isActionLoading: false)),
      (serverName) async {
        emit(TimesheetState.success(
          message: event.docStatus == 0 ? "Task added to day" : "Timesheet submitted successfully",
          user: state.user,
          timesheets: state.timesheets,
          editFromDate: state.editFromDate,
          editToDate: state.editToDate,
          selectedDate: state.selectedDate,
          editAssignments: event.assignments,
          projects: state.projects,
          activeTimesheetId: serverName.isNotEmpty ? serverName : null,
          overview: state.overview,
        ));

        final date = state.selectedDate ?? DateTime.now();
        await _onFetchMonthWiseRequested(
          TimesheetEvent.fetchMonthWiseRequested(month: date.month, year: date.year) as _FetchMonthWiseRequested,
          emit,
        );
      },
    );
  }

  Future<void> _onUpdateRequested(_UpdateRequested event, Emitter<TimesheetState> emit) async {
    final previousState = state;

    emit(state.maybeMap(
      loaded: (s) => s.copyWith(isActionLoading: true),
      initial: (s) => s.copyWith(isActionLoading: true),
      orElse: () => state,
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
      (failure) async => emit(previousState.copyWith(isActionLoading: false)),
      (serverName) async {
        final resolvedName = serverName.isNotEmpty ? serverName : event.name;

        emit(TimesheetState.success(
          message: event.approved == 0 ? "Task updated successfully" : "Timesheet submitted successfully",
          user: state.user,
          timesheets: state.timesheets,
          editFromDate: state.editFromDate,
          editToDate: state.editToDate,
          selectedDate: state.selectedDate,
          editAssignments: event.assignments,
          projects: state.projects,
          activeTimesheetId: resolvedName,
          overview: state.overview,
        ));

        final date = state.selectedDate ?? DateTime.now();
        await _onFetchMonthWiseRequested(
          TimesheetEvent.fetchMonthWiseRequested(month: date.month, year: date.year) as _FetchMonthWiseRequested,
          emit,
        );
      },
    );
  }

  Future<void> _onFetchMonthWiseRequested(_FetchMonthWiseRequested event, Emitter<TimesheetState> emit) async {
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
      overview: state.overview,
    ));

    final result = await getWeekWiseTimesheetUseCase(month: event.month, year: event.year);

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
        overview: state.overview,
      )),
      (assignments) {
        emit(TimesheetState.loaded(
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
        ));
        // Overview is NOT re-fetched here — _onStarted and explicit navigation handle it
      },
    );
  }

  Future<void> _onDeleteEntryRequested(_DeleteEntryRequested event, Emitter<TimesheetState> emit) async {
    final previousState = state;

    emit(state.maybeMap(
      loaded: (s) => s.copyWith(isActionLoading: true),
      initial: (s) => s.copyWith(isActionLoading: true),
      orElse: () => state,
    ));

    final result = await deleteTimesheetEntryUseCase(
      name: event.name,
      parent: event.parent,
      date: event.date,
    );

    await result.fold(
      (failure) async => emit(previousState.copyWith(isActionLoading: false)),
      (_) async {
        final updatedAssignments = state.editAssignments.where((a) => a.name != event.name).toList();

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
          overview: state.overview,
        ));

        final date = state.selectedDate ?? DateTime.now();
        await _onFetchMonthWiseRequested(
          TimesheetEvent.fetchMonthWiseRequested(month: date.month, year: date.year) as _FetchMonthWiseRequested,
          emit,
        );
      },
    );
  }

  Future<void> _onFetchOverviewRequested(_FetchOverviewRequested event, Emitter<TimesheetState> emit) async {
    final result = await getTimesheetOverviewUseCase(month: event.month, year: event.year);

    result.fold(
      (failure) {
        assert(() {
          log('TimesheetBloc: overview fetch failed — ${failure.message}', name: 'Timesheet');
          return true;
        }());
      },
      (overview) => emit(state.copyWith(overview: overview)),
    );
  }
}
```

---

## FIX 3 — Rewrite `timesheet_state.dart` (remove dead `detailLoaded`, fix `@override`)

**File:** `lib/features/timesheet/presentation/bloc/timesheet_state.dart`

**Replace the entire file content with:**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/timesheet_overview_entity.dart';

part 'timesheet_state.freezed.dart';

@freezed
abstract class TimesheetState with _$TimesheetState {
  const factory TimesheetState.initial({
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    DateTime? selectedDate,
    @Default([]) List<TimesheetEntity> timesheets,
    @Default(false) bool hasMore,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
    @Default(false) bool isActionLoading,
    String? activeTimesheetId,
    TimesheetOverviewEntity? overview,
  }) = _Initial;

  const factory TimesheetState.loading({
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    DateTime? selectedDate,
    @Default([]) List<TimesheetEntity> timesheets,
    @Default(false) bool hasMore,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
    @Default(false) bool isActionLoading,
    String? activeTimesheetId,
    TimesheetOverviewEntity? overview,
  }) = _Loading;

  const factory TimesheetState.loaded({
    required List<TimesheetEntity> timesheets,
    @Default(false) bool hasMore,
    @Default(false) bool isFetchingMore,
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    DateTime? selectedDate,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
    @Default(false) bool isActionLoading,
    String? activeTimesheetId,
    TimesheetOverviewEntity? overview,
  }) = _Loaded;

  const factory TimesheetState.success({
    required String message,
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    DateTime? selectedDate,
    @Default([]) List<TimesheetEntity> timesheets,
    @Default(false) bool hasMore,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
    @Default(false) bool isActionLoading,
    String? activeTimesheetId,
    TimesheetOverviewEntity? overview,
  }) = _Success;

  const factory TimesheetState.error({
    required String message,
    UserEntity? user,
    DateTime? editFromDate,
    DateTime? editToDate,
    DateTime? selectedDate,
    @Default([]) List<TimesheetEntity> timesheets,
    @Default(false) bool hasMore,
    @Default([]) List<ProjectAssignmentEntity> editAssignments,
    @Default([]) List<ProjectEntity> projects,
    @Default(false) bool isActionLoading,
    String? activeTimesheetId,
    TimesheetOverviewEntity? overview,
  }) = _Error;

  const TimesheetState._();

  UserEntity? get user;
  DateTime? get editFromDate;
  DateTime? get editToDate;
  DateTime? get selectedDate;
  List<TimesheetEntity> get timesheets;
  bool get hasMore;
  List<ProjectAssignmentEntity> get editAssignments;
  List<ProjectEntity> get projects;
  bool get isActionLoading;
  String? get activeTimesheetId;
  TimesheetOverviewEntity? get overview;
}
```

After saving, run:
```
dart run build_runner build --delete-conflicting-outputs
```

---

## FIX 4 — Update DI registration for `TimesheetBloc`

**File:** `lib/core/di/dependency_injection.dart`

**Find:**
```dart
    Get.lazyPut<TimesheetBloc>(
      () => TimesheetBloc(
        getProjectsUseCase: Get.find<GetProjectsUseCase>(),
        createTimesheetUseCase: Get.find<CreateTimesheetUseCase>(),
        updateTimesheetUseCase: Get.find<UpdateTimesheetUseCase>(),
        getWeekWiseTimesheetUseCase: Get.find<GetWeekWiseTimesheetUseCase>(),
        deleteTimesheetEntryUseCase: Get.find<DeleteTimesheetEntryUseCase>(),
        getTimesheetOverviewUseCase: Get.find<GetTimesheetOverviewUseCase>(),
        authRepository: Get.find<IAuthRepository>(),
        sharedPreferences: sharedPrefs,
      ),
      fenix: true,
    );
```

**Replace with:**
```dart
    Get.lazyPut<TimesheetBloc>(
      () => TimesheetBloc(
        getProjectsUseCase: Get.find<GetProjectsUseCase>(),
        createTimesheetUseCase: Get.find<CreateTimesheetUseCase>(),
        updateTimesheetUseCase: Get.find<UpdateTimesheetUseCase>(),
        getWeekWiseTimesheetUseCase: Get.find<GetWeekWiseTimesheetUseCase>(),
        deleteTimesheetEntryUseCase: Get.find<DeleteTimesheetEntryUseCase>(),
        getTimesheetOverviewUseCase: Get.find<GetTimesheetOverviewUseCase>(),
        localStorageService: Get.find<LocalStorageService>(),
      ),
      fenix: true,
    );
```

---

## FIX 5 — Delete `timesheet_list_screen.dart` (entire file is commented-out dead code)

**Action:** Delete the file.

```bash
rm lib/features/timesheet/presentation/screens/timesheet_list_screen.dart
```

If any import references it elsewhere, remove those imports too. Verify with:
```bash
grep -r "timesheet_list_screen" lib/
```

---

## FIX 6 — Remove `flutter/cupertino.dart` import and `debugPrint` from `timesheet_repository_impl.dart`

**File:** `lib/features/timesheet/data/repositories/timesheet_repository_impl.dart`

**Step 6a — Fix imports. Find:**
```dart
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
```

**Replace with:**
```dart
import 'dart:convert';
import 'dart:developer' show log;

import 'package:dartz/dartz.dart';
```

**Step 6b — Remove `debugPrint` for create payload. Find:**
```dart
        debugPrint("CREATE(Custom) payload is ${jsonEncode(payload)}");
        
        final result = await remoteDataSource.createTimesheet(payload);
```

**Replace with:**
```dart
        final result = await remoteDataSource.createTimesheet(payload);
```

**Step 6c — Remove `debugPrint` for update payload. Find:**
```dart
        debugPrint("UPDATE(SYNC) payload is ${jsonEncode(payload)}");

        final result = await remoteDataSource.updateTimesheet(payload);
```

**Replace with:**
```dart
        final result = await remoteDataSource.updateTimesheet(payload);
```

**Step 6d — Remove `debugPrint` for assignments count. Find:**
```dart
        debugPrint("REPO: Extracted ${allAssignments.length} total assignments for month $month/$year");
        return Right(allAssignments);
```

**Replace with:**
```dart
        return Right(allAssignments);
```

---

## FIX 7 — Remove redundant `Content-Type` headers from datasource

**File:** `lib/features/timesheet/data/datasources/timesheet_remote_datasource.dart`

**Step 7a. Find:**
```dart
    final response = await dioClient.post(
      TimesheetApiConstants.createTimesheet,
      data: payload,
      options: Options(headers: {"Content-Type": "application/json"}),
    );
```

**Replace with:**
```dart
    final response = await dioClient.post(
      TimesheetApiConstants.createTimesheet,
      data: payload,
    );
```

**Step 7b. Find:**
```dart
    final response = await dioClient.post(
      TimesheetApiConstants.updateTimesheet,
      data: payload,
      options: Options(headers: {"Content-Type": "application/json"}),
    );
```

**Replace with:**
```dart
    final response = await dioClient.post(
      TimesheetApiConstants.updateTimesheet,
      data: payload,
    );
```

**Step 7c. Find:**
```dart
    final response = await dioClient.post(
      TimesheetApiConstants.deleteEntry,
      data: payload,
      options: Options(headers: {"Content-Type": "application/json"}),
    );
```

**Replace with:**
```dart
    final response = await dioClient.post(
      TimesheetApiConstants.deleteEntry,
      data: payload,
    );
```

**Step 7d — Remove manual statusCode checks. Find:**
```dart
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }
    throw ServerException(message: "Failed to fetch month data", code: response.statusCode);
  }
```

**Replace with:**
```dart
    return response.data as Map<String, dynamic>;
  }
```

**Step 7e. Find:**
```dart
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }
    throw ServerException(message: "Failed to fetch overview data", code: response.statusCode);
  }
```

**Replace with:**
```dart
    return response.data as Map<String, dynamic>;
  }
```

After steps 7a–7c removed the `Options` usage, also remove the now-unused `dio` import if `Options` was the only thing from it. Check if `Options` is still used in `_handleMutationResponse` — it is not, so verify:

**Find at top of file:**
```dart
import 'package:dio/dio.dart';
```

Check if `Response` (used in `_handleMutationResponse` parameter type) still requires this import. It does — `Response` is from `dio`. Keep the import.

---

## FIX 8 — Convert `TimesheetOverviewModel` to `@freezed`

**File:** `lib/features/timesheet/data/models/timesheet_overview_model.dart`

**Replace the entire file content with:**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/timesheet_overview_entity.dart';

part 'timesheet_overview_model.freezed.dart';
part 'timesheet_overview_model.g.dart';

@freezed
abstract class TimesheetOverviewModel with _$TimesheetOverviewModel {
  const factory TimesheetOverviewModel({
    @Default(0) int filled,
    @JsonKey(name: 'pending_approval') @Default(0) int pendingApproval,
    @JsonKey(name: 'correction_needed') @Default(0) int correctionNeeded,
    @JsonKey(name: 'upcoming_to_submit') @Default(0) int upcomingToSubmit,
    @Default(0) int approved,
    @JsonKey(name: 'total_weeks') @Default(0) int totalWeeks,
    @JsonKey(name: 'week_meta') @Default({}) Map<String, dynamic> weekMeta,
  }) = _TimesheetOverviewModel;

  const TimesheetOverviewModel._();

  factory TimesheetOverviewModel.fromJson(Map<String, dynamic> json) =>
      _$TimesheetOverviewModelFromJson(json);

  TimesheetOverviewEntity toEntity() => TimesheetOverviewEntity(
    filled: filled,
    pendingApproval: pendingApproval,
    correctionNeeded: correctionNeeded,
    upcomingToSubmit: upcomingToSubmit,
    approved: approved,
    totalWeeks: totalWeeks,
    weekMeta: weekMeta,
  );
}
```

Run codegen:
```
dart run build_runner build --delete-conflicting-outputs
```

---

## FIX 9 — Fix state mutation inside `build()` in `TimesheetApplyForm`

**File:** `lib/features/timesheet/presentation/widgets/timesheet_apply_form.dart`

**Step 9a — Remove the side-effect block from `build()`. Find:**
```dart
        // Automatic project matching when editing starts
        if (widget.editingTask != null && _selectedProject == null && projects.isNotEmpty) {
          try {
            _selectedProject = projects.firstWhere((p) => p.projectName == widget.editingTask!.project);
          } catch (_) {
            // No match found
          }
        }
```

**Replace with:**
```dart
```
(Delete those 7 lines entirely.)

**Step 9b — Update `_prefillForm()` to handle project matching. Find:**
```dart
  void _prefillForm() {
    if (widget.editingTask != null) {
      _taskController.text = widget.editingTask!.taskData ?? '';
      _descriptionController.text = widget.editingTask!.description ?? '';
      _expectedController.text = widget.editingTask!.expectedHours.toString();
      _actualController.text = widget.editingTask!.spentHours.toString();
      // Project matching will happen in the build method once projects are loaded
    } else {
      _taskController.clear();
      _expectedController.clear();
      _actualController.clear();
      _descriptionController.clear();
      _selectedProject = null;
    }
  }
```

**Replace with:**
```dart
  void _prefillForm() {
    if (widget.editingTask != null) {
      _taskController.text = widget.editingTask!.taskData ?? '';
      _descriptionController.text = widget.editingTask!.description ?? '';
      _expectedController.text = widget.editingTask!.expectedHours.toString();
      _actualController.text = widget.editingTask!.spentHours.toString();
      _matchProject();
    } else {
      _taskController.clear();
      _expectedController.clear();
      _actualController.clear();
      _descriptionController.clear();
      _selectedProject = null;
    }
  }

  void _matchProject() {
    if (widget.editingTask == null) return;
    final bloc = context.findAncestorStateOfType<State>()?.context;
    // Project matching is deferred to the BlocBuilder — see _tryMatchProject()
  }

  void _tryMatchProject(List<ProjectEntity> projects) {
    if (widget.editingTask == null || _selectedProject != null || projects.isEmpty) return;
    try {
      final match = projects.firstWhere((p) => p.projectName == widget.editingTask!.project);
      if (mounted) setState(() => _selectedProject = match);
    } catch (_) {}
  }
```

**Step 9c — Call `_tryMatchProject` safely in `BlocBuilder`. Inside the `BlocBuilder` builder, find:**
```dart
        final selectedProjectName = _selectedProject?.projectName;
```

**Replace with:**
```dart
        // Trigger project matching after projects load — safe, not inside build
        WidgetsBinding.instance.addPostFrameCallback((_) => _tryMatchProject(projects));

        final selectedProjectName = _selectedProject?.projectName;
```

---

## FIX 10 — Remove dead `_buildDropdown()` method from `TimesheetApplyForm`

**File:** `lib/features/timesheet/presentation/widgets/timesheet_apply_form.dart`

**Find and delete these lines entirely:**
```dart
  Widget _buildDropdown(List<ProjectEntity> projects) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: TimesheetColors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ProjectEntity>(
          value: _selectedProject,
          isExpanded: true,
          icon: const Icon(Icons.expand_more, color: TimesheetColors.textSecondary),
          hint: Text("Select a project", style: TimesheetStyles.bodyMedium),
          items: projects.map((p) {
            return DropdownMenuItem(
              value: p,
              child: Text(p.projectName, style: TimesheetStyles.bodyMedium),
            );
          }).toList(),
          onChanged: (val) => setState(() => _selectedProject = val),
        ),
      ),
    );
  }
```

---

## FIX 11 — Remove `debugPrint` from `TimesheetApplyForm` and stub the image picker

**File:** `lib/features/timesheet/presentation/widgets/timesheet_apply_form.dart`

**Step 11a — Remove debugPrint. Find:**
```dart
    debugPrint("UI: New Task Data to add: name='${newTask.name}', taskData='${newTask.taskData}'");
```

**Replace with:**
```dart
```
(Delete that line.)

**Step 11b — Stub image picker with toast. Find:**
```dart
  Widget _buildUploadPlaceholder() {
    return GestureDetector(
      onTap: () async {
        final picker = ImagePicker();
        await picker.pickImage(source: ImageSource.gallery);
      },
```

**Replace with:**
```dart
  Widget _buildUploadPlaceholder() {
    return GestureDetector(
      onTap: () {
        ToastUtils.showInfo("Document upload coming soon");
      },
```

**Step 11c — Remove now-unused `image_picker` import. Find:**
```dart
import 'package:image_picker/image_picker.dart';
```

**Replace with:**
```dart
```
(Delete that line.)

---

## FIX 12 — Fix heavy computation in `build()` in `ApplyTimesheetScreen`

**File:** `lib/features/timesheet/presentation/screens/apply_timesheet_screen.dart`

**Step 12a — Add `_availableMonths` field. Find:**
```dart
class _ApplyTimesheetScreenState extends State<ApplyTimesheetScreen> {
  ProjectAssignmentEntity? _editingTask;
  int? _editingIndex;
```

**Replace with:**
```dart
class _ApplyTimesheetScreenState extends State<ApplyTimesheetScreen> {
  ProjectAssignmentEntity? _editingTask;
  int? _editingIndex;
  late final List<DateTime> _availableMonths;
```

**Step 12b — Initialise `_availableMonths` in `initState`. Find:**
```dart
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
```

**Replace with:**
```dart
  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _availableMonths = List.generate(5, (i) => DateTime(now.year, now.month - 3 + i, 1));
    WidgetsBinding.instance.addPostFrameCallback((_) {
```

**Step 12c — Move `formatWeeks` and `findActiveIdForWeek` out of `build()`.** Find the full block below (inside `build()`) and delete it:
```dart
            // Helper to format week lists from metadata
            String formatWeeks(dynamic data) {
              if (data == null) return "";
              if (data is List) {
                if (data.isEmpty) return "";
                final labels = data.map((item) {
                  if (item is Map && item.containsKey('label')) {
                    return item['label'].toString();
                  }
                  return "Week $item";
                }).toList();
                return labels.join(", ");
              }
              return "";
            }
```

And delete:
```dart
            // Dynamically find the active timesheet ID for the CURRENT selected week
            String? findActiveIdForWeek() {
              if (state.editAssignments.isEmpty) return null;
              final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
              final endOfWeek = startOfWeek.add(const Duration(days: 6));
              
              final weekOnlyStart = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
              final weekOnlyEnd = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59);

              for (var a in state.editAssignments) {
                if (a.date == null || a.parent == null) continue;
                final d = DateTime.tryParse(a.date!);
                if (d != null && d.isAfter(weekOnlyStart.subtract(const Duration(seconds: 1))) && d.isBefore(weekOnlyEnd)) {
                  return a.parent;
                }
              }
              return null;
            }
```

And delete:
```dart
            // Calculate the 5 month options (past 3, current, next 1)
            final now = DateTime.now();
            final availableMonths = List.generate(5, (index) {
              return DateTime(now.year, now.month - 3 + index, 1);
            });
```

**Step 12d — Add the two methods at class level.** Add these two methods to `_ApplyTimesheetScreenState` before the `build()` method:
```dart
  String _formatWeeks(dynamic data) {
    if (data == null) return "";
    if (data is List) {
      if (data.isEmpty) return "";
      return data.map((item) {
        if (item is Map && item.containsKey('label')) return item['label'].toString();
        return "Week $item";
      }).join(", ");
    }
    return "";
  }

  String? _findActiveIdForWeek(DateTime selectedDate, List<ProjectAssignmentEntity> assignments) {
    if (assignments.isEmpty) return null;
    final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final weekStart = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    final weekEnd = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59);

    for (var a in assignments) {
      if (a.date == null || a.parent == null) continue;
      final d = DateTime.tryParse(a.date!);
      if (d != null && d.isAfter(weekStart.subtract(const Duration(seconds: 1))) && d.isBefore(weekEnd)) {
        return a.parent;
      }
    }
    return null;
  }
```

**Step 12e — Update call sites inside `build()` to use the new methods and field.**

Find:
```dart
            final currentWeekActiveId = findActiveIdForWeek();
```

**Replace with:**
```dart
            final currentWeekActiveId = _findActiveIdForWeek(selectedDate, state.editAssignments);
```

Find all occurrences of `formatWeeks(` inside `build()` and replace with `_formatWeeks(`. There are 5 occurrences:
```dart
                          filledWeeks: formatWeeks(weekMeta['filled']),
                          approvedWeeks: formatWeeks(weekMeta['approved']),
                          pendingWeeks: formatWeeks(weekMeta['pending_approval']),
                          rejectedWeeks: formatWeeks(weekMeta['correction_needed']),
                          upcomingWeeks: formatWeeks(weekMeta['upcoming_to_submit']),
```

**Replace with:**
```dart
                          filledWeeks: _formatWeeks(weekMeta['filled']),
                          approvedWeeks: _formatWeeks(weekMeta['approved']),
                          pendingWeeks: _formatWeeks(weekMeta['pending_approval']),
                          rejectedWeeks: _formatWeeks(weekMeta['correction_needed']),
                          upcomingWeeks: _formatWeeks(weekMeta['upcoming_to_submit']),
```

Find:
```dart
                              value: availableMonths.firstWhere(
```

**Replace with:**
```dart
                              value: _availableMonths.firstWhere(
```

Find:
```dart
                              items: availableMonths.map((date) {
```

**Replace with:**
```dart
                              items: _availableMonths.map((date) {
```

---

## FIX 13 — Replace raw `AlertDialog` with `AppDialogs` in `ApplyTimesheetScreen`

**File:** `lib/features/timesheet/presentation/screens/apply_timesheet_screen.dart`

**Step 13a — Add `AppDialogs` import if missing.** At the top of the file, add:
```dart
import '../../../../shared/components/app_dialogs.dart';
```

**Step 13b — Replace the delete dialog. Find:**
```dart
                          onDelete: (idx) async {
                            final task = assignmentsForDay[idx];
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                title: const Text("Delete Task"),
                                content: Text("Are you sure you want to delete \"${task.description?.isNotEmpty == true ? task.description : task.project}\"?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: TimesheetColors.error),
                                    onPressed: () => Navigator.pop(ctx, true),
                                    child: const Text("Delete", style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            );
```

**Replace with:**
```dart
                          onDelete: (idx) async {
                            final task = assignmentsForDay[idx];
                            final taskLabel = task.description?.isNotEmpty == true ? task.description! : task.project;
                            final confirmed = await AppDialogs.showConfirmation(
                              context: context,
                              title: "Delete Task",
                              message: "Are you sure you want to delete \"$taskLabel\"?",
                              confirmLabel: "Delete",
                              isDestructive: true,
                            );
```

> **Note:** If `AppDialogs.showConfirmation` does not exist yet, locate `lib/shared/components/app_dialogs.dart` and add:
> ```dart
> static Future<bool> showConfirmation({
>   required BuildContext context,
>   required String title,
>   required String message,
>   String confirmLabel = "Confirm",
>   bool isDestructive = false,
> }) async {
>   final result = await showDialog<bool>(
>     context: context,
>     builder: (ctx) => AlertDialog(
>       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
>       title: Text(title),
>       content: Text(message),
>       actions: [
>         TextButton(
>           onPressed: () => Navigator.pop(ctx, false),
>           child: const Text("Cancel"),
>         ),
>         ElevatedButton(
>           style: ElevatedButton.styleFrom(
>             backgroundColor: isDestructive ? AppColors.error : AppColors.primary,
>           ),
>           onPressed: () => Navigator.pop(ctx, true),
>           child: Text(confirmLabel, style: const TextStyle(color: Colors.white)),
>         ),
>       ],
>     ),
>   );
>   return result ?? false;
> }
> ```

---

## FIX 14 — Migrate `TimesheetColors` / `TimesheetStyles` usages to `AppColors` / `AppTextStyle`

This is the largest migration. Do it in order: first add any missing tokens to `AppColors`/`AppTextStyle`, then update each widget file, then delete `timesheet_theme.dart`.

### Step 14a — Add missing tokens to `AppColors`

**File:** `lib/core/theme/app_colors.dart`

Locate the file and add these constants if they are not already present (check before adding):
```dart
  // Status colours used by timesheet
  static const Color successLight = Color(0xffdcfce7);
  static const Color successDark = Color(0xff15803d);
  static const Color warningLight = Color(0xffffedd5);
  static const Color warningDark = Color(0xffc2410c);
  static const Color errorLight = Color(0xfffee2e2);
  static const Color errorDark = Color(0xffb91c1c);
  static const Color primaryFixed = Color(0xffdce1ff);
  static const Color onPrimaryFixedVariant = Color(0xff003baf);
  static const Color tertiaryFixed = Color(0xffffdbd0);
  static const Color tertiary = Color(0xff992f00);
```

### Step 14b — Add missing text styles to `AppTextStyle`

**File:** `lib/core/theme/app_text_style.dart`

Add these if not already present:
```dart
  static TextStyle get statsValue => GoogleFonts.manrope(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
  );

  static TextStyle get statsLabel => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: AppColors.textSecondary,
  );

  static TextStyle get dateNumber => GoogleFonts.manrope(
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  static TextStyle get dateDay => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.2,
  );
```

### Step 14c — Update `timesheet_apply_form.dart`

**Find:**
```dart
import 'timesheet_theme.dart';
```
**Replace with:**
```dart
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
```

Then do a **find-and-replace-all** within this file:
| Find | Replace |
|---|---|
| `TimesheetColors.surfaceContainerLowest` | `AppColors.surface` |
| `TimesheetColors.surfaceContainerHighest` | `AppColors.surfaceVariant` |
| `TimesheetColors.surfaceContainerHigh` | `AppColors.surfaceVariant` |
| `TimesheetColors.surfaceContainerLow` | `AppColors.surfaceVariant` |
| `TimesheetColors.primary` | `AppColors.primary` |
| `TimesheetColors.textPrimary` | `AppColors.textPrimary` |
| `TimesheetColors.textSecondary` | `AppColors.textSecondary` |
| `TimesheetColors.border` | `AppColors.border` |
| `TimesheetColors.error` | `AppColors.error` |
| `TimesheetStyles.bodyMedium` | `AppTextStyle.bodyMedium` |
| `TimesheetStyles.bodySmall` | `AppTextStyle.bodySmall` |
| `TimesheetStyles.statsLabel` | `AppTextStyle.statsLabel` |
| `TimesheetStyles.h3` | `AppTextStyle.h3` |
| `TimesheetStyles.button` | `AppTextStyle.button` |
| `Color(0xFF155DFC)` | `AppColors.primary` |

### Step 14d — Update `timesheet_task_section.dart`

**Find:**
```dart
import 'timesheet_theme.dart';
```
**Replace with:**
```dart
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
```

Apply same find-and-replace-all table as 14c. Additionally:
| Find | Replace |
|---|---|
| `TimesheetColors.green100` | `AppColors.successLight` |
| `TimesheetColors.green700` | `AppColors.successDark` |
| `TimesheetColors.orange100` | `AppColors.warningLight` |
| `TimesheetColors.orange700` | `AppColors.warningDark` |
| `TimesheetColors.primaryFixed` | `AppColors.primaryFixed` |
| `TimesheetColors.onPrimaryFixedVariant` | `AppColors.onPrimaryFixedVariant` |
| `TimesheetColors.tertiaryFixed` | `AppColors.tertiaryFixed` |
| `TimesheetColors.tertiary` | `AppColors.tertiary` |

### Step 14e — Update `timesheet_week_selector.dart`

**Find:**
```dart
import 'timesheet_theme.dart';
```
**Replace with:**
```dart
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
```

Apply same table as 14c. Also replace:
| Find | Replace |
|---|---|
| `TimesheetStyles.dateDay` | `AppTextStyle.dateDay` |
| `TimesheetStyles.dateNumber` | `AppTextStyle.dateNumber` |

### Step 14f — Update `timesheet_stats_bento.dart`

**Find:**
```dart
import 'timesheet_theme.dart';
```
**Replace with:**
```dart
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
```

Apply same table as 14c. Also replace:
| Find | Replace |
|---|---|
| `TimesheetStyles.statsValue` | `AppTextStyle.statsValue` |
| `TimesheetStyles.statsLabel` | `AppTextStyle.statsLabel` |
| `TimesheetColors.primaryFixed` | `AppColors.primaryFixed` |
| `TimesheetColors.onPrimaryFixedVariant` | `AppColors.onPrimaryFixedVariant` |

### Step 14g — Update `timesheet_submit_bar.dart`

**Find:**
```dart
import 'timesheet_theme.dart';
```
**Replace with:**
```dart
import '../../../../core/theme/app_colors.dart';
```

Apply same table as 14c. Also replace:
| Find | Replace |
|---|---|
| `Color(0xFF155DFC)` | `AppColors.primary` |

### Step 14h — Update `timesheet_card.dart`

**Find:**
```dart
import 'timesheet_theme.dart';
```
**Replace with:**
```dart
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
```

Apply same table as 14c. Also replace:
| Find | Replace |
|---|---|
| `const Color(0xFFF3F2F7)` | `AppColors.surfaceVariant` |
| `const Color(0xFF1B0EC1)` | `AppColors.primary` |
| `TimesheetStyles.button` | `AppTextStyle.button` |
| `TimesheetStyles.bodySmall` | `AppTextStyle.bodySmall` |

### Step 14i — Update `apply_timesheet_screen.dart`

**Find:**
```dart
import '../widgets/timesheet_theme.dart';
```
**Replace with:**
```dart
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
```

Apply same table as 14c.

### Step 14j — Delete `timesheet_theme.dart`

```bash
rm lib/features/timesheet/presentation/widgets/timesheet_theme.dart
```

Verify no remaining references:
```bash
grep -r "timesheet_theme\|TimesheetColors\|TimesheetStyles" lib/
```

Fix any remaining occurrences that the find-and-replace missed.

---

## FIX 15 — Fix arbitrary task icon in `TimesheetTaskSection`

**File:** `lib/features/timesheet/presentation/widgets/timesheet_task_section.dart`

**Find:**
```dart
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: index % 2 == 0 ? TimesheetColors.primaryFixed : TimesheetColors.tertiaryFixed,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              index % 2 == 0 ? Icons.code : Icons.palette,
              color: index % 2 == 0 ? TimesheetColors.primary : TimesheetColors.tertiary,
              size: 20,
            ),
          ),
```

**Replace with:**
```dart
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryFixed,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.task_alt,
              color: AppColors.onPrimaryFixedVariant,
              size: 20,
            ),
          ),
```

---

## FIX 16 — Fix "This Week" hardcoded label in `TimesheetWeekSelector`

**File:** `lib/features/timesheet/presentation/widgets/timesheet_week_selector.dart`

This widget is a `StatelessWidget` with `BuildContext context` in `build()`. Add `AppLocalizations` import if not already present:
```dart
import '../../../../l10n/app_localizations.dart';
```

**Find:**
```dart
            const Text(
              'This Week',
              style: TextStyle(
                color: TimesheetColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
```

**Replace with:**
```dart
            Text(
              AppLocalizations.of(context)?.thisWeek ?? 'This Week',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
```

Also add `thisWeek` key to all ARB files in `lib/l10n/` (e.g. `app_en.arb`):
```json
"thisWeek": "This Week"
```

---

## FIX 17 — Fix "Today's Tasks" and "No tasks" hardcoded strings in `TimesheetTaskSection`

**File:** `lib/features/timesheet/presentation/widgets/timesheet_task_section.dart`

Add `AppLocalizations` import:
```dart
import '../../../../l10n/app_localizations.dart';
```

**Find:**
```dart
        Row(
          children: [
            Text("Today's Tasks", style: TimesheetStyles.h3.copyWith(fontSize: 14)),
```

**Replace with:**
```dart
        Row(
          children: [
            Text(
              AppLocalizations.of(context)?.todaysTasks ?? "Today's Tasks",
              style: AppTextStyle.h3.copyWith(fontSize: 14),
            ),
```

**Find:**
```dart
              child: Text(
                "No tasks for this day",
                style: TimesheetStyles.bodySmall,
              ),
```

**Replace with:**
```dart
              child: Text(
                AppLocalizations.of(context)?.noTasksForThisDay ?? "No tasks for this day",
                style: AppTextStyle.bodySmall,
              ),
```

Add to all ARB files:
```json
"todaysTasks": "Today's Tasks",
"noTasksForThisDay": "No tasks for this day"
```

---

## FIX 18 — Remove redundant `BlocProvider.value` in `ApplyTimesheetScreen`

**File:** `lib/features/timesheet/presentation/screens/apply_timesheet_screen.dart`

**Find:**
```dart
    return BlocProvider<TimesheetBloc>.value(
      value: Get.find<TimesheetBloc>(),
        child: BlocListener<TimesheetBloc, TimesheetState>(
```

**Replace with:**
```dart
    return BlocListener<TimesheetBloc, TimesheetState>(
```

Then find the matching closing bracket for the removed `BlocProvider`. It is the last `)` before the final `}` in `build()`. Remove it:

**Find (near end of build method):**
```dart
      ),
    );
  }
}
```

If there is one extra `)` from the removed `BlocProvider`, remove it so the widget tree is balanced. Verify by running `flutter analyze`.

---

## Post-Fix Verification

Run all of these after applying every fix:

```bash
# 1. Regenerate freezed + json_serializable files
dart run build_runner build --delete-conflicting-outputs

# 2. Static analysis — must be zero new errors
flutter analyze

# 3. Confirm no TimesheetColors/TimesheetStyles references remain
grep -r "TimesheetColors\|TimesheetStyles\|timesheet_theme" lib/

# 4. Confirm no debugPrint in timesheet feature
grep -r "debugPrint" lib/features/timesheet/

# 5. Confirm dead screen file is gone
ls lib/features/timesheet/presentation/screens/

# 6. Confirm no direct SharedPreferences or IAuthRepository in timesheet BLoC
grep -r "SharedPreferences\|IAuthRepository\|authRepository" lib/features/timesheet/presentation/bloc/

# 7. Debug build
flutter build apk --debug
```

**Manual UI test checklist:**
- [ ] Open timesheet screen — month stats bento shows correct week counts
- [ ] Select a day — tasks for that day display with correct icons
- [ ] Add a task — form submits, success toast appears, task appears in list
- [ ] Edit a task — form pre-fills, update submits, task updates in list  
- [ ] Delete a task — `AppDialogs` confirmation appears, task removed after confirm
- [ ] Navigate previous/next week — week selector and task list update correctly
- [ ] Change month via dropdown — data reloads for selected month
- [ ] Submit weekly timesheet — only draft tasks submitted, navigates back on success
- [ ] Trigger a network error — error state shows, previous data is preserved (rollback works)
