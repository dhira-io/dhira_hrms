// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performance_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PerformanceEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PerformanceEvent()';
}


}

/// @nodoc
class $PerformanceEventCopyWith<$Res>  {
$PerformanceEventCopyWith(PerformanceEvent _, $Res Function(PerformanceEvent) __);
}


/// Adds pattern-matching-related methods to [PerformanceEvent].
extension PerformanceEventPatterns on PerformanceEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PerformanceStarted value)?  started,TResult Function( PerformanceFetchRequested value)?  fetchRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PerformanceStarted() when started != null:
return started(_that);case PerformanceFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PerformanceStarted value)  started,required TResult Function( PerformanceFetchRequested value)  fetchRequested,}){
final _that = this;
switch (_that) {
case PerformanceStarted():
return started(_that);case PerformanceFetchRequested():
return fetchRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PerformanceStarted value)?  started,TResult? Function( PerformanceFetchRequested value)?  fetchRequested,}){
final _that = this;
switch (_that) {
case PerformanceStarted() when started != null:
return started(_that);case PerformanceFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String employeeId)?  fetchRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PerformanceStarted() when started != null:
return started();case PerformanceFetchRequested() when fetchRequested != null:
return fetchRequested(_that.employeeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String employeeId)  fetchRequested,}) {final _that = this;
switch (_that) {
case PerformanceStarted():
return started();case PerformanceFetchRequested():
return fetchRequested(_that.employeeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String employeeId)?  fetchRequested,}) {final _that = this;
switch (_that) {
case PerformanceStarted() when started != null:
return started();case PerformanceFetchRequested() when fetchRequested != null:
return fetchRequested(_that.employeeId);case _:
  return null;

}
}

}

/// @nodoc


class PerformanceStarted implements PerformanceEvent {
  const PerformanceStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PerformanceEvent.started()';
}


}




/// @nodoc


class PerformanceFetchRequested implements PerformanceEvent {
  const PerformanceFetchRequested(this.employeeId);
  

 final  String employeeId;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceFetchRequestedCopyWith<PerformanceFetchRequested> get copyWith => _$PerformanceFetchRequestedCopyWithImpl<PerformanceFetchRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceFetchRequested&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId));
}


@override
int get hashCode => Object.hash(runtimeType,employeeId);

@override
String toString() {
  return 'PerformanceEvent.fetchRequested(employeeId: $employeeId)';
}


}

/// @nodoc
abstract mixin class $PerformanceFetchRequestedCopyWith<$Res> implements $PerformanceEventCopyWith<$Res> {
  factory $PerformanceFetchRequestedCopyWith(PerformanceFetchRequested value, $Res Function(PerformanceFetchRequested) _then) = _$PerformanceFetchRequestedCopyWithImpl;
@useResult
$Res call({
 String employeeId
});




}
/// @nodoc
class _$PerformanceFetchRequestedCopyWithImpl<$Res>
    implements $PerformanceFetchRequestedCopyWith<$Res> {
  _$PerformanceFetchRequestedCopyWithImpl(this._self, this._then);

  final PerformanceFetchRequested _self;
  final $Res Function(PerformanceFetchRequested) _then;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? employeeId = null,}) {
  return _then(PerformanceFetchRequested(
null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
