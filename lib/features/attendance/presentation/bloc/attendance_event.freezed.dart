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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _PunchInRequested value)?  punchInRequested,TResult Function( _PunchOutRequested value)?  punchOutRequested,TResult Function( _CheckStatusRequested value)?  checkStatusRequested,TResult Function( _LogRequested value)?  logRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _PunchInRequested() when punchInRequested != null:
return punchInRequested(_that);case _PunchOutRequested() when punchOutRequested != null:
return punchOutRequested(_that);case _CheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested(_that);case _LogRequested() when logRequested != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _PunchInRequested value)  punchInRequested,required TResult Function( _PunchOutRequested value)  punchOutRequested,required TResult Function( _CheckStatusRequested value)  checkStatusRequested,required TResult Function( _LogRequested value)  logRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _PunchInRequested():
return punchInRequested(_that);case _PunchOutRequested():
return punchOutRequested(_that);case _CheckStatusRequested():
return checkStatusRequested(_that);case _LogRequested():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _PunchInRequested value)?  punchInRequested,TResult? Function( _PunchOutRequested value)?  punchOutRequested,TResult? Function( _CheckStatusRequested value)?  checkStatusRequested,TResult? Function( _LogRequested value)?  logRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _PunchInRequested() when punchInRequested != null:
return punchInRequested(_that);case _PunchOutRequested() when punchOutRequested != null:
return punchOutRequested(_that);case _CheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested(_that);case _LogRequested() when logRequested != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String empid)?  started,TResult Function( String empid)?  punchInRequested,TResult Function( String empid)?  punchOutRequested,TResult Function( String empid)?  checkStatusRequested,TResult Function( String empid)?  logRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.empid);case _PunchInRequested() when punchInRequested != null:
return punchInRequested(_that.empid);case _PunchOutRequested() when punchOutRequested != null:
return punchOutRequested(_that.empid);case _CheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested(_that.empid);case _LogRequested() when logRequested != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String empid)  started,required TResult Function( String empid)  punchInRequested,required TResult Function( String empid)  punchOutRequested,required TResult Function( String empid)  checkStatusRequested,required TResult Function( String empid)  logRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.empid);case _PunchInRequested():
return punchInRequested(_that.empid);case _PunchOutRequested():
return punchOutRequested(_that.empid);case _CheckStatusRequested():
return checkStatusRequested(_that.empid);case _LogRequested():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String empid)?  started,TResult? Function( String empid)?  punchInRequested,TResult? Function( String empid)?  punchOutRequested,TResult? Function( String empid)?  checkStatusRequested,TResult? Function( String empid)?  logRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.empid);case _PunchInRequested() when punchInRequested != null:
return punchInRequested(_that.empid);case _PunchOutRequested() when punchOutRequested != null:
return punchOutRequested(_that.empid);case _CheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested(_that.empid);case _LogRequested() when logRequested != null:
return logRequested(_that.empid);case _:
  return null;

}
}

}

/// @nodoc


class _Started extends AttendanceEvent {
  const _Started(this.empid): super._();
  

@override final  String empid;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartedCopyWith<_Started> get copyWith => __$StartedCopyWithImpl<_Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started&&(identical(other.empid, empid) || other.empid == empid));
}


@override
int get hashCode => Object.hash(runtimeType,empid);

@override
String toString() {
  return 'AttendanceEvent.started(empid: $empid)';
}


}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) = __$StartedCopyWithImpl;
@override @useResult
$Res call({
 String empid
});




}
/// @nodoc
class __$StartedCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? empid = null,}) {
  return _then(_Started(
null == empid ? _self.empid : empid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PunchInRequested extends AttendanceEvent {
  const _PunchInRequested(this.empid): super._();
  

@override final  String empid;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PunchInRequestedCopyWith<_PunchInRequested> get copyWith => __$PunchInRequestedCopyWithImpl<_PunchInRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PunchInRequested&&(identical(other.empid, empid) || other.empid == empid));
}


@override
int get hashCode => Object.hash(runtimeType,empid);

@override
String toString() {
  return 'AttendanceEvent.punchInRequested(empid: $empid)';
}


}

/// @nodoc
abstract mixin class _$PunchInRequestedCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory _$PunchInRequestedCopyWith(_PunchInRequested value, $Res Function(_PunchInRequested) _then) = __$PunchInRequestedCopyWithImpl;
@override @useResult
$Res call({
 String empid
});




}
/// @nodoc
class __$PunchInRequestedCopyWithImpl<$Res>
    implements _$PunchInRequestedCopyWith<$Res> {
  __$PunchInRequestedCopyWithImpl(this._self, this._then);

  final _PunchInRequested _self;
  final $Res Function(_PunchInRequested) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? empid = null,}) {
  return _then(_PunchInRequested(
null == empid ? _self.empid : empid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PunchOutRequested extends AttendanceEvent {
  const _PunchOutRequested(this.empid): super._();
  

@override final  String empid;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PunchOutRequestedCopyWith<_PunchOutRequested> get copyWith => __$PunchOutRequestedCopyWithImpl<_PunchOutRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PunchOutRequested&&(identical(other.empid, empid) || other.empid == empid));
}


@override
int get hashCode => Object.hash(runtimeType,empid);

@override
String toString() {
  return 'AttendanceEvent.punchOutRequested(empid: $empid)';
}


}

/// @nodoc
abstract mixin class _$PunchOutRequestedCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory _$PunchOutRequestedCopyWith(_PunchOutRequested value, $Res Function(_PunchOutRequested) _then) = __$PunchOutRequestedCopyWithImpl;
@override @useResult
$Res call({
 String empid
});




}
/// @nodoc
class __$PunchOutRequestedCopyWithImpl<$Res>
    implements _$PunchOutRequestedCopyWith<$Res> {
  __$PunchOutRequestedCopyWithImpl(this._self, this._then);

  final _PunchOutRequested _self;
  final $Res Function(_PunchOutRequested) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? empid = null,}) {
  return _then(_PunchOutRequested(
null == empid ? _self.empid : empid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CheckStatusRequested extends AttendanceEvent {
  const _CheckStatusRequested(this.empid): super._();
  

@override final  String empid;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckStatusRequestedCopyWith<_CheckStatusRequested> get copyWith => __$CheckStatusRequestedCopyWithImpl<_CheckStatusRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckStatusRequested&&(identical(other.empid, empid) || other.empid == empid));
}


@override
int get hashCode => Object.hash(runtimeType,empid);

@override
String toString() {
  return 'AttendanceEvent.checkStatusRequested(empid: $empid)';
}


}

/// @nodoc
abstract mixin class _$CheckStatusRequestedCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory _$CheckStatusRequestedCopyWith(_CheckStatusRequested value, $Res Function(_CheckStatusRequested) _then) = __$CheckStatusRequestedCopyWithImpl;
@override @useResult
$Res call({
 String empid
});




}
/// @nodoc
class __$CheckStatusRequestedCopyWithImpl<$Res>
    implements _$CheckStatusRequestedCopyWith<$Res> {
  __$CheckStatusRequestedCopyWithImpl(this._self, this._then);

  final _CheckStatusRequested _self;
  final $Res Function(_CheckStatusRequested) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? empid = null,}) {
  return _then(_CheckStatusRequested(
null == empid ? _self.empid : empid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LogRequested extends AttendanceEvent {
  const _LogRequested(this.empid): super._();
  

@override final  String empid;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LogRequestedCopyWith<_LogRequested> get copyWith => __$LogRequestedCopyWithImpl<_LogRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogRequested&&(identical(other.empid, empid) || other.empid == empid));
}


@override
int get hashCode => Object.hash(runtimeType,empid);

@override
String toString() {
  return 'AttendanceEvent.logRequested(empid: $empid)';
}


}

/// @nodoc
abstract mixin class _$LogRequestedCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory _$LogRequestedCopyWith(_LogRequested value, $Res Function(_LogRequested) _then) = __$LogRequestedCopyWithImpl;
@override @useResult
$Res call({
 String empid
});




}
/// @nodoc
class __$LogRequestedCopyWithImpl<$Res>
    implements _$LogRequestedCopyWith<$Res> {
  __$LogRequestedCopyWithImpl(this._self, this._then);

  final _LogRequested _self;
  final $Res Function(_LogRequested) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? empid = null,}) {
  return _then(_LogRequested(
null == empid ? _self.empid : empid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
