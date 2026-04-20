// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_work_durations_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttendanceWorkDurationsEntity {

 double get todayHours; String get todayLabel; double get weekHours; String get weekLabel; double get monthHours; String get monthLabel; bool get onBreak; bool get punchedIn;
/// Create a copy of AttendanceWorkDurationsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceWorkDurationsEntityCopyWith<AttendanceWorkDurationsEntity> get copyWith => _$AttendanceWorkDurationsEntityCopyWithImpl<AttendanceWorkDurationsEntity>(this as AttendanceWorkDurationsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceWorkDurationsEntity&&(identical(other.todayHours, todayHours) || other.todayHours == todayHours)&&(identical(other.todayLabel, todayLabel) || other.todayLabel == todayLabel)&&(identical(other.weekHours, weekHours) || other.weekHours == weekHours)&&(identical(other.weekLabel, weekLabel) || other.weekLabel == weekLabel)&&(identical(other.monthHours, monthHours) || other.monthHours == monthHours)&&(identical(other.monthLabel, monthLabel) || other.monthLabel == monthLabel)&&(identical(other.onBreak, onBreak) || other.onBreak == onBreak)&&(identical(other.punchedIn, punchedIn) || other.punchedIn == punchedIn));
}


@override
int get hashCode => Object.hash(runtimeType,todayHours,todayLabel,weekHours,weekLabel,monthHours,monthLabel,onBreak,punchedIn);

@override
String toString() {
  return 'AttendanceWorkDurationsEntity(todayHours: $todayHours, todayLabel: $todayLabel, weekHours: $weekHours, weekLabel: $weekLabel, monthHours: $monthHours, monthLabel: $monthLabel, onBreak: $onBreak, punchedIn: $punchedIn)';
}


}

/// @nodoc
abstract mixin class $AttendanceWorkDurationsEntityCopyWith<$Res>  {
  factory $AttendanceWorkDurationsEntityCopyWith(AttendanceWorkDurationsEntity value, $Res Function(AttendanceWorkDurationsEntity) _then) = _$AttendanceWorkDurationsEntityCopyWithImpl;
@useResult
$Res call({
 double todayHours, String todayLabel, double weekHours, String weekLabel, double monthHours, String monthLabel, bool onBreak, bool punchedIn
});




}
/// @nodoc
class _$AttendanceWorkDurationsEntityCopyWithImpl<$Res>
    implements $AttendanceWorkDurationsEntityCopyWith<$Res> {
  _$AttendanceWorkDurationsEntityCopyWithImpl(this._self, this._then);

  final AttendanceWorkDurationsEntity _self;
  final $Res Function(AttendanceWorkDurationsEntity) _then;

/// Create a copy of AttendanceWorkDurationsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todayHours = null,Object? todayLabel = null,Object? weekHours = null,Object? weekLabel = null,Object? monthHours = null,Object? monthLabel = null,Object? onBreak = null,Object? punchedIn = null,}) {
  return _then(_self.copyWith(
todayHours: null == todayHours ? _self.todayHours : todayHours // ignore: cast_nullable_to_non_nullable
as double,todayLabel: null == todayLabel ? _self.todayLabel : todayLabel // ignore: cast_nullable_to_non_nullable
as String,weekHours: null == weekHours ? _self.weekHours : weekHours // ignore: cast_nullable_to_non_nullable
as double,weekLabel: null == weekLabel ? _self.weekLabel : weekLabel // ignore: cast_nullable_to_non_nullable
as String,monthHours: null == monthHours ? _self.monthHours : monthHours // ignore: cast_nullable_to_non_nullable
as double,monthLabel: null == monthLabel ? _self.monthLabel : monthLabel // ignore: cast_nullable_to_non_nullable
as String,onBreak: null == onBreak ? _self.onBreak : onBreak // ignore: cast_nullable_to_non_nullable
as bool,punchedIn: null == punchedIn ? _self.punchedIn : punchedIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceWorkDurationsEntity].
extension AttendanceWorkDurationsEntityPatterns on AttendanceWorkDurationsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceWorkDurationsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceWorkDurationsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceWorkDurationsEntity value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceWorkDurationsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceWorkDurationsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceWorkDurationsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double todayHours,  String todayLabel,  double weekHours,  String weekLabel,  double monthHours,  String monthLabel,  bool onBreak,  bool punchedIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceWorkDurationsEntity() when $default != null:
return $default(_that.todayHours,_that.todayLabel,_that.weekHours,_that.weekLabel,_that.monthHours,_that.monthLabel,_that.onBreak,_that.punchedIn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double todayHours,  String todayLabel,  double weekHours,  String weekLabel,  double monthHours,  String monthLabel,  bool onBreak,  bool punchedIn)  $default,) {final _that = this;
switch (_that) {
case _AttendanceWorkDurationsEntity():
return $default(_that.todayHours,_that.todayLabel,_that.weekHours,_that.weekLabel,_that.monthHours,_that.monthLabel,_that.onBreak,_that.punchedIn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double todayHours,  String todayLabel,  double weekHours,  String weekLabel,  double monthHours,  String monthLabel,  bool onBreak,  bool punchedIn)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceWorkDurationsEntity() when $default != null:
return $default(_that.todayHours,_that.todayLabel,_that.weekHours,_that.weekLabel,_that.monthHours,_that.monthLabel,_that.onBreak,_that.punchedIn);case _:
  return null;

}
}

}

/// @nodoc


class _AttendanceWorkDurationsEntity extends AttendanceWorkDurationsEntity {
  const _AttendanceWorkDurationsEntity({required this.todayHours, required this.todayLabel, required this.weekHours, required this.weekLabel, required this.monthHours, required this.monthLabel, required this.onBreak, required this.punchedIn}): super._();
  

@override final  double todayHours;
@override final  String todayLabel;
@override final  double weekHours;
@override final  String weekLabel;
@override final  double monthHours;
@override final  String monthLabel;
@override final  bool onBreak;
@override final  bool punchedIn;

/// Create a copy of AttendanceWorkDurationsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceWorkDurationsEntityCopyWith<_AttendanceWorkDurationsEntity> get copyWith => __$AttendanceWorkDurationsEntityCopyWithImpl<_AttendanceWorkDurationsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceWorkDurationsEntity&&(identical(other.todayHours, todayHours) || other.todayHours == todayHours)&&(identical(other.todayLabel, todayLabel) || other.todayLabel == todayLabel)&&(identical(other.weekHours, weekHours) || other.weekHours == weekHours)&&(identical(other.weekLabel, weekLabel) || other.weekLabel == weekLabel)&&(identical(other.monthHours, monthHours) || other.monthHours == monthHours)&&(identical(other.monthLabel, monthLabel) || other.monthLabel == monthLabel)&&(identical(other.onBreak, onBreak) || other.onBreak == onBreak)&&(identical(other.punchedIn, punchedIn) || other.punchedIn == punchedIn));
}


@override
int get hashCode => Object.hash(runtimeType,todayHours,todayLabel,weekHours,weekLabel,monthHours,monthLabel,onBreak,punchedIn);

@override
String toString() {
  return 'AttendanceWorkDurationsEntity(todayHours: $todayHours, todayLabel: $todayLabel, weekHours: $weekHours, weekLabel: $weekLabel, monthHours: $monthHours, monthLabel: $monthLabel, onBreak: $onBreak, punchedIn: $punchedIn)';
}


}

/// @nodoc
abstract mixin class _$AttendanceWorkDurationsEntityCopyWith<$Res> implements $AttendanceWorkDurationsEntityCopyWith<$Res> {
  factory _$AttendanceWorkDurationsEntityCopyWith(_AttendanceWorkDurationsEntity value, $Res Function(_AttendanceWorkDurationsEntity) _then) = __$AttendanceWorkDurationsEntityCopyWithImpl;
@override @useResult
$Res call({
 double todayHours, String todayLabel, double weekHours, String weekLabel, double monthHours, String monthLabel, bool onBreak, bool punchedIn
});




}
/// @nodoc
class __$AttendanceWorkDurationsEntityCopyWithImpl<$Res>
    implements _$AttendanceWorkDurationsEntityCopyWith<$Res> {
  __$AttendanceWorkDurationsEntityCopyWithImpl(this._self, this._then);

  final _AttendanceWorkDurationsEntity _self;
  final $Res Function(_AttendanceWorkDurationsEntity) _then;

/// Create a copy of AttendanceWorkDurationsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todayHours = null,Object? todayLabel = null,Object? weekHours = null,Object? weekLabel = null,Object? monthHours = null,Object? monthLabel = null,Object? onBreak = null,Object? punchedIn = null,}) {
  return _then(_AttendanceWorkDurationsEntity(
todayHours: null == todayHours ? _self.todayHours : todayHours // ignore: cast_nullable_to_non_nullable
as double,todayLabel: null == todayLabel ? _self.todayLabel : todayLabel // ignore: cast_nullable_to_non_nullable
as String,weekHours: null == weekHours ? _self.weekHours : weekHours // ignore: cast_nullable_to_non_nullable
as double,weekLabel: null == weekLabel ? _self.weekLabel : weekLabel // ignore: cast_nullable_to_non_nullable
as String,monthHours: null == monthHours ? _self.monthHours : monthHours // ignore: cast_nullable_to_non_nullable
as double,monthLabel: null == monthLabel ? _self.monthLabel : monthLabel // ignore: cast_nullable_to_non_nullable
as String,onBreak: null == onBreak ? _self.onBreak : onBreak // ignore: cast_nullable_to_non_nullable
as bool,punchedIn: null == punchedIn ? _self.punchedIn : punchedIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
