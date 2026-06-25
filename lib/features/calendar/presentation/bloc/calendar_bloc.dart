import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/calendar_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/usecases/get_calendar_events_usecase.dart';
import 'package:dhira_hrms/features/calendar/domain/usecases/get_calendar_summary_usecase.dart';
import 'calendar_event.dart';
import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final GetCalendarMonthEventsUseCase getCalendarEventsUseCase;
  final GetCalendarSummaryUseCase getCalendarSummaryUseCase;
  final LocalStorageService localStorageService;

  CalendarBloc({
    required this.getCalendarEventsUseCase,
    required this.getCalendarSummaryUseCase,
    required this.localStorageService,
  }) : super(const CalendarState.initial()) {
    on<CalendarStarted>(_onStarted);
    on<CalendarMonthChanged>(_onMonthChanged);
    on<CalendarDaySelected>(_onDaySelected);
  }

  Future<void> _onStarted(
    CalendarStarted event,
    Emitter<CalendarState> emit,
  ) async {
    await _fetchData(DateTime.now(), emit);
  }

  Future<void> _onMonthChanged(
    CalendarMonthChanged event,
    Emitter<CalendarState> emit,
  ) async {
    await _fetchData(event.month, emit);
  }

  void _onDaySelected(
    CalendarDaySelected event,
    Emitter<CalendarState> emit,
  ) {
    state.mapOrNull(
      loaded: (loadedState) {
        emit(loadedState.copyWith(selectedDay: event.day));
      },
    );
  }

  Future<void> _fetchData(
    DateTime month,
    Emitter<CalendarState> emit,
  ) async {
    emit(const CalendarState.loading());

    final empid = localStorageService.getEmpId();
    if (empid == null || empid.isEmpty) {
      emit(const CalendarState.error(message: "Employee ID not found"));
      return;
    }

    final fromDate = DateTimeUtils.formatToYMD(month.firstDayOfMonth);
    final toDate = DateTimeUtils.formatToYMD(month.lastDayOfMonth);

    final results = await Future.wait([
      getCalendarEventsUseCase(GetCalendarMonthEventsParams(
        employee: empid,
        fromDate: fromDate,
        toDate: toDate,
      )),
      getCalendarSummaryUseCase(GetCalendarSummaryParams(
        employee: empid,
        month: month.month,
        year: month.year,
      )),
    ]);

    final eventsResult = results[0] as Either<Failure, Map<String, String>>;
    final summaryResult = results[1] as Either<Failure, CalendarSummaryEntity>;

    if (eventsResult.isLeft()) {
      eventsResult.fold(
        (failure) => emit(CalendarState.error(message: failure.message)),
        (_) {},
      );
      return;
    }

    if (summaryResult.isLeft()) {
      summaryResult.fold(
        (failure) => emit(CalendarState.error(message: failure.message)),
        (_) {},
      );
      return;
    }

    final events = eventsResult.getOrElse(() => {});
    final summary = summaryResult.getOrElse(() => throw Exception("Unexpected state"));

    emit(CalendarState.loaded(
      events: events,
      summary: summary,
      focusedMonth: month,
      selectedDay: DateTimeUtils.isSameDay(month, DateTime.now()) ? DateTime.now() : null,
    ));
  }
}
