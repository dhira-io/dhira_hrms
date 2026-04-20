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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  punchInRequested,TResult Function()?  punchOutRequested,TResult Function()?  checkStatusRequested,TResult Function()?  logRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _PunchInRequested() when punchInRequested != null:
return punchInRequested();case _PunchOutRequested() when punchOutRequested != null:
return punchOutRequested();case _CheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested();case _LogRequested() when logRequested != null:
return logRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  punchInRequested,required TResult Function()  punchOutRequested,required TResult Function()  checkStatusRequested,required TResult Function()  logRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _PunchInRequested():
return punchInRequested();case _PunchOutRequested():
return punchOutRequested();case _CheckStatusRequested():
return checkStatusRequested();case _LogRequested():
return logRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  punchInRequested,TResult? Function()?  punchOutRequested,TResult? Function()?  checkStatusRequested,TResult? Function()?  logRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _PunchInRequested() when punchInRequested != null:
return punchInRequested();case _PunchOutRequested() when punchOutRequested != null:
return punchOutRequested();case _CheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested();case _LogRequested() when logRequested != null:
return logRequested();case _:
  return null;

}
}

}

/// @nodoc


class _Started extends AttendanceEvent {
  const _Started(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent.started()';
}


}




/// @nodoc


class _PunchInRequested extends AttendanceEvent {
  const _PunchInRequested(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PunchInRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent.punchInRequested()';
}


}




/// @nodoc


class _PunchOutRequested extends AttendanceEvent {
  const _PunchOutRequested(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PunchOutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent.punchOutRequested()';
}


}




/// @nodoc


class _CheckStatusRequested extends AttendanceEvent {
  const _CheckStatusRequested(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckStatusRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent.checkStatusRequested()';
}


}




/// @nodoc


class _LogRequested extends AttendanceEvent {
  const _LogRequested(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent.logRequested()';
}


}




// dart format on
