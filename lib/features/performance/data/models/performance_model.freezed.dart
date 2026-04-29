// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PerformanceModel {

@JsonKey(name: 'employee_id') String get employeeId;@JsonKey(name: 'performance_score') double get score;@JsonKey(name: 'review_period') String get period;
/// Create a copy of PerformanceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceModelCopyWith<PerformanceModel> get copyWith => _$PerformanceModelCopyWithImpl<PerformanceModel>(this as PerformanceModel, _$identity);

  /// Serializes this PerformanceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceModel&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.score, score) || other.score == score)&&(identical(other.period, period) || other.period == period));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,score,period);

@override
String toString() {
  return 'PerformanceModel(employeeId: $employeeId, score: $score, period: $period)';
}


}

/// @nodoc
abstract mixin class $PerformanceModelCopyWith<$Res>  {
  factory $PerformanceModelCopyWith(PerformanceModel value, $Res Function(PerformanceModel) _then) = _$PerformanceModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'employee_id') String employeeId,@JsonKey(name: 'performance_score') double score,@JsonKey(name: 'review_period') String period
});




}
/// @nodoc
class _$PerformanceModelCopyWithImpl<$Res>
    implements $PerformanceModelCopyWith<$Res> {
  _$PerformanceModelCopyWithImpl(this._self, this._then);

  final PerformanceModel _self;
  final $Res Function(PerformanceModel) _then;

/// Create a copy of PerformanceModel
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


/// Adds pattern-matching-related methods to [PerformanceModel].
extension PerformanceModelPatterns on PerformanceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PerformanceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PerformanceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PerformanceModel value)  $default,){
final _that = this;
switch (_that) {
case _PerformanceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PerformanceModel value)?  $default,){
final _that = this;
switch (_that) {
case _PerformanceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'performance_score')  double score, @JsonKey(name: 'review_period')  String period)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PerformanceModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'performance_score')  double score, @JsonKey(name: 'review_period')  String period)  $default,) {final _that = this;
switch (_that) {
case _PerformanceModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'employee_id')  String employeeId, @JsonKey(name: 'performance_score')  double score, @JsonKey(name: 'review_period')  String period)?  $default,) {final _that = this;
switch (_that) {
case _PerformanceModel() when $default != null:
return $default(_that.employeeId,_that.score,_that.period);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PerformanceModel implements PerformanceModel {
  const _PerformanceModel({@JsonKey(name: 'employee_id') required this.employeeId, @JsonKey(name: 'performance_score') required this.score, @JsonKey(name: 'review_period') required this.period});
  factory _PerformanceModel.fromJson(Map<String, dynamic> json) => _$PerformanceModelFromJson(json);

@override@JsonKey(name: 'employee_id') final  String employeeId;
@override@JsonKey(name: 'performance_score') final  double score;
@override@JsonKey(name: 'review_period') final  String period;

/// Create a copy of PerformanceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceModelCopyWith<_PerformanceModel> get copyWith => __$PerformanceModelCopyWithImpl<_PerformanceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PerformanceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceModel&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.score, score) || other.score == score)&&(identical(other.period, period) || other.period == period));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,score,period);

@override
String toString() {
  return 'PerformanceModel(employeeId: $employeeId, score: $score, period: $period)';
}


}

/// @nodoc
abstract mixin class _$PerformanceModelCopyWith<$Res> implements $PerformanceModelCopyWith<$Res> {
  factory _$PerformanceModelCopyWith(_PerformanceModel value, $Res Function(_PerformanceModel) _then) = __$PerformanceModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'employee_id') String employeeId,@JsonKey(name: 'performance_score') double score,@JsonKey(name: 'review_period') String period
});




}
/// @nodoc
class __$PerformanceModelCopyWithImpl<$Res>
    implements _$PerformanceModelCopyWith<$Res> {
  __$PerformanceModelCopyWithImpl(this._self, this._then);

  final _PerformanceModel _self;
  final $Res Function(_PerformanceModel) _then;

/// Create a copy of PerformanceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? score = null,Object? period = null,}) {
  return _then(_PerformanceModel(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
