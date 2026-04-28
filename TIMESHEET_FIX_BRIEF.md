# Timesheet Feature — Code Review Fix Brief

**Scope:** `lib/features/timesheet/` (all layers)  
**Review basis:** README.md architecture guidelines (Clean Architecture + BLoC + GetX DI), Flutter best-practice performance  
**Total issues:** 9 Critical · 16 Medium/Minor  

---

## Execution Order

Fix in this order to avoid cascading compile errors:

1. Fix C1 (remove `IAuthRepository` + `SharedPreferences` from BLoC, use `LocalStorageService`)
2. Fix C2 (`timesheet_state.dart` — remove dead state + misleading `@override`)
3. Fix C3 (refactor single mega-handler to individual handlers)
4. Fix C4–C5 (remove dead local variables and dead field)
5. Fix C6 (overview double-fetch)
6. Fix C7 (delete `timesheet_list_screen.dart` dead file)
7. Fix C8–C10 (data layer — `flutter/cupertino`, `debugPrint`, raw Map datasource)
8. Fix M1–M8 (apply_timesheet_screen and apply_form issues)
9. Fix M9 (migrate `TimesheetColors`/`TimesheetStyles` to `AppColors`/`AppTextStyle`)
10. Fix M10 (convert `TimesheetOverviewModel` to freezed)
11. Fix M11–M16 (hardcoded strings, colors, remaining widget issues)

---

## CRITICAL Issues

---

### C1 — BLoC directly injects `IAuthRepository` and `SharedPreferences` (cross-feature + architecture violations)

**Files:**
- `lib/features/timesheet/presentation/bloc/timesheet_bloc.dart:11,12,27,28,39,40,78-92`

**Problem:**
```dart
// WRONG — cross-feature dependency:
import '../../../auth/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimesheetBloc extends Bloc<TimesheetEvent, TimesheetState> {
  final IAuthRepository authRepository;       // cross-feature violation
  final SharedPreferences sharedPreferences;  // architecture violation — data layer in BLoC

  Future<void> _onUserInitRequested(Emitter<TimesheetState> emit) async {
    final results = await Future.wait([
      authRepository.getCurrentUser(),  // calls another feature's repo
      getProjectsUseCase(),
    ]);
    // ...
  }
}
```

**Why it's wrong:**
- The BLoC is presentation layer. It must not depend on another feature's domain repository.
- `SharedPreferences` is a data-layer concern; it must be accessed via `LocalStorageService` (already in DI).
- `LocalStorageService` already stores user data after login. Use it directly.

**Fix:**
1. Add missing accessors to `lib/core/services/local_storage_service.dart` (see M16 — already required by Attendance fix):
```dart
String? getEmpId() => _prefs.getString(StorageConstants.empId);
String? getUserFullname() => _prefs.getString(StorageConstants.userFullname);
String? getDepartment() => _prefs.getString(StorageConstants.department);
String? getApprover() => _prefs.getString(StorageConstants.approver);
```

2. Replace in `timesheet_bloc.dart`:
```dart
// REMOVE these imports:
// import '../../../auth/domain/repositories/auth_repository.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../auth/domain/entities/user_entity.dart';

// ADD:
import '../../../../core/services/local_storage_service.dart';

class TimesheetBloc extends Bloc<TimesheetEvent, TimesheetState> {
  // REMOVE: final IAuthRepository authRepository;
  // REMOVE: final SharedPreferences sharedPreferences;
  final LocalStorageService localStorageService;   // ADD

  TimesheetBloc({
    required this.getProjectsUseCase,
    required this.createTimesheetUseCase,
    required this.updateTimesheetUseCase,
    required this.getWeekWiseTimesheetUseCase,
    required this.deleteTimesheetEntryUseCase,
    required this.getTimesheetOverviewUseCase,
    required this.localStorageService,   // REPLACE authRepository + sharedPreferences
  }) : super(const TimesheetState.initial()) { /* ... */ }

  Future<void> _onUserInitRequested(Emitter<TimesheetState> emit) async {
    // REPLACE the authRepository.getCurrentUser() call with LocalStorageService reads:
    final projectsResult = await getProjectsUseCase();
    final projects = projectsResult.getOrElse(() => []);

    final user = UserEntity(
      empId: localStorageService.getEmpId() ?? '',
      fullName: localStorageService.getUserFullname() ?? '',
      department: localStorageService.getDepartment() ?? '',
      approver: localStorageService.getApprover() ?? '',
    );

    emit(state.copyWith(user: user, projects: projects));
  }
}
```

3. Update DI registration in `lib/core/di/timesheet_module.dart` (or wherever `TimesheetBloc` is registered):
```dart
// REMOVE: authRepository: Get.find<IAuthRepository>(),
// REMOVE: sharedPreferences: Get.find<SharedPreferences>(),
// ADD:
localStorageService: Get.find<LocalStorageService>(),
```

---

### C2 — Single mega-handler `on<TimesheetEvent>` violates README BLoC pattern

**File:** `lib/features/timesheet/presentation/bloc/timesheet_bloc.dart:42-58`

**Problem:**
```dart
// WRONG — single handler for all events:
on<TimesheetEvent>((event, emit) async {
  await event.map(
    started: (_) async => await _onStarted(emit),
    userInitRequested: (_) async => await _onUserInitRequested(emit),
    fromDateChanged: (e) async => emit(...),
    // ...
  );
});
```

**Why it's wrong:** README specifies individual `on<SpecificEvent>()` handlers. The single-handler pattern blocks concurrent events, prevents event transformer customization, and makes the BLoC harder to test.

**Fix:** Replace with individual handlers:
```dart
TimesheetBloc({...}) : super(const TimesheetState.initial()) {
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

Future<void> _onStarted(_Started event, Emitter<TimesheetState> emit) async { /* ... */ }
Future<void> _onUserInitRequested(_UserInitRequested event, Emitter<TimesheetState> emit) async { /* ... */ }
Future<void> _onSubmitRequested(_SubmitRequested event, Emitter<TimesheetState> emit) async { /* ... */ }
Future<void> _onUpdateRequested(_UpdateRequested event, Emitter<TimesheetState> emit) async { /* ... */ }
Future<void> _onFetchMonthWiseRequested(_FetchMonthWiseRequested event, Emitter<TimesheetState> emit) async { /* ... */ }
Future<void> _onDeleteEntryRequested(_DeleteEntryRequested event, Emitter<TimesheetState> emit) async { /* ... */ }
Future<void> _onFetchOverviewRequested(_FetchOverviewRequested event, Emitter<TimesheetState> emit) async { /* ... */ }
```

Note: Update all handler method signatures to accept the specific event type and emit parameter.

---

### C3 — `previousState` declared but never used (dead variable × 2)

**File:** `lib/features/timesheet/presentation/bloc/timesheet_bloc.dart:121,183`

**Problem:**
```dart
Future<void> _onSubmitRequested(...) async {
  final previousState = state;  // line 121 — never read again
  // ...
}

Future<void> _onUpdateRequested(...) async {
  final previousState = state;  // line 183 — never read again
  // ...
}
```

This implies intended rollback-on-failure that was never implemented, leaving the state permanently in `error` after any failure.

**Fix:** Either implement rollback on error (emit `previousState` instead of `TimesheetState.error`) or remove the variable:

**Option A — Implement rollback (recommended):**
```dart
Future<void> _onSubmitRequested(...) async {
  final previousState = state;
  emit(state.maybeMap(
    loaded: (s) => s.copyWith(isActionLoading: true),
    initial: (s) => s.copyWith(isActionLoading: true),
    orElse: () => state,
  ));
  final result = await createTimesheetUseCase(...);
  result.fold(
    (failure) => emit(previousState.copyWith(isActionLoading: false)),  // rollback + clear loading
    (serverName) async { /* success path */ },
  );
}
```

**Option B — Remove and emit explicit error:**
```dart
// Remove: final previousState = state;
// Keep existing error emit behavior
```

Apply the same fix to `_onUpdateRequested`.

---

### C4 — `_currentEmployeeId` field declared but never assigned or read

**File:** `lib/features/timesheet/presentation/bloc/timesheet_bloc.dart:30`

**Problem:**
```dart
String? _currentEmployeeId;  // declared, never set, never read
```

**Fix:** Delete line 30 entirely.

---

### C5 — `_onFetchMonthWiseRequested` dispatches `fetchOverviewRequested` inside itself (double-fetch)

**File:** `lib/features/timesheet/presentation/bloc/timesheet_bloc.dart:281`

**Problem:**
```dart
void _onFetchMonthWiseRequested(...) async {
  // ...
  result.fold(
    // ...
    (assignments) {
      emit(TimesheetState.loaded(...));
      add(TimesheetEvent.fetchOverviewRequested(month: month, year: year));  // line 281
    },
  );
}
```

`_onStarted` already calls both `fetchMonthWiseRequested` and `fetchOverviewRequested` independently. Every month fetch also triggers an extra overview fetch. The `_onSubmitRequested` and `_onUpdateRequested` both call `_onFetchMonthWiseRequested` after success, causing 2 overview fetches per task add/update.

**Fix:** Remove `add(TimesheetEvent.fetchOverviewRequested(...))` from `_onFetchMonthWiseRequested`. The overview is fetched by `_onStarted` and by explicit user navigation. If you want overview synced after month data loads, call `_onFetchOverviewRequested` directly (not via `add()`) to keep it synchronous:
```dart
(assignments) async {
  emit(TimesheetState.loaded(...));
  // Call directly — no double dispatch:
  await _onFetchOverviewRequested(
    TimesheetEvent.fetchOverviewRequested(month: month, year: year) as _FetchOverviewRequested, 
    emit
  );
},
```

---

### C6 — `TimesheetState.detailLoaded` defined but never emitted (dead state)

**File:** `lib/features/timesheet/presentation/bloc/timesheet_state.dart:54-67`

**Problem:**
```dart
const factory TimesheetState.detailLoaded({
  required TimesheetEntity timesheet,
  required List<ProjectEntity> projects,
  // ...
}) = _DetailLoaded;
```

No code path anywhere in the BLoC emits `TimesheetState.detailLoaded`. The factory and its generated freezed code are dead.

**Fix:** Remove the `detailLoaded` factory entirely from `timesheet_state.dart`, regenerate freezed files:
```bash
dart run build_runner build --delete-conflicting-outputs
```

---

### C7 — `@override` on state getters is misleading (no supertype declares them)

**File:** `lib/features/timesheet/presentation/bloc/timesheet_state.dart:101-122`

**Problem:**
```dart
const TimesheetState._();

@override          // misleading — no supertype defines this
UserEntity? get user;
@override
DateTime? get editFromDate;
// etc.
```

These `@override` annotations are technically incorrect. There is no superclass or interface declaring these abstract getters. Freezed generates them. The annotation compiles but gives the wrong signal that a contract is being fulfilled.

**Fix:** Remove all `@override` annotations from the shared getter declarations at the bottom of `TimesheetState`:
```dart
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
```

---

### C8 — `timesheet_list_screen.dart` is entirely commented out (180 lines of dead code)

**File:** `lib/features/timesheet/presentation/screens/timesheet_list_screen.dart`

**Problem:** The entire file (180 lines) is commented out. The class `TimesheetListScreen` is referenced nowhere in active code.

**Fix:** Delete the file entirely:
```bash
rm lib/features/timesheet/presentation/screens/timesheet_list_screen.dart
```

If the screen will be restored in the future, it should live in a feature branch, not as commented code in main.

---

### C9 — `flutter/cupertino.dart` imported in data layer

**File:** `lib/features/timesheet/data/repositories/timesheet_repository_impl.dart:4`

**Problem:**
```dart
import 'package:flutter/cupertino.dart';  // UI framework in data layer — violation
// Used only for: debugPrint(...)
```

The data layer must not import Flutter UI packages.

**Fix:** Remove the import and replace `debugPrint` with `dart:developer` `log()` or remove debug logs entirely (see M4 below):
```dart
// REMOVE: import 'package:flutter/cupertino.dart';
// If you want structured logging, use:
import 'dart:developer' show log;
// Then replace debugPrint(...) with log(..., name: 'TimesheetRepo')
```

---

## MEDIUM Issues

---

### M1 — Heavy computation and helper functions inside `build()` in `ApplyTimesheetScreen`

**File:** `lib/features/timesheet/presentation/screens/apply_timesheet_screen.dart:159-201`

**Problem:**
```dart
Widget build(BuildContext context) {
  // ...
  // These are defined AND executed inside build — recreated every frame:
  String formatWeeks(dynamic data) { ... }        // line 159 — closure defined in build
  String? findActiveIdForWeek() { ... }            // line 177 — iterates all assignments every frame
  final availableMonths = List.generate(5, ...);   // line 198 — new list every frame
}
```

**Fix:** Move to class-level methods or compute only when dependencies change:
```dart
// Move to class level or a helper class:
List<DateTime> _buildAvailableMonths() {
  final now = DateTime.now();
  return List.generate(5, (i) => DateTime(now.year, now.month - 3 + i, 1));
}

String _formatWeeks(dynamic data) { /* static method */ }

String? _findActiveIdForWeek(DateTime selectedDate, List<ProjectAssignmentEntity> assignments) {
  // Pure function — can be static
}
```

Or cache `availableMonths` in `initState`:
```dart
late final List<DateTime> _availableMonths;

@override
void initState() {
  super.initState();
  final now = DateTime.now();
  _availableMonths = List.generate(5, (i) => DateTime(now.year, now.month - 3 + i, 1));
}
```

---

### M2 — Redundant `BlocProvider.value` wrapping in `ApplyTimesheetScreen`

**File:** `lib/features/timesheet/presentation/screens/apply_timesheet_screen.dart:120-121`

**Problem:**
```dart
return BlocProvider<TimesheetBloc>.value(
  value: Get.find<TimesheetBloc>(),   // double-wrapping if parent already provides it
  child: BlocListener<TimesheetBloc, TimesheetState>(
    // ...
  ),
);
```

If the router or parent widget already provides `TimesheetBloc` in the widget tree, this is a redundant wrap. If this is the only place the BLoC is provided, remove the manual `Get.find` and provide via DI setup at the route level.

**Fix:** Remove the `BlocProvider.value` wrapper if `TimesheetBloc` is provided by the parent route, or consolidate so the bloc is provided exactly once:
```dart
// If already provided upstream — just use:
return BlocListener<TimesheetBloc, TimesheetState>(
  // ...
);

// If it must be provided here — keep BlocProvider but don't mix Get.find + BlocProvider.value:
return BlocProvider(
  create: (_) => Get.find<TimesheetBloc>(),
  child: BlocListener<TimesheetBloc, TimesheetState>(...),
);
```

---

### M3 — Hardcoded UI strings not using l10n in `ApplyTimesheetScreen`

**File:** `lib/features/timesheet/presentation/screens/apply_timesheet_screen.dart:210,330-339`

**Problem:**
```dart
title: Text("Timesheet Entry", ...),      // line 210
title: const Text("Delete Task"),          // line 330
content: Text("Are you sure you want to delete \"...\"?"),  // line 331
child: const Text("Cancel"),               // line 334
child: const Text("Delete", ...),          // line 339
```

**Fix:** Add keys to `lib/l10n/` ARB files and use `AppLocalizations`:
```dart
final l10n = AppLocalizations.of(context)!;
title: Text(l10n.timesheetEntry),
title: Text(l10n.deleteTask),
content: Text(l10n.deleteTaskConfirmation(task.description ?? task.project)),
child: Text(l10n.cancel),
child: Text(l10n.delete),
```

---

### M4 — Raw `AlertDialog` instead of `AppDialogs` for delete confirmation

**File:** `lib/features/timesheet/presentation/screens/apply_timesheet_screen.dart:326-344`

**Problem:**
```dart
final confirmed = await showDialog<bool>(
  context: context,
  builder: (ctx) => AlertDialog(    // raw AlertDialog — not using AppDialogs
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    title: const Text("Delete Task"),
    // ...
  ),
);
```

**Fix:** Replace with the shared `AppDialogs.showConfirmation`:
```dart
final confirmed = await AppDialogs.showConfirmation(
  context: context,
  title: l10n.deleteTask,
  message: l10n.deleteTaskConfirmation(task.description ?? task.project),
  confirmLabel: l10n.delete,
  isDestructive: true,
);
```

---

### M5 — Side effect (state mutation) inside `build()` in `TimesheetApplyForm`

**File:** `lib/features/timesheet/presentation/widgets/timesheet_apply_form.dart:152-157`

**Problem:**
```dart
Widget build(BuildContext context) {
  // ...
  // Mutating state inside build — anti-pattern:
  if (widget.editingTask != null && _selectedProject == null && projects.isNotEmpty) {
    try {
      _selectedProject = projects.firstWhere((p) => p.projectName == widget.editingTask!.project);
    } catch (_) {}
  }
}
```

Side effects in `build()` can trigger during layout/paint phases and cause unpredictable rebuilds.

**Fix:** Move to `_prefillForm()` which is already called from `initState` and `didUpdateWidget`. If projects load after `initState`, trigger this lookup in a `BlocListener` that fires when `state.projects` changes:
```dart
// In _prefillForm(), add:
if (widget.editingTask != null && projects.isNotEmpty) {
  try {
    _selectedProject = projects.firstWhere((p) => p.projectName == widget.editingTask!.project);
  } catch (_) {}
}

// In didUpdateWidget, also check if projects just became available:
@override
void didUpdateWidget(TimesheetApplyForm oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (widget.editingTask != oldWidget.editingTask || widget.editingIndex != oldWidget.editingIndex) {
    _prefillForm();
  }
}
```

Or add a `BlocListener` in the form's `build()` that calls `_prefillForm()` when projects load for the first time (when `state.projects.isNotEmpty && oldState.projects.isEmpty`).

---

### M6 — `_buildDropdown()` is dead code in `TimesheetApplyForm`

**File:** `lib/features/timesheet/presentation/widgets/timesheet_apply_form.dart:317-340`

**Problem:**
```dart
Widget _buildDropdown(List<ProjectEntity> projects) {
  // This method is never called anywhere
  return Container( /* ... */ );
}
```

**Fix:** Delete lines 317–340 entirely.

---

### M7 — `image_picker` imported and used but image is never stored

**File:** `lib/features/timesheet/presentation/widgets/timesheet_apply_form.dart:3,344-346`

**Problem:**
```dart
import 'package:image_picker/image_picker.dart';  // used only in upload placeholder

Widget _buildUploadPlaceholder() {
  return GestureDetector(
    onTap: () async {
      final picker = ImagePicker();
      await picker.pickImage(source: ImageSource.gallery);  // result discarded
    },
    // ...
  );
}
```

The image is picked but the `XFile?` return is not stored, uploaded, or displayed anywhere. This is incomplete functionality.

**Fix — Option A (remove until feature is ready):** Replace the `GestureDetector.onTap` with a placeholder or remove the upload section:
```dart
onTap: () {
  ToastUtils.showInfo("Document upload coming soon");
},
```

**Fix — Option B (implement properly):** Store the picked file in state, display a preview, and include it in the submission payload.

---

### M8 — `debugPrint` calls in production code

**Files:**
- `lib/features/timesheet/presentation/widgets/timesheet_apply_form.dart:91`
- `lib/features/timesheet/data/repositories/timesheet_repository_impl.dart:65,93,175`

**Problem:**
```dart
// In timesheet_apply_form.dart:
debugPrint("UI: New Task Data to add: name='${newTask.name}', taskData='${newTask.taskData}'");

// In timesheet_repository_impl.dart:
debugPrint("CREATE(Custom) payload is ${jsonEncode(payload)}");
debugPrint("UPDATE(SYNC) payload is ${jsonEncode(payload)}");
debugPrint("REPO: Extracted ${allAssignments.length} total assignments for month $month/$year");
```

`debugPrint` logs sensitive payloads (employee data, hours, project names) to the console in release builds if `kDebugMode` is not checked.

**Fix:** Remove all four `debugPrint` calls entirely. If logging is needed for debugging, wrap in `assert(() { debugPrint(...); return true; }())` or use the `Logger` service from DI.

---

### M9 — `TimesheetColors` and `TimesheetStyles` are a separate design system (major convention violation)

**File:** `lib/features/timesheet/presentation/widgets/timesheet_theme.dart` (full file)

**Problem:** `timesheet_theme.dart` defines its own 21-color palette and Google Fonts-based text styles, completely bypassing `AppColors` and `AppTextStyle`. These are consumed by every timesheet widget, creating a forked UI system with duplicate/conflicting color values.

**Evidence of conflict:**
```dart
// timesheet_theme.dart:
static const Color primary = Color(0xff0047cc);  // TimesheetColors.primary

// Possibly different from:
static const Color primary = /* AppColors.primary value */;
```

**Fix:** Delete `timesheet_theme.dart` and migrate all usages to `AppColors` and `AppTextStyle`:

**Migration map:**

| `TimesheetColors.*` | Replace with |
|---|---|
| `primary` | `AppColors.primary` |
| `secondary` | `AppColors.secondary` |
| `background` | `AppColors.background` |
| `textPrimary` | `AppColors.textPrimary` |
| `textSecondary` | `AppColors.textSecondary` |
| `border` | `AppColors.border` |
| `surfaceContainerLowest` | `AppColors.surface` |
| `surfaceContainerLow` | `AppColors.surfaceVariant` (or nearest equivalent) |
| `error` | `AppColors.error` |
| `success` | `AppColors.success` |
| `warning` | `AppColors.warning` |
| `green100`, `green700` | `AppColors.successLight`, `AppColors.successDark` (add if missing) |
| `orange100`, `orange700` | `AppColors.warningLight`, `AppColors.warningDark` (add if missing) |
| `red100`, `red700` | `AppColors.errorLight`, `AppColors.errorDark` (add if missing) |

| `TimesheetStyles.*` | Replace with |
|---|---|
| `h1`, `h2`, `h3` | `AppTextStyle.h1`, `AppTextStyle.h2`, `AppTextStyle.h3` |
| `bodyLarge`, `bodyMedium`, `bodySmall` | `AppTextStyle.bodyLarge`, `AppTextStyle.bodyMedium`, `AppTextStyle.bodySmall` |
| `statsValue`, `statsLabel` | Add `AppTextStyle.statsValue`, `AppTextStyle.statsLabel` to `app_text_style.dart` |
| `dateNumber`, `dateDay` | Add `AppTextStyle.dateNumber`, `AppTextStyle.dateDay` to `app_text_style.dart` |
| `button` | `AppTextStyle.button` |

After migration, delete `timesheet_theme.dart` and remove its imports from all widget files.

**Files to update:** `timesheet_apply_form.dart`, `timesheet_task_section.dart`, `timesheet_week_selector.dart`, `timesheet_stats_bento.dart`, `timesheet_submit_bar.dart`, `timesheet_card.dart`, `apply_timesheet_screen.dart`

---

### M10 — `TimesheetOverviewModel` uses manual `fromJson` instead of `@freezed`

**File:** `lib/features/timesheet/data/models/timesheet_overview_model.dart`

**Problem:** The model is a plain Dart class with hand-written `fromJson`. Every other model in the project uses `@freezed` (verified: `project_assignment_model.dart`, `project_model.dart`, `timesheet_model.dart`).

**Fix:** Convert to `@freezed`:
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/timesheet_overview_entity.dart';

part 'timesheet_overview_model.freezed.dart';
part 'timesheet_overview_model.g.dart';

@freezed
abstract class TimesheetOverviewModel with _$TimesheetOverviewModel {
  const factory TimesheetOverviewModel({
    @Default(0) int filled,
    @Default(0) int approved,
    @JsonKey(name: 'pending_approval') @Default(0) int pendingApproval,
    @JsonKey(name: 'correction_needed') @Default(0) int correctionNeeded,
    @JsonKey(name: 'upcoming_to_submit') @Default(0) int upcomingToSubmit,
    @JsonKey(name: 'week_meta') @Default({}) Map<String, dynamic> weekMeta,
  }) = _TimesheetOverviewModel;

  const TimesheetOverviewModel._();

  factory TimesheetOverviewModel.fromJson(Map<String, dynamic> json) =>
      _$TimesheetOverviewModelFromJson(json);

  TimesheetOverviewEntity toEntity() => TimesheetOverviewEntity(
    filled: filled,
    approved: approved,
    pendingApproval: pendingApproval,
    correctionNeeded: correctionNeeded,
    upcomingToSubmit: upcomingToSubmit,
    weekMeta: weekMeta,
  );
}
```

Run: `dart run build_runner build --delete-conflicting-outputs`

---

### M11 — Redundant `Content-Type` headers in datasource

**File:** `lib/features/timesheet/data/datasources/timesheet_remote_datasource.dart`

**Problem:** Multiple API call methods pass `Options(headers: {"Content-Type": "application/json"})` explicitly when `DioClient` already sets this as a default header for all requests.

**Fix:** Remove all `options: Options(headers: {"Content-Type": "application/json"})` parameters from `createTimesheet`, `updateTimesheet`, `deleteTimesheetEntry` datasource calls.

---

### M12 — Manual HTTP status code check in datasource

**File:** `lib/features/timesheet/data/datasources/timesheet_remote_datasource.dart`

**Problem:** Any method that checks `if (response.statusCode == 200)` manually is redundant — `DioClient`'s interceptor throws `DioException` for non-2xx responses, which is caught by `Failure.fromException(e)` in the repository.

**Fix:** Remove manual `statusCode` checks and trust the interceptor. If the call returns without throwing, it succeeded.

---

### M13 — `_buildSyncPayload()` complex business/mapping logic in repository implementation

**File:** `lib/features/timesheet/data/repositories/timesheet_repository_impl.dart:103-138`

**Problem:** `_buildSyncPayload()` contains nested loop logic, date key generation, and payload structuring (a business rule: how to map assignments to the week/day tree structure the API expects). This is more than a simple model mapping and belongs in a dedicated mapper class.

**Fix:** Extract to `lib/features/timesheet/data/mappers/timesheet_payload_mapper.dart`:
```dart
class TimesheetPayloadMapper {
  static Map<String, dynamic> buildSyncPayload(
    List<ProjectAssignmentEntity> assignments,
    String employee,
    {int? docStatus}
  ) {
    // ... move _buildSyncPayload logic here ...
  }
}
```

Then in the repository:
```dart
final payload = TimesheetPayloadMapper.buildSyncPayload(assignments, employee, docStatus: approved);
```

---

### M14 — Hardcoded colors in `TimesheetSubmitBar` and `TimesheetCard`

**Files:**
- `lib/features/timesheet/presentation/widgets/timesheet_submit_bar.dart:51`
- `lib/features/timesheet/presentation/widgets/timesheet_card.dart:27,63`

**Problem:**
```dart
// timesheet_submit_bar.dart:
colors: [TimesheetColors.primary, Color(0xFF155DFC)],  // hardcoded gradient end color

// timesheet_card.dart:
color: const Color(0xFFF3F2F7),        // hardcoded card background
backgroundColor: const Color(0xFF1B0EC1),  // hardcoded button color
```

**Fix:** Replace with `AppColors` tokens (add new ones if needed):
```dart
// timesheet_submit_bar.dart:
colors: [AppColors.primary, AppColors.primaryDark],  // add AppColors.primaryDark if needed

// timesheet_card.dart:
color: AppColors.surfaceVariant,
backgroundColor: AppColors.primary,
```

---

### M15 — Hardcoded strings in `TimesheetWeekSelector`, `TimesheetTaskSection`, and `TimesheetApplyForm`

**Files:**
- `lib/features/timesheet/presentation/widgets/timesheet_week_selector.dart:43`
- `lib/features/timesheet/presentation/widgets/timesheet_task_section.dart:24,49`
- `lib/features/timesheet/presentation/widgets/timesheet_apply_form.dart` (multiple labels)

**Problem:**
```dart
// timesheet_week_selector.dart:
const Text('This Week', ...)           // not l10n

// timesheet_task_section.dart:
Text("Today's Tasks", ...)             // not l10n
Text("No tasks for this day", ...)     // not l10n

// timesheet_apply_form.dart:
_buildLabel("Select Project")
_buildLabel("Task")
_buildLabel("Expected (h)")
_buildLabel("Actual (h)")
_buildLabel("Detailed Description")
_buildLabel("Supporting Documents")
Text("Tap to Browse Files", ...)
Text("Max size 5MB (PDF, JPG, PNG)", ...)
Text(widget.editingTask != null ? "Update Task" : "Add New Task", ...)
Text(widget.editingTask != null ? "Update Task" : "Add To Day", ...)
```

**Fix:** Add all these strings to ARB files and use `AppLocalizations.of(context)!`:
- Note: `TimesheetTaskSection` and `TimesheetWeekSelector` are `StatelessWidget` — they need `BuildContext` passed to access `l10n`, which they already receive via `build(BuildContext context)`. Pass the `l10n` instance or use `context.l10n` extension.

---

### M16 — `_onFetchOverviewRequested` silently swallows all failures

**File:** `lib/features/timesheet/presentation/bloc/timesheet_bloc.dart:347-349`

**Problem:**
```dart
Future<void> _onFetchOverviewRequested(int month, int year, Emitter<TimesheetState> emit) async {
  final result = await getTimesheetOverviewUseCase(month: month, year: year);
  result.fold(
    (failure) => null,  // completely silenced — no logging, no UI feedback
    (overview) => emit(state.copyWith(overview: overview)),
  );
}
```

If the overview API consistently fails (wrong endpoint, auth issue, network), the stats panel stays empty or shows stale data with zero user feedback.

**Fix:** At minimum log the failure; optionally show a non-blocking snackbar:
```dart
result.fold(
  (failure) {
    assert(() {
      log('TimesheetBloc: overview fetch failed — ${failure.message}', name: 'Timesheet');
      return true;
    }());
    // Overview failure is non-critical; don't block the main UI
    // But emit current state to ensure isActionLoading is cleared
  },
  (overview) => emit(state.copyWith(overview: overview)),
);
```

---

### M17 — Task icon based on `index % 2` is arbitrary and meaningless

**File:** `lib/features/timesheet/presentation/widgets/timesheet_task_section.dart:97-104`

**Problem:**
```dart
decoration: BoxDecoration(
  color: index % 2 == 0 ? TimesheetColors.primaryFixed : TimesheetColors.tertiaryFixed,
),
child: Icon(
  index % 2 == 0 ? Icons.code : Icons.palette,  // alternates based on position, not type
  color: index % 2 == 0 ? TimesheetColors.primary : TimesheetColors.tertiary,
),
```

This gives tasks random-looking icons that change as tasks are reordered.

**Fix — Option A (single consistent icon):**
```dart
decoration: BoxDecoration(color: AppColors.primaryFixed),
child: const Icon(Icons.task_alt, color: AppColors.primary, size: 20),
```

**Fix — Option B (icon based on project/category):** Map project name or task category to a meaningful icon.

---

## Summary Table

| # | Severity | File | Issue |
|---|---|---|---|
| C1 | 🔴 Critical | `timesheet_bloc.dart` | `IAuthRepository` + `SharedPreferences` injected into BLoC — use `LocalStorageService` |
| C2 | 🔴 Critical | `timesheet_bloc.dart` | Single `on<TimesheetEvent>` mega-handler — split into individual `on<SpecificEvent>()` |
| C3 | 🔴 Critical | `timesheet_bloc.dart` | `previousState` declared but never used — missing rollback logic |
| C4 | 🔴 Critical | `timesheet_bloc.dart` | `_currentEmployeeId` field declared but never assigned or read |
| C5 | 🔴 Critical | `timesheet_bloc.dart` | `_onFetchMonthWiseRequested` causes double overview fetch via `add()` |
| C6 | 🔴 Critical | `timesheet_state.dart` | `detailLoaded` state defined but never emitted — dead code |
| C7 | 🔴 Critical | `timesheet_state.dart` | `@override` on abstract getters with no supertype — misleading annotations |
| C8 | 🔴 Critical | `timesheet_list_screen.dart` | Entire file is commented out — 180 lines of dead code |
| C9 | 🔴 Critical | `timesheet_repository_impl.dart` | `flutter/cupertino.dart` imported in data layer |
| M1 | 🟡 Medium | `apply_timesheet_screen.dart` | Heavy helpers + `List.generate` defined inside `build()` — recreated every frame |
| M2 | 🟡 Medium | `apply_timesheet_screen.dart` | Redundant `BlocProvider.value` wrapping |
| M3 | 🟡 Medium | `apply_timesheet_screen.dart` | Hardcoded strings — use `l10n` |
| M4 | 🟡 Medium | `apply_timesheet_screen.dart` | Raw `AlertDialog` instead of `AppDialogs.showConfirmation` |
| M5 | 🟡 Medium | `timesheet_apply_form.dart` | State mutation (`_selectedProject = ...`) inside `build()` — anti-pattern |
| M6 | 🟡 Medium | `timesheet_apply_form.dart` | `_buildDropdown()` method never called — dead code |
| M7 | 🟡 Medium | `timesheet_apply_form.dart` | `image_picker` result discarded — incomplete feature |
| M8 | 🟡 Medium | `timesheet_apply_form.dart` + `timesheet_repository_impl.dart` | 4× `debugPrint` in production code |
| M9 | 🟡 Medium | `timesheet_theme.dart` | Entire separate design system — delete and migrate to `AppColors`/`AppTextStyle` |
| M10 | 🟡 Medium | `timesheet_overview_model.dart` | Plain class with manual `fromJson` — convert to `@freezed` |
| M11 | 🟠 Minor | `timesheet_remote_datasource.dart` | Redundant `Content-Type` headers on all mutation calls |
| M12 | 🟠 Minor | `timesheet_remote_datasource.dart` | Manual `statusCode == 200` check — trust DioClient interceptor |
| M13 | 🟠 Minor | `timesheet_repository_impl.dart` | `_buildSyncPayload()` complex logic — extract to mapper class |
| M14 | 🟠 Minor | `timesheet_submit_bar.dart` + `timesheet_card.dart` | Hardcoded `Color(0xFF...)` values — use `AppColors` |
| M15 | 🟠 Minor | `timesheet_week_selector.dart`, `timesheet_task_section.dart`, `timesheet_apply_form.dart` | Hardcoded user-visible strings — use `l10n` |
| M16 | 🟠 Minor | `timesheet_bloc.dart` | Overview failures silently discarded — add at minimum debug log |
| M17 | 🟠 Minor | `timesheet_task_section.dart` | Task icon based on `index % 2` — meaningless UX |

---

## Verification Checklist

After all fixes are applied:

- [ ] `flutter analyze` — zero new errors or warnings
- [ ] `dart run build_runner build --delete-conflicting-outputs` — clean codegen (after removing `detailLoaded` and adding freezed to `TimesheetOverviewModel`)
- [ ] `flutter build apk --debug` — compiles cleanly
- [ ] Navigate to timesheet screen — month stats bento shows correct filled/approved/pending counts
- [ ] Select a day — tasks for that day display correctly
- [ ] Add a task — form submits, task appears in the list, success toast shows
- [ ] Edit a task — form pre-fills with task data, update submits, task updates in list
- [ ] Delete a task — confirmation dialog appears, task removed from list after confirmation
- [ ] Navigate previous/next week — week selector updates, tasks filter to selected day
- [ ] Navigate to different month — month dropdown updates data correctly
- [ ] Submit weekly timesheet — only draft tasks for that week are submitted, success redirects to previous screen
- [ ] No `TimesheetColors` or `TimesheetStyles` references remain in any file (confirm with `grep -r "TimesheetColors\|TimesheetStyles" lib/`)
- [ ] No `debugPrint` in timesheet files (confirm with `grep -r "debugPrint" lib/features/timesheet/`)
- [ ] `timesheet_list_screen.dart` deleted (confirm with `ls lib/features/timesheet/presentation/screens/`)
- [ ] Run `graphify update .` to refresh the knowledge graph after changes
