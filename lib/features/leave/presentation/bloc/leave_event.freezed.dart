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





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LeaveEvent()';
}


}

/// @nodoc
class $LeaveEventCopyWith<$Res>  {
$LeaveEventCopyWith(LeaveEvent _, $Res Function(LeaveEvent) __);
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _RefreshRequested value)?  refreshRequested,TResult Function( _LoadMoreRequested value)?  loadMoreRequested,TResult Function( _SearchChanged value)?  searchChanged,TResult Function( _ApplyRequested value)?  applyRequested,TResult Function( _UpdateRequested value)?  updateRequested,TResult Function( _StatusUpdateRequested value)?  statusUpdateRequested,TResult Function( _DeleteRequested value)?  deleteRequested,TResult Function( _CancelRequested value)?  cancelRequested,TResult Function( _BalanceRequested value)?  balanceRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _RefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case _LoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that);case _SearchChanged() when searchChanged != null:
return searchChanged(_that);case _ApplyRequested() when applyRequested != null:
return applyRequested(_that);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that);case _StatusUpdateRequested() when statusUpdateRequested != null:
return statusUpdateRequested(_that);case _DeleteRequested() when deleteRequested != null:
return deleteRequested(_that);case _CancelRequested() when cancelRequested != null:
return cancelRequested(_that);case _BalanceRequested() when balanceRequested != null:
return balanceRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _RefreshRequested value)  refreshRequested,required TResult Function( _LoadMoreRequested value)  loadMoreRequested,required TResult Function( _SearchChanged value)  searchChanged,required TResult Function( _ApplyRequested value)  applyRequested,required TResult Function( _UpdateRequested value)  updateRequested,required TResult Function( _StatusUpdateRequested value)  statusUpdateRequested,required TResult Function( _DeleteRequested value)  deleteRequested,required TResult Function( _CancelRequested value)  cancelRequested,required TResult Function( _BalanceRequested value)  balanceRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _RefreshRequested():
return refreshRequested(_that);case _LoadMoreRequested():
return loadMoreRequested(_that);case _SearchChanged():
return searchChanged(_that);case _ApplyRequested():
return applyRequested(_that);case _UpdateRequested():
return updateRequested(_that);case _StatusUpdateRequested():
return statusUpdateRequested(_that);case _DeleteRequested():
return deleteRequested(_that);case _CancelRequested():
return cancelRequested(_that);case _BalanceRequested():
return balanceRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _RefreshRequested value)?  refreshRequested,TResult? Function( _LoadMoreRequested value)?  loadMoreRequested,TResult? Function( _SearchChanged value)?  searchChanged,TResult? Function( _ApplyRequested value)?  applyRequested,TResult? Function( _UpdateRequested value)?  updateRequested,TResult? Function( _StatusUpdateRequested value)?  statusUpdateRequested,TResult? Function( _DeleteRequested value)?  deleteRequested,TResult? Function( _CancelRequested value)?  cancelRequested,TResult? Function( _BalanceRequested value)?  balanceRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _RefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case _LoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that);case _SearchChanged() when searchChanged != null:
return searchChanged(_that);case _ApplyRequested() when applyRequested != null:
return applyRequested(_that);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that);case _StatusUpdateRequested() when statusUpdateRequested != null:
return statusUpdateRequested(_that);case _DeleteRequested() when deleteRequested != null:
return deleteRequested(_that);case _CancelRequested() when cancelRequested != null:
return cancelRequested(_that);case _BalanceRequested() when balanceRequested != null:
return balanceRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String employeeId)?  started,TResult Function( String employeeId)?  refreshRequested,TResult Function( String employeeId)?  loadMoreRequested,TResult Function( String query)?  searchChanged,TResult Function( String employeeId,  String leaveType,  String fromDate,  String toDate,  String reason,  int halfDay,  String? halfDayDate)?  applyRequested,TResult Function( String leaveId,  String fromDate,  String toDate,  String reason,  int halfDay,  String? halfDayDate)?  updateRequested,TResult Function( String leaveApplicationName,  String newStatus)?  statusUpdateRequested,TResult Function( String name,  String employeeId)?  deleteRequested,TResult Function( String name,  String employeeId)?  cancelRequested,TResult Function( String employeeId,  String todayDate)?  balanceRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.employeeId);case _RefreshRequested() when refreshRequested != null:
return refreshRequested(_that.employeeId);case _LoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that.employeeId);case _SearchChanged() when searchChanged != null:
return searchChanged(_that.query);case _ApplyRequested() when applyRequested != null:
return applyRequested(_that.employeeId,_that.leaveType,_that.fromDate,_that.toDate,_that.reason,_that.halfDay,_that.halfDayDate);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that.leaveId,_that.fromDate,_that.toDate,_that.reason,_that.halfDay,_that.halfDayDate);case _StatusUpdateRequested() when statusUpdateRequested != null:
return statusUpdateRequested(_that.leaveApplicationName,_that.newStatus);case _DeleteRequested() when deleteRequested != null:
return deleteRequested(_that.name,_that.employeeId);case _CancelRequested() when cancelRequested != null:
return cancelRequested(_that.name,_that.employeeId);case _BalanceRequested() when balanceRequested != null:
return balanceRequested(_that.employeeId,_that.todayDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String employeeId)  started,required TResult Function( String employeeId)  refreshRequested,required TResult Function( String employeeId)  loadMoreRequested,required TResult Function( String query)  searchChanged,required TResult Function( String employeeId,  String leaveType,  String fromDate,  String toDate,  String reason,  int halfDay,  String? halfDayDate)  applyRequested,required TResult Function( String leaveId,  String fromDate,  String toDate,  String reason,  int halfDay,  String? halfDayDate)  updateRequested,required TResult Function( String leaveApplicationName,  String newStatus)  statusUpdateRequested,required TResult Function( String name,  String employeeId)  deleteRequested,required TResult Function( String name,  String employeeId)  cancelRequested,required TResult Function( String employeeId,  String todayDate)  balanceRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.employeeId);case _RefreshRequested():
return refreshRequested(_that.employeeId);case _LoadMoreRequested():
return loadMoreRequested(_that.employeeId);case _SearchChanged():
return searchChanged(_that.query);case _ApplyRequested():
return applyRequested(_that.employeeId,_that.leaveType,_that.fromDate,_that.toDate,_that.reason,_that.halfDay,_that.halfDayDate);case _UpdateRequested():
return updateRequested(_that.leaveId,_that.fromDate,_that.toDate,_that.reason,_that.halfDay,_that.halfDayDate);case _StatusUpdateRequested():
return statusUpdateRequested(_that.leaveApplicationName,_that.newStatus);case _DeleteRequested():
return deleteRequested(_that.name,_that.employeeId);case _CancelRequested():
return cancelRequested(_that.name,_that.employeeId);case _BalanceRequested():
return balanceRequested(_that.employeeId,_that.todayDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String employeeId)?  started,TResult? Function( String employeeId)?  refreshRequested,TResult? Function( String employeeId)?  loadMoreRequested,TResult? Function( String query)?  searchChanged,TResult? Function( String employeeId,  String leaveType,  String fromDate,  String toDate,  String reason,  int halfDay,  String? halfDayDate)?  applyRequested,TResult? Function( String leaveId,  String fromDate,  String toDate,  String reason,  int halfDay,  String? halfDayDate)?  updateRequested,TResult? Function( String leaveApplicationName,  String newStatus)?  statusUpdateRequested,TResult? Function( String name,  String employeeId)?  deleteRequested,TResult? Function( String name,  String employeeId)?  cancelRequested,TResult? Function( String employeeId,  String todayDate)?  balanceRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.employeeId);case _RefreshRequested() when refreshRequested != null:
return refreshRequested(_that.employeeId);case _LoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that.employeeId);case _SearchChanged() when searchChanged != null:
return searchChanged(_that.query);case _ApplyRequested() when applyRequested != null:
return applyRequested(_that.employeeId,_that.leaveType,_that.fromDate,_that.toDate,_that.reason,_that.halfDay,_that.halfDayDate);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that.leaveId,_that.fromDate,_that.toDate,_that.reason,_that.halfDay,_that.halfDayDate);case _StatusUpdateRequested() when statusUpdateRequested != null:
return statusUpdateRequested(_that.leaveApplicationName,_that.newStatus);case _DeleteRequested() when deleteRequested != null:
return deleteRequested(_that.name,_that.employeeId);case _CancelRequested() when cancelRequested != null:
return cancelRequested(_that.name,_that.employeeId);case _BalanceRequested() when balanceRequested != null:
return balanceRequested(_that.employeeId,_that.todayDate);case _:
  return null;

}
}

}

/// @nodoc


class _Started extends LeaveEvent {
  const _Started(this.employeeId): super._();
  

 final  String employeeId;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
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
@useResult
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
@pragma('vm:prefer-inline') $Res call({Object? employeeId = null,}) {
  return _then(_Started(
null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RefreshRequested extends LeaveEvent {
  const _RefreshRequested(this.employeeId): super._();
  

 final  String employeeId;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshRequestedCopyWith<_RefreshRequested> get copyWith => __$RefreshRequestedCopyWithImpl<_RefreshRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshRequested&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId);

@override
String toString() {
  return 'LeaveEvent.refreshRequested(employeeId: $employeeId)';
}


}

/// @nodoc
abstract mixin class _$RefreshRequestedCopyWith<$Res> implements $LeaveEventCopyWith<$Res> {
  factory _$RefreshRequestedCopyWith(_RefreshRequested value, $Res Function(_RefreshRequested) _then) = __$RefreshRequestedCopyWithImpl;
@useResult
$Res call({
 String employeeId
});




}
/// @nodoc
class __$RefreshRequestedCopyWithImpl<$Res>
    implements _$RefreshRequestedCopyWith<$Res> {
  __$RefreshRequestedCopyWithImpl(this._self, this._then);

  final _RefreshRequested _self;
  final $Res Function(_RefreshRequested) _then;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? employeeId = null,}) {
  return _then(_RefreshRequested(
null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadMoreRequested extends LeaveEvent {
  const _LoadMoreRequested(this.employeeId): super._();
  

 final  String employeeId;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
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
@useResult
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
@pragma('vm:prefer-inline') $Res call({Object? employeeId = null,}) {
  return _then(_LoadMoreRequested(
null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SearchChanged extends LeaveEvent {
  const _SearchChanged(this.query): super._();
  

 final  String query;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchChangedCopyWith<_SearchChanged> get copyWith => __$SearchChangedCopyWithImpl<_SearchChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'LeaveEvent.searchChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchChangedCopyWith<$Res> implements $LeaveEventCopyWith<$Res> {
  factory _$SearchChangedCopyWith(_SearchChanged value, $Res Function(_SearchChanged) _then) = __$SearchChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchChangedCopyWithImpl<$Res>
    implements _$SearchChangedCopyWith<$Res> {
  __$SearchChangedCopyWithImpl(this._self, this._then);

  final _SearchChanged _self;
  final $Res Function(_SearchChanged) _then;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ApplyRequested extends LeaveEvent {
  const _ApplyRequested({required this.employeeId, required this.leaveType, required this.fromDate, required this.toDate, required this.reason, required this.halfDay, this.halfDayDate}): super._();
  

 final  String employeeId;
 final  String leaveType;
 final  String fromDate;
 final  String toDate;
 final  String reason;
 final  int halfDay;
 final  String? halfDayDate;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
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
@useResult
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
@pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? reason = null,Object? halfDay = null,Object? halfDayDate = freezed,}) {
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


class _UpdateRequested extends LeaveEvent {
  const _UpdateRequested({required this.leaveId, required this.fromDate, required this.toDate, required this.reason, required this.halfDay, this.halfDayDate}): super._();
  

 final  String leaveId;
 final  String fromDate;
 final  String toDate;
 final  String reason;
 final  int halfDay;
 final  String? halfDayDate;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateRequestedCopyWith<_UpdateRequested> get copyWith => __$UpdateRequestedCopyWithImpl<_UpdateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateRequested&&(identical(other.leaveId, leaveId) || other.leaveId == leaveId)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.halfDay, halfDay) || other.halfDay == halfDay)&&(identical(other.halfDayDate, halfDayDate) || other.halfDayDate == halfDayDate));
}


@override
int get hashCode => Object.hash(runtimeType,leaveId,fromDate,toDate,reason,halfDay,halfDayDate);

@override
String toString() {
  return 'LeaveEvent.updateRequested(leaveId: $leaveId, fromDate: $fromDate, toDate: $toDate, reason: $reason, halfDay: $halfDay, halfDayDate: $halfDayDate)';
}


}

/// @nodoc
abstract mixin class _$UpdateRequestedCopyWith<$Res> implements $LeaveEventCopyWith<$Res> {
  factory _$UpdateRequestedCopyWith(_UpdateRequested value, $Res Function(_UpdateRequested) _then) = __$UpdateRequestedCopyWithImpl;
@useResult
$Res call({
 String leaveId, String fromDate, String toDate, String reason, int halfDay, String? halfDayDate
});




}
/// @nodoc
class __$UpdateRequestedCopyWithImpl<$Res>
    implements _$UpdateRequestedCopyWith<$Res> {
  __$UpdateRequestedCopyWithImpl(this._self, this._then);

  final _UpdateRequested _self;
  final $Res Function(_UpdateRequested) _then;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? leaveId = null,Object? fromDate = null,Object? toDate = null,Object? reason = null,Object? halfDay = null,Object? halfDayDate = freezed,}) {
  return _then(_UpdateRequested(
leaveId: null == leaveId ? _self.leaveId : leaveId // ignore: cast_nullable_to_non_nullable
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


class _StatusUpdateRequested extends LeaveEvent {
  const _StatusUpdateRequested({required this.leaveApplicationName, required this.newStatus}): super._();
  

 final  String leaveApplicationName;
 final  String newStatus;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatusUpdateRequestedCopyWith<_StatusUpdateRequested> get copyWith => __$StatusUpdateRequestedCopyWithImpl<_StatusUpdateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatusUpdateRequested&&(identical(other.leaveApplicationName, leaveApplicationName) || other.leaveApplicationName == leaveApplicationName)&&(identical(other.newStatus, newStatus) || other.newStatus == newStatus));
}


@override
int get hashCode => Object.hash(runtimeType,leaveApplicationName,newStatus);

@override
String toString() {
  return 'LeaveEvent.statusUpdateRequested(leaveApplicationName: $leaveApplicationName, newStatus: $newStatus)';
}


}

/// @nodoc
abstract mixin class _$StatusUpdateRequestedCopyWith<$Res> implements $LeaveEventCopyWith<$Res> {
  factory _$StatusUpdateRequestedCopyWith(_StatusUpdateRequested value, $Res Function(_StatusUpdateRequested) _then) = __$StatusUpdateRequestedCopyWithImpl;
@useResult
$Res call({
 String leaveApplicationName, String newStatus
});




}
/// @nodoc
class __$StatusUpdateRequestedCopyWithImpl<$Res>
    implements _$StatusUpdateRequestedCopyWith<$Res> {
  __$StatusUpdateRequestedCopyWithImpl(this._self, this._then);

  final _StatusUpdateRequested _self;
  final $Res Function(_StatusUpdateRequested) _then;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? leaveApplicationName = null,Object? newStatus = null,}) {
  return _then(_StatusUpdateRequested(
leaveApplicationName: null == leaveApplicationName ? _self.leaveApplicationName : leaveApplicationName // ignore: cast_nullable_to_non_nullable
as String,newStatus: null == newStatus ? _self.newStatus : newStatus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DeleteRequested extends LeaveEvent {
  const _DeleteRequested(this.name, this.employeeId): super._();
  

 final  String name;
 final  String employeeId;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
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
@useResult
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
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employeeId = null,}) {
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
 final  String employeeId;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
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
@useResult
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
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employeeId = null,}) {
  return _then(_CancelRequested(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _BalanceRequested extends LeaveEvent {
  const _BalanceRequested(this.employeeId, this.todayDate): super._();
  

 final  String employeeId;
 final  String todayDate;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BalanceRequestedCopyWith<_BalanceRequested> get copyWith => __$BalanceRequestedCopyWithImpl<_BalanceRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BalanceRequested&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.todayDate, todayDate) || other.todayDate == todayDate));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId,todayDate);

@override
String toString() {
  return 'LeaveEvent.balanceRequested(employeeId: $employeeId, todayDate: $todayDate)';
}


}

/// @nodoc
abstract mixin class _$BalanceRequestedCopyWith<$Res> implements $LeaveEventCopyWith<$Res> {
  factory _$BalanceRequestedCopyWith(_BalanceRequested value, $Res Function(_BalanceRequested) _then) = __$BalanceRequestedCopyWithImpl;
@useResult
$Res call({
 String employeeId, String todayDate
});




}
/// @nodoc
class __$BalanceRequestedCopyWithImpl<$Res>
    implements _$BalanceRequestedCopyWith<$Res> {
  __$BalanceRequestedCopyWithImpl(this._self, this._then);

  final _BalanceRequested _self;
  final $Res Function(_BalanceRequested) _then;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? todayDate = null,}) {
  return _then(_BalanceRequested(
null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,null == todayDate ? _self.todayDate : todayDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
