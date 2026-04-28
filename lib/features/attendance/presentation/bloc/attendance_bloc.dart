import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/attendance_entities.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_leave_details_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/end_break_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_work_durations_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_attendance_month_summary_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_leave_history_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_team_leaves_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_calendar_events_usecase.dart';
import '../../domain/usecases/get_checkin_status_usecase.dart';
import '../../domain/usecases/punch_in_usecase.dart';
import '../../domain/usecases/punch_out_usecase.dart';
import '../../domain/usecases/start_break_usecase.dart';
import '../../domain/usecases/get_holiday_list_leave_policy_usecase.dart';
import 'dart:async';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/error/failures.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

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


  AttendanceBloc({
    required this.punchInUseCase,
    required this.punchOutUseCase,
    required this.getCheckinStatusUseCase,
    required this.getCalendarEventsUseCase,
    required this.startBreakUseCase,
    required this.endBreakUseCase,
    required this.getWorkDurationsUseCase,
    required this.getAttendanceMonthSummaryUseCase,
    required this.getLeaveDetailsUseCase,
    required this.getLeaveHistoryUseCase,
    required this.getTeamLeavesUseCase,
    required this.getHolidayListLeavePolicyUseCase,
    required this.localStorageService,
  }) : super(const AttendanceState.initial()) {
    on<Started>((event, emit) => _onStarted(emit));
    on<PunchInRequested>((event, emit) => _onPunchInRequested(emit));
    on<PunchOutRequested>((event, emit) => _onPunchOutRequested(emit));
    on<CheckStatusRequested>(_onCheckStatusRequested);
    on<CalendarEventsRequested>(
      (event, emit) =>
          _onCalendarEventsRequested(event.fromDate, event.toDate, emit),
    );
    on<PageChangedRequested>(
      (event, emit) => _onPageChangedRequested(event.date, emit),
    );
    on<TakeBreakRequested>((event, emit) => _onTakeBreakRequested(emit));
    on<EndBreakRequested>((event, emit) => _onEndBreakRequested(emit));
    on<WorkDurationsRequested>(_onWorkDurationsRequested);
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
    return localStorageService.getEmpId();
  }

  Future<void> _onStarted(Emitter<AttendanceState> emit) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    
    // Explicitly emit loading state for fresh start
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

  Future<void> _onCheckStatusRequested(
    CheckStatusRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    // Only show loader if we don't have a status yet
    final hasStatus = state.maybeMap(
      loaded: (s) => true,
      orElse: () => false,
    );

    if (!hasStatus) {
      emit(AttendanceState.loading(
        calendarEvents: state.calendarEvents,
        actionType: AttendanceActionType.checkStatus,
        monthSummary: state.monthSummary,
        leaveDetails: state.leaveDetails,
        leaveHistory: state.leaveHistory,
        teamLeaves: state.teamLeaves,
      ));
    }
    await _loadAttendanceData(emit, useCache: true);
  }

  Future<void> _onWorkDurationsRequested(
    WorkDurationsRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    // Only show loader if we don't have work durations yet
    final hasDurations = state.maybeMap(
      loaded: (s) => s.workDurations != null,
      orElse: () => false,
    );

    if (!hasDurations) {
      emit(AttendanceState.loading(
        calendarEvents: state.calendarEvents,
        actionType: AttendanceActionType.checkStatus,
        monthSummary: state.monthSummary,
        leaveDetails: state.leaveDetails,
        leaveHistory: state.leaveHistory,
        teamLeaves: state.teamLeaves,
      ));
    }
    await _loadAttendanceData(emit, useCache: true);
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
            leaveHistory: currentState.leaveHistory,
            teamLeaves: currentState.teamLeaves,
            holidayListLeavePolicy: currentState.holidayListLeavePolicy,
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
            leaveHistory: currentState.leaveHistory,
            teamLeaves: currentState.teamLeaves,
            holidayListLeavePolicy: currentState.holidayListLeavePolicy,
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


    final result = await getLeaveDetailsUseCase(
      GetLeaveDetailsParams(
        employee: empid,
        date: date,
        gender: localStorageService.getGender(),
      ),
    );

    await result.fold(
      (failure) async {
        emit(state.copyWith(leaveDetails: state.leaveDetails));
      },
      (details) async {
        emit(state.copyWith(leaveDetails: details));
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
        teamLeaves: state.teamLeaves,
        holidayListLeavePolicy: state.holidayListLeavePolicy,
        userName: _userName,
        profileImage: _profileImage,
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
        teamLeaves: state.teamLeaves,
        holidayListLeavePolicy: state.holidayListLeavePolicy,
        userName: _userName,
        profileImage: _profileImage,
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
    _userName = localStorageService.getUserFullname();
    final cookieMap = localStorageService.getCookieMap();
    if (cookieMap != null) {
      _profileImage = cookieMap['user_image'];
    }
    _isProfileFetched = true;
  }

  Future<void> _onPageChangedRequested(
    DateTime date,
    Emitter<AttendanceState> emit,
  ) async {
    final empid = await _getEmpId();
    if (empid == null) return;

    final fromDate = DateTime(date.year, date.month, 1);
    final toDate = DateTime(date.year, date.month + 1, 0);

    final results = await Future.wait([
      getCalendarEventsUseCase(
        employee: empid,
        fromDate: DateTimeUtils.formatToYMD(fromDate),
        toDate: DateTimeUtils.formatToYMD(toDate),
      ),
      getAttendanceMonthSummaryUseCase(
        employee: empid,
        month: date.month,
        year: date.year,
      ),
      getLeaveDetailsUseCase(
        GetLeaveDetailsParams(
          employee: empid,
          date: DateTimeUtils.formatToYMD(date),
          gender: localStorageService.getGender(),
        ),
      ),
    ]);

    final eventsResult = results[0] as Either<Failure, Map<String, String>>;
    final summaryResult =
        results[1] as Either<Failure, AttendanceMonthSummaryEntity>;
    final detailsResult = results[2] as Either<Failure, LeaveDetailsEntity>;

    var newState = state;

    eventsResult.fold(
      (_) {},
      (events) => newState = newState.copyWith(calendarEvents: events),
    );
    summaryResult.fold(
      (_) {},
      (summary) => newState = newState.copyWith(monthSummary: summary),
    );
    detailsResult.fold(
      (_) {},
      (details) => newState = newState.copyWith(leaveDetails: details),
    );

    emit(newState);
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
        durationsResult.fold(
          (failure) => emit(
            AttendanceState.loaded(
              status: status.copyWith(
                message: messageOverride ?? status.message,
              ),
              logs: [],
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
              logs: [],
              calendarEvents: state.calendarEvents,
              workDurations: durations,
              monthSummary: state.monthSummary,
              leaveDetails: state.leaveDetails,
              leaveHistory: state.leaveHistory,
              teamLeaves: state.teamLeaves,
              userName: _userName,
              profileImage: _profileImage,
            ),
          ),
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
