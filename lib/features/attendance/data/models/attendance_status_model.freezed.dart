// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceStatusModel {

@JsonKey(name: 'success') bool get success;@JsonKey(name: 'punched_in') bool get punchedIn;@JsonKey(name: 'first_in') String? get firstIn;@JsonKey(name: 'last_out') String? get lastOut;
/// Create a copy of AttendanceStatusModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceStatusModelCopyWith<AttendanceStatusModel> get copyWith => _$AttendanceStatusModelCopyWithImpl<AttendanceStatusModel>(this as AttendanceStatusModel, _$identity);

  /// Serializes this AttendanceStatusModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceStatusModel&&(identical(other.success, success) || other.success == success)&&(identical(other.punchedIn, punchedIn) || other.punchedIn == punchedIn)&&(identical(other.firstIn, firstIn) || other.firstIn == firstIn)&&(identical(other.lastOut, lastOut) || other.lastOut == lastOut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,punchedIn,firstIn,lastOut);

@override
String toString() {
  return 'AttendanceStatusModel(success: $success, punchedIn: $punchedIn, firstIn: $firstIn, lastOut: $lastOut)';
}


}

/// @nodoc
abstract mixin class $AttendanceStatusModelCopyWith<$Res>  {
  factory $AttendanceStatusModelCopyWith(AttendanceStatusModel value, $Res Function(AttendanceStatusModel) _then) = _$AttendanceStatusModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'success') bool success,@JsonKey(name: 'punched_in') bool punchedIn,@JsonKey(name: 'first_in') String? firstIn,@JsonKey(name: 'last_out') String? lastOut
});




}
/// @nodoc
class _$AttendanceStatusModelCopyWithImpl<$Res>
    implements $AttendanceStatusModelCopyWith<$Res> {
  _$AttendanceStatusModelCopyWithImpl(this._self, this._then);

  final AttendanceStatusModel _self;
  final $Res Function(AttendanceStatusModel) _then;

/// Create a copy of AttendanceStatusModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? punchedIn = null,Object? firstIn = freezed,Object? lastOut = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,punchedIn: null == punchedIn ? _self.punchedIn : punchedIn // ignore: cast_nullable_to_non_nullable
as bool,firstIn: freezed == firstIn ? _self.firstIn : firstIn // ignore: cast_nullable_to_non_nullable
as String?,lastOut: freezed == lastOut ? _self.lastOut : lastOut // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceStatusModel].
extension AttendanceStatusModelPatterns on AttendanceStatusModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceStatusModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceStatusModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceStatusModel value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceStatusModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceStatusModel value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceStatusModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'success')  bool success, @JsonKey(name: 'punched_in')  bool punchedIn, @JsonKey(name: 'first_in')  String? firstIn, @JsonKey(name: 'last_out')  String? lastOut)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceStatusModel() when $default != null:
return $default(_that.success,_that.punchedIn,_that.firstIn,_that.lastOut);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'success')  bool success, @JsonKey(name: 'punched_in')  bool punchedIn, @JsonKey(name: 'first_in')  String? firstIn, @JsonKey(name: 'last_out')  String? lastOut)  $default,) {final _that = this;
switch (_that) {
case _AttendanceStatusModel():
return $default(_that.success,_that.punchedIn,_that.firstIn,_that.lastOut);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'success')  bool success, @JsonKey(name: 'punched_in')  bool punchedIn, @JsonKey(name: 'first_in')  String? firstIn, @JsonKey(name: 'last_out')  String? lastOut)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceStatusModel() when $default != null:
return $default(_that.success,_that.punchedIn,_that.firstIn,_that.lastOut);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceStatusModel extends AttendanceStatusModel {
  const _AttendanceStatusModel({@JsonKey(name: 'success') required this.success, @JsonKey(name: 'punched_in') required this.punchedIn, @JsonKey(name: 'first_in') this.firstIn, @JsonKey(name: 'last_out') this.lastOut}): super._();
  factory _AttendanceStatusModel.fromJson(Map<String, dynamic> json) => _$AttendanceStatusModelFromJson(json);

@override@JsonKey(name: 'success') final  bool success;
@override@JsonKey(name: 'punched_in') final  bool punchedIn;
@override@JsonKey(name: 'first_in') final  String? firstIn;
@override@JsonKey(name: 'last_out') final  String? lastOut;

/// Create a copy of AttendanceStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceStatusModelCopyWith<_AttendanceStatusModel> get copyWith => __$AttendanceStatusModelCopyWithImpl<_AttendanceStatusModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceStatusModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceStatusModel&&(identical(other.success, success) || other.success == success)&&(identical(other.punchedIn, punchedIn) || other.punchedIn == punchedIn)&&(identical(other.firstIn, firstIn) || other.firstIn == firstIn)&&(identical(other.lastOut, lastOut) || other.lastOut == lastOut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,punchedIn,firstIn,lastOut);

@override
String toString() {
  return 'AttendanceStatusModel(success: $success, punchedIn: $punchedIn, firstIn: $firstIn, lastOut: $lastOut)';
}


}

/// @nodoc
abstract mixin class _$AttendanceStatusModelCopyWith<$Res> implements $AttendanceStatusModelCopyWith<$Res> {
  factory _$AttendanceStatusModelCopyWith(_AttendanceStatusModel value, $Res Function(_AttendanceStatusModel) _then) = __$AttendanceStatusModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'success') bool success,@JsonKey(name: 'punched_in') bool punchedIn,@JsonKey(name: 'first_in') String? firstIn,@JsonKey(name: 'last_out') String? lastOut
});




}
/// @nodoc
class __$AttendanceStatusModelCopyWithImpl<$Res>
    implements _$AttendanceStatusModelCopyWith<$Res> {
  __$AttendanceStatusModelCopyWithImpl(this._self, this._then);

  final _AttendanceStatusModel _self;
  final $Res Function(_AttendanceStatusModel) _then;

/// Create a copy of AttendanceStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? punchedIn = null,Object? firstIn = freezed,Object? lastOut = freezed,}) {
  return _then(_AttendanceStatusModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,punchedIn: null == punchedIn ? _self.punchedIn : punchedIn // ignore: cast_nullable_to_non_nullable
as bool,firstIn: freezed == firstIn ? _self.firstIn : firstIn // ignore: cast_nullable_to_non_nullable
as String?,lastOut: freezed == lastOut ? _self.lastOut : lastOut // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
