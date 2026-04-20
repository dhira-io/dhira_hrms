// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_work_durations_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceWorkDurationsModel {

@JsonKey(name: 'today') WorkDurationInfo get today;@JsonKey(name: 'week') WorkDurationInfo get week;@JsonKey(name: 'month') WorkDurationInfo get month;@JsonKey(name: 'on_break') bool get onBreak;@JsonKey(name: 'punched_in') bool get punchedIn;
/// Create a copy of AttendanceWorkDurationsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceWorkDurationsModelCopyWith<AttendanceWorkDurationsModel> get copyWith => _$AttendanceWorkDurationsModelCopyWithImpl<AttendanceWorkDurationsModel>(this as AttendanceWorkDurationsModel, _$identity);

  /// Serializes this AttendanceWorkDurationsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceWorkDurationsModel&&(identical(other.today, today) || other.today == today)&&(identical(other.week, week) || other.week == week)&&(identical(other.month, month) || other.month == month)&&(identical(other.onBreak, onBreak) || other.onBreak == onBreak)&&(identical(other.punchedIn, punchedIn) || other.punchedIn == punchedIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,today,week,month,onBreak,punchedIn);

@override
String toString() {
  return 'AttendanceWorkDurationsModel(today: $today, week: $week, month: $month, onBreak: $onBreak, punchedIn: $punchedIn)';
}


}

/// @nodoc
abstract mixin class $AttendanceWorkDurationsModelCopyWith<$Res>  {
  factory $AttendanceWorkDurationsModelCopyWith(AttendanceWorkDurationsModel value, $Res Function(AttendanceWorkDurationsModel) _then) = _$AttendanceWorkDurationsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'today') WorkDurationInfo today,@JsonKey(name: 'week') WorkDurationInfo week,@JsonKey(name: 'month') WorkDurationInfo month,@JsonKey(name: 'on_break') bool onBreak,@JsonKey(name: 'punched_in') bool punchedIn
});


$WorkDurationInfoCopyWith<$Res> get today;$WorkDurationInfoCopyWith<$Res> get week;$WorkDurationInfoCopyWith<$Res> get month;

}
/// @nodoc
class _$AttendanceWorkDurationsModelCopyWithImpl<$Res>
    implements $AttendanceWorkDurationsModelCopyWith<$Res> {
  _$AttendanceWorkDurationsModelCopyWithImpl(this._self, this._then);

  final AttendanceWorkDurationsModel _self;
  final $Res Function(AttendanceWorkDurationsModel) _then;

/// Create a copy of AttendanceWorkDurationsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? today = null,Object? week = null,Object? month = null,Object? onBreak = null,Object? punchedIn = null,}) {
  return _then(_self.copyWith(
today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as WorkDurationInfo,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as WorkDurationInfo,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as WorkDurationInfo,onBreak: null == onBreak ? _self.onBreak : onBreak // ignore: cast_nullable_to_non_nullable
as bool,punchedIn: null == punchedIn ? _self.punchedIn : punchedIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of AttendanceWorkDurationsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkDurationInfoCopyWith<$Res> get today {
  
  return $WorkDurationInfoCopyWith<$Res>(_self.today, (value) {
    return _then(_self.copyWith(today: value));
  });
}/// Create a copy of AttendanceWorkDurationsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkDurationInfoCopyWith<$Res> get week {
  
  return $WorkDurationInfoCopyWith<$Res>(_self.week, (value) {
    return _then(_self.copyWith(week: value));
  });
}/// Create a copy of AttendanceWorkDurationsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkDurationInfoCopyWith<$Res> get month {
  
  return $WorkDurationInfoCopyWith<$Res>(_self.month, (value) {
    return _then(_self.copyWith(month: value));
  });
}
}


/// Adds pattern-matching-related methods to [AttendanceWorkDurationsModel].
extension AttendanceWorkDurationsModelPatterns on AttendanceWorkDurationsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceWorkDurationsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceWorkDurationsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceWorkDurationsModel value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceWorkDurationsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceWorkDurationsModel value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceWorkDurationsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'today')  WorkDurationInfo today, @JsonKey(name: 'week')  WorkDurationInfo week, @JsonKey(name: 'month')  WorkDurationInfo month, @JsonKey(name: 'on_break')  bool onBreak, @JsonKey(name: 'punched_in')  bool punchedIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceWorkDurationsModel() when $default != null:
return $default(_that.today,_that.week,_that.month,_that.onBreak,_that.punchedIn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'today')  WorkDurationInfo today, @JsonKey(name: 'week')  WorkDurationInfo week, @JsonKey(name: 'month')  WorkDurationInfo month, @JsonKey(name: 'on_break')  bool onBreak, @JsonKey(name: 'punched_in')  bool punchedIn)  $default,) {final _that = this;
switch (_that) {
case _AttendanceWorkDurationsModel():
return $default(_that.today,_that.week,_that.month,_that.onBreak,_that.punchedIn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'today')  WorkDurationInfo today, @JsonKey(name: 'week')  WorkDurationInfo week, @JsonKey(name: 'month')  WorkDurationInfo month, @JsonKey(name: 'on_break')  bool onBreak, @JsonKey(name: 'punched_in')  bool punchedIn)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceWorkDurationsModel() when $default != null:
return $default(_that.today,_that.week,_that.month,_that.onBreak,_that.punchedIn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceWorkDurationsModel extends AttendanceWorkDurationsModel {
  const _AttendanceWorkDurationsModel({@JsonKey(name: 'today') required this.today, @JsonKey(name: 'week') required this.week, @JsonKey(name: 'month') required this.month, @JsonKey(name: 'on_break') required this.onBreak, @JsonKey(name: 'punched_in') required this.punchedIn}): super._();
  factory _AttendanceWorkDurationsModel.fromJson(Map<String, dynamic> json) => _$AttendanceWorkDurationsModelFromJson(json);

@override@JsonKey(name: 'today') final  WorkDurationInfo today;
@override@JsonKey(name: 'week') final  WorkDurationInfo week;
@override@JsonKey(name: 'month') final  WorkDurationInfo month;
@override@JsonKey(name: 'on_break') final  bool onBreak;
@override@JsonKey(name: 'punched_in') final  bool punchedIn;

/// Create a copy of AttendanceWorkDurationsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceWorkDurationsModelCopyWith<_AttendanceWorkDurationsModel> get copyWith => __$AttendanceWorkDurationsModelCopyWithImpl<_AttendanceWorkDurationsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceWorkDurationsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceWorkDurationsModel&&(identical(other.today, today) || other.today == today)&&(identical(other.week, week) || other.week == week)&&(identical(other.month, month) || other.month == month)&&(identical(other.onBreak, onBreak) || other.onBreak == onBreak)&&(identical(other.punchedIn, punchedIn) || other.punchedIn == punchedIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,today,week,month,onBreak,punchedIn);

@override
String toString() {
  return 'AttendanceWorkDurationsModel(today: $today, week: $week, month: $month, onBreak: $onBreak, punchedIn: $punchedIn)';
}


}

/// @nodoc
abstract mixin class _$AttendanceWorkDurationsModelCopyWith<$Res> implements $AttendanceWorkDurationsModelCopyWith<$Res> {
  factory _$AttendanceWorkDurationsModelCopyWith(_AttendanceWorkDurationsModel value, $Res Function(_AttendanceWorkDurationsModel) _then) = __$AttendanceWorkDurationsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'today') WorkDurationInfo today,@JsonKey(name: 'week') WorkDurationInfo week,@JsonKey(name: 'month') WorkDurationInfo month,@JsonKey(name: 'on_break') bool onBreak,@JsonKey(name: 'punched_in') bool punchedIn
});


@override $WorkDurationInfoCopyWith<$Res> get today;@override $WorkDurationInfoCopyWith<$Res> get week;@override $WorkDurationInfoCopyWith<$Res> get month;

}
/// @nodoc
class __$AttendanceWorkDurationsModelCopyWithImpl<$Res>
    implements _$AttendanceWorkDurationsModelCopyWith<$Res> {
  __$AttendanceWorkDurationsModelCopyWithImpl(this._self, this._then);

  final _AttendanceWorkDurationsModel _self;
  final $Res Function(_AttendanceWorkDurationsModel) _then;

/// Create a copy of AttendanceWorkDurationsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? today = null,Object? week = null,Object? month = null,Object? onBreak = null,Object? punchedIn = null,}) {
  return _then(_AttendanceWorkDurationsModel(
today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as WorkDurationInfo,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as WorkDurationInfo,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as WorkDurationInfo,onBreak: null == onBreak ? _self.onBreak : onBreak // ignore: cast_nullable_to_non_nullable
as bool,punchedIn: null == punchedIn ? _self.punchedIn : punchedIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AttendanceWorkDurationsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkDurationInfoCopyWith<$Res> get today {
  
  return $WorkDurationInfoCopyWith<$Res>(_self.today, (value) {
    return _then(_self.copyWith(today: value));
  });
}/// Create a copy of AttendanceWorkDurationsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkDurationInfoCopyWith<$Res> get week {
  
  return $WorkDurationInfoCopyWith<$Res>(_self.week, (value) {
    return _then(_self.copyWith(week: value));
  });
}/// Create a copy of AttendanceWorkDurationsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkDurationInfoCopyWith<$Res> get month {
  
  return $WorkDurationInfoCopyWith<$Res>(_self.month, (value) {
    return _then(_self.copyWith(month: value));
  });
}
}


/// @nodoc
mixin _$WorkDurationInfo {

 double get hours; String get label;
/// Create a copy of WorkDurationInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkDurationInfoCopyWith<WorkDurationInfo> get copyWith => _$WorkDurationInfoCopyWithImpl<WorkDurationInfo>(this as WorkDurationInfo, _$identity);

  /// Serializes this WorkDurationInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkDurationInfo&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hours,label);

@override
String toString() {
  return 'WorkDurationInfo(hours: $hours, label: $label)';
}


}

/// @nodoc
abstract mixin class $WorkDurationInfoCopyWith<$Res>  {
  factory $WorkDurationInfoCopyWith(WorkDurationInfo value, $Res Function(WorkDurationInfo) _then) = _$WorkDurationInfoCopyWithImpl;
@useResult
$Res call({
 double hours, String label
});




}
/// @nodoc
class _$WorkDurationInfoCopyWithImpl<$Res>
    implements $WorkDurationInfoCopyWith<$Res> {
  _$WorkDurationInfoCopyWithImpl(this._self, this._then);

  final WorkDurationInfo _self;
  final $Res Function(WorkDurationInfo) _then;

/// Create a copy of WorkDurationInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hours = null,Object? label = null,}) {
  return _then(_self.copyWith(
hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as double,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkDurationInfo].
extension WorkDurationInfoPatterns on WorkDurationInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkDurationInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkDurationInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkDurationInfo value)  $default,){
final _that = this;
switch (_that) {
case _WorkDurationInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkDurationInfo value)?  $default,){
final _that = this;
switch (_that) {
case _WorkDurationInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double hours,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkDurationInfo() when $default != null:
return $default(_that.hours,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double hours,  String label)  $default,) {final _that = this;
switch (_that) {
case _WorkDurationInfo():
return $default(_that.hours,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double hours,  String label)?  $default,) {final _that = this;
switch (_that) {
case _WorkDurationInfo() when $default != null:
return $default(_that.hours,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkDurationInfo implements WorkDurationInfo {
  const _WorkDurationInfo({required this.hours, required this.label});
  factory _WorkDurationInfo.fromJson(Map<String, dynamic> json) => _$WorkDurationInfoFromJson(json);

@override final  double hours;
@override final  String label;

/// Create a copy of WorkDurationInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkDurationInfoCopyWith<_WorkDurationInfo> get copyWith => __$WorkDurationInfoCopyWithImpl<_WorkDurationInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkDurationInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkDurationInfo&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hours,label);

@override
String toString() {
  return 'WorkDurationInfo(hours: $hours, label: $label)';
}


}

/// @nodoc
abstract mixin class _$WorkDurationInfoCopyWith<$Res> implements $WorkDurationInfoCopyWith<$Res> {
  factory _$WorkDurationInfoCopyWith(_WorkDurationInfo value, $Res Function(_WorkDurationInfo) _then) = __$WorkDurationInfoCopyWithImpl;
@override @useResult
$Res call({
 double hours, String label
});




}
/// @nodoc
class __$WorkDurationInfoCopyWithImpl<$Res>
    implements _$WorkDurationInfoCopyWith<$Res> {
  __$WorkDurationInfoCopyWithImpl(this._self, this._then);

  final _WorkDurationInfo _self;
  final $Res Function(_WorkDurationInfo) _then;

/// Create a copy of WorkDurationInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hours = null,Object? label = null,}) {
  return _then(_WorkDurationInfo(
hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as double,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
