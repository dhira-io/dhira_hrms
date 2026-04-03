// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_log_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttendanceLogEntity {

 String get date; String get dayName; String get inTime; String? get outTime; double? get workingHours; String get status;
/// Create a copy of AttendanceLogEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceLogEntityCopyWith<AttendanceLogEntity> get copyWith => _$AttendanceLogEntityCopyWithImpl<AttendanceLogEntity>(this as AttendanceLogEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceLogEntity&&(identical(other.date, date) || other.date == date)&&(identical(other.dayName, dayName) || other.dayName == dayName)&&(identical(other.inTime, inTime) || other.inTime == inTime)&&(identical(other.outTime, outTime) || other.outTime == outTime)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,date,dayName,inTime,outTime,workingHours,status);

@override
String toString() {
  return 'AttendanceLogEntity(date: $date, dayName: $dayName, inTime: $inTime, outTime: $outTime, workingHours: $workingHours, status: $status)';
}


}

/// @nodoc
abstract mixin class $AttendanceLogEntityCopyWith<$Res>  {
  factory $AttendanceLogEntityCopyWith(AttendanceLogEntity value, $Res Function(AttendanceLogEntity) _then) = _$AttendanceLogEntityCopyWithImpl;
@useResult
$Res call({
 String date, String dayName, String inTime, String? outTime, double? workingHours, String status
});




}
/// @nodoc
class _$AttendanceLogEntityCopyWithImpl<$Res>
    implements $AttendanceLogEntityCopyWith<$Res> {
  _$AttendanceLogEntityCopyWithImpl(this._self, this._then);

  final AttendanceLogEntity _self;
  final $Res Function(AttendanceLogEntity) _then;

/// Create a copy of AttendanceLogEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? dayName = null,Object? inTime = null,Object? outTime = freezed,Object? workingHours = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dayName: null == dayName ? _self.dayName : dayName // ignore: cast_nullable_to_non_nullable
as String,inTime: null == inTime ? _self.inTime : inTime // ignore: cast_nullable_to_non_nullable
as String,outTime: freezed == outTime ? _self.outTime : outTime // ignore: cast_nullable_to_non_nullable
as String?,workingHours: freezed == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceLogEntity].
extension AttendanceLogEntityPatterns on AttendanceLogEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceLogEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceLogEntity() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceLogEntity value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceLogEntity():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceLogEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceLogEntity() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String dayName,  String inTime,  String? outTime,  double? workingHours,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceLogEntity() when $default != null:
return $default(_that.date,_that.dayName,_that.inTime,_that.outTime,_that.workingHours,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String dayName,  String inTime,  String? outTime,  double? workingHours,  String status)  $default,) {final _that = this;
switch (_that) {
case _AttendanceLogEntity():
return $default(_that.date,_that.dayName,_that.inTime,_that.outTime,_that.workingHours,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String dayName,  String inTime,  String? outTime,  double? workingHours,  String status)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceLogEntity() when $default != null:
return $default(_that.date,_that.dayName,_that.inTime,_that.outTime,_that.workingHours,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _AttendanceLogEntity extends AttendanceLogEntity {
  const _AttendanceLogEntity({required this.date, required this.dayName, required this.inTime, this.outTime, this.workingHours, required this.status}): super._();
  

@override final  String date;
@override final  String dayName;
@override final  String inTime;
@override final  String? outTime;
@override final  double? workingHours;
@override final  String status;

/// Create a copy of AttendanceLogEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceLogEntityCopyWith<_AttendanceLogEntity> get copyWith => __$AttendanceLogEntityCopyWithImpl<_AttendanceLogEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceLogEntity&&(identical(other.date, date) || other.date == date)&&(identical(other.dayName, dayName) || other.dayName == dayName)&&(identical(other.inTime, inTime) || other.inTime == inTime)&&(identical(other.outTime, outTime) || other.outTime == outTime)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,date,dayName,inTime,outTime,workingHours,status);

@override
String toString() {
  return 'AttendanceLogEntity(date: $date, dayName: $dayName, inTime: $inTime, outTime: $outTime, workingHours: $workingHours, status: $status)';
}


}

/// @nodoc
abstract mixin class _$AttendanceLogEntityCopyWith<$Res> implements $AttendanceLogEntityCopyWith<$Res> {
  factory _$AttendanceLogEntityCopyWith(_AttendanceLogEntity value, $Res Function(_AttendanceLogEntity) _then) = __$AttendanceLogEntityCopyWithImpl;
@override @useResult
$Res call({
 String date, String dayName, String inTime, String? outTime, double? workingHours, String status
});




}
/// @nodoc
class __$AttendanceLogEntityCopyWithImpl<$Res>
    implements _$AttendanceLogEntityCopyWith<$Res> {
  __$AttendanceLogEntityCopyWithImpl(this._self, this._then);

  final _AttendanceLogEntity _self;
  final $Res Function(_AttendanceLogEntity) _then;

/// Create a copy of AttendanceLogEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? dayName = null,Object? inTime = null,Object? outTime = freezed,Object? workingHours = freezed,Object? status = null,}) {
  return _then(_AttendanceLogEntity(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dayName: null == dayName ? _self.dayName : dayName // ignore: cast_nullable_to_non_nullable
as String,inTime: null == inTime ? _self.inTime : inTime // ignore: cast_nullable_to_non_nullable
as String,outTime: freezed == outTime ? _self.outTime : outTime // ignore: cast_nullable_to_non_nullable
as String?,workingHours: freezed == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
