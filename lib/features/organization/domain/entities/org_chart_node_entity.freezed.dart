// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'org_chart_node_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrgChartNodeEntity {

 String get id; String get name; String get role; List<OrgChartNodeEntity> get children;
/// Create a copy of OrgChartNodeEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrgChartNodeEntityCopyWith<OrgChartNodeEntity> get copyWith => _$OrgChartNodeEntityCopyWithImpl<OrgChartNodeEntity>(this as OrgChartNodeEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrgChartNodeEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other.children, children));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,role,const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'OrgChartNodeEntity(id: $id, name: $name, role: $role, children: $children)';
}


}

/// @nodoc
abstract mixin class $OrgChartNodeEntityCopyWith<$Res>  {
  factory $OrgChartNodeEntityCopyWith(OrgChartNodeEntity value, $Res Function(OrgChartNodeEntity) _then) = _$OrgChartNodeEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String role, List<OrgChartNodeEntity> children
});




}
/// @nodoc
class _$OrgChartNodeEntityCopyWithImpl<$Res>
    implements $OrgChartNodeEntityCopyWith<$Res> {
  _$OrgChartNodeEntityCopyWithImpl(this._self, this._then);

  final OrgChartNodeEntity _self;
  final $Res Function(OrgChartNodeEntity) _then;

/// Create a copy of OrgChartNodeEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? role = null,Object? children = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<OrgChartNodeEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [OrgChartNodeEntity].
extension OrgChartNodeEntityPatterns on OrgChartNodeEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrgChartNodeEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrgChartNodeEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrgChartNodeEntity value)  $default,){
final _that = this;
switch (_that) {
case _OrgChartNodeEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrgChartNodeEntity value)?  $default,){
final _that = this;
switch (_that) {
case _OrgChartNodeEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String role,  List<OrgChartNodeEntity> children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrgChartNodeEntity() when $default != null:
return $default(_that.id,_that.name,_that.role,_that.children);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String role,  List<OrgChartNodeEntity> children)  $default,) {final _that = this;
switch (_that) {
case _OrgChartNodeEntity():
return $default(_that.id,_that.name,_that.role,_that.children);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String role,  List<OrgChartNodeEntity> children)?  $default,) {final _that = this;
switch (_that) {
case _OrgChartNodeEntity() when $default != null:
return $default(_that.id,_that.name,_that.role,_that.children);case _:
  return null;

}
}

}

/// @nodoc


class _OrgChartNodeEntity implements OrgChartNodeEntity {
  const _OrgChartNodeEntity({required this.id, required this.name, required this.role, final  List<OrgChartNodeEntity> children = const []}): _children = children;
  

@override final  String id;
@override final  String name;
@override final  String role;
 final  List<OrgChartNodeEntity> _children;
@override@JsonKey() List<OrgChartNodeEntity> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}


/// Create a copy of OrgChartNodeEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrgChartNodeEntityCopyWith<_OrgChartNodeEntity> get copyWith => __$OrgChartNodeEntityCopyWithImpl<_OrgChartNodeEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrgChartNodeEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other._children, _children));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,role,const DeepCollectionEquality().hash(_children));

@override
String toString() {
  return 'OrgChartNodeEntity(id: $id, name: $name, role: $role, children: $children)';
}


}

/// @nodoc
abstract mixin class _$OrgChartNodeEntityCopyWith<$Res> implements $OrgChartNodeEntityCopyWith<$Res> {
  factory _$OrgChartNodeEntityCopyWith(_OrgChartNodeEntity value, $Res Function(_OrgChartNodeEntity) _then) = __$OrgChartNodeEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String role, List<OrgChartNodeEntity> children
});




}
/// @nodoc
class __$OrgChartNodeEntityCopyWithImpl<$Res>
    implements _$OrgChartNodeEntityCopyWith<$Res> {
  __$OrgChartNodeEntityCopyWithImpl(this._self, this._then);

  final _OrgChartNodeEntity _self;
  final $Res Function(_OrgChartNodeEntity) _then;

/// Create a copy of OrgChartNodeEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? role = null,Object? children = null,}) {
  return _then(_OrgChartNodeEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<OrgChartNodeEntity>,
  ));
}


}

// dart format on
