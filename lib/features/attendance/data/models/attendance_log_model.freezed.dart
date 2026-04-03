// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceLogModel {

@JsonKey(name: 'attendance_date') String get date;@JsonKey(name: 'day_name') String get dayName;@JsonKey(name: 'in_time') String get inTime;@JsonKey(name: 'out_time') String? get outTime;@JsonKey(name: 'working_hours') double? get workingHours; String get status;
/// Create a copy of AttendanceLogModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceLogModelCopyWith<AttendanceLogModel> get copyWith => _$AttendanceLogModelCopyWithImpl<AttendanceLogModel>(this as AttendanceLogModel, _$identity);

  /// Serializes this AttendanceLogModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceLogModel&&(identical(other.date, date) || other.date == date)&&(identical(other.dayName, dayName) || other.dayName == dayName)&&(identical(other.inTime, inTime) || other.inTime == inTime)&&(identical(other.outTime, outTime) || other.outTime == outTime)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,dayName,inTime,outTime,workingHours,status);

@override
String toString() {
  return 'AttendanceLogModel(date: $date, dayName: $dayName, inTime: $inTime, outTime: $outTime, workingHours: $workingHours, status: $status)';
}


}

/// @nodoc
abstract mixin class $AttendanceLogModelCopyWith<$Res>  {
  factory $AttendanceLogModelCopyWith(AttendanceLogModel value, $Res Function(AttendanceLogModel) _then) = _$AttendanceLogModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'attendance_date') String date,@JsonKey(name: 'day_name') String dayName,@JsonKey(name: 'in_time') String inTime,@JsonKey(name: 'out_time') String? outTime,@JsonKey(name: 'working_hours') double? workingHours, String status
});




}
/// @nodoc
class _$AttendanceLogModelCopyWithImpl<$Res>
    implements $AttendanceLogModelCopyWith<$Res> {
  _$AttendanceLogModelCopyWithImpl(this._self, this._then);

  final AttendanceLogModel _self;
  final $Res Function(AttendanceLogModel) _then;

/// Create a copy of AttendanceLogModel
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


/// Adds pattern-matching-related methods to [AttendanceLogModel].
extension AttendanceLogModelPatterns on AttendanceLogModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceLogModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceLogModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceLogModel value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceLogModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceLogModel value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceLogModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'attendance_date')  String date, @JsonKey(name: 'day_name')  String dayName, @JsonKey(name: 'in_time')  String inTime, @JsonKey(name: 'out_time')  String? outTime, @JsonKey(name: 'working_hours')  double? workingHours,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceLogModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'attendance_date')  String date, @JsonKey(name: 'day_name')  String dayName, @JsonKey(name: 'in_time')  String inTime, @JsonKey(name: 'out_time')  String? outTime, @JsonKey(name: 'working_hours')  double? workingHours,  String status)  $default,) {final _that = this;
switch (_that) {
case _AttendanceLogModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'attendance_date')  String date, @JsonKey(name: 'day_name')  String dayName, @JsonKey(name: 'in_time')  String inTime, @JsonKey(name: 'out_time')  String? outTime, @JsonKey(name: 'working_hours')  double? workingHours,  String status)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceLogModel() when $default != null:
return $default(_that.date,_that.dayName,_that.inTime,_that.outTime,_that.workingHours,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceLogModel extends AttendanceLogModel {
  const _AttendanceLogModel({@JsonKey(name: 'attendance_date') required this.date, @JsonKey(name: 'day_name') required this.dayName, @JsonKey(name: 'in_time') required this.inTime, @JsonKey(name: 'out_time') this.outTime, @JsonKey(name: 'working_hours') this.workingHours, required this.status}): super._();
  factory _AttendanceLogModel.fromJson(Map<String, dynamic> json) => _$AttendanceLogModelFromJson(json);

@override@JsonKey(name: 'attendance_date') final  String date;
@override@JsonKey(name: 'day_name') final  String dayName;
@override@JsonKey(name: 'in_time') final  String inTime;
@override@JsonKey(name: 'out_time') final  String? outTime;
@override@JsonKey(name: 'working_hours') final  double? workingHours;
@override final  String status;

/// Create a copy of AttendanceLogModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceLogModelCopyWith<_AttendanceLogModel> get copyWith => __$AttendanceLogModelCopyWithImpl<_AttendanceLogModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceLogModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceLogModel&&(identical(other.date, date) || other.date == date)&&(identical(other.dayName, dayName) || other.dayName == dayName)&&(identical(other.inTime, inTime) || other.inTime == inTime)&&(identical(other.outTime, outTime) || other.outTime == outTime)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,dayName,inTime,outTime,workingHours,status);

@override
String toString() {
  return 'AttendanceLogModel(date: $date, dayName: $dayName, inTime: $inTime, outTime: $outTime, workingHours: $workingHours, status: $status)';
}


}

/// @nodoc
abstract mixin class _$AttendanceLogModelCopyWith<$Res> implements $AttendanceLogModelCopyWith<$Res> {
  factory _$AttendanceLogModelCopyWith(_AttendanceLogModel value, $Res Function(_AttendanceLogModel) _then) = __$AttendanceLogModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'attendance_date') String date,@JsonKey(name: 'day_name') String dayName,@JsonKey(name: 'in_time') String inTime,@JsonKey(name: 'out_time') String? outTime,@JsonKey(name: 'working_hours') double? workingHours, String status
});




}
/// @nodoc
class __$AttendanceLogModelCopyWithImpl<$Res>
    implements _$AttendanceLogModelCopyWith<$Res> {
  __$AttendanceLogModelCopyWithImpl(this._self, this._then);

  final _AttendanceLogModel _self;
  final $Res Function(_AttendanceLogModel) _then;

/// Create a copy of AttendanceLogModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? dayName = null,Object? inTime = null,Object? outTime = freezed,Object? workingHours = freezed,Object? status = null,}) {
  return _then(_AttendanceLogModel(
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
