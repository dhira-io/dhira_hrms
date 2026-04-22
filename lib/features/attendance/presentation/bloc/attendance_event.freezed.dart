// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttendanceEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent()';
}


}

/// @nodoc
class $AttendanceEventCopyWith<$Res>  {
$AttendanceEventCopyWith(AttendanceEvent _, $Res Function(AttendanceEvent) __);
}


/// Adds pattern-matching-related methods to [AttendanceEvent].
extension AttendanceEventPatterns on AttendanceEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( PunchInRequested value)?  punchInRequested,TResult Function( PunchOutRequested value)?  punchOutRequested,TResult Function( CheckStatusRequested value)?  checkStatusRequested,TResult Function( CalendarEventsRequested value)?  calendarEventsRequested,TResult Function( LogRequested value)?  logRequested,TResult Function( TakeBreakRequested value)?  takeBreakRequested,TResult Function( EndBreakRequested value)?  endBreakRequested,TResult Function( WorkDurationsRequested value)?  workDurationsRequested,TResult Function( MonthSummaryRequested value)?  monthSummaryRequested,TResult Function( LeaveDetailsRequested value)?  leaveDetailsRequested,TResult Function( LeaveHistoryRequested value)?  leaveHistoryRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case PunchInRequested() when punchInRequested != null:
return punchInRequested(_that);case PunchOutRequested() when punchOutRequested != null:
return punchOutRequested(_that);case CheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested(_that);case CalendarEventsRequested() when calendarEventsRequested != null:
return calendarEventsRequested(_that);case LogRequested() when logRequested != null:
return logRequested(_that);case TakeBreakRequested() when takeBreakRequested != null:
return takeBreakRequested(_that);case EndBreakRequested() when endBreakRequested != null:
return endBreakRequested(_that);case WorkDurationsRequested() when workDurationsRequested != null:
return workDurationsRequested(_that);case MonthSummaryRequested() when monthSummaryRequested != null:
return monthSummaryRequested(_that);case LeaveDetailsRequested() when leaveDetailsRequested != null:
return leaveDetailsRequested(_that);case LeaveHistoryRequested() when leaveHistoryRequested != null:
return leaveHistoryRequested(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( PunchInRequested value)  punchInRequested,required TResult Function( PunchOutRequested value)  punchOutRequested,required TResult Function( CheckStatusRequested value)  checkStatusRequested,required TResult Function( CalendarEventsRequested value)  calendarEventsRequested,required TResult Function( LogRequested value)  logRequested,required TResult Function( TakeBreakRequested value)  takeBreakRequested,required TResult Function( EndBreakRequested value)  endBreakRequested,required TResult Function( WorkDurationsRequested value)  workDurationsRequested,required TResult Function( MonthSummaryRequested value)  monthSummaryRequested,required TResult Function( LeaveDetailsRequested value)  leaveDetailsRequested,required TResult Function( LeaveHistoryRequested value)  leaveHistoryRequested,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case PunchInRequested():
return punchInRequested(_that);case PunchOutRequested():
return punchOutRequested(_that);case CheckStatusRequested():
return checkStatusRequested(_that);case CalendarEventsRequested():
return calendarEventsRequested(_that);case LogRequested():
return logRequested(_that);case TakeBreakRequested():
return takeBreakRequested(_that);case EndBreakRequested():
return endBreakRequested(_that);case WorkDurationsRequested():
return workDurationsRequested(_that);case MonthSummaryRequested():
return monthSummaryRequested(_that);case LeaveDetailsRequested():
return leaveDetailsRequested(_that);case LeaveHistoryRequested():
return leaveHistoryRequested(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( PunchInRequested value)?  punchInRequested,TResult? Function( PunchOutRequested value)?  punchOutRequested,TResult? Function( CheckStatusRequested value)?  checkStatusRequested,TResult? Function( CalendarEventsRequested value)?  calendarEventsRequested,TResult? Function( LogRequested value)?  logRequested,TResult? Function( TakeBreakRequested value)?  takeBreakRequested,TResult? Function( EndBreakRequested value)?  endBreakRequested,TResult? Function( WorkDurationsRequested value)?  workDurationsRequested,TResult? Function( MonthSummaryRequested value)?  monthSummaryRequested,TResult? Function( LeaveDetailsRequested value)?  leaveDetailsRequested,TResult? Function( LeaveHistoryRequested value)?  leaveHistoryRequested,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case PunchInRequested() when punchInRequested != null:
return punchInRequested(_that);case PunchOutRequested() when punchOutRequested != null:
return punchOutRequested(_that);case CheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested(_that);case CalendarEventsRequested() when calendarEventsRequested != null:
return calendarEventsRequested(_that);case LogRequested() when logRequested != null:
return logRequested(_that);case TakeBreakRequested() when takeBreakRequested != null:
return takeBreakRequested(_that);case EndBreakRequested() when endBreakRequested != null:
return endBreakRequested(_that);case WorkDurationsRequested() when workDurationsRequested != null:
return workDurationsRequested(_that);case MonthSummaryRequested() when monthSummaryRequested != null:
return monthSummaryRequested(_that);case LeaveDetailsRequested() when leaveDetailsRequested != null:
return leaveDetailsRequested(_that);case LeaveHistoryRequested() when leaveHistoryRequested != null:
return leaveHistoryRequested(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  punchInRequested,TResult Function()?  punchOutRequested,TResult Function()?  checkStatusRequested,TResult Function( String fromDate,  String toDate)?  calendarEventsRequested,TResult Function()?  logRequested,TResult Function()?  takeBreakRequested,TResult Function()?  endBreakRequested,TResult Function()?  workDurationsRequested,TResult Function( int month,  int year)?  monthSummaryRequested,TResult Function( String date)?  leaveDetailsRequested,TResult Function()?  leaveHistoryRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case PunchInRequested() when punchInRequested != null:
return punchInRequested();case PunchOutRequested() when punchOutRequested != null:
return punchOutRequested();case CheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested();case CalendarEventsRequested() when calendarEventsRequested != null:
return calendarEventsRequested(_that.fromDate,_that.toDate);case LogRequested() when logRequested != null:
return logRequested();case TakeBreakRequested() when takeBreakRequested != null:
return takeBreakRequested();case EndBreakRequested() when endBreakRequested != null:
return endBreakRequested();case WorkDurationsRequested() when workDurationsRequested != null:
return workDurationsRequested();case MonthSummaryRequested() when monthSummaryRequested != null:
return monthSummaryRequested(_that.month,_that.year);case LeaveDetailsRequested() when leaveDetailsRequested != null:
return leaveDetailsRequested(_that.date);case LeaveHistoryRequested() when leaveHistoryRequested != null:
return leaveHistoryRequested();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  punchInRequested,required TResult Function()  punchOutRequested,required TResult Function()  checkStatusRequested,required TResult Function( String fromDate,  String toDate)  calendarEventsRequested,required TResult Function()  logRequested,required TResult Function()  takeBreakRequested,required TResult Function()  endBreakRequested,required TResult Function()  workDurationsRequested,required TResult Function( int month,  int year)  monthSummaryRequested,required TResult Function( String date)  leaveDetailsRequested,required TResult Function()  leaveHistoryRequested,}) {final _that = this;
switch (_that) {
case Started():
return started();case PunchInRequested():
return punchInRequested();case PunchOutRequested():
return punchOutRequested();case CheckStatusRequested():
return checkStatusRequested();case CalendarEventsRequested():
return calendarEventsRequested(_that.fromDate,_that.toDate);case LogRequested():
return logRequested();case TakeBreakRequested():
return takeBreakRequested();case EndBreakRequested():
return endBreakRequested();case WorkDurationsRequested():
return workDurationsRequested();case MonthSummaryRequested():
return monthSummaryRequested(_that.month,_that.year);case LeaveDetailsRequested():
return leaveDetailsRequested(_that.date);case LeaveHistoryRequested():
return leaveHistoryRequested();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  punchInRequested,TResult? Function()?  punchOutRequested,TResult? Function()?  checkStatusRequested,TResult? Function( String fromDate,  String toDate)?  calendarEventsRequested,TResult? Function()?  logRequested,TResult? Function()?  takeBreakRequested,TResult? Function()?  endBreakRequested,TResult? Function()?  workDurationsRequested,TResult? Function( int month,  int year)?  monthSummaryRequested,TResult? Function( String date)?  leaveDetailsRequested,TResult? Function()?  leaveHistoryRequested,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case PunchInRequested() when punchInRequested != null:
return punchInRequested();case PunchOutRequested() when punchOutRequested != null:
return punchOutRequested();case CheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested();case CalendarEventsRequested() when calendarEventsRequested != null:
return calendarEventsRequested(_that.fromDate,_that.toDate);case LogRequested() when logRequested != null:
return logRequested();case TakeBreakRequested() when takeBreakRequested != null:
return takeBreakRequested();case EndBreakRequested() when endBreakRequested != null:
return endBreakRequested();case WorkDurationsRequested() when workDurationsRequested != null:
return workDurationsRequested();case MonthSummaryRequested() when monthSummaryRequested != null:
return monthSummaryRequested(_that.month,_that.year);case LeaveDetailsRequested() when leaveDetailsRequested != null:
return leaveDetailsRequested(_that.date);case LeaveHistoryRequested() when leaveHistoryRequested != null:
return leaveHistoryRequested();case _:
  return null;

}
}

}

/// @nodoc


class Started extends AttendanceEvent {
  const Started(): super._();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent.started()';
}


}




/// @nodoc


class PunchInRequested extends AttendanceEvent {
  const PunchInRequested(): super._();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PunchInRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent.punchInRequested()';
}


}




/// @nodoc


class PunchOutRequested extends AttendanceEvent {
  const PunchOutRequested(): super._();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PunchOutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent.punchOutRequested()';
}


}




/// @nodoc


class CheckStatusRequested extends AttendanceEvent {
  const CheckStatusRequested(): super._();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckStatusRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent.checkStatusRequested()';
}


}




/// @nodoc


class CalendarEventsRequested extends AttendanceEvent {
  const CalendarEventsRequested({required this.fromDate, required this.toDate}): super._();


 final  String fromDate;
 final  String toDate;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarEventsRequestedCopyWith<CalendarEventsRequested> get copyWith => _$CalendarEventsRequestedCopyWithImpl<CalendarEventsRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarEventsRequested&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate));
}


@override
int get hashCode => Object.hash(runtimeType,fromDate,toDate);

@override
String toString() {
  return 'AttendanceEvent.calendarEventsRequested(fromDate: $fromDate, toDate: $toDate)';
}


}

/// @nodoc
abstract mixin class $CalendarEventsRequestedCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory $CalendarEventsRequestedCopyWith(CalendarEventsRequested value, $Res Function(CalendarEventsRequested) _then) = _$CalendarEventsRequestedCopyWithImpl;
@useResult
$Res call({
 String fromDate, String toDate
});




}
/// @nodoc
class _$CalendarEventsRequestedCopyWithImpl<$Res>
    implements $CalendarEventsRequestedCopyWith<$Res> {
  _$CalendarEventsRequestedCopyWithImpl(this._self, this._then);

  final CalendarEventsRequested _self;
  final $Res Function(CalendarEventsRequested) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fromDate = null,Object? toDate = null,}) {
  return _then(CalendarEventsRequested(
fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LogRequested extends AttendanceEvent {
  const LogRequested(): super._();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent.logRequested()';
}


}




/// @nodoc


class TakeBreakRequested extends AttendanceEvent {
  const TakeBreakRequested(): super._();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TakeBreakRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent.takeBreakRequested()';
}


}




/// @nodoc


class EndBreakRequested extends AttendanceEvent {
  const EndBreakRequested(): super._();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EndBreakRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent.endBreakRequested()';
}


}




/// @nodoc


class WorkDurationsRequested extends AttendanceEvent {
  const WorkDurationsRequested(): super._();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkDurationsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent.workDurationsRequested()';
}


}




/// @nodoc


class MonthSummaryRequested extends AttendanceEvent {
  const MonthSummaryRequested({required this.month, required this.year}): super._();


 final  int month;
 final  int year;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthSummaryRequestedCopyWith<MonthSummaryRequested> get copyWith => _$MonthSummaryRequestedCopyWithImpl<MonthSummaryRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthSummaryRequested&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year));
}


@override
int get hashCode => Object.hash(runtimeType,month,year);

@override
String toString() {
  return 'AttendanceEvent.monthSummaryRequested(month: $month, year: $year)';
}


}

/// @nodoc
abstract mixin class $MonthSummaryRequestedCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory $MonthSummaryRequestedCopyWith(MonthSummaryRequested value, $Res Function(MonthSummaryRequested) _then) = _$MonthSummaryRequestedCopyWithImpl;
@useResult
$Res call({
 int month, int year
});




}
/// @nodoc
class _$MonthSummaryRequestedCopyWithImpl<$Res>
    implements $MonthSummaryRequestedCopyWith<$Res> {
  _$MonthSummaryRequestedCopyWithImpl(this._self, this._then);

  final MonthSummaryRequested _self;
  final $Res Function(MonthSummaryRequested) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? month = null,Object? year = null,}) {
  return _then(MonthSummaryRequested(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class LeaveDetailsRequested extends AttendanceEvent {
  const LeaveDetailsRequested({required this.date}): super._();


 final  String date;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveDetailsRequestedCopyWith<LeaveDetailsRequested> get copyWith => _$LeaveDetailsRequestedCopyWithImpl<LeaveDetailsRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveDetailsRequested&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'AttendanceEvent.leaveDetailsRequested(date: $date)';
}


}

/// @nodoc
abstract mixin class $LeaveDetailsRequestedCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory $LeaveDetailsRequestedCopyWith(LeaveDetailsRequested value, $Res Function(LeaveDetailsRequested) _then) = _$LeaveDetailsRequestedCopyWithImpl;
@useResult
$Res call({
 String date
});




}
/// @nodoc
class _$LeaveDetailsRequestedCopyWithImpl<$Res>
    implements $LeaveDetailsRequestedCopyWith<$Res> {
  _$LeaveDetailsRequestedCopyWithImpl(this._self, this._then);

  final LeaveDetailsRequested _self;
  final $Res Function(LeaveDetailsRequested) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,}) {
  return _then(LeaveDetailsRequested(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LeaveHistoryRequested extends AttendanceEvent {
  const LeaveHistoryRequested(): super._();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveHistoryRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent.leaveHistoryRequested()';
}


}




// dart format on
