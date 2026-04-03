// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectEntity {

 String get name; String get projectName;
/// Create a copy of ProjectEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectEntityCopyWith<ProjectEntity> get copyWith => _$ProjectEntityCopyWithImpl<ProjectEntity>(this as ProjectEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.projectName, projectName) || other.projectName == projectName));
}


@override
int get hashCode => Object.hash(runtimeType,name,projectName);

@override
String toString() {
  return 'ProjectEntity(name: $name, projectName: $projectName)';
}


}

/// @nodoc
abstract mixin class $ProjectEntityCopyWith<$Res>  {
  factory $ProjectEntityCopyWith(ProjectEntity value, $Res Function(ProjectEntity) _then) = _$ProjectEntityCopyWithImpl;
@useResult
$Res call({
 String name, String projectName
});




}
/// @nodoc
class _$ProjectEntityCopyWithImpl<$Res>
    implements $ProjectEntityCopyWith<$Res> {
  _$ProjectEntityCopyWithImpl(this._self, this._then);

  final ProjectEntity _self;
  final $Res Function(ProjectEntity) _then;

/// Create a copy of ProjectEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? projectName = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectEntity].
extension ProjectEntityPatterns on ProjectEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProjectEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String projectName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectEntity() when $default != null:
return $default(_that.name,_that.projectName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String projectName)  $default,) {final _that = this;
switch (_that) {
case _ProjectEntity():
return $default(_that.name,_that.projectName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String projectName)?  $default,) {final _that = this;
switch (_that) {
case _ProjectEntity() when $default != null:
return $default(_that.name,_that.projectName);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectEntity extends ProjectEntity {
  const _ProjectEntity({required this.name, required this.projectName}): super._();
  

@override final  String name;
@override final  String projectName;

/// Create a copy of ProjectEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectEntityCopyWith<_ProjectEntity> get copyWith => __$ProjectEntityCopyWithImpl<_ProjectEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.projectName, projectName) || other.projectName == projectName));
}


@override
int get hashCode => Object.hash(runtimeType,name,projectName);

@override
String toString() {
  return 'ProjectEntity(name: $name, projectName: $projectName)';
}


}

/// @nodoc
abstract mixin class _$ProjectEntityCopyWith<$Res> implements $ProjectEntityCopyWith<$Res> {
  factory _$ProjectEntityCopyWith(_ProjectEntity value, $Res Function(_ProjectEntity) _then) = __$ProjectEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String projectName
});




}
/// @nodoc
class __$ProjectEntityCopyWithImpl<$Res>
    implements _$ProjectEntityCopyWith<$Res> {
  __$ProjectEntityCopyWithImpl(this._self, this._then);

  final _ProjectEntity _self;
  final $Res Function(_ProjectEntity) _then;

/// Create a copy of ProjectEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? projectName = null,}) {
  return _then(_ProjectEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
