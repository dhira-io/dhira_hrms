// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrganizationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrganizationState()';
}


}

/// @nodoc
class $OrganizationStateCopyWith<$Res>  {
$OrganizationStateCopyWith(OrganizationState _, $Res Function(OrganizationState) __);
}


/// Adds pattern-matching-related methods to [OrganizationState].
extension OrganizationStatePatterns on OrganizationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _OrganizationsLoaded value)?  organizationsLoaded,TResult Function( _ChartLoaded value)?  chartLoaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _OrganizationsLoaded() when organizationsLoaded != null:
return organizationsLoaded(_that);case _ChartLoaded() when chartLoaded != null:
return chartLoaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _OrganizationsLoaded value)  organizationsLoaded,required TResult Function( _ChartLoaded value)  chartLoaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _OrganizationsLoaded():
return organizationsLoaded(_that);case _ChartLoaded():
return chartLoaded(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _OrganizationsLoaded value)?  organizationsLoaded,TResult? Function( _ChartLoaded value)?  chartLoaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _OrganizationsLoaded() when organizationsLoaded != null:
return organizationsLoaded(_that);case _ChartLoaded() when chartLoaded != null:
return chartLoaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<OrganizationEntity> organizations)?  organizationsLoaded,TResult Function( OrgChartNodeEntity rootNode)?  chartLoaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _OrganizationsLoaded() when organizationsLoaded != null:
return organizationsLoaded(_that.organizations);case _ChartLoaded() when chartLoaded != null:
return chartLoaded(_that.rootNode);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<OrganizationEntity> organizations)  organizationsLoaded,required TResult Function( OrgChartNodeEntity rootNode)  chartLoaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _OrganizationsLoaded():
return organizationsLoaded(_that.organizations);case _ChartLoaded():
return chartLoaded(_that.rootNode);case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<OrganizationEntity> organizations)?  organizationsLoaded,TResult? Function( OrgChartNodeEntity rootNode)?  chartLoaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _OrganizationsLoaded() when organizationsLoaded != null:
return organizationsLoaded(_that.organizations);case _ChartLoaded() when chartLoaded != null:
return chartLoaded(_that.rootNode);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements OrganizationState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrganizationState.initial()';
}


}




/// @nodoc


class _Loading implements OrganizationState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrganizationState.loading()';
}


}




/// @nodoc


class _OrganizationsLoaded implements OrganizationState {
  const _OrganizationsLoaded(final  List<OrganizationEntity> organizations): _organizations = organizations;
  

 final  List<OrganizationEntity> _organizations;
 List<OrganizationEntity> get organizations {
  if (_organizations is EqualUnmodifiableListView) return _organizations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_organizations);
}


/// Create a copy of OrganizationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrganizationsLoadedCopyWith<_OrganizationsLoaded> get copyWith => __$OrganizationsLoadedCopyWithImpl<_OrganizationsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrganizationsLoaded&&const DeepCollectionEquality().equals(other._organizations, _organizations));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_organizations));

@override
String toString() {
  return 'OrganizationState.organizationsLoaded(organizations: $organizations)';
}


}

/// @nodoc
abstract mixin class _$OrganizationsLoadedCopyWith<$Res> implements $OrganizationStateCopyWith<$Res> {
  factory _$OrganizationsLoadedCopyWith(_OrganizationsLoaded value, $Res Function(_OrganizationsLoaded) _then) = __$OrganizationsLoadedCopyWithImpl;
@useResult
$Res call({
 List<OrganizationEntity> organizations
});




}
/// @nodoc
class __$OrganizationsLoadedCopyWithImpl<$Res>
    implements _$OrganizationsLoadedCopyWith<$Res> {
  __$OrganizationsLoadedCopyWithImpl(this._self, this._then);

  final _OrganizationsLoaded _self;
  final $Res Function(_OrganizationsLoaded) _then;

/// Create a copy of OrganizationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? organizations = null,}) {
  return _then(_OrganizationsLoaded(
null == organizations ? _self._organizations : organizations // ignore: cast_nullable_to_non_nullable
as List<OrganizationEntity>,
  ));
}


}

/// @nodoc


class _ChartLoaded implements OrganizationState {
  const _ChartLoaded(this.rootNode);
  

 final  OrgChartNodeEntity rootNode;

/// Create a copy of OrganizationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChartLoadedCopyWith<_ChartLoaded> get copyWith => __$ChartLoadedCopyWithImpl<_ChartLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChartLoaded&&(identical(other.rootNode, rootNode) || other.rootNode == rootNode));
}


@override
int get hashCode => Object.hash(runtimeType,rootNode);

@override
String toString() {
  return 'OrganizationState.chartLoaded(rootNode: $rootNode)';
}


}

/// @nodoc
abstract mixin class _$ChartLoadedCopyWith<$Res> implements $OrganizationStateCopyWith<$Res> {
  factory _$ChartLoadedCopyWith(_ChartLoaded value, $Res Function(_ChartLoaded) _then) = __$ChartLoadedCopyWithImpl;
@useResult
$Res call({
 OrgChartNodeEntity rootNode
});


$OrgChartNodeEntityCopyWith<$Res> get rootNode;

}
/// @nodoc
class __$ChartLoadedCopyWithImpl<$Res>
    implements _$ChartLoadedCopyWith<$Res> {
  __$ChartLoadedCopyWithImpl(this._self, this._then);

  final _ChartLoaded _self;
  final $Res Function(_ChartLoaded) _then;

/// Create a copy of OrganizationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rootNode = null,}) {
  return _then(_ChartLoaded(
null == rootNode ? _self.rootNode : rootNode // ignore: cast_nullable_to_non_nullable
as OrgChartNodeEntity,
  ));
}

/// Create a copy of OrganizationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrgChartNodeEntityCopyWith<$Res> get rootNode {
  
  return $OrgChartNodeEntityCopyWith<$Res>(_self.rootNode, (value) {
    return _then(_self.copyWith(rootNode: value));
  });
}
}

/// @nodoc


class _Error implements OrganizationState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of OrganizationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OrganizationState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $OrganizationStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of OrganizationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
