// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_type_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LeaveTypeEntity {

 String get name; String get leaveTypeName;
/// Create a copy of LeaveTypeEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveTypeEntityCopyWith<LeaveTypeEntity> get copyWith => _$LeaveTypeEntityCopyWithImpl<LeaveTypeEntity>(this as LeaveTypeEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveTypeEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.leaveTypeName, leaveTypeName) || other.leaveTypeName == leaveTypeName));
}


@override
int get hashCode => Object.hash(runtimeType,name,leaveTypeName);

@override
String toString() {
  return 'LeaveTypeEntity(name: $name, leaveTypeName: $leaveTypeName)';
}


}

/// @nodoc
abstract mixin class $LeaveTypeEntityCopyWith<$Res>  {
  factory $LeaveTypeEntityCopyWith(LeaveTypeEntity value, $Res Function(LeaveTypeEntity) _then) = _$LeaveTypeEntityCopyWithImpl;
@useResult
$Res call({
 String name, String leaveTypeName
});




}
/// @nodoc
class _$LeaveTypeEntityCopyWithImpl<$Res>
    implements $LeaveTypeEntityCopyWith<$Res> {
  _$LeaveTypeEntityCopyWithImpl(this._self, this._then);

  final LeaveTypeEntity _self;
  final $Res Function(LeaveTypeEntity) _then;

/// Create a copy of LeaveTypeEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? leaveTypeName = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,leaveTypeName: null == leaveTypeName ? _self.leaveTypeName : leaveTypeName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveTypeEntity].
extension LeaveTypeEntityPatterns on LeaveTypeEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveTypeEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveTypeEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveTypeEntity value)  $default,){
final _that = this;
switch (_that) {
case _LeaveTypeEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveTypeEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveTypeEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String leaveTypeName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveTypeEntity() when $default != null:
return $default(_that.name,_that.leaveTypeName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String leaveTypeName)  $default,) {final _that = this;
switch (_that) {
case _LeaveTypeEntity():
return $default(_that.name,_that.leaveTypeName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String leaveTypeName)?  $default,) {final _that = this;
switch (_that) {
case _LeaveTypeEntity() when $default != null:
return $default(_that.name,_that.leaveTypeName);case _:
  return null;

}
}

}

/// @nodoc


class _LeaveTypeEntity extends LeaveTypeEntity {
  const _LeaveTypeEntity({required this.name, required this.leaveTypeName}): super._();
  

@override final  String name;
@override final  String leaveTypeName;

/// Create a copy of LeaveTypeEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveTypeEntityCopyWith<_LeaveTypeEntity> get copyWith => __$LeaveTypeEntityCopyWithImpl<_LeaveTypeEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveTypeEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.leaveTypeName, leaveTypeName) || other.leaveTypeName == leaveTypeName));
}


@override
int get hashCode => Object.hash(runtimeType,name,leaveTypeName);

@override
String toString() {
  return 'LeaveTypeEntity(name: $name, leaveTypeName: $leaveTypeName)';
}


}

/// @nodoc
abstract mixin class _$LeaveTypeEntityCopyWith<$Res> implements $LeaveTypeEntityCopyWith<$Res> {
  factory _$LeaveTypeEntityCopyWith(_LeaveTypeEntity value, $Res Function(_LeaveTypeEntity) _then) = __$LeaveTypeEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String leaveTypeName
});




}
/// @nodoc
class __$LeaveTypeEntityCopyWithImpl<$Res>
    implements _$LeaveTypeEntityCopyWith<$Res> {
  __$LeaveTypeEntityCopyWithImpl(this._self, this._then);

  final _LeaveTypeEntity _self;
  final $Res Function(_LeaveTypeEntity) _then;

/// Create a copy of LeaveTypeEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? leaveTypeName = null,}) {
  return _then(_LeaveTypeEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,leaveTypeName: null == leaveTypeName ? _self.leaveTypeName : leaveTypeName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
