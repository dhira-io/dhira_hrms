// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttendanceState {

 Map<String, String>? get calendarEvents; String? get userName; String? get profileImage; AttendanceMonthSummaryEntity? get monthSummary;
/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceStateCopyWith<AttendanceState> get copyWith => _$AttendanceStateCopyWithImpl<AttendanceState>(this as AttendanceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceState&&const DeepCollectionEquality().equals(other.calendarEvents, calendarEvents)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.monthSummary, monthSummary) || other.monthSummary == monthSummary));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(calendarEvents),userName,profileImage,monthSummary);

@override
String toString() {
  return 'AttendanceState(calendarEvents: $calendarEvents, userName: $userName, profileImage: $profileImage, monthSummary: $monthSummary)';
}


}

/// @nodoc
abstract mixin class $AttendanceStateCopyWith<$Res>  {
  factory $AttendanceStateCopyWith(AttendanceState value, $Res Function(AttendanceState) _then) = _$AttendanceStateCopyWithImpl;
@useResult
$Res call({
 Map<String, String>? calendarEvents, String? userName, String? profileImage, AttendanceMonthSummaryEntity? monthSummary
});




}
/// @nodoc
class _$AttendanceStateCopyWithImpl<$Res>
    implements $AttendanceStateCopyWith<$Res> {
  _$AttendanceStateCopyWithImpl(this._self, this._then);

  final AttendanceState _self;
  final $Res Function(AttendanceState) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? calendarEvents = freezed,Object? userName = freezed,Object? profileImage = freezed,Object? monthSummary = freezed,}) {
  return _then(_self.copyWith(
calendarEvents: freezed == calendarEvents ? _self.calendarEvents : calendarEvents // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,monthSummary: freezed == monthSummary ? _self.monthSummary : monthSummary // ignore: cast_nullable_to_non_nullable
as AttendanceMonthSummaryEntity?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceState].
extension AttendanceStatePatterns on AttendanceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Loading value)?  loading,TResult Function( Loaded value)?  loaded,TResult Function( Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Loaded() when loaded != null:
return loaded(_that);case Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Loading value)  loading,required TResult Function( Loaded value)  loaded,required TResult Function( Error value)  error,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Loading():
return loading(_that);case Loaded():
return loaded(_that);case Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Loading value)?  loading,TResult? Function( Loaded value)?  loaded,TResult? Function( Error value)?  error,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Loaded() when loaded != null:
return loaded(_that);case Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Map<String, String>? calendarEvents,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary)?  initial,TResult Function( Map<String, String>? calendarEvents,  AttendanceActionType? actionType,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary)?  loading,TResult Function( AttendanceStatusEntity status,  List<AttendanceLogEntity> logs,  Map<String, String>? calendarEvents,  AttendanceWorkDurationsEntity? workDurations,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary)?  loaded,TResult Function( String message,  Map<String, String>? calendarEvents,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that.calendarEvents,_that.userName,_that.profileImage,_that.monthSummary);case Loading() when loading != null:
return loading(_that.calendarEvents,_that.actionType,_that.userName,_that.profileImage,_that.monthSummary);case Loaded() when loaded != null:
return loaded(_that.status,_that.logs,_that.calendarEvents,_that.workDurations,_that.userName,_that.profileImage,_that.monthSummary);case Error() when error != null:
return error(_that.message,_that.calendarEvents,_that.userName,_that.profileImage,_that.monthSummary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Map<String, String>? calendarEvents,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary)  initial,required TResult Function( Map<String, String>? calendarEvents,  AttendanceActionType? actionType,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary)  loading,required TResult Function( AttendanceStatusEntity status,  List<AttendanceLogEntity> logs,  Map<String, String>? calendarEvents,  AttendanceWorkDurationsEntity? workDurations,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary)  loaded,required TResult Function( String message,  Map<String, String>? calendarEvents,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary)  error,}) {final _that = this;
switch (_that) {
case Initial():
return initial(_that.calendarEvents,_that.userName,_that.profileImage,_that.monthSummary);case Loading():
return loading(_that.calendarEvents,_that.actionType,_that.userName,_that.profileImage,_that.monthSummary);case Loaded():
return loaded(_that.status,_that.logs,_that.calendarEvents,_that.workDurations,_that.userName,_that.profileImage,_that.monthSummary);case Error():
return error(_that.message,_that.calendarEvents,_that.userName,_that.profileImage,_that.monthSummary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Map<String, String>? calendarEvents,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary)?  initial,TResult? Function( Map<String, String>? calendarEvents,  AttendanceActionType? actionType,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary)?  loading,TResult? Function( AttendanceStatusEntity status,  List<AttendanceLogEntity> logs,  Map<String, String>? calendarEvents,  AttendanceWorkDurationsEntity? workDurations,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary)?  loaded,TResult? Function( String message,  Map<String, String>? calendarEvents,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary)?  error,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that.calendarEvents,_that.userName,_that.profileImage,_that.monthSummary);case Loading() when loading != null:
return loading(_that.calendarEvents,_that.actionType,_that.userName,_that.profileImage,_that.monthSummary);case Loaded() when loaded != null:
return loaded(_that.status,_that.logs,_that.calendarEvents,_that.workDurations,_that.userName,_that.profileImage,_that.monthSummary);case Error() when error != null:
return error(_that.message,_that.calendarEvents,_that.userName,_that.profileImage,_that.monthSummary);case _:
  return null;

}
}

}

/// @nodoc


class Initial extends AttendanceState {
  const Initial({final  Map<String, String>? calendarEvents, this.userName, this.profileImage, this.monthSummary}): _calendarEvents = calendarEvents,super._();
  

 final  Map<String, String>? _calendarEvents;
@override Map<String, String>? get calendarEvents {
  final value = _calendarEvents;
  if (value == null) return null;
  if (_calendarEvents is EqualUnmodifiableMapView) return _calendarEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? userName;
@override final  String? profileImage;
@override final  AttendanceMonthSummaryEntity? monthSummary;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialCopyWith<Initial> get copyWith => _$InitialCopyWithImpl<Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial&&const DeepCollectionEquality().equals(other._calendarEvents, _calendarEvents)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.monthSummary, monthSummary) || other.monthSummary == monthSummary));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_calendarEvents),userName,profileImage,monthSummary);

@override
String toString() {
  return 'AttendanceState.initial(calendarEvents: $calendarEvents, userName: $userName, profileImage: $profileImage, monthSummary: $monthSummary)';
}


}

/// @nodoc
abstract mixin class $InitialCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) _then) = _$InitialCopyWithImpl;
@override @useResult
$Res call({
 Map<String, String>? calendarEvents, String? userName, String? profileImage, AttendanceMonthSummaryEntity? monthSummary
});




}
/// @nodoc
class _$InitialCopyWithImpl<$Res>
    implements $InitialCopyWith<$Res> {
  _$InitialCopyWithImpl(this._self, this._then);

  final Initial _self;
  final $Res Function(Initial) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? calendarEvents = freezed,Object? userName = freezed,Object? profileImage = freezed,Object? monthSummary = freezed,}) {
  return _then(Initial(
calendarEvents: freezed == calendarEvents ? _self._calendarEvents : calendarEvents // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,monthSummary: freezed == monthSummary ? _self.monthSummary : monthSummary // ignore: cast_nullable_to_non_nullable
as AttendanceMonthSummaryEntity?,
  ));
}


}

/// @nodoc


class Loading extends AttendanceState {
  const Loading({final  Map<String, String>? calendarEvents, this.actionType, this.userName, this.profileImage, this.monthSummary}): _calendarEvents = calendarEvents,super._();
  

 final  Map<String, String>? _calendarEvents;
@override Map<String, String>? get calendarEvents {
  final value = _calendarEvents;
  if (value == null) return null;
  if (_calendarEvents is EqualUnmodifiableMapView) return _calendarEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  AttendanceActionType? actionType;
@override final  String? userName;
@override final  String? profileImage;
@override final  AttendanceMonthSummaryEntity? monthSummary;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadingCopyWith<Loading> get copyWith => _$LoadingCopyWithImpl<Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading&&const DeepCollectionEquality().equals(other._calendarEvents, _calendarEvents)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.monthSummary, monthSummary) || other.monthSummary == monthSummary));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_calendarEvents),actionType,userName,profileImage,monthSummary);

@override
String toString() {
  return 'AttendanceState.loading(calendarEvents: $calendarEvents, actionType: $actionType, userName: $userName, profileImage: $profileImage, monthSummary: $monthSummary)';
}


}

/// @nodoc
abstract mixin class $LoadingCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) _then) = _$LoadingCopyWithImpl;
@override @useResult
$Res call({
 Map<String, String>? calendarEvents, AttendanceActionType? actionType, String? userName, String? profileImage, AttendanceMonthSummaryEntity? monthSummary
});




}
/// @nodoc
class _$LoadingCopyWithImpl<$Res>
    implements $LoadingCopyWith<$Res> {
  _$LoadingCopyWithImpl(this._self, this._then);

  final Loading _self;
  final $Res Function(Loading) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? calendarEvents = freezed,Object? actionType = freezed,Object? userName = freezed,Object? profileImage = freezed,Object? monthSummary = freezed,}) {
  return _then(Loading(
calendarEvents: freezed == calendarEvents ? _self._calendarEvents : calendarEvents // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,actionType: freezed == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as AttendanceActionType?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,monthSummary: freezed == monthSummary ? _self.monthSummary : monthSummary // ignore: cast_nullable_to_non_nullable
as AttendanceMonthSummaryEntity?,
  ));
}


}

/// @nodoc


class Loaded extends AttendanceState {
  const Loaded({required this.status, required final  List<AttendanceLogEntity> logs, final  Map<String, String>? calendarEvents, this.workDurations, this.userName, this.profileImage, this.monthSummary}): _logs = logs,_calendarEvents = calendarEvents,super._();
  

 final  AttendanceStatusEntity status;
 final  List<AttendanceLogEntity> _logs;
 List<AttendanceLogEntity> get logs {
  if (_logs is EqualUnmodifiableListView) return _logs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logs);
}

 final  Map<String, String>? _calendarEvents;
@override Map<String, String>? get calendarEvents {
  final value = _calendarEvents;
  if (value == null) return null;
  if (_calendarEvents is EqualUnmodifiableMapView) return _calendarEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  AttendanceWorkDurationsEntity? workDurations;
@override final  String? userName;
@override final  String? profileImage;
@override final  AttendanceMonthSummaryEntity? monthSummary;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._logs, _logs)&&const DeepCollectionEquality().equals(other._calendarEvents, _calendarEvents)&&(identical(other.workDurations, workDurations) || other.workDurations == workDurations)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.monthSummary, monthSummary) || other.monthSummary == monthSummary));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_logs),const DeepCollectionEquality().hash(_calendarEvents),workDurations,userName,profileImage,monthSummary);

@override
String toString() {
  return 'AttendanceState.loaded(status: $status, logs: $logs, calendarEvents: $calendarEvents, workDurations: $workDurations, userName: $userName, profileImage: $profileImage, monthSummary: $monthSummary)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@override @useResult
$Res call({
 AttendanceStatusEntity status, List<AttendanceLogEntity> logs, Map<String, String>? calendarEvents, AttendanceWorkDurationsEntity? workDurations, String? userName, String? profileImage, AttendanceMonthSummaryEntity? monthSummary
});


$AttendanceStatusEntityCopyWith<$Res> get status;$AttendanceWorkDurationsEntityCopyWith<$Res>? get workDurations;

}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? logs = null,Object? calendarEvents = freezed,Object? workDurations = freezed,Object? userName = freezed,Object? profileImage = freezed,Object? monthSummary = freezed,}) {
  return _then(Loaded(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttendanceStatusEntity,logs: null == logs ? _self._logs : logs // ignore: cast_nullable_to_non_nullable
as List<AttendanceLogEntity>,calendarEvents: freezed == calendarEvents ? _self._calendarEvents : calendarEvents // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,workDurations: freezed == workDurations ? _self.workDurations : workDurations // ignore: cast_nullable_to_non_nullable
as AttendanceWorkDurationsEntity?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,monthSummary: freezed == monthSummary ? _self.monthSummary : monthSummary // ignore: cast_nullable_to_non_nullable
as AttendanceMonthSummaryEntity?,
  ));
}

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceStatusEntityCopyWith<$Res> get status {
  
  return $AttendanceStatusEntityCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceWorkDurationsEntityCopyWith<$Res>? get workDurations {
    if (_self.workDurations == null) {
    return null;
  }

  return $AttendanceWorkDurationsEntityCopyWith<$Res>(_self.workDurations!, (value) {
    return _then(_self.copyWith(workDurations: value));
  });
}
}

/// @nodoc


class Error extends AttendanceState {
  const Error(this.message, {final  Map<String, String>? calendarEvents, this.userName, this.profileImage, this.monthSummary}): _calendarEvents = calendarEvents,super._();
  

 final  String message;
 final  Map<String, String>? _calendarEvents;
@override Map<String, String>? get calendarEvents {
  final value = _calendarEvents;
  if (value == null) return null;
  if (_calendarEvents is EqualUnmodifiableMapView) return _calendarEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? userName;
@override final  String? profileImage;
@override final  AttendanceMonthSummaryEntity? monthSummary;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._calendarEvents, _calendarEvents)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.monthSummary, monthSummary) || other.monthSummary == monthSummary));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_calendarEvents),userName,profileImage,monthSummary);

@override
String toString() {
  return 'AttendanceState.error(message: $message, calendarEvents: $calendarEvents, userName: $userName, profileImage: $profileImage, monthSummary: $monthSummary)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@override @useResult
$Res call({
 String message, Map<String, String>? calendarEvents, String? userName, String? profileImage, AttendanceMonthSummaryEntity? monthSummary
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? calendarEvents = freezed,Object? userName = freezed,Object? profileImage = freezed,Object? monthSummary = freezed,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,calendarEvents: freezed == calendarEvents ? _self._calendarEvents : calendarEvents // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,monthSummary: freezed == monthSummary ? _self.monthSummary : monthSummary // ignore: cast_nullable_to_non_nullable
as AttendanceMonthSummaryEntity?,
  ));
}


}

// dart format on
