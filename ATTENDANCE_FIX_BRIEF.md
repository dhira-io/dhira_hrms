# Attendance Module — Fix Brief for AI Implementation

> **Project:** dhira_hrms (Flutter, Clean Architecture + BLoC + Get DI)
> **Root:** `lib/` relative to project root
> **Generated:** 2026-04-26

Apply every fix below in order. Run `flutter analyze` after each group to verify no regressions.
After all fixes run: `dart run build_runner build --delete-conflicting-outputs`

---

## GROUP 1 — Core service completeness (do this first, others depend on it)

### Fix 1.1 — Extend `LocalStorageService` with missing accessors

**File:** `lib/core/services/local_storage_service.dart`

**Current content:**
```dart
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _tokenKey = 'auth_token';
  static const String _userEmailKey = 'user_email';
  static const String _themeKey = 'is_dark_mode';

  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  // Token Management
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    await _prefs.remove(_tokenKey);
  }

  // User Email Management
  Future<void> saveUserEmail(String email) async {
    await _prefs.setString(_userEmailKey, email);
  }

  String? getUserEmail() {
    return _prefs.getString(_userEmailKey);
  }

  // Theme Management
  Future<void> saveThemeMode(bool isDarkMode) async {
    await _prefs.setBool(_themeKey, isDarkMode);
  }

  bool getThemeMode() {
    return _prefs.getBool(_themeKey) ?? false;
  }

  // General Clear
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
```

**Replace entire file with:**
```dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/storage_constants.dart';

class LocalStorageService {
  static const String _tokenKey = 'auth_token';
  static const String _userEmailKey = 'user_email';
  static const String _themeKey = 'is_dark_mode';

  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  // Token Management
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  String? getToken() => _prefs.getString(_tokenKey);

  Future<void> clearToken() async => _prefs.remove(_tokenKey);

  // User Email Management
  Future<void> saveUserEmail(String email) async {
    await _prefs.setString(_userEmailKey, email);
  }

  String? getUserEmail() => _prefs.getString(_userEmailKey);

  // Theme Management
  Future<void> saveThemeMode(bool isDarkMode) async {
    await _prefs.setBool(_themeKey, isDarkMode);
  }

  bool getThemeMode() => _prefs.getBool(_themeKey) ?? false;

  // Employee / Profile accessors (used by presentation layer via BLoC)
  String? getEmpId() => _prefs.getString(StorageConstants.empId);
  String? getUserFullname() => _prefs.getString(StorageConstants.userFullname);
  String? getDepartment() => _prefs.getString(StorageConstants.department);
  String? getGender() => _prefs.getString(StorageConstants.gender);

  Map<String, dynamic>? getCookieMap() {
    final raw = _prefs.getString(StorageConstants.cookies);
    if (raw == null) return null;
    try {
      return json.decode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  // General Clear
  Future<void> clearAll() async => _prefs.clear();
}
```

---

### Fix 1.2 — Add `baseUrl` constant to `AppConstants`

**File:** `lib/core/constants/app_constants.dart`

Add the following line inside the `AppConstants` class body (after the existing `opacityMedium` line):

```dart
  // Network
  static const String baseUrl = 'https://dev-api.hrms.dhira.io/';
```

> Note: This must match the `baseUrl` string already in `lib/core/di/dependency_injection.dart` line 134.

---

## GROUP 2 — Attendance BLoC fixes

**File:** `lib/features/attendance/presentation/bloc/attendance_bloc.dart`

Apply all sub-fixes to this single file. Show the full replacement at the end.

### Fix 2.1 — Remove `SharedPreferences` direct access; inject `LocalStorageService`

**Current constructor:**
```dart
class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final PunchInUseCase punchInUseCase;
  final PunchOutUseCase punchOutUseCase;
  final GetCheckinStatusUseCase getCheckinStatusUseCase;
  final GetAttendanceLogsUseCase getAttendanceLogsUseCase;
  final GetCalendarEventsUseCase getCalendarEventsUseCase;
  final StartBreakUseCase startBreakUseCase;
  final EndBreakUseCase endBreakUseCase;
  final GetWorkDurationsUseCase getWorkDurationsUseCase;
  final GetAttendanceMonthSummaryUseCase getAttendanceMonthSummaryUseCase;
  final GetLeaveDetailsUseCase getLeaveDetailsUseCase;
  final GetLeaveHistoryUseCase getLeaveHistoryUseCase;
  final GetTeamLeavesUseCase getTeamLeavesUseCase;
  final GetHolidayListLeavePolicyUseCase getHolidayListLeavePolicyUseCase;
```

**Change to** (add `localStorageService`, remove `GetAttendanceLogsUseCase`):
```dart
class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final PunchInUseCase punchInUseCase;
  final PunchOutUseCase punchOutUseCase;
  final GetCheckinStatusUseCase getCheckinStatusUseCase;
  final GetCalendarEventsUseCase getCalendarEventsUseCase;
  final StartBreakUseCase startBreakUseCase;
  final EndBreakUseCase endBreakUseCase;
  final GetWorkDurationsUseCase getWorkDurationsUseCase;
  final GetAttendanceMonthSummaryUseCase getAttendanceMonthSummaryUseCase;
  final GetLeaveDetailsUseCase getLeaveDetailsUseCase;
  final GetLeaveHistoryUseCase getLeaveHistoryUseCase;
  final GetTeamLeavesUseCase getTeamLeavesUseCase;
  final GetHolidayListLeavePolicyUseCase getHolidayListLeavePolicyUseCase;
  final LocalStorageService localStorageService;
```

### Fix 2.2 — Replace `_getEmpId()` method

**Remove:**
```dart
  Future<String?> _getEmpId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageConstants.empId);
  }
```

**Replace with:**
```dart
  String? _getEmpId() => localStorageService.getEmpId();
```

> This is now synchronous. Update all `await _getEmpId()` callers to just `_getEmpId()` and remove the null-guard `if (empid == null) return;` where it is used (or keep it, both are fine).

### Fix 2.3 — Replace `_fetchProfileIfNeeded()` method

**Remove:**
```dart
  String? _userName;
  String? _profileImage;
  bool _isProfileFetched = false;

  Future<void> _fetchProfileIfNeeded() async {
    if (_isProfileFetched) return;
    final prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString(StorageConstants.userFullname);
    final cookieString = prefs.getString(StorageConstants.cookies);
    if (cookieString != null) {
      try {
        final Map<String, dynamic> cookieMap = json.decode(cookieString);
        _profileImage = cookieMap['user_image'];
      } catch (_) {}
    }
    _isProfileFetched = true;
  }
```

**Replace with:**
```dart
  String? _userName;
  String? _profileImage;
  bool _isProfileFetched = false;

  void _fetchProfileIfNeeded() {
    if (_isProfileFetched) return;
    _userName = localStorageService.getUserFullname();
    _profileImage = localStorageService.getCookieMap()?['user_image'] as String?;
    _isProfileFetched = true;
  }
```

> Update all `await _fetchProfileIfNeeded()` callers to `_fetchProfileIfNeeded()` (remove `await`).

### Fix 2.4 — Move gender-filtering out of `_onLeaveDetailsRequested`

**Current `_onLeaveDetailsRequested` method (lines ~280-325):**
```dart
  Future<void> _onLeaveDetailsRequested(
    String date,
    Emitter<AttendanceState> emit,
  ) async {
    if (state.leaveDetails != null) return;

    final empid = await _getEmpId();
    if (empid == null) return;
    final currentState = state;

    final result = await getLeaveDetailsUseCase(
      GetLeaveDetailsParams(employee: empid, date: date),
    );

    await result.fold(
      (failure) async {
        emit(state.copyWith(leaveDetails: state.leaveDetails));
      },
      (details) async {
        final prefs = await SharedPreferences.getInstance();
        final gender = prefs.getString(StorageConstants.gender)?.toLowerCase();

        final filteredAllocation = Map<String, LeaveAllocationEntity>.from(
          details.leaveAllocation,
        );

        if (gender == 'male') {
          filteredAllocation.removeWhere(
            (key, value) => key.toLowerCase().contains('maternity'),
          );
        } else if (gender == 'female') {
          filteredAllocation.removeWhere(
            (key, value) => key.toLowerCase().contains('paternity'),
          );
        }

        final filteredDetails = details.copyWith(
          leaveAllocation: filteredAllocation,
        );
        emit(state.copyWith(leaveDetails: filteredDetails));
      },
    );
  }
```

**Replace with:**
```dart
  Future<void> _onLeaveDetailsRequested(
    String date,
    Emitter<AttendanceState> emit,
  ) async {
    if (state.leaveDetails != null) return;

    final empid = _getEmpId();
    if (empid == null) return;

    final gender = localStorageService.getGender()?.toLowerCase();

    final result = await getLeaveDetailsUseCase(
      GetLeaveDetailsParams(employee: empid, date: date, gender: gender),
    );

    result.fold(
      (failure) => emit(state.copyWith(leaveDetails: state.leaveDetails)),
      (details) => emit(state.copyWith(leaveDetails: details)),
    );
  }
```

> The gender filtering moves into `GetLeaveDetailsUseCase` — see Fix 3.1 below.

### Fix 2.5 — Remove `getAttendanceLogsUseCase` (dead use case)

Remove `final GetAttendanceLogsUseCase getAttendanceLogsUseCase;` from the class fields and constructor.

In `_loadAttendanceData`, remove the dead `logsResult` declaration:
```dart
// REMOVE these two lines:
final Either<dynamic, List<AttendanceLogEntity>> logsResult = const Right([]);
```

Replace the nested `logsResult.fold(...)` block inside `_loadAttendanceData` — since logs always came from the hardcoded `Right([])`, and the `logs` variable was always `[]`, simplify:

**In `_loadAttendanceData`, the inner fold that references `logsResult`:**

Find:
```dart
      (status) {
        logsResult.fold(
          (failure) => emit(
            AttendanceState.error( ... ),
          ),
          (logs) {
            _cachedLogs = logs;
            durationsResult.fold(
              (failure) => emit(
                AttendanceState.loaded(
                  status: status.copyWith(...),
                  logs: logs,
                  ...
                ),
              ),
              (durations) => emit(
                AttendanceState.loaded(
                  status: status.copyWith(...),
                  logs: logs,
                  ...
                  workDurations: durations,
                ),
              ),
            );
          },
        );
      },
```

Replace with (pass `_cachedLogs` directly, remove `logsResult` entirely):
```dart
      (status) {
        durationsResult.fold(
          (failure) => emit(
            AttendanceState.loaded(
              status: status.copyWith(
                message: messageOverride ?? status.message,
              ),
              logs: _cachedLogs,
              calendarEvents: state.calendarEvents,
              monthSummary: state.monthSummary,
              leaveDetails: state.leaveDetails,
              leaveHistory: state.leaveHistory,
              teamLeaves: state.teamLeaves,
              userName: _userName,
              profileImage: _profileImage,
            ),
          ),
          (durations) => emit(
            AttendanceState.loaded(
              status: status.copyWith(
                message: messageOverride ?? status.message,
              ),
              logs: _cachedLogs,
              calendarEvents: state.calendarEvents,
              monthSummary: state.monthSummary,
              leaveDetails: state.leaveDetails,
              leaveHistory: state.leaveHistory,
              teamLeaves: state.teamLeaves,
              workDurations: durations,
              userName: _userName,
              profileImage: _profileImage,
            ),
          ),
        );
      },
```

### Fix 2.6 — Update BLoC imports

**Remove these imports from `attendance_bloc.dart`:**
```dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';
```

**Add this import:**
```dart
import '../../../../core/services/local_storage_service.dart';
```

---

## GROUP 3 — UseCase fix

### Fix 3.1 — Move gender-filtering into `GetLeaveDetailsUseCase`

**File:** `lib/features/attendance/domain/usecases/get_leave_details_usecase.dart`

**Current content:**
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/attendance_entities.dart';
import '../repositories/attendance_repository.dart';

class GetLeaveDetailsUseCase
    implements UseCase<LeaveDetailsEntity, GetLeaveDetailsParams> {
  final IAttendanceRepository repository;

  GetLeaveDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, LeaveDetailsEntity>> call(
    GetLeaveDetailsParams params,
  ) async {
    return await repository.getLeaveDetails(
      employee: params.employee,
      date: params.date,
    );
  }
}

class GetLeaveDetailsParams {
  final String employee;
  final String date;

  GetLeaveDetailsParams({required this.employee, required this.date});
}
```

**Replace entire file with:**
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/attendance_entities.dart';
import '../repositories/attendance_repository.dart';

class GetLeaveDetailsUseCase
    implements UseCase<LeaveDetailsEntity, GetLeaveDetailsParams> {
  final IAttendanceRepository repository;

  GetLeaveDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, LeaveDetailsEntity>> call(
    GetLeaveDetailsParams params,
  ) async {
    final result = await repository.getLeaveDetails(
      employee: params.employee,
      date: params.date,
    );

    return result.fold(
      Left.new,
      (details) {
        final gender = params.gender?.toLowerCase();
        if (gender == null) return Right(details);

        final filtered = Map<String, LeaveAllocationEntity>.from(
          details.leaveAllocation,
        );

        if (gender == 'male') {
          filtered.removeWhere(
            (key, _) => key.toLowerCase().contains('maternity'),
          );
        } else if (gender == 'female') {
          filtered.removeWhere(
            (key, _) => key.toLowerCase().contains('paternity'),
          );
        }

        return Right(details.copyWith(leaveAllocation: filtered));
      },
    );
  }
}

class GetLeaveDetailsParams {
  final String employee;
  final String date;
  final String? gender;

  GetLeaveDetailsParams({
    required this.employee,
    required this.date,
    this.gender,
  });
}
```

---

## GROUP 4 — DI wiring update

**File:** `lib/core/di/dependency_injection.dart`

### Fix 4.1 — Remove `GetAttendanceLogsUseCase` from DI

Find and **delete** this block (around line 229-232):
```dart
    Get.lazyPut<GetAttendanceLogsUseCase>(
      () => GetAttendanceLogsUseCase(Get.find<IAttendanceRepository>()),
      fenix: true,
    );
```

Also delete its import at the top of the file:
```dart
import '../../features/attendance/domain/usecases/get_attendance_logs_usecase.dart';
```

### Fix 4.2 — Add `LocalStorageService` to `AttendanceBloc` registration

Find the `AttendanceBloc` registration (around line 426) and add `localStorageService`:
```dart
    Get.lazyPut<AttendanceBloc>(
      () => AttendanceBloc(
        punchInUseCase: Get.find<PunchInUseCase>(),
        punchOutUseCase: Get.find<PunchOutUseCase>(),
        getCheckinStatusUseCase: Get.find<GetCheckinStatusUseCase>(),
        // REMOVE: getAttendanceLogsUseCase: Get.find<GetAttendanceLogsUseCase>(),
        getCalendarEventsUseCase: Get.find<GetCalendarEventsUseCase>(),
        startBreakUseCase: Get.find<StartBreakUseCase>(),
        endBreakUseCase: Get.find<EndBreakUseCase>(),
        getWorkDurationsUseCase: Get.find<GetWorkDurationsUseCase>(),
        getAttendanceMonthSummaryUseCase:
            Get.find<GetAttendanceMonthSummaryUseCase>(),
        getLeaveDetailsUseCase:
            Get.find<attendance_leave.GetLeaveDetailsUseCase>(),
        getLeaveHistoryUseCase: Get.find<GetLeaveHistoryUseCase>(),
        getTeamLeavesUseCase: Get.find<GetTeamLeavesUseCase>(),
        getHolidayListLeavePolicyUseCase:
            Get.find<GetHolidayListLeavePolicyUseCase>(),
        localStorageService: Get.find<LocalStorageService>(),  // ADD THIS
      ),
      fenix: true,
    );
```

---

## GROUP 5 — Screen cleanup

### Fix 5.1 — Remove dead `_empid` state from `AttendanceScreen`

**File:** `lib/features/attendance/presentation/screens/attendance_screen.dart`

**Remove** the following:
- Import: `import 'package:shared_preferences/shared_preferences.dart';`
- Import: `import '../../../../core/constants/storage_constants.dart';`
- Field: `String? _empid;`
- Method `_loadEmpId()` entirely
- Call `_loadEmpId();` inside `initState`

The screen no longer needs `initState` at all unless there is other logic there. If `initState` only had `_loadEmpId()`, remove the entire `initState` override too.

The screen's `build` method should no longer have any `_empid` references. If there is a null check `if (_empid == null) return Scaffold(...)` remove that too — the `BlocListener` on `BottomNavCubit` already fires `started` when the tab is selected.

---

## GROUP 6 — Widget fixes

### Fix 6.1 — Replace `DioClient.baseUrl` reference in `AttendanceHeader`

**File:** `lib/features/attendance/presentation/widgets/attendance_header.dart`

**Remove import:**
```dart
import '../../../../core/network/dio_client.dart';
```

**Replace:**
```dart
final baseUrl = Get.find<DioClient>().baseUrl;
```
**With:**
```dart
const baseUrl = AppConstants.baseUrl;
```

Add import if not present:
```dart
import '../../../../core/constants/app_constants.dart';
```

> Ensure `get/get.dart` import can be removed if `Get.find` is no longer used anywhere else in the file. Check before removing.

---

### Fix 6.2 — Make `StreamSubscription` lifecycle-safe in `AttendanceHeader`

**File:** `lib/features/attendance/presentation/widgets/attendance_header.dart`

Add subscription fields to `_AttendanceHeaderState`:
```dart
  StreamSubscription<AttendanceState>? _policySubscription;
  StreamSubscription<AttendanceState>? _holidaySubscription;
```

Add `dispose`:
```dart
  @override
  void dispose() {
    _policySubscription?.cancel();
    _holidaySubscription?.cancel();
    super.dispose();
  }
```

Update `_showPolicyOnceLoaded`:
```dart
  void _showPolicyOnceLoaded(BuildContext context) {
    _policySubscription?.cancel();
    final bloc = context.read<AttendanceBloc>();
    _policySubscription = bloc.stream.listen((state) {
      if (!mounted) {
        _policySubscription?.cancel();
        return;
      }
      if (state.holidayListLeavePolicy != null && state is! Loading) {
        LeavePolicyPdfBottomSheet.show(
          context,
          state.holidayListLeavePolicy!.leavePolicy.fileUrl,
        );
        _policySubscription?.cancel();
      } else if (state is Error) {
        _policySubscription?.cancel();
      }
    });
  }
```

Update `_showHolidayListOnceLoaded`:
```dart
  void _showHolidayListOnceLoaded(BuildContext context) {
    _holidaySubscription?.cancel();
    final bloc = context.read<AttendanceBloc>();
    _holidaySubscription = bloc.stream.listen((state) {
      if (!mounted) {
        _holidaySubscription?.cancel();
        return;
      }
      if (state.holidayListLeavePolicy != null && state is! Loading) {
        HolidayListBottomSheet.showYearly(context, state.holidayListLeavePolicy!);
        _holidaySubscription?.cancel();
      } else if (state is Error) {
        _holidaySubscription?.cancel();
      }
    });
  }
```

Add import for `StreamSubscription`:
```dart
import 'dart:async';
```
> `dart:async` is likely already imported — check before adding.

---

### Fix 6.3 — Add app-lifecycle awareness to `PunchCard` polling timer

**File:** `lib/features/attendance/presentation/widgets/punch_card.dart`

Change the `State` declaration:
```dart
// FROM:
class _PunchCardState extends State<PunchCard> {

// TO:
class _PunchCardState extends State<PunchCard> with WidgetsBindingObserver {
```

In `initState`, register the observer:
```dart
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // ... existing timer setup ...
  }
```

In `dispose`, remove the observer:
```dart
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer.cancel();
    _pollingTimer?.cancel();
    _stopwatch.stop();
    super.dispose();
  }
```

Add lifecycle handler:
```dart
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _pollingTimer?.cancel();
    } else if (state == AppLifecycleState.resumed) {
      _pollingTimer ??= Timer.periodic(const Duration(seconds: 30), (timer) {
        if (mounted) {
          context.read<AttendanceBloc>().add(
            const AttendanceEvent.workDurationsRequested(),
          );
        }
      });
    }
  }
```

---

## GROUP 7 — State & datasource cleanup

### Fix 7.1 — Fix fragile `calendarEvents` getter in `AttendanceState`

**File:** `lib/features/attendance/presentation/bloc/attendance_state.dart`

**Remove lines 21-34:**
```dart
  @override
  Map<String, String>? get calendarEvents {
    return maybeWhen(
      initial: (events, _, __, ___, ____, _____, ______, _______) => events,
      loading: (events, _, __, ___, ____, _____, ______, _______, ________) =>
          events,
      loaded: (status, logs, events, _, __, ___, ____, _____, ______, _______,
              ________) =>
          events,
      error: (message, events, _, __, ___, ____, _____, ______, _______) =>
          events,
      orElse: () => null,
    );
  }
```

**Replace with:**
```dart
  Map<String, String>? get calendarEvents => mapOrNull(
        initial: (s) => s.calendarEvents,
        loading: (s) => s.calendarEvents,
        loaded: (s) => s.calendarEvents,
        error: (s) => s.calendarEvents,
      );
```

---

### Fix 7.2 — Remove commented mock data from `AttendanceRemoteDataSource`

**File:** `lib/features/attendance/data/datasources/attendance_remote_datasource.dart`

Delete the following comment blocks entirely:

1. Lines ~113–170: The entire commented `// Mock response for testing...` block inside `getAttendanceLogs`
2. Lines ~185–209: The entire commented `// Mock response for testing` block inside `getCalendarEvents`

---

### Fix 7.3 — Remove `debugPrint` from `AttendanceRemoteDataSource`

**File:** `lib/features/attendance/data/datasources/attendance_remote_datasource.dart`

Find and delete:
```dart
    debugPrint("Leave History Response: ${response.data}");
```

Also check whether `import 'package:flutter/foundation.dart';` is used anywhere else in the file. If `debugPrint` was its only use, remove that import too.

---

### Fix 7.4 — Remove stale import from `AttendanceLogList`

**File:** `lib/features/attendance/presentation/widgets/attendance_log_list.dart`

Remove:
```dart
import 'leave_details_section.dart';
```

---

## Verification Checklist

```
[ ] flutter analyze         → zero new errors
[ ] flutter build apk --debug → compiles cleanly
[ ] dart run build_runner build --delete-conflicting-outputs → no codegen errors
[ ] Hot-reload attendance screen → punch card shows, calendar populates
[ ] Punch In → status updates, toast shows success message
[ ] Punch Out (< 9h30m) → confirmation dialog appears
[ ] Navigate away and back → BLoC reloads via BottomNavCubit.started event
[ ] Background app 30s → no polling events in flutter logs
[ ] Leave Policy chip → bottom sheet opens correctly
[ ] Holiday List chip → bottom sheet opens correctly
[ ] Calendar month/week toggle → works without state flicker
[ ] Month summary shows correct data
[ ] On Leave Today section visible when team has leaves
```

---

## Files Modified Summary

| File | Change type |
|------|-------------|
| `lib/core/services/local_storage_service.dart` | Extended — new accessors |
| `lib/core/constants/app_constants.dart` | Extended — `baseUrl` constant |
| `lib/features/attendance/presentation/bloc/attendance_bloc.dart` | Refactored — inject `LocalStorageService`, remove SharedPreferences, remove dead `GetAttendanceLogsUseCase`, move gender logic |
| `lib/features/attendance/domain/usecases/get_leave_details_usecase.dart` | Refactored — gender filtering moved here |
| `lib/core/di/dependency_injection.dart` | Updated — remove `GetAttendanceLogsUseCase`, add `localStorageService` to `AttendanceBloc` |
| `lib/features/attendance/presentation/screens/attendance_screen.dart` | Cleaned — remove dead `_empid` / SharedPreferences |
| `lib/features/attendance/presentation/widgets/attendance_header.dart` | Fixed — remove `DioClient`, lifecycle-safe subscriptions |
| `lib/features/attendance/presentation/widgets/punch_card.dart` | Fixed — `WidgetsBindingObserver` for polling |
| `lib/features/attendance/presentation/bloc/attendance_state.dart` | Fixed — safe `calendarEvents` getter |
| `lib/features/attendance/data/datasources/attendance_remote_datasource.dart` | Cleaned — remove mock data, remove `debugPrint` |
| `lib/features/attendance/presentation/widgets/attendance_log_list.dart` | Cleaned — remove stale import |
