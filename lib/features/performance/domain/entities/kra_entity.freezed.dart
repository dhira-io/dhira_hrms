// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kra_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KraEntity {

 String get name; double get weightage;
/// Create a copy of KraEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KraEntityCopyWith<KraEntity> get copyWith => _$KraEntityCopyWithImpl<KraEntity>(this as KraEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KraEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.weightage, weightage) || other.weightage == weightage));
}


@override
int get hashCode => Object.hash(runtimeType,name,weightage);

@override
String toString() {
  return 'KraEntity(name: $name, weightage: $weightage)';
}


}

/// @nodoc
abstract mixin class $KraEntityCopyWith<$Res>  {
  factory $KraEntityCopyWith(KraEntity value, $Res Function(KraEntity) _then) = _$KraEntityCopyWithImpl;
@useResult
$Res call({
 String name, double weightage
});




}
/// @nodoc
class _$KraEntityCopyWithImpl<$Res>
    implements $KraEntityCopyWith<$Res> {
  _$KraEntityCopyWithImpl(this._self, this._then);

  final KraEntity _self;
  final $Res Function(KraEntity) _then;

/// Create a copy of KraEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? weightage = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,weightage: null == weightage ? _self.weightage : weightage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [KraEntity].
extension KraEntityPatterns on KraEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KraEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KraEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KraEntity value)  $default,){
final _that = this;
switch (_that) {
case _KraEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KraEntity value)?  $default,){
final _that = this;
switch (_that) {
case _KraEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  double weightage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KraEntity() when $default != null:
return $default(_that.name,_that.weightage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  double weightage)  $default,) {final _that = this;
switch (_that) {
case _KraEntity():
return $default(_that.name,_that.weightage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  double weightage)?  $default,) {final _that = this;
switch (_that) {
case _KraEntity() when $default != null:
return $default(_that.name,_that.weightage);case _:
  return null;

}
}

}

/// @nodoc


class _KraEntity implements KraEntity {
  const _KraEntity({required this.name, this.weightage = 0.0});
  

@override final  String name;
@override@JsonKey() final  double weightage;

/// Create a copy of KraEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KraEntityCopyWith<_KraEntity> get copyWith => __$KraEntityCopyWithImpl<_KraEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KraEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.weightage, weightage) || other.weightage == weightage));
}


@override
int get hashCode => Object.hash(runtimeType,name,weightage);

@override
String toString() {
  return 'KraEntity(name: $name, weightage: $weightage)';
}


}

/// @nodoc
abstract mixin class _$KraEntityCopyWith<$Res> implements $KraEntityCopyWith<$Res> {
  factory _$KraEntityCopyWith(_KraEntity value, $Res Function(_KraEntity) _then) = __$KraEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, double weightage
});




}
/// @nodoc
class __$KraEntityCopyWithImpl<$Res>
    implements _$KraEntityCopyWith<$Res> {
  __$KraEntityCopyWithImpl(this._self, this._then);

  final _KraEntity _self;
  final $Res Function(_KraEntity) _then;

/// Create a copy of KraEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? weightage = null,}) {
  return _then(_KraEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,weightage: null == weightage ? _self.weightage : weightage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
