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

 String get empid;
/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceEventCopyWith<AttendanceEvent> get copyWith => _$AttendanceEventCopyWithImpl<AttendanceEvent>(this as AttendanceEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceEvent&&(identical(other.empid, empid) || other.empid == empid));
}


@override
int get hashCode => Object.hash(runtimeType,empid);

@override
String toString() {
  return 'AttendanceEvent(empid: $empid)';
}


}

/// @nodoc
abstract mixin class $AttendanceEventCopyWith<$Res>  {
  factory $AttendanceEventCopyWith(AttendanceEvent value, $Res Function(AttendanceEvent) _then) = _$AttendanceEventCopyWithImpl;
@useResult
$Res call({
 String empid
});




}
/// @nodoc
class _$AttendanceEventCopyWithImpl<$Res>
    implements $AttendanceEventCopyWith<$Res> {
  _$AttendanceEventCopyWithImpl(this._self, this._then);

  final AttendanceEvent _self;
  final $Res Function(AttendanceEvent) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? empid = null,}) {
  return _then(_self.copyWith(
empid: null == empid ? _self.empid : empid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( PunchInRequested value)?  punchInRequested,TResult Function( PunchOutRequested value)?  punchOutRequested,TResult Function( CheckStatusRequested value)?  checkStatusRequested,TResult Function( CalendarEventsRequested value)?  calendarEventsRequested,TResult Function( LogRequested value)?  logRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case PunchInRequested() when punchInRequested != null:
return punchInRequested(_that);case PunchOutRequested() when punchOutRequested != null:
return punchOutRequested(_that);case CheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested(_that);case CalendarEventsRequested() when calendarEventsRequested != null:
return calendarEventsRequested(_that);case LogRequested() when logRequested != null:
return logRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( PunchInRequested value)  punchInRequested,required TResult Function( PunchOutRequested value)  punchOutRequested,required TResult Function( CheckStatusRequested value)  checkStatusRequested,required TResult Function( CalendarEventsRequested value)  calendarEventsRequested,required TResult Function( LogRequested value)  logRequested,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case PunchInRequested():
return punchInRequested(_that);case PunchOutRequested():
return punchOutRequested(_that);case CheckStatusRequested():
return checkStatusRequested(_that);case CalendarEventsRequested():
return calendarEventsRequested(_that);case LogRequested():
return logRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( PunchInRequested value)?  punchInRequested,TResult? Function( PunchOutRequested value)?  punchOutRequested,TResult? Function( CheckStatusRequested value)?  checkStatusRequested,TResult? Function( CalendarEventsRequested value)?  calendarEventsRequested,TResult? Function( LogRequested value)?  logRequested,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case PunchInRequested() when punchInRequested != null:
return punchInRequested(_that);case PunchOutRequested() when punchOutRequested != null:
return punchOutRequested(_that);case CheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested(_that);case CalendarEventsRequested() when calendarEventsRequested != null:
return calendarEventsRequested(_that);case LogRequested() when logRequested != null:
return logRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String empid)?  started,TResult Function( String empid)?  punchInRequested,TResult Function( String empid)?  punchOutRequested,TResult Function( String empid)?  checkStatusRequested,TResult Function( String empid,  String fromDate,  String toDate)?  calendarEventsRequested,TResult Function( String empid)?  logRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that.empid);case PunchInRequested() when punchInRequested != null:
return punchInRequested(_that.empid);case PunchOutRequested() when punchOutRequested != null:
return punchOutRequested(_that.empid);case CheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested(_that.empid);case CalendarEventsRequested() when calendarEventsRequested != null:
return calendarEventsRequested(_that.empid,_that.fromDate,_that.toDate);case LogRequested() when logRequested != null:
return logRequested(_that.empid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String empid)  started,required TResult Function( String empid)  punchInRequested,required TResult Function( String empid)  punchOutRequested,required TResult Function( String empid)  checkStatusRequested,required TResult Function( String empid,  String fromDate,  String toDate)  calendarEventsRequested,required TResult Function( String empid)  logRequested,}) {final _that = this;
switch (_that) {
case Started():
return started(_that.empid);case PunchInRequested():
return punchInRequested(_that.empid);case PunchOutRequested():
return punchOutRequested(_that.empid);case CheckStatusRequested():
return checkStatusRequested(_that.empid);case CalendarEventsRequested():
return calendarEventsRequested(_that.empid,_that.fromDate,_that.toDate);case LogRequested():
return logRequested(_that.empid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String empid)?  started,TResult? Function( String empid)?  punchInRequested,TResult? Function( String empid)?  punchOutRequested,TResult? Function( String empid)?  checkStatusRequested,TResult? Function( String empid,  String fromDate,  String toDate)?  calendarEventsRequested,TResult? Function( String empid)?  logRequested,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that.empid);case PunchInRequested() when punchInRequested != null:
return punchInRequested(_that.empid);case PunchOutRequested() when punchOutRequested != null:
return punchOutRequested(_that.empid);case CheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested(_that.empid);case CalendarEventsRequested() when calendarEventsRequested != null:
return calendarEventsRequested(_that.empid,_that.fromDate,_that.toDate);case LogRequested() when logRequested != null:
return logRequested(_that.empid);case _:
  return null;

}
}

}

/// @nodoc


class Started extends AttendanceEvent {
  const Started(this.empid): super._();
  

@override final  String empid;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartedCopyWith<Started> get copyWith => _$StartedCopyWithImpl<Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started&&(identical(other.empid, empid) || other.empid == empid));
}


@override
int get hashCode => Object.hash(runtimeType,empid);

@override
String toString() {
  return 'AttendanceEvent.started(empid: $empid)';
}


}

/// @nodoc
abstract mixin class $StartedCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory $StartedCopyWith(Started value, $Res Function(Started) _then) = _$StartedCopyWithImpl;
@override @useResult
$Res call({
 String empid
});




}
/// @nodoc
class _$StartedCopyWithImpl<$Res>
    implements $StartedCopyWith<$Res> {
  _$StartedCopyWithImpl(this._self, this._then);

  final Started _self;
  final $Res Function(Started) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? empid = null,}) {
  return _then(Started(
null == empid ? _self.empid : empid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PunchInRequested extends AttendanceEvent {
  const PunchInRequested(this.empid): super._();
  

@override final  String empid;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PunchInRequestedCopyWith<PunchInRequested> get copyWith => _$PunchInRequestedCopyWithImpl<PunchInRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PunchInRequested&&(identical(other.empid, empid) || other.empid == empid));
}


@override
int get hashCode => Object.hash(runtimeType,empid);

@override
String toString() {
  return 'AttendanceEvent.punchInRequested(empid: $empid)';
}


}

/// @nodoc
abstract mixin class $PunchInRequestedCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory $PunchInRequestedCopyWith(PunchInRequested value, $Res Function(PunchInRequested) _then) = _$PunchInRequestedCopyWithImpl;
@override @useResult
$Res call({
 String empid
});




}
/// @nodoc
class _$PunchInRequestedCopyWithImpl<$Res>
    implements $PunchInRequestedCopyWith<$Res> {
  _$PunchInRequestedCopyWithImpl(this._self, this._then);

  final PunchInRequested _self;
  final $Res Function(PunchInRequested) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? empid = null,}) {
  return _then(PunchInRequested(
null == empid ? _self.empid : empid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PunchOutRequested extends AttendanceEvent {
  const PunchOutRequested(this.empid): super._();
  

@override final  String empid;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PunchOutRequestedCopyWith<PunchOutRequested> get copyWith => _$PunchOutRequestedCopyWithImpl<PunchOutRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PunchOutRequested&&(identical(other.empid, empid) || other.empid == empid));
}


@override
int get hashCode => Object.hash(runtimeType,empid);

@override
String toString() {
  return 'AttendanceEvent.punchOutRequested(empid: $empid)';
}


}

/// @nodoc
abstract mixin class $PunchOutRequestedCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory $PunchOutRequestedCopyWith(PunchOutRequested value, $Res Function(PunchOutRequested) _then) = _$PunchOutRequestedCopyWithImpl;
@override @useResult
$Res call({
 String empid
});




}
/// @nodoc
class _$PunchOutRequestedCopyWithImpl<$Res>
    implements $PunchOutRequestedCopyWith<$Res> {
  _$PunchOutRequestedCopyWithImpl(this._self, this._then);

  final PunchOutRequested _self;
  final $Res Function(PunchOutRequested) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? empid = null,}) {
  return _then(PunchOutRequested(
null == empid ? _self.empid : empid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CheckStatusRequested extends AttendanceEvent {
  const CheckStatusRequested(this.empid): super._();
  

@override final  String empid;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckStatusRequestedCopyWith<CheckStatusRequested> get copyWith => _$CheckStatusRequestedCopyWithImpl<CheckStatusRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckStatusRequested&&(identical(other.empid, empid) || other.empid == empid));
}


@override
int get hashCode => Object.hash(runtimeType,empid);

@override
String toString() {
  return 'AttendanceEvent.checkStatusRequested(empid: $empid)';
}


}

/// @nodoc
abstract mixin class $CheckStatusRequestedCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory $CheckStatusRequestedCopyWith(CheckStatusRequested value, $Res Function(CheckStatusRequested) _then) = _$CheckStatusRequestedCopyWithImpl;
@override @useResult
$Res call({
 String empid
});




}
/// @nodoc
class _$CheckStatusRequestedCopyWithImpl<$Res>
    implements $CheckStatusRequestedCopyWith<$Res> {
  _$CheckStatusRequestedCopyWithImpl(this._self, this._then);

  final CheckStatusRequested _self;
  final $Res Function(CheckStatusRequested) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? empid = null,}) {
  return _then(CheckStatusRequested(
null == empid ? _self.empid : empid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CalendarEventsRequested extends AttendanceEvent {
  const CalendarEventsRequested({required this.empid, required this.fromDate, required this.toDate}): super._();
  

@override final  String empid;
 final  String fromDate;
 final  String toDate;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarEventsRequestedCopyWith<CalendarEventsRequested> get copyWith => _$CalendarEventsRequestedCopyWithImpl<CalendarEventsRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarEventsRequested&&(identical(other.empid, empid) || other.empid == empid)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate));
}


@override
int get hashCode => Object.hash(runtimeType,empid,fromDate,toDate);

@override
String toString() {
  return 'AttendanceEvent.calendarEventsRequested(empid: $empid, fromDate: $fromDate, toDate: $toDate)';
}


}

/// @nodoc
abstract mixin class $CalendarEventsRequestedCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory $CalendarEventsRequestedCopyWith(CalendarEventsRequested value, $Res Function(CalendarEventsRequested) _then) = _$CalendarEventsRequestedCopyWithImpl;
@override @useResult
$Res call({
 String empid, String fromDate, String toDate
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
@override @pragma('vm:prefer-inline') $Res call({Object? empid = null,Object? fromDate = null,Object? toDate = null,}) {
  return _then(CalendarEventsRequested(
empid: null == empid ? _self.empid : empid // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LogRequested extends AttendanceEvent {
  const LogRequested(this.empid): super._();
  

@override final  String empid;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogRequestedCopyWith<LogRequested> get copyWith => _$LogRequestedCopyWithImpl<LogRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogRequested&&(identical(other.empid, empid) || other.empid == empid));
}


@override
int get hashCode => Object.hash(runtimeType,empid);

@override
String toString() {
  return 'AttendanceEvent.logRequested(empid: $empid)';
}


}

/// @nodoc
abstract mixin class $LogRequestedCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory $LogRequestedCopyWith(LogRequested value, $Res Function(LogRequested) _then) = _$LogRequestedCopyWithImpl;
@override @useResult
$Res call({
 String empid
});




}
/// @nodoc
class _$LogRequestedCopyWithImpl<$Res>
    implements $LogRequestedCopyWith<$Res> {
  _$LogRequestedCopyWithImpl(this._self, this._then);

  final LogRequested _self;
  final $Res Function(LogRequested) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? empid = null,}) {
  return _then(LogRequested(
null == empid ? _self.empid : empid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
