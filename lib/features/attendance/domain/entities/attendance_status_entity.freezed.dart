// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_status_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttendanceStatusEntity {

 bool get success; bool get punchedIn; bool get onBreak; bool get dayEnded; String? get firstIn; String? get lastOut; String? get message;
/// Create a copy of AttendanceStatusEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceStatusEntityCopyWith<AttendanceStatusEntity> get copyWith => _$AttendanceStatusEntityCopyWithImpl<AttendanceStatusEntity>(this as AttendanceStatusEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceStatusEntity&&(identical(other.success, success) || other.success == success)&&(identical(other.punchedIn, punchedIn) || other.punchedIn == punchedIn)&&(identical(other.onBreak, onBreak) || other.onBreak == onBreak)&&(identical(other.dayEnded, dayEnded) || other.dayEnded == dayEnded)&&(identical(other.firstIn, firstIn) || other.firstIn == firstIn)&&(identical(other.lastOut, lastOut) || other.lastOut == lastOut)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,success,punchedIn,onBreak,dayEnded,firstIn,lastOut,message);

@override
String toString() {
  return 'AttendanceStatusEntity(success: $success, punchedIn: $punchedIn, onBreak: $onBreak, dayEnded: $dayEnded, firstIn: $firstIn, lastOut: $lastOut, message: $message)';
}


}

/// @nodoc
abstract mixin class $AttendanceStatusEntityCopyWith<$Res>  {
  factory $AttendanceStatusEntityCopyWith(AttendanceStatusEntity value, $Res Function(AttendanceStatusEntity) _then) = _$AttendanceStatusEntityCopyWithImpl;
@useResult
$Res call({
 bool success, bool punchedIn, bool onBreak, bool dayEnded, String? firstIn, String? lastOut, String? message
});




}
/// @nodoc
class _$AttendanceStatusEntityCopyWithImpl<$Res>
    implements $AttendanceStatusEntityCopyWith<$Res> {
  _$AttendanceStatusEntityCopyWithImpl(this._self, this._then);

  final AttendanceStatusEntity _self;
  final $Res Function(AttendanceStatusEntity) _then;

/// Create a copy of AttendanceStatusEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? punchedIn = null,Object? onBreak = null,Object? dayEnded = null,Object? firstIn = freezed,Object? lastOut = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,punchedIn: null == punchedIn ? _self.punchedIn : punchedIn // ignore: cast_nullable_to_non_nullable
as bool,onBreak: null == onBreak ? _self.onBreak : onBreak // ignore: cast_nullable_to_non_nullable
as bool,dayEnded: null == dayEnded ? _self.dayEnded : dayEnded // ignore: cast_nullable_to_non_nullable
as bool,firstIn: freezed == firstIn ? _self.firstIn : firstIn // ignore: cast_nullable_to_non_nullable
as String?,lastOut: freezed == lastOut ? _self.lastOut : lastOut // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceStatusEntity].
extension AttendanceStatusEntityPatterns on AttendanceStatusEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceStatusEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceStatusEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceStatusEntity value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceStatusEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceStatusEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceStatusEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  bool punchedIn,  bool onBreak,  bool dayEnded,  String? firstIn,  String? lastOut,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceStatusEntity() when $default != null:
return $default(_that.success,_that.punchedIn,_that.onBreak,_that.dayEnded,_that.firstIn,_that.lastOut,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  bool punchedIn,  bool onBreak,  bool dayEnded,  String? firstIn,  String? lastOut,  String? message)  $default,) {final _that = this;
switch (_that) {
case _AttendanceStatusEntity():
return $default(_that.success,_that.punchedIn,_that.onBreak,_that.dayEnded,_that.firstIn,_that.lastOut,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  bool punchedIn,  bool onBreak,  bool dayEnded,  String? firstIn,  String? lastOut,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceStatusEntity() when $default != null:
return $default(_that.success,_that.punchedIn,_that.onBreak,_that.dayEnded,_that.firstIn,_that.lastOut,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _AttendanceStatusEntity extends AttendanceStatusEntity {
  const _AttendanceStatusEntity({required this.success, required this.punchedIn, required this.onBreak, required this.dayEnded, this.firstIn, this.lastOut, this.message}): super._();
  

@override final  bool success;
@override final  bool punchedIn;
@override final  bool onBreak;
@override final  bool dayEnded;
@override final  String? firstIn;
@override final  String? lastOut;
@override final  String? message;

/// Create a copy of AttendanceStatusEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceStatusEntityCopyWith<_AttendanceStatusEntity> get copyWith => __$AttendanceStatusEntityCopyWithImpl<_AttendanceStatusEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceStatusEntity&&(identical(other.success, success) || other.success == success)&&(identical(other.punchedIn, punchedIn) || other.punchedIn == punchedIn)&&(identical(other.onBreak, onBreak) || other.onBreak == onBreak)&&(identical(other.dayEnded, dayEnded) || other.dayEnded == dayEnded)&&(identical(other.firstIn, firstIn) || other.firstIn == firstIn)&&(identical(other.lastOut, lastOut) || other.lastOut == lastOut)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,success,punchedIn,onBreak,dayEnded,firstIn,lastOut,message);

@override
String toString() {
  return 'AttendanceStatusEntity(success: $success, punchedIn: $punchedIn, onBreak: $onBreak, dayEnded: $dayEnded, firstIn: $firstIn, lastOut: $lastOut, message: $message)';
}


}

/// @nodoc
abstract mixin class _$AttendanceStatusEntityCopyWith<$Res> implements $AttendanceStatusEntityCopyWith<$Res> {
  factory _$AttendanceStatusEntityCopyWith(_AttendanceStatusEntity value, $Res Function(_AttendanceStatusEntity) _then) = __$AttendanceStatusEntityCopyWithImpl;
@override @useResult
$Res call({
 bool success, bool punchedIn, bool onBreak, bool dayEnded, String? firstIn, String? lastOut, String? message
});




}
/// @nodoc
class __$AttendanceStatusEntityCopyWithImpl<$Res>
    implements _$AttendanceStatusEntityCopyWith<$Res> {
  __$AttendanceStatusEntityCopyWithImpl(this._self, this._then);

  final _AttendanceStatusEntity _self;
  final $Res Function(_AttendanceStatusEntity) _then;

/// Create a copy of AttendanceStatusEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? punchedIn = null,Object? onBreak = null,Object? dayEnded = null,Object? firstIn = freezed,Object? lastOut = freezed,Object? message = freezed,}) {
  return _then(_AttendanceStatusEntity(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,punchedIn: null == punchedIn ? _self.punchedIn : punchedIn // ignore: cast_nullable_to_non_nullable
as bool,onBreak: null == onBreak ? _self.onBreak : onBreak // ignore: cast_nullable_to_non_nullable
as bool,dayEnded: null == dayEnded ? _self.dayEnded : dayEnded // ignore: cast_nullable_to_non_nullable
as bool,firstIn: freezed == firstIn ? _self.firstIn : firstIn // ignore: cast_nullable_to_non_nullable
as String?,lastOut: freezed == lastOut ? _self.lastOut : lastOut // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
