// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approvals_access_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApprovalsAccessEntity {

 bool get canAccess;
/// Create a copy of ApprovalsAccessEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApprovalsAccessEntityCopyWith<ApprovalsAccessEntity> get copyWith => _$ApprovalsAccessEntityCopyWithImpl<ApprovalsAccessEntity>(this as ApprovalsAccessEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApprovalsAccessEntity&&(identical(other.canAccess, canAccess) || other.canAccess == canAccess));
}


@override
int get hashCode => Object.hash(runtimeType,canAccess);

@override
String toString() {
  return 'ApprovalsAccessEntity(canAccess: $canAccess)';
}


}

/// @nodoc
abstract mixin class $ApprovalsAccessEntityCopyWith<$Res>  {
  factory $ApprovalsAccessEntityCopyWith(ApprovalsAccessEntity value, $Res Function(ApprovalsAccessEntity) _then) = _$ApprovalsAccessEntityCopyWithImpl;
@useResult
$Res call({
 bool canAccess
});




}
/// @nodoc
class _$ApprovalsAccessEntityCopyWithImpl<$Res>
    implements $ApprovalsAccessEntityCopyWith<$Res> {
  _$ApprovalsAccessEntityCopyWithImpl(this._self, this._then);

  final ApprovalsAccessEntity _self;
  final $Res Function(ApprovalsAccessEntity) _then;

/// Create a copy of ApprovalsAccessEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? canAccess = null,}) {
  return _then(_self.copyWith(
canAccess: null == canAccess ? _self.canAccess : canAccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ApprovalsAccessEntity].
extension ApprovalsAccessEntityPatterns on ApprovalsAccessEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApprovalsAccessEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApprovalsAccessEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApprovalsAccessEntity value)  $default,){
final _that = this;
switch (_that) {
case _ApprovalsAccessEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApprovalsAccessEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ApprovalsAccessEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool canAccess)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApprovalsAccessEntity() when $default != null:
return $default(_that.canAccess);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool canAccess)  $default,) {final _that = this;
switch (_that) {
case _ApprovalsAccessEntity():
return $default(_that.canAccess);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool canAccess)?  $default,) {final _that = this;
switch (_that) {
case _ApprovalsAccessEntity() when $default != null:
return $default(_that.canAccess);case _:
  return null;

}
}

}

/// @nodoc


class _ApprovalsAccessEntity implements ApprovalsAccessEntity {
  const _ApprovalsAccessEntity({required this.canAccess});
  

@override final  bool canAccess;

/// Create a copy of ApprovalsAccessEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApprovalsAccessEntityCopyWith<_ApprovalsAccessEntity> get copyWith => __$ApprovalsAccessEntityCopyWithImpl<_ApprovalsAccessEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApprovalsAccessEntity&&(identical(other.canAccess, canAccess) || other.canAccess == canAccess));
}


@override
int get hashCode => Object.hash(runtimeType,canAccess);

@override
String toString() {
  return 'ApprovalsAccessEntity(canAccess: $canAccess)';
}


}

/// @nodoc
abstract mixin class _$ApprovalsAccessEntityCopyWith<$Res> implements $ApprovalsAccessEntityCopyWith<$Res> {
  factory _$ApprovalsAccessEntityCopyWith(_ApprovalsAccessEntity value, $Res Function(_ApprovalsAccessEntity) _then) = __$ApprovalsAccessEntityCopyWithImpl;
@override @useResult
$Res call({
 bool canAccess
});




}
/// @nodoc
class __$ApprovalsAccessEntityCopyWithImpl<$Res>
    implements _$ApprovalsAccessEntityCopyWith<$Res> {
  __$ApprovalsAccessEntityCopyWithImpl(this._self, this._then);

  final _ApprovalsAccessEntity _self;
  final $Res Function(_ApprovalsAccessEntity) _then;

/// Create a copy of ApprovalsAccessEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? canAccess = null,}) {
  return _then(_ApprovalsAccessEntity(
canAccess: null == canAccess ? _self.canAccess : canAccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
