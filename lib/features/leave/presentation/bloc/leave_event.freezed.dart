// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LeaveEvent {

 String get employeeId;
/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveEventCopyWith<LeaveEvent> get copyWith => _$LeaveEventCopyWithImpl<LeaveEvent>(this as LeaveEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveEvent&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId);

@override
String toString() {
  return 'LeaveEvent(employeeId: $employeeId)';
}


}

/// @nodoc
abstract mixin class $LeaveEventCopyWith<$Res>  {
  factory $LeaveEventCopyWith(LeaveEvent value, $Res Function(LeaveEvent) _then) = _$LeaveEventCopyWithImpl;
@useResult
$Res call({
 String employeeId
});




}
/// @nodoc
class _$LeaveEventCopyWithImpl<$Res>
    implements $LeaveEventCopyWith<$Res> {
  _$LeaveEventCopyWithImpl(this._self, this._then);

  final LeaveEvent _self;
  final $Res Function(LeaveEvent) _then;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employeeId = null,}) {
  return _then(_self.copyWith(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveEvent].
extension LeaveEventPatterns on LeaveEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _LoadMoreRequested value)?  loadMoreRequested,TResult Function( _ApplyRequested value)?  applyRequested,TResult Function( _DeleteRequested value)?  deleteRequested,TResult Function( _CancelRequested value)?  cancelRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that);case _ApplyRequested() when applyRequested != null:
return applyRequested(_that);case _DeleteRequested() when deleteRequested != null:
return deleteRequested(_that);case _CancelRequested() when cancelRequested != null:
return cancelRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _LoadMoreRequested value)  loadMoreRequested,required TResult Function( _ApplyRequested value)  applyRequested,required TResult Function( _DeleteRequested value)  deleteRequested,required TResult Function( _CancelRequested value)  cancelRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _LoadMoreRequested():
return loadMoreRequested(_that);case _ApplyRequested():
return applyRequested(_that);case _DeleteRequested():
return deleteRequested(_that);case _CancelRequested():
return cancelRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _LoadMoreRequested value)?  loadMoreRequested,TResult? Function( _ApplyRequested value)?  applyRequested,TResult? Function( _DeleteRequested value)?  deleteRequested,TResult? Function( _CancelRequested value)?  cancelRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that);case _ApplyRequested() when applyRequested != null:
return applyRequested(_that);case _DeleteRequested() when deleteRequested != null:
return deleteRequested(_that);case _CancelRequested() when cancelRequested != null:
return cancelRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String employeeId)?  started,TResult Function( String employeeId)?  loadMoreRequested,TResult Function( String employeeId,  String leaveType,  String fromDate,  String toDate,  String reason,  int halfDay,  String? halfDayDate)?  applyRequested,TResult Function( String name,  String employeeId)?  deleteRequested,TResult Function( String name,  String employeeId)?  cancelRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.employeeId);case _LoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that.employeeId);case _ApplyRequested() when applyRequested != null:
return applyRequested(_that.employeeId,_that.leaveType,_that.fromDate,_that.toDate,_that.reason,_that.halfDay,_that.halfDayDate);case _DeleteRequested() when deleteRequested != null:
return deleteRequested(_that.name,_that.employeeId);case _CancelRequested() when cancelRequested != null:
return cancelRequested(_that.name,_that.employeeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String employeeId)  started,required TResult Function( String employeeId)  loadMoreRequested,required TResult Function( String employeeId,  String leaveType,  String fromDate,  String toDate,  String reason,  int halfDay,  String? halfDayDate)  applyRequested,required TResult Function( String name,  String employeeId)  deleteRequested,required TResult Function( String name,  String employeeId)  cancelRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.employeeId);case _LoadMoreRequested():
return loadMoreRequested(_that.employeeId);case _ApplyRequested():
return applyRequested(_that.employeeId,_that.leaveType,_that.fromDate,_that.toDate,_that.reason,_that.halfDay,_that.halfDayDate);case _DeleteRequested():
return deleteRequested(_that.name,_that.employeeId);case _CancelRequested():
return cancelRequested(_that.name,_that.employeeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String employeeId)?  started,TResult? Function( String employeeId)?  loadMoreRequested,TResult? Function( String employeeId,  String leaveType,  String fromDate,  String toDate,  String reason,  int halfDay,  String? halfDayDate)?  applyRequested,TResult? Function( String name,  String employeeId)?  deleteRequested,TResult? Function( String name,  String employeeId)?  cancelRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.employeeId);case _LoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that.employeeId);case _ApplyRequested() when applyRequested != null:
return applyRequested(_that.employeeId,_that.leaveType,_that.fromDate,_that.toDate,_that.reason,_that.halfDay,_that.halfDayDate);case _DeleteRequested() when deleteRequested != null:
return deleteRequested(_that.name,_that.employeeId);case _CancelRequested() when cancelRequested != null:
return cancelRequested(_that.name,_that.employeeId);case _:
  return null;

}
}

}

/// @nodoc


class _Started extends LeaveEvent {
  const _Started(this.employeeId): super._();
  

@override final  String employeeId;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartedCopyWith<_Started> get copyWith => __$StartedCopyWithImpl<_Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId);

@override
String toString() {
  return 'LeaveEvent.started(employeeId: $employeeId)';
}


}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res> implements $LeaveEventCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) = __$StartedCopyWithImpl;
@override @useResult
$Res call({
 String employeeId
});




}
/// @nodoc
class __$StartedCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeId = null,}) {
  return _then(_Started(
null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadMoreRequested extends LeaveEvent {
  const _LoadMoreRequested(this.employeeId): super._();
  

@override final  String employeeId;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadMoreRequestedCopyWith<_LoadMoreRequested> get copyWith => __$LoadMoreRequestedCopyWithImpl<_LoadMoreRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMoreRequested&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId);

@override
String toString() {
  return 'LeaveEvent.loadMoreRequested(employeeId: $employeeId)';
}


}

/// @nodoc
abstract mixin class _$LoadMoreRequestedCopyWith<$Res> implements $LeaveEventCopyWith<$Res> {
  factory _$LoadMoreRequestedCopyWith(_LoadMoreRequested value, $Res Function(_LoadMoreRequested) _then) = __$LoadMoreRequestedCopyWithImpl;
@override @useResult
$Res call({
 String employeeId
});




}
/// @nodoc
class __$LoadMoreRequestedCopyWithImpl<$Res>
    implements _$LoadMoreRequestedCopyWith<$Res> {
  __$LoadMoreRequestedCopyWithImpl(this._self, this._then);

  final _LoadMoreRequested _self;
  final $Res Function(_LoadMoreRequested) _then;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeId = null,}) {
  return _then(_LoadMoreRequested(
null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ApplyRequested extends LeaveEvent {
  const _ApplyRequested({required this.employeeId, required this.leaveType, required this.fromDate, required this.toDate, required this.reason, required this.halfDay, this.halfDayDate}): super._();
  

@override final  String employeeId;
 final  String leaveType;
 final  String fromDate;
 final  String toDate;
 final  String reason;
 final  int halfDay;
 final  String? halfDayDate;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplyRequestedCopyWith<_ApplyRequested> get copyWith => __$ApplyRequestedCopyWithImpl<_ApplyRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplyRequested&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.halfDay, halfDay) || other.halfDay == halfDay)&&(identical(other.halfDayDate, halfDayDate) || other.halfDayDate == halfDayDate));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId,leaveType,fromDate,toDate,reason,halfDay,halfDayDate);

@override
String toString() {
  return 'LeaveEvent.applyRequested(employeeId: $employeeId, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, reason: $reason, halfDay: $halfDay, halfDayDate: $halfDayDate)';
}


}

/// @nodoc
abstract mixin class _$ApplyRequestedCopyWith<$Res> implements $LeaveEventCopyWith<$Res> {
  factory _$ApplyRequestedCopyWith(_ApplyRequested value, $Res Function(_ApplyRequested) _then) = __$ApplyRequestedCopyWithImpl;
@override @useResult
$Res call({
 String employeeId, String leaveType, String fromDate, String toDate, String reason, int halfDay, String? halfDayDate
});




}
/// @nodoc
class __$ApplyRequestedCopyWithImpl<$Res>
    implements _$ApplyRequestedCopyWith<$Res> {
  __$ApplyRequestedCopyWithImpl(this._self, this._then);

  final _ApplyRequested _self;
  final $Res Function(_ApplyRequested) _then;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? reason = null,Object? halfDay = null,Object? halfDayDate = freezed,}) {
  return _then(_ApplyRequested(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,halfDay: null == halfDay ? _self.halfDay : halfDay // ignore: cast_nullable_to_non_nullable
as int,halfDayDate: freezed == halfDayDate ? _self.halfDayDate : halfDayDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _DeleteRequested extends LeaveEvent {
  const _DeleteRequested(this.name, this.employeeId): super._();
  

 final  String name;
@override final  String employeeId;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteRequestedCopyWith<_DeleteRequested> get copyWith => __$DeleteRequestedCopyWithImpl<_DeleteRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteRequested&&(identical(other.name, name) || other.name == name)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId));
}


@override
int get hashCode => Object.hash(runtimeType,name,employeeId);

@override
String toString() {
  return 'LeaveEvent.deleteRequested(name: $name, employeeId: $employeeId)';
}


}

/// @nodoc
abstract mixin class _$DeleteRequestedCopyWith<$Res> implements $LeaveEventCopyWith<$Res> {
  factory _$DeleteRequestedCopyWith(_DeleteRequested value, $Res Function(_DeleteRequested) _then) = __$DeleteRequestedCopyWithImpl;
@override @useResult
$Res call({
 String name, String employeeId
});




}
/// @nodoc
class __$DeleteRequestedCopyWithImpl<$Res>
    implements _$DeleteRequestedCopyWith<$Res> {
  __$DeleteRequestedCopyWithImpl(this._self, this._then);

  final _DeleteRequested _self;
  final $Res Function(_DeleteRequested) _then;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employeeId = null,}) {
  return _then(_DeleteRequested(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CancelRequested extends LeaveEvent {
  const _CancelRequested(this.name, this.employeeId): super._();
  

 final  String name;
@override final  String employeeId;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CancelRequestedCopyWith<_CancelRequested> get copyWith => __$CancelRequestedCopyWithImpl<_CancelRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CancelRequested&&(identical(other.name, name) || other.name == name)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId));
}


@override
int get hashCode => Object.hash(runtimeType,name,employeeId);

@override
String toString() {
  return 'LeaveEvent.cancelRequested(name: $name, employeeId: $employeeId)';
}


}

/// @nodoc
abstract mixin class _$CancelRequestedCopyWith<$Res> implements $LeaveEventCopyWith<$Res> {
  factory _$CancelRequestedCopyWith(_CancelRequested value, $Res Function(_CancelRequested) _then) = __$CancelRequestedCopyWithImpl;
@override @useResult
$Res call({
 String name, String employeeId
});




}
/// @nodoc
class __$CancelRequestedCopyWithImpl<$Res>
    implements _$CancelRequestedCopyWith<$Res> {
  __$CancelRequestedCopyWithImpl(this._self, this._then);

  final _CancelRequested _self;
  final $Res Function(_CancelRequested) _then;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employeeId = null,}) {
  return _then(_CancelRequested(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
