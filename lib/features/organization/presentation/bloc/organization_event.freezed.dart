// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrganizationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrganizationEvent()';
}


}

/// @nodoc
class $OrganizationEventCopyWith<$Res>  {
$OrganizationEventCopyWith(OrganizationEvent _, $Res Function(OrganizationEvent) __);
}


/// Adds pattern-matching-related methods to [OrganizationEvent].
extension OrganizationEventPatterns on OrganizationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _LoadOrganizationsRequested value)?  loadOrganizationsRequested,TResult Function( _LoadChartRequested value)?  loadChartRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadOrganizationsRequested() when loadOrganizationsRequested != null:
return loadOrganizationsRequested(_that);case _LoadChartRequested() when loadChartRequested != null:
return loadChartRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _LoadOrganizationsRequested value)  loadOrganizationsRequested,required TResult Function( _LoadChartRequested value)  loadChartRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _LoadOrganizationsRequested():
return loadOrganizationsRequested(_that);case _LoadChartRequested():
return loadChartRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _LoadOrganizationsRequested value)?  loadOrganizationsRequested,TResult? Function( _LoadChartRequested value)?  loadChartRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadOrganizationsRequested() when loadOrganizationsRequested != null:
return loadOrganizationsRequested(_that);case _LoadChartRequested() when loadChartRequested != null:
return loadChartRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  loadOrganizationsRequested,TResult Function()?  loadChartRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoadOrganizationsRequested() when loadOrganizationsRequested != null:
return loadOrganizationsRequested();case _LoadChartRequested() when loadChartRequested != null:
return loadChartRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  loadOrganizationsRequested,required TResult Function()  loadChartRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _LoadOrganizationsRequested():
return loadOrganizationsRequested();case _LoadChartRequested():
return loadChartRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  loadOrganizationsRequested,TResult? Function()?  loadChartRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoadOrganizationsRequested() when loadOrganizationsRequested != null:
return loadOrganizationsRequested();case _LoadChartRequested() when loadChartRequested != null:
return loadChartRequested();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements OrganizationEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrganizationEvent.started()';
}


}




/// @nodoc


class _LoadOrganizationsRequested implements OrganizationEvent {
  const _LoadOrganizationsRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadOrganizationsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrganizationEvent.loadOrganizationsRequested()';
}


}




/// @nodoc


class _LoadChartRequested implements OrganizationEvent {
  const _LoadChartRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadChartRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrganizationEvent.loadChartRequested()';
}


}




// dart format on
