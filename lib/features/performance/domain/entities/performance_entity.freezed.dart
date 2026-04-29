// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performance_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PerformanceEntity {

 String get employeeId; double get score; String get period;
/// Create a copy of PerformanceEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceEntityCopyWith<PerformanceEntity> get copyWith => _$PerformanceEntityCopyWithImpl<PerformanceEntity>(this as PerformanceEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceEntity&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.score, score) || other.score == score)&&(identical(other.period, period) || other.period == period));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId,score,period);

@override
String toString() {
  return 'PerformanceEntity(employeeId: $employeeId, score: $score, period: $period)';
}


}

/// @nodoc
abstract mixin class $PerformanceEntityCopyWith<$Res>  {
  factory $PerformanceEntityCopyWith(PerformanceEntity value, $Res Function(PerformanceEntity) _then) = _$PerformanceEntityCopyWithImpl;
@useResult
$Res call({
 String employeeId, double score, String period
});




}
/// @nodoc
class _$PerformanceEntityCopyWithImpl<$Res>
    implements $PerformanceEntityCopyWith<$Res> {
  _$PerformanceEntityCopyWithImpl(this._self, this._then);

  final PerformanceEntity _self;
  final $Res Function(PerformanceEntity) _then;

/// Create a copy of PerformanceEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employeeId = null,Object? score = null,Object? period = null,}) {
  return _then(_self.copyWith(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PerformanceEntity].
extension PerformanceEntityPatterns on PerformanceEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PerformanceEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PerformanceEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PerformanceEntity value)  $default,){
final _that = this;
switch (_that) {
case _PerformanceEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PerformanceEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PerformanceEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String employeeId,  double score,  String period)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PerformanceEntity() when $default != null:
return $default(_that.employeeId,_that.score,_that.period);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String employeeId,  double score,  String period)  $default,) {final _that = this;
switch (_that) {
case _PerformanceEntity():
return $default(_that.employeeId,_that.score,_that.period);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String employeeId,  double score,  String period)?  $default,) {final _that = this;
switch (_that) {
case _PerformanceEntity() when $default != null:
return $default(_that.employeeId,_that.score,_that.period);case _:
  return null;

}
}

}

/// @nodoc


class _PerformanceEntity implements PerformanceEntity {
  const _PerformanceEntity({required this.employeeId, required this.score, required this.period});
  

@override final  String employeeId;
@override final  double score;
@override final  String period;

/// Create a copy of PerformanceEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceEntityCopyWith<_PerformanceEntity> get copyWith => __$PerformanceEntityCopyWithImpl<_PerformanceEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceEntity&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.score, score) || other.score == score)&&(identical(other.period, period) || other.period == period));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId,score,period);

@override
String toString() {
  return 'PerformanceEntity(employeeId: $employeeId, score: $score, period: $period)';
}


}

/// @nodoc
abstract mixin class _$PerformanceEntityCopyWith<$Res> implements $PerformanceEntityCopyWith<$Res> {
  factory _$PerformanceEntityCopyWith(_PerformanceEntity value, $Res Function(_PerformanceEntity) _then) = __$PerformanceEntityCopyWithImpl;
@override @useResult
$Res call({
 String employeeId, double score, String period
});




}
/// @nodoc
class __$PerformanceEntityCopyWithImpl<$Res>
    implements _$PerformanceEntityCopyWith<$Res> {
  __$PerformanceEntityCopyWithImpl(this._self, this._then);

  final _PerformanceEntity _self;
  final $Res Function(_PerformanceEntity) _then;

/// Create a copy of PerformanceEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? score = null,Object? period = null,}) {
  return _then(_PerformanceEntity(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
