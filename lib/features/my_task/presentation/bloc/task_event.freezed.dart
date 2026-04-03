// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskEvent()';
}


}

/// @nodoc
class $TaskEventCopyWith<$Res>  {
$TaskEventCopyWith(TaskEvent _, $Res Function(TaskEvent) __);
}


/// Adds pattern-matching-related methods to [TaskEvent].
extension TaskEventPatterns on TaskEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _LoadTasksRequested value)?  loadTasksRequested,TResult Function( _LoadMoreTasksRequested value)?  loadMoreTasksRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadTasksRequested() when loadTasksRequested != null:
return loadTasksRequested(_that);case _LoadMoreTasksRequested() when loadMoreTasksRequested != null:
return loadMoreTasksRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _LoadTasksRequested value)  loadTasksRequested,required TResult Function( _LoadMoreTasksRequested value)  loadMoreTasksRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _LoadTasksRequested():
return loadTasksRequested(_that);case _LoadMoreTasksRequested():
return loadMoreTasksRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _LoadTasksRequested value)?  loadTasksRequested,TResult? Function( _LoadMoreTasksRequested value)?  loadMoreTasksRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadTasksRequested() when loadTasksRequested != null:
return loadTasksRequested(_that);case _LoadMoreTasksRequested() when loadMoreTasksRequested != null:
return loadMoreTasksRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( bool isRefresh)?  loadTasksRequested,TResult Function()?  loadMoreTasksRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoadTasksRequested() when loadTasksRequested != null:
return loadTasksRequested(_that.isRefresh);case _LoadMoreTasksRequested() when loadMoreTasksRequested != null:
return loadMoreTasksRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( bool isRefresh)  loadTasksRequested,required TResult Function()  loadMoreTasksRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _LoadTasksRequested():
return loadTasksRequested(_that.isRefresh);case _LoadMoreTasksRequested():
return loadMoreTasksRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( bool isRefresh)?  loadTasksRequested,TResult? Function()?  loadMoreTasksRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoadTasksRequested() when loadTasksRequested != null:
return loadTasksRequested(_that.isRefresh);case _LoadMoreTasksRequested() when loadMoreTasksRequested != null:
return loadMoreTasksRequested();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements TaskEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskEvent.started()';
}


}




/// @nodoc


class _LoadTasksRequested implements TaskEvent {
  const _LoadTasksRequested({this.isRefresh = false});
  

@JsonKey() final  bool isRefresh;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadTasksRequestedCopyWith<_LoadTasksRequested> get copyWith => __$LoadTasksRequestedCopyWithImpl<_LoadTasksRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadTasksRequested&&(identical(other.isRefresh, isRefresh) || other.isRefresh == isRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,isRefresh);

@override
String toString() {
  return 'TaskEvent.loadTasksRequested(isRefresh: $isRefresh)';
}


}

/// @nodoc
abstract mixin class _$LoadTasksRequestedCopyWith<$Res> implements $TaskEventCopyWith<$Res> {
  factory _$LoadTasksRequestedCopyWith(_LoadTasksRequested value, $Res Function(_LoadTasksRequested) _then) = __$LoadTasksRequestedCopyWithImpl;
@useResult
$Res call({
 bool isRefresh
});




}
/// @nodoc
class __$LoadTasksRequestedCopyWithImpl<$Res>
    implements _$LoadTasksRequestedCopyWith<$Res> {
  __$LoadTasksRequestedCopyWithImpl(this._self, this._then);

  final _LoadTasksRequested _self;
  final $Res Function(_LoadTasksRequested) _then;

/// Create a copy of TaskEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isRefresh = null,}) {
  return _then(_LoadTasksRequested(
isRefresh: null == isRefresh ? _self.isRefresh : isRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _LoadMoreTasksRequested implements TaskEvent {
  const _LoadMoreTasksRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMoreTasksRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TaskEvent.loadMoreTasksRequested()';
}


}




// dart format on
