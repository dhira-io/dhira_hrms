
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

 Map<String, String>? get calendarEvents; String? get userName; String? get profileImage; AttendanceMonthSummaryEntity? get monthSummary; LeaveDetailsEntity? get leaveDetails; List<LeaveHistoryEntity>? get leaveHistory; List<TeamLeaveEntity>? get teamLeaves; HolidayListLeavePolicyEntity? get holidayListLeavePolicy;
/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceStateCopyWith<AttendanceState> get copyWith => _$AttendanceStateCopyWithImpl<AttendanceState>(this as AttendanceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceState&&const DeepCollectionEquality().equals(other.calendarEvents, calendarEvents)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.monthSummary, monthSummary) || other.monthSummary == monthSummary)&&(identical(other.leaveDetails, leaveDetails) || other.leaveDetails == leaveDetails)&&const DeepCollectionEquality().equals(other.leaveHistory, leaveHistory)&&const DeepCollectionEquality().equals(other.teamLeaves, teamLeaves)&&(identical(other.holidayListLeavePolicy, holidayListLeavePolicy) || other.holidayListLeavePolicy == holidayListLeavePolicy));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(calendarEvents),userName,profileImage,monthSummary,leaveDetails,const DeepCollectionEquality().hash(leaveHistory),const DeepCollectionEquality().hash(teamLeaves),holidayListLeavePolicy);

@override
String toString() {
  return 'AttendanceState(calendarEvents: $calendarEvents, userName: $userName, profileImage: $profileImage, monthSummary: $monthSummary, leaveDetails: $leaveDetails, leaveHistory: $leaveHistory, teamLeaves: $teamLeaves, holidayListLeavePolicy: $holidayListLeavePolicy)';
}


}

/// @nodoc
abstract mixin class $AttendanceStateCopyWith<$Res>  {
  factory $AttendanceStateCopyWith(AttendanceState value, $Res Function(AttendanceState) _then) = _$AttendanceStateCopyWithImpl;
@useResult
$Res call({
 Map<String, String>? calendarEvents, String? userName, String? profileImage, AttendanceMonthSummaryEntity? monthSummary, LeaveDetailsEntity? leaveDetails, List<LeaveHistoryEntity>? leaveHistory, List<TeamLeaveEntity>? teamLeaves, HolidayListLeavePolicyEntity? holidayListLeavePolicy
});


$LeaveDetailsEntityCopyWith<$Res>? get leaveDetails;$HolidayListLeavePolicyEntityCopyWith<$Res>? get holidayListLeavePolicy;

}
/// @nodoc
class _$AttendanceStateCopyWithImpl<$Res>
    implements $AttendanceStateCopyWith<$Res> {
  _$AttendanceStateCopyWithImpl(this._self, this._then);

  final AttendanceState _self;
  final $Res Function(AttendanceState) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? calendarEvents = freezed,Object? userName = freezed,Object? profileImage = freezed,Object? monthSummary = freezed,Object? leaveDetails = freezed,Object? leaveHistory = freezed,Object? teamLeaves = freezed,Object? holidayListLeavePolicy = freezed,}) {
  return _then(_self.copyWith(
calendarEvents: freezed == calendarEvents ? _self.calendarEvents : calendarEvents // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,monthSummary: freezed == monthSummary ? _self.monthSummary : monthSummary // ignore: cast_nullable_to_non_nullable
as AttendanceMonthSummaryEntity?,leaveDetails: freezed == leaveDetails ? _self.leaveDetails : leaveDetails // ignore: cast_nullable_to_non_nullable
as LeaveDetailsEntity?,leaveHistory: freezed == leaveHistory ? _self.leaveHistory : leaveHistory // ignore: cast_nullable_to_non_nullable
as List<LeaveHistoryEntity>?,teamLeaves: freezed == teamLeaves ? _self.teamLeaves : teamLeaves // ignore: cast_nullable_to_non_nullable
as List<TeamLeaveEntity>?,holidayListLeavePolicy: freezed == holidayListLeavePolicy ? _self.holidayListLeavePolicy : holidayListLeavePolicy // ignore: cast_nullable_to_non_nullable
as HolidayListLeavePolicyEntity?,
  ));
}
/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveDetailsEntityCopyWith<$Res>? get leaveDetails {
    if (_self.leaveDetails == null) {
    return null;
  }

  return $LeaveDetailsEntityCopyWith<$Res>(_self.leaveDetails!, (value) {
    return _then(_self.copyWith(leaveDetails: value));
  });
}/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HolidayListLeavePolicyEntityCopyWith<$Res>? get holidayListLeavePolicy {
    if (_self.holidayListLeavePolicy == null) {
    return null;
  }

  return $HolidayListLeavePolicyEntityCopyWith<$Res>(_self.holidayListLeavePolicy!, (value) {
    return _then(_self.copyWith(holidayListLeavePolicy: value));
  });
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _AttendanceError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _AttendanceError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _AttendanceError value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _AttendanceError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _AttendanceError value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _AttendanceError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Map<String, String>? calendarEvents,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary,  LeaveDetailsEntity? leaveDetails,  List<LeaveHistoryEntity>? leaveHistory,  List<TeamLeaveEntity>? teamLeaves,  HolidayListLeavePolicyEntity? holidayListLeavePolicy)?  initial,TResult Function( Map<String, String>? calendarEvents,  AttendanceActionType? actionType,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary,  LeaveDetailsEntity? leaveDetails,  List<LeaveHistoryEntity>? leaveHistory,  List<TeamLeaveEntity>? teamLeaves,  HolidayListLeavePolicyEntity? holidayListLeavePolicy)?  loading,TResult Function( AttendanceStatusEntity status,  List<AttendanceLogEntity> logs,  Map<String, String>? calendarEvents,  AttendanceWorkDurationsEntity? workDurations,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary,  LeaveDetailsEntity? leaveDetails,  List<LeaveHistoryEntity>? leaveHistory,  List<TeamLeaveEntity>? teamLeaves,  HolidayListLeavePolicyEntity? holidayListLeavePolicy)?  loaded,TResult Function( String message,  Map<String, String>? calendarEvents,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary,  LeaveDetailsEntity? leaveDetails,  List<LeaveHistoryEntity>? leaveHistory,  List<TeamLeaveEntity>? teamLeaves,  HolidayListLeavePolicyEntity? holidayListLeavePolicy)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.calendarEvents,_that.userName,_that.profileImage,_that.monthSummary,_that.leaveDetails,_that.leaveHistory,_that.teamLeaves,_that.holidayListLeavePolicy);case _Loading() when loading != null:
return loading(_that.calendarEvents,_that.actionType,_that.userName,_that.profileImage,_that.monthSummary,_that.leaveDetails,_that.leaveHistory,_that.teamLeaves,_that.holidayListLeavePolicy);case _Loaded() when loaded != null:
return loaded(_that.status,_that.logs,_that.calendarEvents,_that.workDurations,_that.userName,_that.profileImage,_that.monthSummary,_that.leaveDetails,_that.leaveHistory,_that.teamLeaves,_that.holidayListLeavePolicy);case _AttendanceError() when error != null:
return error(_that.message,_that.calendarEvents,_that.userName,_that.profileImage,_that.monthSummary,_that.leaveDetails,_that.leaveHistory,_that.teamLeaves,_that.holidayListLeavePolicy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Map<String, String>? calendarEvents,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary,  LeaveDetailsEntity? leaveDetails,  List<LeaveHistoryEntity>? leaveHistory,  List<TeamLeaveEntity>? teamLeaves,  HolidayListLeavePolicyEntity? holidayListLeavePolicy)  initial,required TResult Function( Map<String, String>? calendarEvents,  AttendanceActionType? actionType,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary,  LeaveDetailsEntity? leaveDetails,  List<LeaveHistoryEntity>? leaveHistory,  List<TeamLeaveEntity>? teamLeaves,  HolidayListLeavePolicyEntity? holidayListLeavePolicy)  loading,required TResult Function( AttendanceStatusEntity status,  List<AttendanceLogEntity> logs,  Map<String, String>? calendarEvents,  AttendanceWorkDurationsEntity? workDurations,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary,  LeaveDetailsEntity? leaveDetails,  List<LeaveHistoryEntity>? leaveHistory,  List<TeamLeaveEntity>? teamLeaves,  HolidayListLeavePolicyEntity? holidayListLeavePolicy)  loaded,required TResult Function( String message,  Map<String, String>? calendarEvents,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary,  LeaveDetailsEntity? leaveDetails,  List<LeaveHistoryEntity>? leaveHistory,  List<TeamLeaveEntity>? teamLeaves,  HolidayListLeavePolicyEntity? holidayListLeavePolicy)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial(_that.calendarEvents,_that.userName,_that.profileImage,_that.monthSummary,_that.leaveDetails,_that.leaveHistory,_that.teamLeaves,_that.holidayListLeavePolicy);case _Loading():
return loading(_that.calendarEvents,_that.actionType,_that.userName,_that.profileImage,_that.monthSummary,_that.leaveDetails,_that.leaveHistory,_that.teamLeaves,_that.holidayListLeavePolicy);case _Loaded():
return loaded(_that.status,_that.logs,_that.calendarEvents,_that.workDurations,_that.userName,_that.profileImage,_that.monthSummary,_that.leaveDetails,_that.leaveHistory,_that.teamLeaves,_that.holidayListLeavePolicy);case _AttendanceError():
return error(_that.message,_that.calendarEvents,_that.userName,_that.profileImage,_that.monthSummary,_that.leaveDetails,_that.leaveHistory,_that.teamLeaves,_that.holidayListLeavePolicy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Map<String, String>? calendarEvents,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary,  LeaveDetailsEntity? leaveDetails,  List<LeaveHistoryEntity>? leaveHistory,  List<TeamLeaveEntity>? teamLeaves,  HolidayListLeavePolicyEntity? holidayListLeavePolicy)?  initial,TResult? Function( Map<String, String>? calendarEvents,  AttendanceActionType? actionType,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary,  LeaveDetailsEntity? leaveDetails,  List<LeaveHistoryEntity>? leaveHistory,  List<TeamLeaveEntity>? teamLeaves,  HolidayListLeavePolicyEntity? holidayListLeavePolicy)?  loading,TResult? Function( AttendanceStatusEntity status,  List<AttendanceLogEntity> logs,  Map<String, String>? calendarEvents,  AttendanceWorkDurationsEntity? workDurations,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary,  LeaveDetailsEntity? leaveDetails,  List<LeaveHistoryEntity>? leaveHistory,  List<TeamLeaveEntity>? teamLeaves,  HolidayListLeavePolicyEntity? holidayListLeavePolicy)?  loaded,TResult? Function( String message,  Map<String, String>? calendarEvents,  String? userName,  String? profileImage,  AttendanceMonthSummaryEntity? monthSummary,  LeaveDetailsEntity? leaveDetails,  List<LeaveHistoryEntity>? leaveHistory,  List<TeamLeaveEntity>? teamLeaves,  HolidayListLeavePolicyEntity? holidayListLeavePolicy)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.calendarEvents,_that.userName,_that.profileImage,_that.monthSummary,_that.leaveDetails,_that.leaveHistory,_that.teamLeaves,_that.holidayListLeavePolicy);case _Loading() when loading != null:
return loading(_that.calendarEvents,_that.actionType,_that.userName,_that.profileImage,_that.monthSummary,_that.leaveDetails,_that.leaveHistory,_that.teamLeaves,_that.holidayListLeavePolicy);case _Loaded() when loaded != null:
return loaded(_that.status,_that.logs,_that.calendarEvents,_that.workDurations,_that.userName,_that.profileImage,_that.monthSummary,_that.leaveDetails,_that.leaveHistory,_that.teamLeaves,_that.holidayListLeavePolicy);case _AttendanceError() when error != null:
return error(_that.message,_that.calendarEvents,_that.userName,_that.profileImage,_that.monthSummary,_that.leaveDetails,_that.leaveHistory,_that.teamLeaves,_that.holidayListLeavePolicy);case _:
  return null;

}
}

}

/// @nodoc


class _Initial extends AttendanceState {
  const _Initial({final  Map<String, String>? calendarEvents, this.userName, this.profileImage, this.monthSummary, this.leaveDetails, final  List<LeaveHistoryEntity>? leaveHistory, final  List<TeamLeaveEntity>? teamLeaves, this.holidayListLeavePolicy}): _calendarEvents = calendarEvents,_leaveHistory = leaveHistory,_teamLeaves = teamLeaves,super._();


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
@override final  LeaveDetailsEntity? leaveDetails;
 final  List<LeaveHistoryEntity>? _leaveHistory;
@override List<LeaveHistoryEntity>? get leaveHistory {
  final value = _leaveHistory;
  if (value == null) return null;
  if (_leaveHistory is EqualUnmodifiableListView) return _leaveHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TeamLeaveEntity>? _teamLeaves;
@override List<TeamLeaveEntity>? get teamLeaves {
  final value = _teamLeaves;
  if (value == null) return null;
  if (_teamLeaves is EqualUnmodifiableListView) return _teamLeaves;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  HolidayListLeavePolicyEntity? holidayListLeavePolicy;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&const DeepCollectionEquality().equals(other._calendarEvents, _calendarEvents)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.monthSummary, monthSummary) || other.monthSummary == monthSummary)&&(identical(other.leaveDetails, leaveDetails) || other.leaveDetails == leaveDetails)&&const DeepCollectionEquality().equals(other._leaveHistory, _leaveHistory)&&const DeepCollectionEquality().equals(other._teamLeaves, _teamLeaves)&&(identical(other.holidayListLeavePolicy, holidayListLeavePolicy) || other.holidayListLeavePolicy == holidayListLeavePolicy));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_calendarEvents),userName,profileImage,monthSummary,leaveDetails,const DeepCollectionEquality().hash(_leaveHistory),const DeepCollectionEquality().hash(_teamLeaves),holidayListLeavePolicy);

@override
String toString() {
  return 'AttendanceState.initial(calendarEvents: $calendarEvents, userName: $userName, profileImage: $profileImage, monthSummary: $monthSummary, leaveDetails: $leaveDetails, leaveHistory: $leaveHistory, teamLeaves: $teamLeaves, holidayListLeavePolicy: $holidayListLeavePolicy)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 Map<String, String>? calendarEvents, String? userName, String? profileImage, AttendanceMonthSummaryEntity? monthSummary, LeaveDetailsEntity? leaveDetails, List<LeaveHistoryEntity>? leaveHistory, List<TeamLeaveEntity>? teamLeaves, HolidayListLeavePolicyEntity? holidayListLeavePolicy
});


@override $LeaveDetailsEntityCopyWith<$Res>? get leaveDetails;@override $HolidayListLeavePolicyEntityCopyWith<$Res>? get holidayListLeavePolicy;

}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? calendarEvents = freezed,Object? userName = freezed,Object? profileImage = freezed,Object? monthSummary = freezed,Object? leaveDetails = freezed,Object? leaveHistory = freezed,Object? teamLeaves = freezed,Object? holidayListLeavePolicy = freezed,}) {
  return _then(_Initial(
calendarEvents: freezed == calendarEvents ? _self._calendarEvents : calendarEvents // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,monthSummary: freezed == monthSummary ? _self.monthSummary : monthSummary // ignore: cast_nullable_to_non_nullable
as AttendanceMonthSummaryEntity?,leaveDetails: freezed == leaveDetails ? _self.leaveDetails : leaveDetails // ignore: cast_nullable_to_non_nullable
as LeaveDetailsEntity?,leaveHistory: freezed == leaveHistory ? _self._leaveHistory : leaveHistory // ignore: cast_nullable_to_non_nullable
as List<LeaveHistoryEntity>?,teamLeaves: freezed == teamLeaves ? _self._teamLeaves : teamLeaves // ignore: cast_nullable_to_non_nullable
as List<TeamLeaveEntity>?,holidayListLeavePolicy: freezed == holidayListLeavePolicy ? _self.holidayListLeavePolicy : holidayListLeavePolicy // ignore: cast_nullable_to_non_nullable
as HolidayListLeavePolicyEntity?,
  ));
}

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveDetailsEntityCopyWith<$Res>? get leaveDetails {
    if (_self.leaveDetails == null) {
    return null;
  }

  return $LeaveDetailsEntityCopyWith<$Res>(_self.leaveDetails!, (value) {
    return _then(_self.copyWith(leaveDetails: value));
  });
}/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HolidayListLeavePolicyEntityCopyWith<$Res>? get holidayListLeavePolicy {
    if (_self.holidayListLeavePolicy == null) {
    return null;
  }

  return $HolidayListLeavePolicyEntityCopyWith<$Res>(_self.holidayListLeavePolicy!, (value) {
    return _then(_self.copyWith(holidayListLeavePolicy: value));
  });
}
}

/// @nodoc


class _Loading extends AttendanceState {
  const _Loading({final  Map<String, String>? calendarEvents, this.actionType, this.userName, this.profileImage, this.monthSummary, this.leaveDetails, final  List<LeaveHistoryEntity>? leaveHistory, final  List<TeamLeaveEntity>? teamLeaves, this.holidayListLeavePolicy}): _calendarEvents = calendarEvents,_leaveHistory = leaveHistory,_teamLeaves = teamLeaves,super._();


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
@override final  LeaveDetailsEntity? leaveDetails;
 final  List<LeaveHistoryEntity>? _leaveHistory;
@override List<LeaveHistoryEntity>? get leaveHistory {
  final value = _leaveHistory;
  if (value == null) return null;
  if (_leaveHistory is EqualUnmodifiableListView) return _leaveHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TeamLeaveEntity>? _teamLeaves;
@override List<TeamLeaveEntity>? get teamLeaves {
  final value = _teamLeaves;
  if (value == null) return null;
  if (_teamLeaves is EqualUnmodifiableListView) return _teamLeaves;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  HolidayListLeavePolicyEntity? holidayListLeavePolicy;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&const DeepCollectionEquality().equals(other._calendarEvents, _calendarEvents)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.monthSummary, monthSummary) || other.monthSummary == monthSummary)&&(identical(other.leaveDetails, leaveDetails) || other.leaveDetails == leaveDetails)&&const DeepCollectionEquality().equals(other._leaveHistory, _leaveHistory)&&const DeepCollectionEquality().equals(other._teamLeaves, _teamLeaves)&&(identical(other.holidayListLeavePolicy, holidayListLeavePolicy) || other.holidayListLeavePolicy == holidayListLeavePolicy));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_calendarEvents),actionType,userName,profileImage,monthSummary,leaveDetails,const DeepCollectionEquality().hash(_leaveHistory),const DeepCollectionEquality().hash(_teamLeaves),holidayListLeavePolicy);

@override
String toString() {
  return 'AttendanceState.loading(calendarEvents: $calendarEvents, actionType: $actionType, userName: $userName, profileImage: $profileImage, monthSummary: $monthSummary, leaveDetails: $leaveDetails, leaveHistory: $leaveHistory, teamLeaves: $teamLeaves, holidayListLeavePolicy: $holidayListLeavePolicy)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@override @useResult
$Res call({
 Map<String, String>? calendarEvents, AttendanceActionType? actionType, String? userName, String? profileImage, AttendanceMonthSummaryEntity? monthSummary, LeaveDetailsEntity? leaveDetails, List<LeaveHistoryEntity>? leaveHistory, List<TeamLeaveEntity>? teamLeaves, HolidayListLeavePolicyEntity? holidayListLeavePolicy
});


@override $LeaveDetailsEntityCopyWith<$Res>? get leaveDetails;@override $HolidayListLeavePolicyEntityCopyWith<$Res>? get holidayListLeavePolicy;

}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? calendarEvents = freezed,Object? actionType = freezed,Object? userName = freezed,Object? profileImage = freezed,Object? monthSummary = freezed,Object? leaveDetails = freezed,Object? leaveHistory = freezed,Object? teamLeaves = freezed,Object? holidayListLeavePolicy = freezed,}) {
  return _then(_Loading(
calendarEvents: freezed == calendarEvents ? _self._calendarEvents : calendarEvents // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,actionType: freezed == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as AttendanceActionType?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,monthSummary: freezed == monthSummary ? _self.monthSummary : monthSummary // ignore: cast_nullable_to_non_nullable
as AttendanceMonthSummaryEntity?,leaveDetails: freezed == leaveDetails ? _self.leaveDetails : leaveDetails // ignore: cast_nullable_to_non_nullable
as LeaveDetailsEntity?,leaveHistory: freezed == leaveHistory ? _self._leaveHistory : leaveHistory // ignore: cast_nullable_to_non_nullable
as List<LeaveHistoryEntity>?,teamLeaves: freezed == teamLeaves ? _self._teamLeaves : teamLeaves // ignore: cast_nullable_to_non_nullable
as List<TeamLeaveEntity>?,holidayListLeavePolicy: freezed == holidayListLeavePolicy ? _self.holidayListLeavePolicy : holidayListLeavePolicy // ignore: cast_nullable_to_non_nullable
as HolidayListLeavePolicyEntity?,
  ));
}

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveDetailsEntityCopyWith<$Res>? get leaveDetails {
    if (_self.leaveDetails == null) {
    return null;
  }

  return $LeaveDetailsEntityCopyWith<$Res>(_self.leaveDetails!, (value) {
    return _then(_self.copyWith(leaveDetails: value));
  });
}/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HolidayListLeavePolicyEntityCopyWith<$Res>? get holidayListLeavePolicy {
    if (_self.holidayListLeavePolicy == null) {
    return null;
  }

  return $HolidayListLeavePolicyEntityCopyWith<$Res>(_self.holidayListLeavePolicy!, (value) {
    return _then(_self.copyWith(holidayListLeavePolicy: value));
  });
}
}

/// @nodoc


class _Loaded extends AttendanceState {
  const _Loaded({required this.status, required final  List<AttendanceLogEntity> logs, final  Map<String, String>? calendarEvents, this.workDurations, this.userName, this.profileImage, this.monthSummary, this.leaveDetails, final  List<LeaveHistoryEntity>? leaveHistory, final  List<TeamLeaveEntity>? teamLeaves, this.holidayListLeavePolicy}): _logs = logs,_calendarEvents = calendarEvents,_leaveHistory = leaveHistory,_teamLeaves = teamLeaves,super._();


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
@override final  LeaveDetailsEntity? leaveDetails;
 final  List<LeaveHistoryEntity>? _leaveHistory;
@override List<LeaveHistoryEntity>? get leaveHistory {
  final value = _leaveHistory;
  if (value == null) return null;
  if (_leaveHistory is EqualUnmodifiableListView) return _leaveHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TeamLeaveEntity>? _teamLeaves;
@override List<TeamLeaveEntity>? get teamLeaves {
  final value = _teamLeaves;
  if (value == null) return null;
  if (_teamLeaves is EqualUnmodifiableListView) return _teamLeaves;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  HolidayListLeavePolicyEntity? holidayListLeavePolicy;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._logs, _logs)&&const DeepCollectionEquality().equals(other._calendarEvents, _calendarEvents)&&(identical(other.workDurations, workDurations) || other.workDurations == workDurations)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.monthSummary, monthSummary) || other.monthSummary == monthSummary)&&(identical(other.leaveDetails, leaveDetails) || other.leaveDetails == leaveDetails)&&const DeepCollectionEquality().equals(other._leaveHistory, _leaveHistory)&&const DeepCollectionEquality().equals(other._teamLeaves, _teamLeaves)&&(identical(other.holidayListLeavePolicy, holidayListLeavePolicy) || other.holidayListLeavePolicy == holidayListLeavePolicy));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_logs),const DeepCollectionEquality().hash(_calendarEvents),workDurations,userName,profileImage,monthSummary,leaveDetails,const DeepCollectionEquality().hash(_leaveHistory),const DeepCollectionEquality().hash(_teamLeaves),holidayListLeavePolicy);

@override
String toString() {
  return 'AttendanceState.loaded(status: $status, logs: $logs, calendarEvents: $calendarEvents, workDurations: $workDurations, userName: $userName, profileImage: $profileImage, monthSummary: $monthSummary, leaveDetails: $leaveDetails, leaveHistory: $leaveHistory, teamLeaves: $teamLeaves, holidayListLeavePolicy: $holidayListLeavePolicy)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@override @useResult
$Res call({
 AttendanceStatusEntity status, List<AttendanceLogEntity> logs, Map<String, String>? calendarEvents, AttendanceWorkDurationsEntity? workDurations, String? userName, String? profileImage, AttendanceMonthSummaryEntity? monthSummary, LeaveDetailsEntity? leaveDetails, List<LeaveHistoryEntity>? leaveHistory, List<TeamLeaveEntity>? teamLeaves, HolidayListLeavePolicyEntity? holidayListLeavePolicy
});


$AttendanceStatusEntityCopyWith<$Res> get status;$AttendanceWorkDurationsEntityCopyWith<$Res>? get workDurations;@override $LeaveDetailsEntityCopyWith<$Res>? get leaveDetails;@override $HolidayListLeavePolicyEntityCopyWith<$Res>? get holidayListLeavePolicy;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? logs = null,Object? calendarEvents = freezed,Object? workDurations = freezed,Object? userName = freezed,Object? profileImage = freezed,Object? monthSummary = freezed,Object? leaveDetails = freezed,Object? leaveHistory = freezed,Object? teamLeaves = freezed,Object? holidayListLeavePolicy = freezed,}) {
  return _then(_Loaded(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttendanceStatusEntity,logs: null == logs ? _self._logs : logs // ignore: cast_nullable_to_non_nullable
as List<AttendanceLogEntity>,calendarEvents: freezed == calendarEvents ? _self._calendarEvents : calendarEvents // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,workDurations: freezed == workDurations ? _self.workDurations : workDurations // ignore: cast_nullable_to_non_nullable
as AttendanceWorkDurationsEntity?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,monthSummary: freezed == monthSummary ? _self.monthSummary : monthSummary // ignore: cast_nullable_to_non_nullable
as AttendanceMonthSummaryEntity?,leaveDetails: freezed == leaveDetails ? _self.leaveDetails : leaveDetails // ignore: cast_nullable_to_non_nullable
as LeaveDetailsEntity?,leaveHistory: freezed == leaveHistory ? _self._leaveHistory : leaveHistory // ignore: cast_nullable_to_non_nullable
as List<LeaveHistoryEntity>?,teamLeaves: freezed == teamLeaves ? _self._teamLeaves : teamLeaves // ignore: cast_nullable_to_non_nullable
as List<TeamLeaveEntity>?,holidayListLeavePolicy: freezed == holidayListLeavePolicy ? _self.holidayListLeavePolicy : holidayListLeavePolicy // ignore: cast_nullable_to_non_nullable
as HolidayListLeavePolicyEntity?,
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
}/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveDetailsEntityCopyWith<$Res>? get leaveDetails {
    if (_self.leaveDetails == null) {
    return null;
  }

  return $LeaveDetailsEntityCopyWith<$Res>(_self.leaveDetails!, (value) {
    return _then(_self.copyWith(leaveDetails: value));
  });
}/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HolidayListLeavePolicyEntityCopyWith<$Res>? get holidayListLeavePolicy {
    if (_self.holidayListLeavePolicy == null) {
    return null;
  }

  return $HolidayListLeavePolicyEntityCopyWith<$Res>(_self.holidayListLeavePolicy!, (value) {
    return _then(_self.copyWith(holidayListLeavePolicy: value));
  });
}
}

/// @nodoc


class _AttendanceError extends AttendanceState {
  const _AttendanceError(this.message, {final  Map<String, String>? calendarEvents, this.userName, this.profileImage, this.monthSummary, this.leaveDetails, final  List<LeaveHistoryEntity>? leaveHistory, final  List<TeamLeaveEntity>? teamLeaves, this.holidayListLeavePolicy}): _calendarEvents = calendarEvents,_leaveHistory = leaveHistory,_teamLeaves = teamLeaves,super._();


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
@override final  LeaveDetailsEntity? leaveDetails;
 final  List<LeaveHistoryEntity>? _leaveHistory;
@override List<LeaveHistoryEntity>? get leaveHistory {
  final value = _leaveHistory;
  if (value == null) return null;
  if (_leaveHistory is EqualUnmodifiableListView) return _leaveHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TeamLeaveEntity>? _teamLeaves;
@override List<TeamLeaveEntity>? get teamLeaves {
  final value = _teamLeaves;
  if (value == null) return null;
  if (_teamLeaves is EqualUnmodifiableListView) return _teamLeaves;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  HolidayListLeavePolicyEntity? holidayListLeavePolicy;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceErrorCopyWith<_AttendanceError> get copyWith => __$AttendanceErrorCopyWithImpl<_AttendanceError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceError&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._calendarEvents, _calendarEvents)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.monthSummary, monthSummary) || other.monthSummary == monthSummary)&&(identical(other.leaveDetails, leaveDetails) || other.leaveDetails == leaveDetails)&&const DeepCollectionEquality().equals(other._leaveHistory, _leaveHistory)&&const DeepCollectionEquality().equals(other._teamLeaves, _teamLeaves)&&(identical(other.holidayListLeavePolicy, holidayListLeavePolicy) || other.holidayListLeavePolicy == holidayListLeavePolicy));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_calendarEvents),userName,profileImage,monthSummary,leaveDetails,const DeepCollectionEquality().hash(_leaveHistory),const DeepCollectionEquality().hash(_teamLeaves),holidayListLeavePolicy);

@override
String toString() {
  return 'AttendanceState.error(message: $message, calendarEvents: $calendarEvents, userName: $userName, profileImage: $profileImage, monthSummary: $monthSummary, leaveDetails: $leaveDetails, leaveHistory: $leaveHistory, teamLeaves: $teamLeaves, holidayListLeavePolicy: $holidayListLeavePolicy)';
}


}

/// @nodoc
abstract mixin class _$AttendanceErrorCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory _$AttendanceErrorCopyWith(_AttendanceError value, $Res Function(_AttendanceError) _then) = __$AttendanceErrorCopyWithImpl;
@override @useResult
$Res call({
 String message, Map<String, String>? calendarEvents, String? userName, String? profileImage, AttendanceMonthSummaryEntity? monthSummary, LeaveDetailsEntity? leaveDetails, List<LeaveHistoryEntity>? leaveHistory, List<TeamLeaveEntity>? teamLeaves, HolidayListLeavePolicyEntity? holidayListLeavePolicy
});


@override $LeaveDetailsEntityCopyWith<$Res>? get leaveDetails;@override $HolidayListLeavePolicyEntityCopyWith<$Res>? get holidayListLeavePolicy;

}
/// @nodoc
class __$AttendanceErrorCopyWithImpl<$Res>
    implements _$AttendanceErrorCopyWith<$Res> {
  __$AttendanceErrorCopyWithImpl(this._self, this._then);

  final _AttendanceError _self;
  final $Res Function(_AttendanceError) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? calendarEvents = freezed,Object? userName = freezed,Object? profileImage = freezed,Object? monthSummary = freezed,Object? leaveDetails = freezed,Object? leaveHistory = freezed,Object? teamLeaves = freezed,Object? holidayListLeavePolicy = freezed,}) {
  return _then(_AttendanceError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,calendarEvents: freezed == calendarEvents ? _self._calendarEvents : calendarEvents // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,monthSummary: freezed == monthSummary ? _self.monthSummary : monthSummary // ignore: cast_nullable_to_non_nullable
as AttendanceMonthSummaryEntity?,leaveDetails: freezed == leaveDetails ? _self.leaveDetails : leaveDetails // ignore: cast_nullable_to_non_nullable
as LeaveDetailsEntity?,leaveHistory: freezed == leaveHistory ? _self._leaveHistory : leaveHistory // ignore: cast_nullable_to_non_nullable
as List<LeaveHistoryEntity>?,teamLeaves: freezed == teamLeaves ? _self._teamLeaves : teamLeaves // ignore: cast_nullable_to_non_nullable
as List<TeamLeaveEntity>?,holidayListLeavePolicy: freezed == holidayListLeavePolicy ? _self.holidayListLeavePolicy : holidayListLeavePolicy // ignore: cast_nullable_to_non_nullable
as HolidayListLeavePolicyEntity?,
  ));
}

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveDetailsEntityCopyWith<$Res>? get leaveDetails {
    if (_self.leaveDetails == null) {
    return null;
  }

  return $LeaveDetailsEntityCopyWith<$Res>(_self.leaveDetails!, (value) {
    return _then(_self.copyWith(leaveDetails: value));
  });
}/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HolidayListLeavePolicyEntityCopyWith<$Res>? get holidayListLeavePolicy {
    if (_self.holidayListLeavePolicy == null) {
    return null;
  }

  return $HolidayListLeavePolicyEntityCopyWith<$Res>(_self.holidayListLeavePolicy!, (value) {
    return _then(_self.copyWith(holidayListLeavePolicy: value));
  });
}
}

// dart format on