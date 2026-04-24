import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/attendance_log_entity.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/leave_details_entity.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_leave_details_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/end_break_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_work_durations_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_attendance_month_summary_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_leave_history_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_team_leaves_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_attendance_logs_usecase.dart';
import '../../domain/usecases/get_calendar_events_usecase.dart';
import '../../domain/usecases/get_checkin_status_usecase.dart';
import '../../domain/usecases/punch_in_usecase.dart';
import '../../domain/usecases/punch_out_usecase.dart';
import '../../domain/usecases/start_break_usecase.dart';
import '../../domain/usecases/get_holiday_list_leave_policy_usecase.dart';
import '../../domain/entities/holiday_list_leave_policy_entity.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

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

  List<AttendanceLogEntity> _cachedLogs = [];

  AttendanceBloc({
    required this.punchInUseCase,
    required this.punchOutUseCase,
    required this.getCheckinStatusUseCase,
    required this.getAttendanceLogsUseCase,
    required this.getCalendarEventsUseCase,
    required this.startBreakUseCase,
    required this.endBreakUseCase,
    required this.getWorkDurationsUseCase,
    required this.getAttendanceMonthSummaryUseCase,
    required this.getLeaveDetailsUseCase,
    required this.getLeaveHistoryUseCase,
    required this.getTeamLeavesUseCase,
    required this.getHolidayListLeavePolicyUseCase,
  }) : super(const AttendanceState.initial()) {
    on<Started>((event, emit) => _onStarted(emit));
    on<PunchInRequested>((event, emit) => _onPunchInRequested(emit));
    on<PunchOutRequested>((event, emit) => _onPunchOutRequested(emit));
    on<CheckStatusRequested>(
      (event, emit) => _loadAttendanceData(emit, useCache: true),
    );
    on<CalendarEventsRequested>(
      (event, emit) =>
          _onCalendarEventsRequested(event.fromDate, event.toDate, emit),
    );
    on<LogRequested>((event, emit) => _loadAttendanceData(emit));
    on<TakeBreakRequested>((event, emit) => _onTakeBreakRequested(emit));
    on<EndBreakRequested>((event, emit) => _onEndBreakRequested(emit));
    on<WorkDurationsRequested>(
      (event, emit) => _loadAttendanceData(emit, useCache: true),
    );
    on<MonthSummaryRequested>(
      (event, emit) => _onMonthSummaryRequested(event.month, event.year, emit),
    );
    on<LeaveDetailsRequested>(
      (event, emit) => _onLeaveDetailsRequested(event.date, emit),
    );
    on<LeaveHistoryRequested>((event, emit) => _onLeaveHistoryRequested(emit));
    on<TeamLeavesRequested>((event, emit) => _onTeamLeavesRequested(emit));
    on<HolidayListLeavePolicyRequested>(
      (event, emit) => _onHolidayListLeavePolicyRequested(emit),
    );
  }

  Future<String?> _getEmpId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageConstants.empId);
  }

  Future<void> _onStarted(Emitter<AttendanceState> emit) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    emit(
      AttendanceState.loading(
        calendarEvents: state.calendarEvents,
        actionType: AttendanceActionType.checkStatus,
        monthSummary: state.monthSummary,
        leaveDetails: state.leaveDetails,
        leaveHistory: state.leaveHistory,
        teamLeaves: state.teamLeaves,
      ),
    );
    if (state.leaveHistory == null) {
      add(const AttendanceEvent.leaveHistoryRequested());
    }
    if (state.leaveDetails == null) {
      add(
        AttendanceEvent.leaveDetailsRequested(
          date: DateTime.now().toString().split(' ')[0],
        ),
      );
    }
    if (state.teamLeaves == null) {
      add(const AttendanceEvent.teamLeavesRequested());
    }
    await _loadAttendanceData(emit);
  }

  Future<void> _onPunchInRequested(Emitter<AttendanceState> emit) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    emit(
      AttendanceState.loading(
        calendarEvents: state.calendarEvents,
        actionType: AttendanceActionType.punchIn,
        monthSummary: state.monthSummary,
        leaveDetails: state.leaveDetails,
        leaveHistory: state.leaveHistory,
        teamLeaves: state.teamLeaves,
      ),
    );
    final result = await punchInUseCase(empid);
    await result.fold(
      (failure) async {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: state.calendarEvents,
            monthSummary: state.monthSummary,
            leaveDetails: state.leaveDetails,
            leaveHistory: state.leaveHistory,
            teamLeaves: state.teamLeaves,
          ),
        );
        await _loadAttendanceData(
          emit,
          useCache: true,
        ); // Reload last known state without logs
      },
      (status) async {
        // Only refresh status and durations
        await _loadAttendanceData(
          emit,
          useCache: true,
          messageOverride: "Punched In Successfully, Have a great day!",
        );
      },
    );
  }

  Future<void> _onPunchOutRequested(Emitter<AttendanceState> emit) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    emit(
      AttendanceState.loading(
        calendarEvents: state.calendarEvents,
        actionType: AttendanceActionType.punchOut,
        monthSummary: state.monthSummary,
        leaveDetails: state.leaveDetails,
        leaveHistory: state.leaveHistory,
        teamLeaves: state.teamLeaves,
      ),
    );
    final result = await punchOutUseCase(empid);
    await result.fold(
      (failure) async {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: state.calendarEvents,
            monthSummary: state.monthSummary,
            leaveDetails: state.leaveDetails,
            leaveHistory: state.leaveHistory,
            teamLeaves: state.teamLeaves,
          ),
        );
        await _loadAttendanceData(
          emit,
          useCache: true,
        ); // Reload last known state without logs
      },
      (status) async {
        // Only refresh status and durations
        await _loadAttendanceData(
          emit,
          useCache: true,
          messageOverride: "Punched out successfully, See you tomorrow!",
        );
      },
    );
  }

  Future<void> _onCalendarEventsRequested(
    String fromDate,
    String toDate,
    Emitter<AttendanceState> emit,
  ) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    final currentState = state;

    final result = await getCalendarEventsUseCase(
      employee: empid,
      fromDate: fromDate,
      toDate: toDate,
    );

    result.fold(
      (failure) {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: currentState.calendarEvents,
            monthSummary: currentState.monthSummary,
            leaveDetails: currentState.leaveDetails,
            userName: _userName,
            profileImage: _profileImage,
          ),
        );
      },
      (events) {
        emit(state.copyWith(calendarEvents: events));
      },
    );
  }

  Future<void> _onMonthSummaryRequested(
    int month,
    int year,
    Emitter<AttendanceState> emit,
  ) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    final currentState = state;

    final result = await getAttendanceMonthSummaryUseCase(
      employee: empid,
      month: month,
      year: year,
    );

    result.fold(
      (failure) {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: currentState.calendarEvents,
            monthSummary: currentState.monthSummary,
            leaveDetails: currentState.leaveDetails,
            userName: _userName,
            profileImage: _profileImage,
          ),
        );
      },
      (summary) {
        emit(state.copyWith(monthSummary: summary));
      },
    );
  }

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

        // Create a modifiable copy of the leave allocations
        final filteredAllocation = Map<String, LeaveAllocationEntity>.from(
          details.leaveAllocation,
        );

        if (gender == 'male') {
          // Remove Maternity Leave for males
          filteredAllocation.removeWhere(
            (key, value) => key.toLowerCase().contains('maternity'),
          );
        } else if (gender == 'female') {
          // Remove Paternity Leave for females
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

  Future<void> _onLeaveHistoryRequested(Emitter<AttendanceState> emit) async {
    // Only fetch if history is null (first time)
    if (state.leaveHistory != null) return;

    final empid = await _getEmpId();
    if (empid == null) return;
    final currentState = state;

    final result = await getLeaveHistoryUseCase(empid);

    result.fold(
      (failure) {
        emit(state.copyWith(leaveHistory: currentState.leaveHistory));
      },
      (history) {
        emit(state.copyWith(leaveHistory: history));
      },
    );
  }

  Future<void> _onTeamLeavesRequested(Emitter<AttendanceState> emit) async {
    if (state.teamLeaves != null) return;

    final empid = await _getEmpId();
    if (empid == null) return;

    final today = DateTime.now().toString().split(' ')[0];

    final result = await getTeamLeavesUseCase(
      GetTeamLeavesParams(employee: empid, fromDate: today, toDate: today),
    );

    result.fold(
      (failure) {
        // Handle failure
      },
      (leaves) {
        emit(state.copyWith(teamLeaves: leaves));
      },
    );
  }

  Future<void> _onTakeBreakRequested(Emitter<AttendanceState> emit) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    emit(
      AttendanceState.loading(
        calendarEvents: state.calendarEvents,
        actionType: AttendanceActionType.takeBreak,
        monthSummary: state.monthSummary,
        leaveDetails: state.leaveDetails,
        leaveHistory: state.leaveHistory,
      ),
    );
    final result = await startBreakUseCase(empid);
    await result.fold(
      (failure) async {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: state.calendarEvents,
            monthSummary: state.monthSummary,
            leaveDetails: state.leaveDetails,
            leaveHistory: state.leaveHistory,
            teamLeaves: state.teamLeaves,
          ),
        );
        await _loadAttendanceData(emit, useCache: true);
      },
      (status) async {
        // Only refresh status and durations
        await _loadAttendanceData(
          emit,
          useCache: true,
          messageOverride: "Time Paused.",
        );
      },
    );
  }

  Future<void> _onEndBreakRequested(Emitter<AttendanceState> emit) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    emit(
      AttendanceState.loading(
        calendarEvents: state.calendarEvents,
        actionType: AttendanceActionType.endBreak,
        monthSummary: state.monthSummary,
        leaveDetails: state.leaveDetails,
        leaveHistory: state.leaveHistory,
      ),
    );
    final result = await endBreakUseCase(empid);
    await result.fold(
      (failure) async {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: state.calendarEvents,
            monthSummary: state.monthSummary,
            leaveDetails: state.leaveDetails,
            leaveHistory: state.leaveHistory,
            teamLeaves: state.teamLeaves,
          ),
        );
        await _loadAttendanceData(emit, useCache: true);
      },
      (status) async {
        await _loadAttendanceData(
          emit,
          useCache: true,
          messageOverride: "Timer Resumed",
        );
      },
    );
  }

  // Remove _onWorkDurationsRequested and merge into _loadAttendanceData

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

  Future<void> _loadAttendanceData(
    Emitter<AttendanceState> emit, {
    bool useCache = false,
    String? messageOverride,
  }) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    await _fetchProfileIfNeeded();
    final statusResult = await getCheckinStatusUseCase(empid);
    final durationsResult = await getWorkDurationsUseCase(empid);

    final Either<dynamic, List<AttendanceLogEntity>> logsResult = const Right(
      [],
    );

    statusResult.fold(
      (failure) => emit(
        AttendanceState.error(
          failure.message,
          calendarEvents: state.calendarEvents,
          monthSummary: state.monthSummary,
          leaveDetails: state.leaveDetails,
          leaveHistory: state.leaveHistory,
          teamLeaves: state.teamLeaves,
          userName: _userName,
          profileImage: _profileImage,
        ),
      ),
      (status) {
        logsResult.fold(
          (failure) => emit(
            AttendanceState.error(
              failure.message,
              calendarEvents: state.calendarEvents,
              monthSummary: state.monthSummary,
              leaveDetails: state.leaveDetails,
              leaveHistory: state.leaveHistory,
              teamLeaves: state.teamLeaves,
              userName: _userName,
              profileImage: _profileImage,
            ),
          ),
          (logs) {
            _cachedLogs = logs;
            durationsResult.fold(
              (failure) => emit(
                AttendanceState.loaded(
                  status: status.copyWith(
                    message: messageOverride ?? status.message,
                  ),
                  logs: logs,
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
                  logs: logs,
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
        );
      },
    );
  }

  Future<void> _onHolidayListLeavePolicyRequested(
      Emitter<AttendanceState> emit) async {
    final empid = await _getEmpId();
    if (empid == null) return;

    emit(
      state.copyWith(
        holidayListLeavePolicy: state.holidayListLeavePolicy, // Preserve current
      ),
    );

    // If already loaded, we might not need to reload, but usually we do for fresh data
    // Or we can just check if it's already there
    // if (state.holidayListLeavePolicy != null) return;

    final result = await getHolidayListLeavePolicyUseCase(empid);

    result.fold(
      (failure) {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: state.calendarEvents,
            monthSummary: state.monthSummary,
            leaveDetails: state.leaveDetails,
            leaveHistory: state.leaveHistory,
            teamLeaves: state.teamLeaves,
            holidayListLeavePolicy: state.holidayListLeavePolicy,
            userName: _userName,
            profileImage: _profileImage,
          ),
        );
      },
      (policy) {
        emit(state.copyWith(holidayListLeavePolicy: policy));
      },
    );
  }
}
