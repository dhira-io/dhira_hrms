import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event.freezed.dart';

@freezed
class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent.started() = CalendarStarted;
  const factory CalendarEvent.monthChanged(DateTime month) = CalendarMonthChanged;
  const factory CalendarEvent.daySelected(DateTime day) = CalendarDaySelected;
}
