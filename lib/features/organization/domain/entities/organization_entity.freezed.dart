// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrganizationEntity {

 String get id; String get name; String get department; String get location; int get employeeCount;
/// Create a copy of OrganizationEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizationEntityCopyWith<OrganizationEntity> get copyWith => _$OrganizationEntityCopyWithImpl<OrganizationEntity>(this as OrganizationEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizationEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.department, department) || other.department == department)&&(identical(other.location, location) || other.location == location)&&(identical(other.employeeCount, employeeCount) || other.employeeCount == employeeCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,department,location,employeeCount);

@override
String toString() {
  return 'OrganizationEntity(id: $id, name: $name, department: $department, location: $location, employeeCount: $employeeCount)';
}


}

/// @nodoc
abstract mixin class $OrganizationEntityCopyWith<$Res>  {
  factory $OrganizationEntityCopyWith(OrganizationEntity value, $Res Function(OrganizationEntity) _then) = _$OrganizationEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String department, String location, int employeeCount
});




}
/// @nodoc
class _$OrganizationEntityCopyWithImpl<$Res>
    implements $OrganizationEntityCopyWith<$Res> {
  _$OrganizationEntityCopyWithImpl(this._self, this._then);

  final OrganizationEntity _self;
  final $Res Function(OrganizationEntity) _then;

/// Create a copy of OrganizationEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? department = null,Object? location = null,Object? employeeCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,employeeCount: null == employeeCount ? _self.employeeCount : employeeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OrganizationEntity].
extension OrganizationEntityPatterns on OrganizationEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrganizationEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrganizationEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrganizationEntity value)  $default,){
final _that = this;
switch (_that) {
case _OrganizationEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrganizationEntity value)?  $default,){
final _that = this;
switch (_that) {
case _OrganizationEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String department,  String location,  int employeeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrganizationEntity() when $default != null:
return $default(_that.id,_that.name,_that.department,_that.location,_that.employeeCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String department,  String location,  int employeeCount)  $default,) {final _that = this;
switch (_that) {
case _OrganizationEntity():
return $default(_that.id,_that.name,_that.department,_that.location,_that.employeeCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String department,  String location,  int employeeCount)?  $default,) {final _that = this;
switch (_that) {
case _OrganizationEntity() when $default != null:
return $default(_that.id,_that.name,_that.department,_that.location,_that.employeeCount);case _:
  return null;

}
}

}

/// @nodoc


class _OrganizationEntity implements OrganizationEntity {
  const _OrganizationEntity({required this.id, required this.name, required this.department, required this.location, required this.employeeCount});
  

@override final  String id;
@override final  String name;
@override final  String department;
@override final  String location;
@override final  int employeeCount;

/// Create a copy of OrganizationEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrganizationEntityCopyWith<_OrganizationEntity> get copyWith => __$OrganizationEntityCopyWithImpl<_OrganizationEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrganizationEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.department, department) || other.department == department)&&(identical(other.location, location) || other.location == location)&&(identical(other.employeeCount, employeeCount) || other.employeeCount == employeeCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,department,location,employeeCount);

@override
String toString() {
  return 'OrganizationEntity(id: $id, name: $name, department: $department, location: $location, employeeCount: $employeeCount)';
}


}

/// @nodoc
abstract mixin class _$OrganizationEntityCopyWith<$Res> implements $OrganizationEntityCopyWith<$Res> {
  factory _$OrganizationEntityCopyWith(_OrganizationEntity value, $Res Function(_OrganizationEntity) _then) = __$OrganizationEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String department, String location, int employeeCount
});




}
/// @nodoc
class __$OrganizationEntityCopyWithImpl<$Res>
    implements _$OrganizationEntityCopyWith<$Res> {
  __$OrganizationEntityCopyWithImpl(this._self, this._then);

  final _OrganizationEntity _self;
  final $Res Function(_OrganizationEntity) _then;

/// Create a copy of OrganizationEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? department = null,Object? location = null,Object? employeeCount = null,}) {
  return _then(_OrganizationEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,employeeCount: null == employeeCount ? _self.employeeCount : employeeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
