// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'self_assessment_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelfAssessmentState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelfAssessmentState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelfAssessmentState()';
}


}

/// @nodoc
class $SelfAssessmentStateCopyWith<$Res>  {
$SelfAssessmentStateCopyWith(SelfAssessmentState _, $Res Function(SelfAssessmentState) __);
}


/// Adds pattern-matching-related methods to [SelfAssessmentState].
extension SelfAssessmentStatePatterns on SelfAssessmentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Saving value)?  saving,TResult Function( _SaveSuccess value)?  saveSuccess,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Saving() when saving != null:
return saving(_that);case _SaveSuccess() when saveSuccess != null:
return saveSuccess(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Saving value)  saving,required TResult Function( _SaveSuccess value)  saveSuccess,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Saving():
return saving(_that);case _SaveSuccess():
return saveSuccess(_that);case _Failure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Saving value)?  saving,TResult? Function( _SaveSuccess value)?  saveSuccess,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Saving() when saving != null:
return saving(_that);case _SaveSuccess() when saveSuccess != null:
return saveSuccess(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( SelfAssessmentEntity details)?  success,TResult Function( SelfAssessmentEntity details)?  saving,TResult Function( SelfAssessmentEntity details)?  saveSuccess,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.details);case _Saving() when saving != null:
return saving(_that.details);case _SaveSuccess() when saveSuccess != null:
return saveSuccess(_that.details);case _Failure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( SelfAssessmentEntity details)  success,required TResult Function( SelfAssessmentEntity details)  saving,required TResult Function( SelfAssessmentEntity details)  saveSuccess,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.details);case _Saving():
return saving(_that.details);case _SaveSuccess():
return saveSuccess(_that.details);case _Failure():
return failure(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( SelfAssessmentEntity details)?  success,TResult? Function( SelfAssessmentEntity details)?  saving,TResult? Function( SelfAssessmentEntity details)?  saveSuccess,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.details);case _Saving() when saving != null:
return saving(_that.details);case _SaveSuccess() when saveSuccess != null:
return saveSuccess(_that.details);case _Failure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements SelfAssessmentState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelfAssessmentState.initial()';
}


}




/// @nodoc


class _Loading implements SelfAssessmentState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelfAssessmentState.loading()';
}


}




/// @nodoc


class _Success implements SelfAssessmentState {
  const _Success(this.details);
  

 final  SelfAssessmentEntity details;

/// Create a copy of SelfAssessmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.details, details) || other.details == details));
}


@override
int get hashCode => Object.hash(runtimeType,details);

@override
String toString() {
  return 'SelfAssessmentState.success(details: $details)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $SelfAssessmentStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 SelfAssessmentEntity details
});


$SelfAssessmentEntityCopyWith<$Res> get details;

}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of SelfAssessmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? details = null,}) {
  return _then(_Success(
null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as SelfAssessmentEntity,
  ));
}

/// Create a copy of SelfAssessmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelfAssessmentEntityCopyWith<$Res> get details {
  
  return $SelfAssessmentEntityCopyWith<$Res>(_self.details, (value) {
    return _then(_self.copyWith(details: value));
  });
}
}

/// @nodoc


class _Saving implements SelfAssessmentState {
  const _Saving(this.details);
  

 final  SelfAssessmentEntity details;

/// Create a copy of SelfAssessmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingCopyWith<_Saving> get copyWith => __$SavingCopyWithImpl<_Saving>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Saving&&(identical(other.details, details) || other.details == details));
}


@override
int get hashCode => Object.hash(runtimeType,details);

@override
String toString() {
  return 'SelfAssessmentState.saving(details: $details)';
}


}

/// @nodoc
abstract mixin class _$SavingCopyWith<$Res> implements $SelfAssessmentStateCopyWith<$Res> {
  factory _$SavingCopyWith(_Saving value, $Res Function(_Saving) _then) = __$SavingCopyWithImpl;
@useResult
$Res call({
 SelfAssessmentEntity details
});


$SelfAssessmentEntityCopyWith<$Res> get details;

}
/// @nodoc
class __$SavingCopyWithImpl<$Res>
    implements _$SavingCopyWith<$Res> {
  __$SavingCopyWithImpl(this._self, this._then);

  final _Saving _self;
  final $Res Function(_Saving) _then;

/// Create a copy of SelfAssessmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? details = null,}) {
  return _then(_Saving(
null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as SelfAssessmentEntity,
  ));
}

/// Create a copy of SelfAssessmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelfAssessmentEntityCopyWith<$Res> get details {
  
  return $SelfAssessmentEntityCopyWith<$Res>(_self.details, (value) {
    return _then(_self.copyWith(details: value));
  });
}
}

/// @nodoc


class _SaveSuccess implements SelfAssessmentState {
  const _SaveSuccess(this.details);
  

 final  SelfAssessmentEntity details;

/// Create a copy of SelfAssessmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveSuccessCopyWith<_SaveSuccess> get copyWith => __$SaveSuccessCopyWithImpl<_SaveSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveSuccess&&(identical(other.details, details) || other.details == details));
}


@override
int get hashCode => Object.hash(runtimeType,details);

@override
String toString() {
  return 'SelfAssessmentState.saveSuccess(details: $details)';
}


}

/// @nodoc
abstract mixin class _$SaveSuccessCopyWith<$Res> implements $SelfAssessmentStateCopyWith<$Res> {
  factory _$SaveSuccessCopyWith(_SaveSuccess value, $Res Function(_SaveSuccess) _then) = __$SaveSuccessCopyWithImpl;
@useResult
$Res call({
 SelfAssessmentEntity details
});


$SelfAssessmentEntityCopyWith<$Res> get details;

}
/// @nodoc
class __$SaveSuccessCopyWithImpl<$Res>
    implements _$SaveSuccessCopyWith<$Res> {
  __$SaveSuccessCopyWithImpl(this._self, this._then);

  final _SaveSuccess _self;
  final $Res Function(_SaveSuccess) _then;

/// Create a copy of SelfAssessmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? details = null,}) {
  return _then(_SaveSuccess(
null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as SelfAssessmentEntity,
  ));
}

/// Create a copy of SelfAssessmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelfAssessmentEntityCopyWith<$Res> get details {
  
  return $SelfAssessmentEntityCopyWith<$Res>(_self.details, (value) {
    return _then(_self.copyWith(details: value));
  });
}
}

/// @nodoc


class _Failure implements SelfAssessmentState {
  const _Failure(this.message);
  

 final  String message;

/// Create a copy of SelfAssessmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SelfAssessmentState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $SelfAssessmentStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of SelfAssessmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Failure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
