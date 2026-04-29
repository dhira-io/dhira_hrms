// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performance_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PerformanceState {

 PerformanceEntity? get summary; bool get isLoading; bool get isActionLoading; String? get errorMessage;
/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceStateCopyWith<PerformanceState> get copyWith => _$PerformanceStateCopyWithImpl<PerformanceState>(this as PerformanceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceState&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,summary,isLoading,isActionLoading,errorMessage);

@override
String toString() {
  return 'PerformanceState(summary: $summary, isLoading: $isLoading, isActionLoading: $isActionLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PerformanceStateCopyWith<$Res>  {
  factory $PerformanceStateCopyWith(PerformanceState value, $Res Function(PerformanceState) _then) = _$PerformanceStateCopyWithImpl;
@useResult
$Res call({
 PerformanceEntity summary, bool isLoading, bool isActionLoading, String errorMessage
});


$PerformanceEntityCopyWith<$Res>? get summary;

}
/// @nodoc
class _$PerformanceStateCopyWithImpl<$Res>
    implements $PerformanceStateCopyWith<$Res> {
  _$PerformanceStateCopyWithImpl(this._self, this._then);

  final PerformanceState _self;
  final $Res Function(PerformanceState) _then;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? isLoading = null,Object? isActionLoading = null,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
summary: null == summary ? _self.summary! : summary // ignore: cast_nullable_to_non_nullable
as PerformanceEntity,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage! : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceEntityCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $PerformanceEntityCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [PerformanceState].
extension PerformanceStatePatterns on PerformanceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PerformanceInitial value)?  initial,TResult Function( PerformanceLoading value)?  loading,TResult Function( PerformanceLoaded value)?  loaded,TResult Function( PerformanceError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PerformanceInitial() when initial != null:
return initial(_that);case PerformanceLoading() when loading != null:
return loading(_that);case PerformanceLoaded() when loaded != null:
return loaded(_that);case PerformanceError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PerformanceInitial value)  initial,required TResult Function( PerformanceLoading value)  loading,required TResult Function( PerformanceLoaded value)  loaded,required TResult Function( PerformanceError value)  error,}){
final _that = this;
switch (_that) {
case PerformanceInitial():
return initial(_that);case PerformanceLoading():
return loading(_that);case PerformanceLoaded():
return loaded(_that);case PerformanceError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PerformanceInitial value)?  initial,TResult? Function( PerformanceLoading value)?  loading,TResult? Function( PerformanceLoaded value)?  loaded,TResult? Function( PerformanceError value)?  error,}){
final _that = this;
switch (_that) {
case PerformanceInitial() when initial != null:
return initial(_that);case PerformanceLoading() when loading != null:
return loading(_that);case PerformanceLoaded() when loaded != null:
return loaded(_that);case PerformanceError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( PerformanceEntity? summary,  bool isLoading,  bool isActionLoading,  String? errorMessage)?  initial,TResult Function( PerformanceEntity? summary,  bool isLoading,  bool isActionLoading,  String? errorMessage)?  loading,TResult Function( PerformanceEntity summary,  bool isLoading,  bool isActionLoading,  String? errorMessage)?  loaded,TResult Function( PerformanceEntity? summary,  bool isLoading,  bool isActionLoading,  String errorMessage)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PerformanceInitial() when initial != null:
return initial(_that.summary,_that.isLoading,_that.isActionLoading,_that.errorMessage);case PerformanceLoading() when loading != null:
return loading(_that.summary,_that.isLoading,_that.isActionLoading,_that.errorMessage);case PerformanceLoaded() when loaded != null:
return loaded(_that.summary,_that.isLoading,_that.isActionLoading,_that.errorMessage);case PerformanceError() when error != null:
return error(_that.summary,_that.isLoading,_that.isActionLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( PerformanceEntity? summary,  bool isLoading,  bool isActionLoading,  String? errorMessage)  initial,required TResult Function( PerformanceEntity? summary,  bool isLoading,  bool isActionLoading,  String? errorMessage)  loading,required TResult Function( PerformanceEntity summary,  bool isLoading,  bool isActionLoading,  String? errorMessage)  loaded,required TResult Function( PerformanceEntity? summary,  bool isLoading,  bool isActionLoading,  String errorMessage)  error,}) {final _that = this;
switch (_that) {
case PerformanceInitial():
return initial(_that.summary,_that.isLoading,_that.isActionLoading,_that.errorMessage);case PerformanceLoading():
return loading(_that.summary,_that.isLoading,_that.isActionLoading,_that.errorMessage);case PerformanceLoaded():
return loaded(_that.summary,_that.isLoading,_that.isActionLoading,_that.errorMessage);case PerformanceError():
return error(_that.summary,_that.isLoading,_that.isActionLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( PerformanceEntity? summary,  bool isLoading,  bool isActionLoading,  String? errorMessage)?  initial,TResult? Function( PerformanceEntity? summary,  bool isLoading,  bool isActionLoading,  String? errorMessage)?  loading,TResult? Function( PerformanceEntity summary,  bool isLoading,  bool isActionLoading,  String? errorMessage)?  loaded,TResult? Function( PerformanceEntity? summary,  bool isLoading,  bool isActionLoading,  String errorMessage)?  error,}) {final _that = this;
switch (_that) {
case PerformanceInitial() when initial != null:
return initial(_that.summary,_that.isLoading,_that.isActionLoading,_that.errorMessage);case PerformanceLoading() when loading != null:
return loading(_that.summary,_that.isLoading,_that.isActionLoading,_that.errorMessage);case PerformanceLoaded() when loaded != null:
return loaded(_that.summary,_that.isLoading,_that.isActionLoading,_that.errorMessage);case PerformanceError() when error != null:
return error(_that.summary,_that.isLoading,_that.isActionLoading,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class PerformanceInitial implements PerformanceState {
  const PerformanceInitial({this.summary, this.isLoading = false, this.isActionLoading = false, this.errorMessage});
  

@override final  PerformanceEntity? summary;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isActionLoading;
@override final  String? errorMessage;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceInitialCopyWith<PerformanceInitial> get copyWith => _$PerformanceInitialCopyWithImpl<PerformanceInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceInitial&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,summary,isLoading,isActionLoading,errorMessage);

@override
String toString() {
  return 'PerformanceState.initial(summary: $summary, isLoading: $isLoading, isActionLoading: $isActionLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PerformanceInitialCopyWith<$Res> implements $PerformanceStateCopyWith<$Res> {
  factory $PerformanceInitialCopyWith(PerformanceInitial value, $Res Function(PerformanceInitial) _then) = _$PerformanceInitialCopyWithImpl;
@override @useResult
$Res call({
 PerformanceEntity? summary, bool isLoading, bool isActionLoading, String? errorMessage
});


@override $PerformanceEntityCopyWith<$Res>? get summary;

}
/// @nodoc
class _$PerformanceInitialCopyWithImpl<$Res>
    implements $PerformanceInitialCopyWith<$Res> {
  _$PerformanceInitialCopyWithImpl(this._self, this._then);

  final PerformanceInitial _self;
  final $Res Function(PerformanceInitial) _then;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = freezed,Object? isLoading = null,Object? isActionLoading = null,Object? errorMessage = freezed,}) {
  return _then(PerformanceInitial(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as PerformanceEntity?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceEntityCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $PerformanceEntityCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc


class PerformanceLoading implements PerformanceState {
  const PerformanceLoading({this.summary, this.isLoading = true, this.isActionLoading = false, this.errorMessage});
  

@override final  PerformanceEntity? summary;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isActionLoading;
@override final  String? errorMessage;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceLoadingCopyWith<PerformanceLoading> get copyWith => _$PerformanceLoadingCopyWithImpl<PerformanceLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceLoading&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,summary,isLoading,isActionLoading,errorMessage);

@override
String toString() {
  return 'PerformanceState.loading(summary: $summary, isLoading: $isLoading, isActionLoading: $isActionLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PerformanceLoadingCopyWith<$Res> implements $PerformanceStateCopyWith<$Res> {
  factory $PerformanceLoadingCopyWith(PerformanceLoading value, $Res Function(PerformanceLoading) _then) = _$PerformanceLoadingCopyWithImpl;
@override @useResult
$Res call({
 PerformanceEntity? summary, bool isLoading, bool isActionLoading, String? errorMessage
});


@override $PerformanceEntityCopyWith<$Res>? get summary;

}
/// @nodoc
class _$PerformanceLoadingCopyWithImpl<$Res>
    implements $PerformanceLoadingCopyWith<$Res> {
  _$PerformanceLoadingCopyWithImpl(this._self, this._then);

  final PerformanceLoading _self;
  final $Res Function(PerformanceLoading) _then;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = freezed,Object? isLoading = null,Object? isActionLoading = null,Object? errorMessage = freezed,}) {
  return _then(PerformanceLoading(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as PerformanceEntity?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceEntityCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $PerformanceEntityCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc


class PerformanceLoaded implements PerformanceState {
  const PerformanceLoaded({required this.summary, this.isLoading = false, this.isActionLoading = false, this.errorMessage});
  

@override final  PerformanceEntity summary;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isActionLoading;
@override final  String? errorMessage;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceLoadedCopyWith<PerformanceLoaded> get copyWith => _$PerformanceLoadedCopyWithImpl<PerformanceLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceLoaded&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,summary,isLoading,isActionLoading,errorMessage);

@override
String toString() {
  return 'PerformanceState.loaded(summary: $summary, isLoading: $isLoading, isActionLoading: $isActionLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PerformanceLoadedCopyWith<$Res> implements $PerformanceStateCopyWith<$Res> {
  factory $PerformanceLoadedCopyWith(PerformanceLoaded value, $Res Function(PerformanceLoaded) _then) = _$PerformanceLoadedCopyWithImpl;
@override @useResult
$Res call({
 PerformanceEntity summary, bool isLoading, bool isActionLoading, String? errorMessage
});


@override $PerformanceEntityCopyWith<$Res> get summary;

}
/// @nodoc
class _$PerformanceLoadedCopyWithImpl<$Res>
    implements $PerformanceLoadedCopyWith<$Res> {
  _$PerformanceLoadedCopyWithImpl(this._self, this._then);

  final PerformanceLoaded _self;
  final $Res Function(PerformanceLoaded) _then;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? isLoading = null,Object? isActionLoading = null,Object? errorMessage = freezed,}) {
  return _then(PerformanceLoaded(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as PerformanceEntity,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceEntityCopyWith<$Res> get summary {
  
  return $PerformanceEntityCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc


class PerformanceError implements PerformanceState {
  const PerformanceError({this.summary, this.isLoading = false, this.isActionLoading = false, required this.errorMessage});
  

@override final  PerformanceEntity? summary;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isActionLoading;
@override final  String errorMessage;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceErrorCopyWith<PerformanceError> get copyWith => _$PerformanceErrorCopyWithImpl<PerformanceError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceError&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,summary,isLoading,isActionLoading,errorMessage);

@override
String toString() {
  return 'PerformanceState.error(summary: $summary, isLoading: $isLoading, isActionLoading: $isActionLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PerformanceErrorCopyWith<$Res> implements $PerformanceStateCopyWith<$Res> {
  factory $PerformanceErrorCopyWith(PerformanceError value, $Res Function(PerformanceError) _then) = _$PerformanceErrorCopyWithImpl;
@override @useResult
$Res call({
 PerformanceEntity? summary, bool isLoading, bool isActionLoading, String errorMessage
});


@override $PerformanceEntityCopyWith<$Res>? get summary;

}
/// @nodoc
class _$PerformanceErrorCopyWithImpl<$Res>
    implements $PerformanceErrorCopyWith<$Res> {
  _$PerformanceErrorCopyWithImpl(this._self, this._then);

  final PerformanceError _self;
  final $Res Function(PerformanceError) _then;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = freezed,Object? isLoading = null,Object? isActionLoading = null,Object? errorMessage = null,}) {
  return _then(PerformanceError(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as PerformanceEntity?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceEntityCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $PerformanceEntityCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on
