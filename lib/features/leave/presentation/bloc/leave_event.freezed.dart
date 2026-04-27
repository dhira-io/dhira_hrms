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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ApplyRequested value)?  applyRequested,TResult Function( _UpdateRequested value)?  updateRequested,TResult Function( _TypesRequested value)?  typesRequested,TResult Function( _BalanceRequested value)?  balanceRequested,TResult Function( _StatisticsRequested value)?  statisticsRequested,TResult Function( _OverlapLeavesRequested value)?  overlapLeavesRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplyRequested() when applyRequested != null:
return applyRequested(_that);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that);case _TypesRequested() when typesRequested != null:
return typesRequested(_that);case _BalanceRequested() when balanceRequested != null:
return balanceRequested(_that);case _StatisticsRequested() when statisticsRequested != null:
return statisticsRequested(_that);case _OverlapLeavesRequested() when overlapLeavesRequested != null:
return overlapLeavesRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ApplyRequested value)  applyRequested,required TResult Function( _UpdateRequested value)  updateRequested,required TResult Function( _TypesRequested value)  typesRequested,required TResult Function( _BalanceRequested value)  balanceRequested,required TResult Function( _StatisticsRequested value)  statisticsRequested,required TResult Function( _OverlapLeavesRequested value)  overlapLeavesRequested,}){
final _that = this;
switch (_that) {
case _ApplyRequested():
return applyRequested(_that);case _UpdateRequested():
return updateRequested(_that);case _TypesRequested():
return typesRequested(_that);case _BalanceRequested():
return balanceRequested(_that);case _StatisticsRequested():
return statisticsRequested(_that);case _OverlapLeavesRequested():
return overlapLeavesRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ApplyRequested value)?  applyRequested,TResult? Function( _UpdateRequested value)?  updateRequested,TResult? Function( _TypesRequested value)?  typesRequested,TResult? Function( _BalanceRequested value)?  balanceRequested,TResult? Function( _StatisticsRequested value)?  statisticsRequested,TResult? Function( _OverlapLeavesRequested value)?  overlapLeavesRequested,}){
final _that = this;
switch (_that) {
case _ApplyRequested() when applyRequested != null:
return applyRequested(_that);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that);case _TypesRequested() when typesRequested != null:
return typesRequested(_that);case _BalanceRequested() when balanceRequested != null:
return balanceRequested(_that);case _StatisticsRequested() when statisticsRequested != null:
return statisticsRequested(_that);case _OverlapLeavesRequested() when overlapLeavesRequested != null:
return overlapLeavesRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String employeeId,  String employeeName,  String leaveType,  String fromDate,  String toDate,  String reason,  int halfDay,  String? halfDayDate,  String? halfDaySegment,  double? totalleavedays)?  applyRequested,TResult Function( String leaveId,  String fromDate,  String toDate,  String reason,  int halfDay,  String? halfDayDate,  String? halfDaySegment,  double? totalleavedays)?  updateRequested,TResult Function()?  typesRequested,TResult Function( String employeeId,  String todayDate,  String gender)?  balanceRequested,TResult Function( String employeeId,  String fromDate,  String toDate)?  statisticsRequested,TResult Function( String employeeId,  String fromDate,  String toDate)?  overlapLeavesRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplyRequested() when applyRequested != null:
return applyRequested(_that.employeeId,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.reason,_that.halfDay,_that.halfDayDate,_that.halfDaySegment,_that.totalleavedays);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that.leaveId,_that.fromDate,_that.toDate,_that.reason,_that.halfDay,_that.halfDayDate,_that.halfDaySegment,_that.totalleavedays);case _TypesRequested() when typesRequested != null:
return typesRequested();case _BalanceRequested() when balanceRequested != null:
return balanceRequested(_that.employeeId,_that.todayDate,_that.gender);case _StatisticsRequested() when statisticsRequested != null:
return statisticsRequested(_that.employeeId,_that.fromDate,_that.toDate);case _OverlapLeavesRequested() when overlapLeavesRequested != null:
return overlapLeavesRequested(_that.employeeId,_that.fromDate,_that.toDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String employeeId,  String employeeName,  String leaveType,  String fromDate,  String toDate,  String reason,  int halfDay,  String? halfDayDate,  String? halfDaySegment,  double? totalleavedays)  applyRequested,required TResult Function( String leaveId,  String fromDate,  String toDate,  String reason,  int halfDay,  String? halfDayDate,  String? halfDaySegment,  double? totalleavedays)  updateRequested,required TResult Function()  typesRequested,required TResult Function( String employeeId,  String todayDate,  String gender)  balanceRequested,required TResult Function( String employeeId,  String fromDate,  String toDate)  statisticsRequested,required TResult Function( String employeeId,  String fromDate,  String toDate)  overlapLeavesRequested,}) {final _that = this;
switch (_that) {
case _ApplyRequested():
return applyRequested(_that.employeeId,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.reason,_that.halfDay,_that.halfDayDate,_that.halfDaySegment,_that.totalleavedays);case _UpdateRequested():
return updateRequested(_that.leaveId,_that.fromDate,_that.toDate,_that.reason,_that.halfDay,_that.halfDayDate,_that.halfDaySegment,_that.totalleavedays);case _TypesRequested():
return typesRequested();case _BalanceRequested():
return balanceRequested(_that.employeeId,_that.todayDate,_that.gender);case _StatisticsRequested():
return statisticsRequested(_that.employeeId,_that.fromDate,_that.toDate);case _OverlapLeavesRequested():
return overlapLeavesRequested(_that.employeeId,_that.fromDate,_that.toDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String employeeId,  String employeeName,  String leaveType,  String fromDate,  String toDate,  String reason,  int halfDay,  String? halfDayDate,  String? halfDaySegment,  double? totalleavedays)?  applyRequested,TResult? Function( String leaveId,  String fromDate,  String toDate,  String reason,  int halfDay,  String? halfDayDate,  String? halfDaySegment,  double? totalleavedays)?  updateRequested,TResult? Function()?  typesRequested,TResult? Function( String employeeId,  String todayDate,  String gender)?  balanceRequested,TResult? Function( String employeeId,  String fromDate,  String toDate)?  statisticsRequested,TResult? Function( String employeeId,  String fromDate,  String toDate)?  overlapLeavesRequested,}) {final _that = this;
switch (_that) {
case _ApplyRequested() when applyRequested != null:
return applyRequested(_that.employeeId,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.reason,_that.halfDay,_that.halfDayDate,_that.halfDaySegment,_that.totalleavedays);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that.leaveId,_that.fromDate,_that.toDate,_that.reason,_that.halfDay,_that.halfDayDate,_that.halfDaySegment,_that.totalleavedays);case _TypesRequested() when typesRequested != null:
return typesRequested();case _BalanceRequested() when balanceRequested != null:
return balanceRequested(_that.employeeId,_that.todayDate,_that.gender);case _StatisticsRequested() when statisticsRequested != null:
return statisticsRequested(_that.employeeId,_that.fromDate,_that.toDate);case _OverlapLeavesRequested() when overlapLeavesRequested != null:
return overlapLeavesRequested(_that.employeeId,_that.fromDate,_that.toDate);case _:
  return null;

}
}

}

/// @nodoc


class _ApplyRequested extends LeaveEvent {
  const _ApplyRequested({required this.employeeId, required this.employeeName, required this.leaveType, required this.fromDate, required this.toDate, required this.reason, required this.halfDay, this.halfDayDate, this.halfDaySegment, this.totalleavedays}): super._();
  

 final  String employeeId;
 final  String employeeName;
 final  String leaveType;
 final  String fromDate;
 final  String toDate;
 final  String reason;
 final  int halfDay;
 final  String? halfDayDate;
 final  String? halfDaySegment;
 final  double? totalleavedays;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplyRequestedCopyWith<_ApplyRequested> get copyWith => __$ApplyRequestedCopyWithImpl<_ApplyRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplyRequested&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.halfDay, halfDay) || other.halfDay == halfDay)&&(identical(other.halfDayDate, halfDayDate) || other.halfDayDate == halfDayDate)&&(identical(other.halfDaySegment, halfDaySegment) || other.halfDaySegment == halfDaySegment)&&(identical(other.totalleavedays, totalleavedays) || other.totalleavedays == totalleavedays));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId,employeeName,leaveType,fromDate,toDate,reason,halfDay,halfDayDate,halfDaySegment,totalleavedays);

@override
String toString() {
  return 'LeaveEvent.applyRequested(employeeId: $employeeId, employeeName: $employeeName, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, reason: $reason, halfDay: $halfDay, halfDayDate: $halfDayDate, halfDaySegment: $halfDaySegment, totalleavedays: $totalleavedays)';
}


}

/// @nodoc
abstract mixin class _$ApplyRequestedCopyWith<$Res> implements $LeaveEventCopyWith<$Res> {
  factory _$ApplyRequestedCopyWith(_ApplyRequested value, $Res Function(_ApplyRequested) _then) = __$ApplyRequestedCopyWithImpl;
@useResult
$Res call({
 String employeeId, String employeeName, String leaveType, String fromDate, String toDate, String reason, int halfDay, String? halfDayDate, String? halfDaySegment, double? totalleavedays
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
@pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? employeeName = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? reason = null,Object? halfDay = null,Object? halfDayDate = freezed,Object? halfDaySegment = freezed,Object? totalleavedays = freezed,}) {
  return _then(_ApplyRequested(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,halfDay: null == halfDay ? _self.halfDay : halfDay // ignore: cast_nullable_to_non_nullable
as int,halfDayDate: freezed == halfDayDate ? _self.halfDayDate : halfDayDate // ignore: cast_nullable_to_non_nullable
as String?,halfDaySegment: freezed == halfDaySegment ? _self.halfDaySegment : halfDaySegment // ignore: cast_nullable_to_non_nullable
as String?,totalleavedays: freezed == totalleavedays ? _self.totalleavedays : totalleavedays // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc


class _UpdateRequested extends LeaveEvent {
  const _UpdateRequested({required this.leaveId, required this.fromDate, required this.toDate, required this.reason, required this.halfDay, this.halfDayDate, this.halfDaySegment, this.totalleavedays}): super._();
  

 final  String leaveId;
 final  String fromDate;
 final  String toDate;
 final  String reason;
 final  int halfDay;
 final  String? halfDayDate;
 final  String? halfDaySegment;
 final  double? totalleavedays;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateRequestedCopyWith<_UpdateRequested> get copyWith => __$UpdateRequestedCopyWithImpl<_UpdateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateRequested&&(identical(other.leaveId, leaveId) || other.leaveId == leaveId)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.halfDay, halfDay) || other.halfDay == halfDay)&&(identical(other.halfDayDate, halfDayDate) || other.halfDayDate == halfDayDate)&&(identical(other.halfDaySegment, halfDaySegment) || other.halfDaySegment == halfDaySegment)&&(identical(other.totalleavedays, totalleavedays) || other.totalleavedays == totalleavedays));
}


@override
int get hashCode => Object.hash(runtimeType,leaveId,fromDate,toDate,reason,halfDay,halfDayDate,halfDaySegment,totalleavedays);

@override
String toString() {
  return 'LeaveEvent.updateRequested(leaveId: $leaveId, fromDate: $fromDate, toDate: $toDate, reason: $reason, halfDay: $halfDay, halfDayDate: $halfDayDate, halfDaySegment: $halfDaySegment, totalleavedays: $totalleavedays)';
}


}

/// @nodoc
abstract mixin class _$UpdateRequestedCopyWith<$Res> implements $LeaveEventCopyWith<$Res> {
  factory _$UpdateRequestedCopyWith(_UpdateRequested value, $Res Function(_UpdateRequested) _then) = __$UpdateRequestedCopyWithImpl;
@useResult
$Res call({
 String leaveId, String fromDate, String toDate, String reason, int halfDay, String? halfDayDate, String? halfDaySegment, double? totalleavedays
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
@pragma('vm:prefer-inline') $Res call({Object? leaveId = null,Object? fromDate = null,Object? toDate = null,Object? reason = null,Object? halfDay = null,Object? halfDayDate = freezed,Object? halfDaySegment = freezed,Object? totalleavedays = freezed,}) {
  return _then(_UpdateRequested(
leaveId: null == leaveId ? _self.leaveId : leaveId // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,halfDay: null == halfDay ? _self.halfDay : halfDay // ignore: cast_nullable_to_non_nullable
as int,halfDayDate: freezed == halfDayDate ? _self.halfDayDate : halfDayDate // ignore: cast_nullable_to_non_nullable
as String?,halfDaySegment: freezed == halfDaySegment ? _self.halfDaySegment : halfDaySegment // ignore: cast_nullable_to_non_nullable
as String?,totalleavedays: freezed == totalleavedays ? _self.totalleavedays : totalleavedays // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc


class _TypesRequested extends LeaveEvent {
  const _TypesRequested(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TypesRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LeaveEvent.typesRequested()';
}


}




/// @nodoc


class _BalanceRequested extends LeaveEvent {
  const _BalanceRequested({required this.employeeId, required this.todayDate, required this.gender}): super._();
  

 final  String employeeId;
 final  String todayDate;
 final  String gender;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BalanceRequestedCopyWith<_BalanceRequested> get copyWith => __$BalanceRequestedCopyWithImpl<_BalanceRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BalanceRequested&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.todayDate, todayDate) || other.todayDate == todayDate)&&(identical(other.gender, gender) || other.gender == gender));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId,todayDate,gender);

@override
String toString() {
  return 'LeaveEvent.balanceRequested(employeeId: $employeeId, todayDate: $todayDate, gender: $gender)';
}


}

/// @nodoc
abstract mixin class _$BalanceRequestedCopyWith<$Res> implements $LeaveEventCopyWith<$Res> {
  factory _$BalanceRequestedCopyWith(_BalanceRequested value, $Res Function(_BalanceRequested) _then) = __$BalanceRequestedCopyWithImpl;
@useResult
$Res call({
 String employeeId, String todayDate, String gender
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
@pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? todayDate = null,Object? gender = null,}) {
  return _then(_BalanceRequested(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,todayDate: null == todayDate ? _self.todayDate : todayDate // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _StatisticsRequested extends LeaveEvent {
  const _StatisticsRequested({required this.employeeId, required this.fromDate, required this.toDate}): super._();
  

 final  String employeeId;
 final  String fromDate;
 final  String toDate;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatisticsRequestedCopyWith<_StatisticsRequested> get copyWith => __$StatisticsRequestedCopyWithImpl<_StatisticsRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatisticsRequested&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId,fromDate,toDate);

@override
String toString() {
  return 'LeaveEvent.statisticsRequested(employeeId: $employeeId, fromDate: $fromDate, toDate: $toDate)';
}


}

/// @nodoc
abstract mixin class _$StatisticsRequestedCopyWith<$Res> implements $LeaveEventCopyWith<$Res> {
  factory _$StatisticsRequestedCopyWith(_StatisticsRequested value, $Res Function(_StatisticsRequested) _then) = __$StatisticsRequestedCopyWithImpl;
@useResult
$Res call({
 String employeeId, String fromDate, String toDate
});




}
/// @nodoc
class __$StatisticsRequestedCopyWithImpl<$Res>
    implements _$StatisticsRequestedCopyWith<$Res> {
  __$StatisticsRequestedCopyWithImpl(this._self, this._then);

  final _StatisticsRequested _self;
  final $Res Function(_StatisticsRequested) _then;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? fromDate = null,Object? toDate = null,}) {
  return _then(_StatisticsRequested(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _OverlapLeavesRequested extends LeaveEvent {
  const _OverlapLeavesRequested({required this.employeeId, required this.fromDate, required this.toDate}): super._();
  

 final  String employeeId;
 final  String fromDate;
 final  String toDate;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OverlapLeavesRequestedCopyWith<_OverlapLeavesRequested> get copyWith => __$OverlapLeavesRequestedCopyWithImpl<_OverlapLeavesRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OverlapLeavesRequested&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId,fromDate,toDate);

@override
String toString() {
  return 'LeaveEvent.overlapLeavesRequested(employeeId: $employeeId, fromDate: $fromDate, toDate: $toDate)';
}


}

/// @nodoc
abstract mixin class _$OverlapLeavesRequestedCopyWith<$Res> implements $LeaveEventCopyWith<$Res> {
  factory _$OverlapLeavesRequestedCopyWith(_OverlapLeavesRequested value, $Res Function(_OverlapLeavesRequested) _then) = __$OverlapLeavesRequestedCopyWithImpl;
@useResult
$Res call({
 String employeeId, String fromDate, String toDate
});




}
/// @nodoc
class __$OverlapLeavesRequestedCopyWithImpl<$Res>
    implements _$OverlapLeavesRequestedCopyWith<$Res> {
  __$OverlapLeavesRequestedCopyWithImpl(this._self, this._then);

  final _OverlapLeavesRequested _self;
  final $Res Function(_OverlapLeavesRequested) _then;

/// Create a copy of LeaveEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? fromDate = null,Object? toDate = null,}) {
  return _then(_OverlapLeavesRequested(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
