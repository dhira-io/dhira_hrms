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

 String? get jobFamily; String? get pmsCycle; String? get pmsCycleId; List<GoalEntity> get goals; GoalEntity? get selectedGoal; String? get errorMessage;
/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceStateCopyWith<PerformanceState> get copyWith => _$PerformanceStateCopyWithImpl<PerformanceState>(this as PerformanceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceState&&(identical(other.jobFamily, jobFamily) || other.jobFamily == jobFamily)&&(identical(other.pmsCycle, pmsCycle) || other.pmsCycle == pmsCycle)&&(identical(other.pmsCycleId, pmsCycleId) || other.pmsCycleId == pmsCycleId)&&const DeepCollectionEquality().equals(other.goals, goals)&&(identical(other.selectedGoal, selectedGoal) || other.selectedGoal == selectedGoal)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,jobFamily,pmsCycle,pmsCycleId,const DeepCollectionEquality().hash(goals),selectedGoal,errorMessage);

@override
String toString() {
  return 'PerformanceState(jobFamily: $jobFamily, pmsCycle: $pmsCycle, pmsCycleId: $pmsCycleId, goals: $goals, selectedGoal: $selectedGoal, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PerformanceStateCopyWith<$Res>  {
  factory $PerformanceStateCopyWith(PerformanceState value, $Res Function(PerformanceState) _then) = _$PerformanceStateCopyWithImpl;
@useResult
$Res call({
 String? jobFamily, String? pmsCycle, String? pmsCycleId, List<GoalEntity> goals, GoalEntity? selectedGoal, String errorMessage
});


$GoalEntityCopyWith<$Res>? get selectedGoal;

}
/// @nodoc
class _$PerformanceStateCopyWithImpl<$Res>
    implements $PerformanceStateCopyWith<$Res> {
  _$PerformanceStateCopyWithImpl(this._self, this._then);

  final PerformanceState _self;
  final $Res Function(PerformanceState) _then;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jobFamily = freezed,Object? pmsCycle = freezed,Object? pmsCycleId = freezed,Object? goals = null,Object? selectedGoal = freezed,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
jobFamily: freezed == jobFamily ? _self.jobFamily : jobFamily // ignore: cast_nullable_to_non_nullable
as String?,pmsCycle: freezed == pmsCycle ? _self.pmsCycle : pmsCycle // ignore: cast_nullable_to_non_nullable
as String?,pmsCycleId: freezed == pmsCycleId ? _self.pmsCycleId : pmsCycleId // ignore: cast_nullable_to_non_nullable
as String?,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as List<GoalEntity>,selectedGoal: freezed == selectedGoal ? _self.selectedGoal : selectedGoal // ignore: cast_nullable_to_non_nullable
as GoalEntity?,errorMessage: null == errorMessage ? _self.errorMessage! : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalEntityCopyWith<$Res>? get selectedGoal {
    if (_self.selectedGoal == null) {
    return null;
  }

  return $GoalEntityCopyWith<$Res>(_self.selectedGoal!, (value) {
    return _then(_self.copyWith(selectedGoal: value));
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PerformanceInitial value)?  initial,TResult Function( PerformanceLoading value)?  loading,TResult Function( PerformanceLoaded value)?  loaded,TResult Function( PerformanceSaving value)?  saving,TResult Function( PerformanceSubmitting value)?  submitting,TResult Function( PerformanceError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PerformanceInitial() when initial != null:
return initial(_that);case PerformanceLoading() when loading != null:
return loading(_that);case PerformanceLoaded() when loaded != null:
return loaded(_that);case PerformanceSaving() when saving != null:
return saving(_that);case PerformanceSubmitting() when submitting != null:
return submitting(_that);case PerformanceError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PerformanceInitial value)  initial,required TResult Function( PerformanceLoading value)  loading,required TResult Function( PerformanceLoaded value)  loaded,required TResult Function( PerformanceSaving value)  saving,required TResult Function( PerformanceSubmitting value)  submitting,required TResult Function( PerformanceError value)  error,}){
final _that = this;
switch (_that) {
case PerformanceInitial():
return initial(_that);case PerformanceLoading():
return loading(_that);case PerformanceLoaded():
return loaded(_that);case PerformanceSaving():
return saving(_that);case PerformanceSubmitting():
return submitting(_that);case PerformanceError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PerformanceInitial value)?  initial,TResult? Function( PerformanceLoading value)?  loading,TResult? Function( PerformanceLoaded value)?  loaded,TResult? Function( PerformanceSaving value)?  saving,TResult? Function( PerformanceSubmitting value)?  submitting,TResult? Function( PerformanceError value)?  error,}){
final _that = this;
switch (_that) {
case PerformanceInitial() when initial != null:
return initial(_that);case PerformanceLoading() when loading != null:
return loading(_that);case PerformanceLoaded() when loaded != null:
return loaded(_that);case PerformanceSaving() when saving != null:
return saving(_that);case PerformanceSubmitting() when submitting != null:
return submitting(_that);case PerformanceError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String? errorMessage)?  initial,TResult Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String? errorMessage)?  loading,TResult Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String? errorMessage)?  loaded,TResult Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String? errorMessage)?  saving,TResult Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String? errorMessage)?  submitting,TResult Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String errorMessage)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PerformanceInitial() when initial != null:
return initial(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case PerformanceLoading() when loading != null:
return loading(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case PerformanceLoaded() when loaded != null:
return loaded(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case PerformanceSaving() when saving != null:
return saving(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case PerformanceSubmitting() when submitting != null:
return submitting(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case PerformanceError() when error != null:
return error(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String? errorMessage)  initial,required TResult Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String? errorMessage)  loading,required TResult Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String? errorMessage)  loaded,required TResult Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String? errorMessage)  saving,required TResult Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String? errorMessage)  submitting,required TResult Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String errorMessage)  error,}) {final _that = this;
switch (_that) {
case PerformanceInitial():
return initial(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case PerformanceLoading():
return loading(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case PerformanceLoaded():
return loaded(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case PerformanceSaving():
return saving(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case PerformanceSubmitting():
return submitting(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case PerformanceError():
return error(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String? errorMessage)?  initial,TResult? Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String? errorMessage)?  loading,TResult? Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String? errorMessage)?  loaded,TResult? Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String? errorMessage)?  saving,TResult? Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String? errorMessage)?  submitting,TResult? Function( String? jobFamily,  String? pmsCycle,  String? pmsCycleId,  List<GoalEntity> goals,  GoalEntity? selectedGoal,  String errorMessage)?  error,}) {final _that = this;
switch (_that) {
case PerformanceInitial() when initial != null:
return initial(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case PerformanceLoading() when loading != null:
return loading(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case PerformanceLoaded() when loaded != null:
return loaded(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case PerformanceSaving() when saving != null:
return saving(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case PerformanceSubmitting() when submitting != null:
return submitting(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case PerformanceError() when error != null:
return error(_that.jobFamily,_that.pmsCycle,_that.pmsCycleId,_that.goals,_that.selectedGoal,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class PerformanceInitial extends PerformanceState {
  const PerformanceInitial({this.jobFamily, this.pmsCycle, this.pmsCycleId, final  List<GoalEntity> goals = const [], this.selectedGoal, this.errorMessage}): _goals = goals,super._();
  

@override final  String? jobFamily;
@override final  String? pmsCycle;
@override final  String? pmsCycleId;
 final  List<GoalEntity> _goals;
@override@JsonKey() List<GoalEntity> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

@override final  GoalEntity? selectedGoal;
@override final  String? errorMessage;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceInitialCopyWith<PerformanceInitial> get copyWith => _$PerformanceInitialCopyWithImpl<PerformanceInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceInitial&&(identical(other.jobFamily, jobFamily) || other.jobFamily == jobFamily)&&(identical(other.pmsCycle, pmsCycle) || other.pmsCycle == pmsCycle)&&(identical(other.pmsCycleId, pmsCycleId) || other.pmsCycleId == pmsCycleId)&&const DeepCollectionEquality().equals(other._goals, _goals)&&(identical(other.selectedGoal, selectedGoal) || other.selectedGoal == selectedGoal)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,jobFamily,pmsCycle,pmsCycleId,const DeepCollectionEquality().hash(_goals),selectedGoal,errorMessage);

@override
String toString() {
  return 'PerformanceState.initial(jobFamily: $jobFamily, pmsCycle: $pmsCycle, pmsCycleId: $pmsCycleId, goals: $goals, selectedGoal: $selectedGoal, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PerformanceInitialCopyWith<$Res> implements $PerformanceStateCopyWith<$Res> {
  factory $PerformanceInitialCopyWith(PerformanceInitial value, $Res Function(PerformanceInitial) _then) = _$PerformanceInitialCopyWithImpl;
@override @useResult
$Res call({
 String? jobFamily, String? pmsCycle, String? pmsCycleId, List<GoalEntity> goals, GoalEntity? selectedGoal, String? errorMessage
});


@override $GoalEntityCopyWith<$Res>? get selectedGoal;

}
/// @nodoc
class _$PerformanceInitialCopyWithImpl<$Res>
    implements $PerformanceInitialCopyWith<$Res> {
  _$PerformanceInitialCopyWithImpl(this._self, this._then);

  final PerformanceInitial _self;
  final $Res Function(PerformanceInitial) _then;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobFamily = freezed,Object? pmsCycle = freezed,Object? pmsCycleId = freezed,Object? goals = null,Object? selectedGoal = freezed,Object? errorMessage = freezed,}) {
  return _then(PerformanceInitial(
jobFamily: freezed == jobFamily ? _self.jobFamily : jobFamily // ignore: cast_nullable_to_non_nullable
as String?,pmsCycle: freezed == pmsCycle ? _self.pmsCycle : pmsCycle // ignore: cast_nullable_to_non_nullable
as String?,pmsCycleId: freezed == pmsCycleId ? _self.pmsCycleId : pmsCycleId // ignore: cast_nullable_to_non_nullable
as String?,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<GoalEntity>,selectedGoal: freezed == selectedGoal ? _self.selectedGoal : selectedGoal // ignore: cast_nullable_to_non_nullable
as GoalEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalEntityCopyWith<$Res>? get selectedGoal {
    if (_self.selectedGoal == null) {
    return null;
  }

  return $GoalEntityCopyWith<$Res>(_self.selectedGoal!, (value) {
    return _then(_self.copyWith(selectedGoal: value));
  });
}
}

/// @nodoc


class PerformanceLoading extends PerformanceState {
  const PerformanceLoading({this.jobFamily, this.pmsCycle, this.pmsCycleId, final  List<GoalEntity> goals = const [], this.selectedGoal, this.errorMessage}): _goals = goals,super._();
  

@override final  String? jobFamily;
@override final  String? pmsCycle;
@override final  String? pmsCycleId;
 final  List<GoalEntity> _goals;
@override@JsonKey() List<GoalEntity> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

@override final  GoalEntity? selectedGoal;
@override final  String? errorMessage;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceLoadingCopyWith<PerformanceLoading> get copyWith => _$PerformanceLoadingCopyWithImpl<PerformanceLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceLoading&&(identical(other.jobFamily, jobFamily) || other.jobFamily == jobFamily)&&(identical(other.pmsCycle, pmsCycle) || other.pmsCycle == pmsCycle)&&(identical(other.pmsCycleId, pmsCycleId) || other.pmsCycleId == pmsCycleId)&&const DeepCollectionEquality().equals(other._goals, _goals)&&(identical(other.selectedGoal, selectedGoal) || other.selectedGoal == selectedGoal)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,jobFamily,pmsCycle,pmsCycleId,const DeepCollectionEquality().hash(_goals),selectedGoal,errorMessage);

@override
String toString() {
  return 'PerformanceState.loading(jobFamily: $jobFamily, pmsCycle: $pmsCycle, pmsCycleId: $pmsCycleId, goals: $goals, selectedGoal: $selectedGoal, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PerformanceLoadingCopyWith<$Res> implements $PerformanceStateCopyWith<$Res> {
  factory $PerformanceLoadingCopyWith(PerformanceLoading value, $Res Function(PerformanceLoading) _then) = _$PerformanceLoadingCopyWithImpl;
@override @useResult
$Res call({
 String? jobFamily, String? pmsCycle, String? pmsCycleId, List<GoalEntity> goals, GoalEntity? selectedGoal, String? errorMessage
});


@override $GoalEntityCopyWith<$Res>? get selectedGoal;

}
/// @nodoc
class _$PerformanceLoadingCopyWithImpl<$Res>
    implements $PerformanceLoadingCopyWith<$Res> {
  _$PerformanceLoadingCopyWithImpl(this._self, this._then);

  final PerformanceLoading _self;
  final $Res Function(PerformanceLoading) _then;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobFamily = freezed,Object? pmsCycle = freezed,Object? pmsCycleId = freezed,Object? goals = null,Object? selectedGoal = freezed,Object? errorMessage = freezed,}) {
  return _then(PerformanceLoading(
jobFamily: freezed == jobFamily ? _self.jobFamily : jobFamily // ignore: cast_nullable_to_non_nullable
as String?,pmsCycle: freezed == pmsCycle ? _self.pmsCycle : pmsCycle // ignore: cast_nullable_to_non_nullable
as String?,pmsCycleId: freezed == pmsCycleId ? _self.pmsCycleId : pmsCycleId // ignore: cast_nullable_to_non_nullable
as String?,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<GoalEntity>,selectedGoal: freezed == selectedGoal ? _self.selectedGoal : selectedGoal // ignore: cast_nullable_to_non_nullable
as GoalEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalEntityCopyWith<$Res>? get selectedGoal {
    if (_self.selectedGoal == null) {
    return null;
  }

  return $GoalEntityCopyWith<$Res>(_self.selectedGoal!, (value) {
    return _then(_self.copyWith(selectedGoal: value));
  });
}
}

/// @nodoc


class PerformanceLoaded extends PerformanceState {
  const PerformanceLoaded({this.jobFamily, this.pmsCycle, this.pmsCycleId, final  List<GoalEntity> goals = const [], this.selectedGoal, this.errorMessage}): _goals = goals,super._();
  

@override final  String? jobFamily;
@override final  String? pmsCycle;
@override final  String? pmsCycleId;
 final  List<GoalEntity> _goals;
@override@JsonKey() List<GoalEntity> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

@override final  GoalEntity? selectedGoal;
@override final  String? errorMessage;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceLoadedCopyWith<PerformanceLoaded> get copyWith => _$PerformanceLoadedCopyWithImpl<PerformanceLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceLoaded&&(identical(other.jobFamily, jobFamily) || other.jobFamily == jobFamily)&&(identical(other.pmsCycle, pmsCycle) || other.pmsCycle == pmsCycle)&&(identical(other.pmsCycleId, pmsCycleId) || other.pmsCycleId == pmsCycleId)&&const DeepCollectionEquality().equals(other._goals, _goals)&&(identical(other.selectedGoal, selectedGoal) || other.selectedGoal == selectedGoal)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,jobFamily,pmsCycle,pmsCycleId,const DeepCollectionEquality().hash(_goals),selectedGoal,errorMessage);

@override
String toString() {
  return 'PerformanceState.loaded(jobFamily: $jobFamily, pmsCycle: $pmsCycle, pmsCycleId: $pmsCycleId, goals: $goals, selectedGoal: $selectedGoal, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PerformanceLoadedCopyWith<$Res> implements $PerformanceStateCopyWith<$Res> {
  factory $PerformanceLoadedCopyWith(PerformanceLoaded value, $Res Function(PerformanceLoaded) _then) = _$PerformanceLoadedCopyWithImpl;
@override @useResult
$Res call({
 String? jobFamily, String? pmsCycle, String? pmsCycleId, List<GoalEntity> goals, GoalEntity? selectedGoal, String? errorMessage
});


@override $GoalEntityCopyWith<$Res>? get selectedGoal;

}
/// @nodoc
class _$PerformanceLoadedCopyWithImpl<$Res>
    implements $PerformanceLoadedCopyWith<$Res> {
  _$PerformanceLoadedCopyWithImpl(this._self, this._then);

  final PerformanceLoaded _self;
  final $Res Function(PerformanceLoaded) _then;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobFamily = freezed,Object? pmsCycle = freezed,Object? pmsCycleId = freezed,Object? goals = null,Object? selectedGoal = freezed,Object? errorMessage = freezed,}) {
  return _then(PerformanceLoaded(
jobFamily: freezed == jobFamily ? _self.jobFamily : jobFamily // ignore: cast_nullable_to_non_nullable
as String?,pmsCycle: freezed == pmsCycle ? _self.pmsCycle : pmsCycle // ignore: cast_nullable_to_non_nullable
as String?,pmsCycleId: freezed == pmsCycleId ? _self.pmsCycleId : pmsCycleId // ignore: cast_nullable_to_non_nullable
as String?,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<GoalEntity>,selectedGoal: freezed == selectedGoal ? _self.selectedGoal : selectedGoal // ignore: cast_nullable_to_non_nullable
as GoalEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalEntityCopyWith<$Res>? get selectedGoal {
    if (_self.selectedGoal == null) {
    return null;
  }

  return $GoalEntityCopyWith<$Res>(_self.selectedGoal!, (value) {
    return _then(_self.copyWith(selectedGoal: value));
  });
}
}

/// @nodoc


class PerformanceSaving extends PerformanceState {
  const PerformanceSaving({this.jobFamily, this.pmsCycle, this.pmsCycleId, final  List<GoalEntity> goals = const [], this.selectedGoal, this.errorMessage}): _goals = goals,super._();
  

@override final  String? jobFamily;
@override final  String? pmsCycle;
@override final  String? pmsCycleId;
 final  List<GoalEntity> _goals;
@override@JsonKey() List<GoalEntity> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

@override final  GoalEntity? selectedGoal;
@override final  String? errorMessage;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceSavingCopyWith<PerformanceSaving> get copyWith => _$PerformanceSavingCopyWithImpl<PerformanceSaving>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceSaving&&(identical(other.jobFamily, jobFamily) || other.jobFamily == jobFamily)&&(identical(other.pmsCycle, pmsCycle) || other.pmsCycle == pmsCycle)&&(identical(other.pmsCycleId, pmsCycleId) || other.pmsCycleId == pmsCycleId)&&const DeepCollectionEquality().equals(other._goals, _goals)&&(identical(other.selectedGoal, selectedGoal) || other.selectedGoal == selectedGoal)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,jobFamily,pmsCycle,pmsCycleId,const DeepCollectionEquality().hash(_goals),selectedGoal,errorMessage);

@override
String toString() {
  return 'PerformanceState.saving(jobFamily: $jobFamily, pmsCycle: $pmsCycle, pmsCycleId: $pmsCycleId, goals: $goals, selectedGoal: $selectedGoal, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PerformanceSavingCopyWith<$Res> implements $PerformanceStateCopyWith<$Res> {
  factory $PerformanceSavingCopyWith(PerformanceSaving value, $Res Function(PerformanceSaving) _then) = _$PerformanceSavingCopyWithImpl;
@override @useResult
$Res call({
 String? jobFamily, String? pmsCycle, String? pmsCycleId, List<GoalEntity> goals, GoalEntity? selectedGoal, String? errorMessage
});


@override $GoalEntityCopyWith<$Res>? get selectedGoal;

}
/// @nodoc
class _$PerformanceSavingCopyWithImpl<$Res>
    implements $PerformanceSavingCopyWith<$Res> {
  _$PerformanceSavingCopyWithImpl(this._self, this._then);

  final PerformanceSaving _self;
  final $Res Function(PerformanceSaving) _then;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobFamily = freezed,Object? pmsCycle = freezed,Object? pmsCycleId = freezed,Object? goals = null,Object? selectedGoal = freezed,Object? errorMessage = freezed,}) {
  return _then(PerformanceSaving(
jobFamily: freezed == jobFamily ? _self.jobFamily : jobFamily // ignore: cast_nullable_to_non_nullable
as String?,pmsCycle: freezed == pmsCycle ? _self.pmsCycle : pmsCycle // ignore: cast_nullable_to_non_nullable
as String?,pmsCycleId: freezed == pmsCycleId ? _self.pmsCycleId : pmsCycleId // ignore: cast_nullable_to_non_nullable
as String?,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<GoalEntity>,selectedGoal: freezed == selectedGoal ? _self.selectedGoal : selectedGoal // ignore: cast_nullable_to_non_nullable
as GoalEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalEntityCopyWith<$Res>? get selectedGoal {
    if (_self.selectedGoal == null) {
    return null;
  }

  return $GoalEntityCopyWith<$Res>(_self.selectedGoal!, (value) {
    return _then(_self.copyWith(selectedGoal: value));
  });
}
}

/// @nodoc


class PerformanceSubmitting extends PerformanceState {
  const PerformanceSubmitting({this.jobFamily, this.pmsCycle, this.pmsCycleId, final  List<GoalEntity> goals = const [], this.selectedGoal, this.errorMessage}): _goals = goals,super._();
  

@override final  String? jobFamily;
@override final  String? pmsCycle;
@override final  String? pmsCycleId;
 final  List<GoalEntity> _goals;
@override@JsonKey() List<GoalEntity> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

@override final  GoalEntity? selectedGoal;
@override final  String? errorMessage;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceSubmittingCopyWith<PerformanceSubmitting> get copyWith => _$PerformanceSubmittingCopyWithImpl<PerformanceSubmitting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceSubmitting&&(identical(other.jobFamily, jobFamily) || other.jobFamily == jobFamily)&&(identical(other.pmsCycle, pmsCycle) || other.pmsCycle == pmsCycle)&&(identical(other.pmsCycleId, pmsCycleId) || other.pmsCycleId == pmsCycleId)&&const DeepCollectionEquality().equals(other._goals, _goals)&&(identical(other.selectedGoal, selectedGoal) || other.selectedGoal == selectedGoal)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,jobFamily,pmsCycle,pmsCycleId,const DeepCollectionEquality().hash(_goals),selectedGoal,errorMessage);

@override
String toString() {
  return 'PerformanceState.submitting(jobFamily: $jobFamily, pmsCycle: $pmsCycle, pmsCycleId: $pmsCycleId, goals: $goals, selectedGoal: $selectedGoal, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PerformanceSubmittingCopyWith<$Res> implements $PerformanceStateCopyWith<$Res> {
  factory $PerformanceSubmittingCopyWith(PerformanceSubmitting value, $Res Function(PerformanceSubmitting) _then) = _$PerformanceSubmittingCopyWithImpl;
@override @useResult
$Res call({
 String? jobFamily, String? pmsCycle, String? pmsCycleId, List<GoalEntity> goals, GoalEntity? selectedGoal, String? errorMessage
});


@override $GoalEntityCopyWith<$Res>? get selectedGoal;

}
/// @nodoc
class _$PerformanceSubmittingCopyWithImpl<$Res>
    implements $PerformanceSubmittingCopyWith<$Res> {
  _$PerformanceSubmittingCopyWithImpl(this._self, this._then);

  final PerformanceSubmitting _self;
  final $Res Function(PerformanceSubmitting) _then;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobFamily = freezed,Object? pmsCycle = freezed,Object? pmsCycleId = freezed,Object? goals = null,Object? selectedGoal = freezed,Object? errorMessage = freezed,}) {
  return _then(PerformanceSubmitting(
jobFamily: freezed == jobFamily ? _self.jobFamily : jobFamily // ignore: cast_nullable_to_non_nullable
as String?,pmsCycle: freezed == pmsCycle ? _self.pmsCycle : pmsCycle // ignore: cast_nullable_to_non_nullable
as String?,pmsCycleId: freezed == pmsCycleId ? _self.pmsCycleId : pmsCycleId // ignore: cast_nullable_to_non_nullable
as String?,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<GoalEntity>,selectedGoal: freezed == selectedGoal ? _self.selectedGoal : selectedGoal // ignore: cast_nullable_to_non_nullable
as GoalEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalEntityCopyWith<$Res>? get selectedGoal {
    if (_self.selectedGoal == null) {
    return null;
  }

  return $GoalEntityCopyWith<$Res>(_self.selectedGoal!, (value) {
    return _then(_self.copyWith(selectedGoal: value));
  });
}
}

/// @nodoc


class PerformanceError extends PerformanceState {
  const PerformanceError({this.jobFamily, this.pmsCycle, this.pmsCycleId, final  List<GoalEntity> goals = const [], this.selectedGoal, required this.errorMessage}): _goals = goals,super._();
  

@override final  String? jobFamily;
@override final  String? pmsCycle;
@override final  String? pmsCycleId;
 final  List<GoalEntity> _goals;
@override@JsonKey() List<GoalEntity> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

@override final  GoalEntity? selectedGoal;
@override final  String errorMessage;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceErrorCopyWith<PerformanceError> get copyWith => _$PerformanceErrorCopyWithImpl<PerformanceError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceError&&(identical(other.jobFamily, jobFamily) || other.jobFamily == jobFamily)&&(identical(other.pmsCycle, pmsCycle) || other.pmsCycle == pmsCycle)&&(identical(other.pmsCycleId, pmsCycleId) || other.pmsCycleId == pmsCycleId)&&const DeepCollectionEquality().equals(other._goals, _goals)&&(identical(other.selectedGoal, selectedGoal) || other.selectedGoal == selectedGoal)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,jobFamily,pmsCycle,pmsCycleId,const DeepCollectionEquality().hash(_goals),selectedGoal,errorMessage);

@override
String toString() {
  return 'PerformanceState.error(jobFamily: $jobFamily, pmsCycle: $pmsCycle, pmsCycleId: $pmsCycleId, goals: $goals, selectedGoal: $selectedGoal, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PerformanceErrorCopyWith<$Res> implements $PerformanceStateCopyWith<$Res> {
  factory $PerformanceErrorCopyWith(PerformanceError value, $Res Function(PerformanceError) _then) = _$PerformanceErrorCopyWithImpl;
@override @useResult
$Res call({
 String? jobFamily, String? pmsCycle, String? pmsCycleId, List<GoalEntity> goals, GoalEntity? selectedGoal, String errorMessage
});


@override $GoalEntityCopyWith<$Res>? get selectedGoal;

}
/// @nodoc
class _$PerformanceErrorCopyWithImpl<$Res>
    implements $PerformanceErrorCopyWith<$Res> {
  _$PerformanceErrorCopyWithImpl(this._self, this._then);

  final PerformanceError _self;
  final $Res Function(PerformanceError) _then;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobFamily = freezed,Object? pmsCycle = freezed,Object? pmsCycleId = freezed,Object? goals = null,Object? selectedGoal = freezed,Object? errorMessage = null,}) {
  return _then(PerformanceError(
jobFamily: freezed == jobFamily ? _self.jobFamily : jobFamily // ignore: cast_nullable_to_non_nullable
as String?,pmsCycle: freezed == pmsCycle ? _self.pmsCycle : pmsCycle // ignore: cast_nullable_to_non_nullable
as String?,pmsCycleId: freezed == pmsCycleId ? _self.pmsCycleId : pmsCycleId // ignore: cast_nullable_to_non_nullable
as String?,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<GoalEntity>,selectedGoal: freezed == selectedGoal ? _self.selectedGoal : selectedGoal // ignore: cast_nullable_to_non_nullable
as GoalEntity?,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalEntityCopyWith<$Res>? get selectedGoal {
    if (_self.selectedGoal == null) {
    return null;
  }

  return $GoalEntityCopyWith<$Res>(_self.selectedGoal!, (value) {
    return _then(_self.copyWith(selectedGoal: value));
  });
}
}

// dart format on
