// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timesheet_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimesheetEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimesheetEvent()';
}


}

/// @nodoc
class $TimesheetEventCopyWith<$Res>  {
$TimesheetEventCopyWith(TimesheetEvent _, $Res Function(TimesheetEvent) __);
}


/// Adds pattern-matching-related methods to [TimesheetEvent].
extension TimesheetEventPatterns on TimesheetEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TimesheetStarted value)?  started,TResult Function( TimesheetUserInitRequested value)?  userInitRequested,TResult Function( TimesheetFromDateChanged value)?  fromDateChanged,TResult Function( TimesheetToDateChanged value)?  toDateChanged,TResult Function( TimesheetAssignmentsChanged value)?  assignmentsChanged,TResult Function( TimesheetDaySelected value)?  daySelected,TResult Function( TimesheetSubmitRequested value)?  submitRequested,TResult Function( TimesheetUpdateRequested value)?  updateRequested,TResult Function( TimesheetFetchMonthWiseRequested value)?  fetchMonthWiseRequested,TResult Function( TimesheetDeleteEntryRequested value)?  deleteEntryRequested,TResult Function( TimesheetFetchOverviewRequested value)?  fetchOverviewRequested,TResult Function( TimesheetSubmitWeeklyRequested value)?  submitWeeklyRequested,TResult Function( TimesheetEditTaskRequested value)?  editTaskRequested,TResult Function( TimesheetEditTaskCleared value)?  editTaskCleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TimesheetStarted() when started != null:
return started(_that);case TimesheetUserInitRequested() when userInitRequested != null:
return userInitRequested(_that);case TimesheetFromDateChanged() when fromDateChanged != null:
return fromDateChanged(_that);case TimesheetToDateChanged() when toDateChanged != null:
return toDateChanged(_that);case TimesheetAssignmentsChanged() when assignmentsChanged != null:
return assignmentsChanged(_that);case TimesheetDaySelected() when daySelected != null:
return daySelected(_that);case TimesheetSubmitRequested() when submitRequested != null:
return submitRequested(_that);case TimesheetUpdateRequested() when updateRequested != null:
return updateRequested(_that);case TimesheetFetchMonthWiseRequested() when fetchMonthWiseRequested != null:
return fetchMonthWiseRequested(_that);case TimesheetDeleteEntryRequested() when deleteEntryRequested != null:
return deleteEntryRequested(_that);case TimesheetFetchOverviewRequested() when fetchOverviewRequested != null:
return fetchOverviewRequested(_that);case TimesheetSubmitWeeklyRequested() when submitWeeklyRequested != null:
return submitWeeklyRequested(_that);case TimesheetEditTaskRequested() when editTaskRequested != null:
return editTaskRequested(_that);case TimesheetEditTaskCleared() when editTaskCleared != null:
return editTaskCleared(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TimesheetStarted value)  started,required TResult Function( TimesheetUserInitRequested value)  userInitRequested,required TResult Function( TimesheetFromDateChanged value)  fromDateChanged,required TResult Function( TimesheetToDateChanged value)  toDateChanged,required TResult Function( TimesheetAssignmentsChanged value)  assignmentsChanged,required TResult Function( TimesheetDaySelected value)  daySelected,required TResult Function( TimesheetSubmitRequested value)  submitRequested,required TResult Function( TimesheetUpdateRequested value)  updateRequested,required TResult Function( TimesheetFetchMonthWiseRequested value)  fetchMonthWiseRequested,required TResult Function( TimesheetDeleteEntryRequested value)  deleteEntryRequested,required TResult Function( TimesheetFetchOverviewRequested value)  fetchOverviewRequested,required TResult Function( TimesheetSubmitWeeklyRequested value)  submitWeeklyRequested,required TResult Function( TimesheetEditTaskRequested value)  editTaskRequested,required TResult Function( TimesheetEditTaskCleared value)  editTaskCleared,}){
final _that = this;
switch (_that) {
case TimesheetStarted():
return started(_that);case TimesheetUserInitRequested():
return userInitRequested(_that);case TimesheetFromDateChanged():
return fromDateChanged(_that);case TimesheetToDateChanged():
return toDateChanged(_that);case TimesheetAssignmentsChanged():
return assignmentsChanged(_that);case TimesheetDaySelected():
return daySelected(_that);case TimesheetSubmitRequested():
return submitRequested(_that);case TimesheetUpdateRequested():
return updateRequested(_that);case TimesheetFetchMonthWiseRequested():
return fetchMonthWiseRequested(_that);case TimesheetDeleteEntryRequested():
return deleteEntryRequested(_that);case TimesheetFetchOverviewRequested():
return fetchOverviewRequested(_that);case TimesheetSubmitWeeklyRequested():
return submitWeeklyRequested(_that);case TimesheetEditTaskRequested():
return editTaskRequested(_that);case TimesheetEditTaskCleared():
return editTaskCleared(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TimesheetStarted value)?  started,TResult? Function( TimesheetUserInitRequested value)?  userInitRequested,TResult? Function( TimesheetFromDateChanged value)?  fromDateChanged,TResult? Function( TimesheetToDateChanged value)?  toDateChanged,TResult? Function( TimesheetAssignmentsChanged value)?  assignmentsChanged,TResult? Function( TimesheetDaySelected value)?  daySelected,TResult? Function( TimesheetSubmitRequested value)?  submitRequested,TResult? Function( TimesheetUpdateRequested value)?  updateRequested,TResult? Function( TimesheetFetchMonthWiseRequested value)?  fetchMonthWiseRequested,TResult? Function( TimesheetDeleteEntryRequested value)?  deleteEntryRequested,TResult? Function( TimesheetFetchOverviewRequested value)?  fetchOverviewRequested,TResult? Function( TimesheetSubmitWeeklyRequested value)?  submitWeeklyRequested,TResult? Function( TimesheetEditTaskRequested value)?  editTaskRequested,TResult? Function( TimesheetEditTaskCleared value)?  editTaskCleared,}){
final _that = this;
switch (_that) {
case TimesheetStarted() when started != null:
return started(_that);case TimesheetUserInitRequested() when userInitRequested != null:
return userInitRequested(_that);case TimesheetFromDateChanged() when fromDateChanged != null:
return fromDateChanged(_that);case TimesheetToDateChanged() when toDateChanged != null:
return toDateChanged(_that);case TimesheetAssignmentsChanged() when assignmentsChanged != null:
return assignmentsChanged(_that);case TimesheetDaySelected() when daySelected != null:
return daySelected(_that);case TimesheetSubmitRequested() when submitRequested != null:
return submitRequested(_that);case TimesheetUpdateRequested() when updateRequested != null:
return updateRequested(_that);case TimesheetFetchMonthWiseRequested() when fetchMonthWiseRequested != null:
return fetchMonthWiseRequested(_that);case TimesheetDeleteEntryRequested() when deleteEntryRequested != null:
return deleteEntryRequested(_that);case TimesheetFetchOverviewRequested() when fetchOverviewRequested != null:
return fetchOverviewRequested(_that);case TimesheetSubmitWeeklyRequested() when submitWeeklyRequested != null:
return submitWeeklyRequested(_that);case TimesheetEditTaskRequested() when editTaskRequested != null:
return editTaskRequested(_that);case TimesheetEditTaskCleared() when editTaskCleared != null:
return editTaskCleared(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? timesheetId)?  started,TResult Function()?  userInitRequested,TResult Function( DateTime? date)?  fromDateChanged,TResult Function( DateTime? date)?  toDateChanged,TResult Function( List<ProjectAssignmentEntity> assignments)?  assignmentsChanged,TResult Function( DateTime date)?  daySelected,TResult Function( String employee,  String department,  String approver,  String fromDate,  String toDate,  List<ProjectAssignmentEntity> assignments,  int docStatus)?  submitRequested,TResult Function( String name,  String employee,  String department,  String approver,  String fromDate,  String toDate,  int approved,  double hoursTotal,  List<ProjectAssignmentEntity> assignments)?  updateRequested,TResult Function( int month,  int year)?  fetchMonthWiseRequested,TResult Function( String name,  String parent,  String date)?  deleteEntryRequested,TResult Function( int month,  int year)?  fetchOverviewRequested,TResult Function()?  submitWeeklyRequested,TResult Function( ProjectAssignmentEntity task,  int index)?  editTaskRequested,TResult Function()?  editTaskCleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TimesheetStarted() when started != null:
return started(_that.timesheetId);case TimesheetUserInitRequested() when userInitRequested != null:
return userInitRequested();case TimesheetFromDateChanged() when fromDateChanged != null:
return fromDateChanged(_that.date);case TimesheetToDateChanged() when toDateChanged != null:
return toDateChanged(_that.date);case TimesheetAssignmentsChanged() when assignmentsChanged != null:
return assignmentsChanged(_that.assignments);case TimesheetDaySelected() when daySelected != null:
return daySelected(_that.date);case TimesheetSubmitRequested() when submitRequested != null:
return submitRequested(_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.assignments,_that.docStatus);case TimesheetUpdateRequested() when updateRequested != null:
return updateRequested(_that.name,_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.approved,_that.hoursTotal,_that.assignments);case TimesheetFetchMonthWiseRequested() when fetchMonthWiseRequested != null:
return fetchMonthWiseRequested(_that.month,_that.year);case TimesheetDeleteEntryRequested() when deleteEntryRequested != null:
return deleteEntryRequested(_that.name,_that.parent,_that.date);case TimesheetFetchOverviewRequested() when fetchOverviewRequested != null:
return fetchOverviewRequested(_that.month,_that.year);case TimesheetSubmitWeeklyRequested() when submitWeeklyRequested != null:
return submitWeeklyRequested();case TimesheetEditTaskRequested() when editTaskRequested != null:
return editTaskRequested(_that.task,_that.index);case TimesheetEditTaskCleared() when editTaskCleared != null:
return editTaskCleared();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? timesheetId)  started,required TResult Function()  userInitRequested,required TResult Function( DateTime? date)  fromDateChanged,required TResult Function( DateTime? date)  toDateChanged,required TResult Function( List<ProjectAssignmentEntity> assignments)  assignmentsChanged,required TResult Function( DateTime date)  daySelected,required TResult Function( String employee,  String department,  String approver,  String fromDate,  String toDate,  List<ProjectAssignmentEntity> assignments,  int docStatus)  submitRequested,required TResult Function( String name,  String employee,  String department,  String approver,  String fromDate,  String toDate,  int approved,  double hoursTotal,  List<ProjectAssignmentEntity> assignments)  updateRequested,required TResult Function( int month,  int year)  fetchMonthWiseRequested,required TResult Function( String name,  String parent,  String date)  deleteEntryRequested,required TResult Function( int month,  int year)  fetchOverviewRequested,required TResult Function()  submitWeeklyRequested,required TResult Function( ProjectAssignmentEntity task,  int index)  editTaskRequested,required TResult Function()  editTaskCleared,}) {final _that = this;
switch (_that) {
case TimesheetStarted():
return started(_that.timesheetId);case TimesheetUserInitRequested():
return userInitRequested();case TimesheetFromDateChanged():
return fromDateChanged(_that.date);case TimesheetToDateChanged():
return toDateChanged(_that.date);case TimesheetAssignmentsChanged():
return assignmentsChanged(_that.assignments);case TimesheetDaySelected():
return daySelected(_that.date);case TimesheetSubmitRequested():
return submitRequested(_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.assignments,_that.docStatus);case TimesheetUpdateRequested():
return updateRequested(_that.name,_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.approved,_that.hoursTotal,_that.assignments);case TimesheetFetchMonthWiseRequested():
return fetchMonthWiseRequested(_that.month,_that.year);case TimesheetDeleteEntryRequested():
return deleteEntryRequested(_that.name,_that.parent,_that.date);case TimesheetFetchOverviewRequested():
return fetchOverviewRequested(_that.month,_that.year);case TimesheetSubmitWeeklyRequested():
return submitWeeklyRequested();case TimesheetEditTaskRequested():
return editTaskRequested(_that.task,_that.index);case TimesheetEditTaskCleared():
return editTaskCleared();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? timesheetId)?  started,TResult? Function()?  userInitRequested,TResult? Function( DateTime? date)?  fromDateChanged,TResult? Function( DateTime? date)?  toDateChanged,TResult? Function( List<ProjectAssignmentEntity> assignments)?  assignmentsChanged,TResult? Function( DateTime date)?  daySelected,TResult? Function( String employee,  String department,  String approver,  String fromDate,  String toDate,  List<ProjectAssignmentEntity> assignments,  int docStatus)?  submitRequested,TResult? Function( String name,  String employee,  String department,  String approver,  String fromDate,  String toDate,  int approved,  double hoursTotal,  List<ProjectAssignmentEntity> assignments)?  updateRequested,TResult? Function( int month,  int year)?  fetchMonthWiseRequested,TResult? Function( String name,  String parent,  String date)?  deleteEntryRequested,TResult? Function( int month,  int year)?  fetchOverviewRequested,TResult? Function()?  submitWeeklyRequested,TResult? Function( ProjectAssignmentEntity task,  int index)?  editTaskRequested,TResult? Function()?  editTaskCleared,}) {final _that = this;
switch (_that) {
case TimesheetStarted() when started != null:
return started(_that.timesheetId);case TimesheetUserInitRequested() when userInitRequested != null:
return userInitRequested();case TimesheetFromDateChanged() when fromDateChanged != null:
return fromDateChanged(_that.date);case TimesheetToDateChanged() when toDateChanged != null:
return toDateChanged(_that.date);case TimesheetAssignmentsChanged() when assignmentsChanged != null:
return assignmentsChanged(_that.assignments);case TimesheetDaySelected() when daySelected != null:
return daySelected(_that.date);case TimesheetSubmitRequested() when submitRequested != null:
return submitRequested(_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.assignments,_that.docStatus);case TimesheetUpdateRequested() when updateRequested != null:
return updateRequested(_that.name,_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.approved,_that.hoursTotal,_that.assignments);case TimesheetFetchMonthWiseRequested() when fetchMonthWiseRequested != null:
return fetchMonthWiseRequested(_that.month,_that.year);case TimesheetDeleteEntryRequested() when deleteEntryRequested != null:
return deleteEntryRequested(_that.name,_that.parent,_that.date);case TimesheetFetchOverviewRequested() when fetchOverviewRequested != null:
return fetchOverviewRequested(_that.month,_that.year);case TimesheetSubmitWeeklyRequested() when submitWeeklyRequested != null:
return submitWeeklyRequested();case TimesheetEditTaskRequested() when editTaskRequested != null:
return editTaskRequested(_that.task,_that.index);case TimesheetEditTaskCleared() when editTaskCleared != null:
return editTaskCleared();case _:
  return null;

}
}

}

/// @nodoc


class TimesheetStarted extends TimesheetEvent {
  const TimesheetStarted({this.timesheetId}): super._();
  

 final  String? timesheetId;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetStartedCopyWith<TimesheetStarted> get copyWith => _$TimesheetStartedCopyWithImpl<TimesheetStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetStarted&&(identical(other.timesheetId, timesheetId) || other.timesheetId == timesheetId));
}


@override
int get hashCode => Object.hash(runtimeType,timesheetId);

@override
String toString() {
  return 'TimesheetEvent.started(timesheetId: $timesheetId)';
}


}

/// @nodoc
abstract mixin class $TimesheetStartedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory $TimesheetStartedCopyWith(TimesheetStarted value, $Res Function(TimesheetStarted) _then) = _$TimesheetStartedCopyWithImpl;
@useResult
$Res call({
 String? timesheetId
});




}
/// @nodoc
class _$TimesheetStartedCopyWithImpl<$Res>
    implements $TimesheetStartedCopyWith<$Res> {
  _$TimesheetStartedCopyWithImpl(this._self, this._then);

  final TimesheetStarted _self;
  final $Res Function(TimesheetStarted) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? timesheetId = freezed,}) {
  return _then(TimesheetStarted(
timesheetId: freezed == timesheetId ? _self.timesheetId : timesheetId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class TimesheetUserInitRequested extends TimesheetEvent {
  const TimesheetUserInitRequested(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetUserInitRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimesheetEvent.userInitRequested()';
}


}




/// @nodoc


class TimesheetFromDateChanged extends TimesheetEvent {
  const TimesheetFromDateChanged(this.date): super._();
  

 final  DateTime? date;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetFromDateChangedCopyWith<TimesheetFromDateChanged> get copyWith => _$TimesheetFromDateChangedCopyWithImpl<TimesheetFromDateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetFromDateChanged&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'TimesheetEvent.fromDateChanged(date: $date)';
}


}

/// @nodoc
abstract mixin class $TimesheetFromDateChangedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory $TimesheetFromDateChangedCopyWith(TimesheetFromDateChanged value, $Res Function(TimesheetFromDateChanged) _then) = _$TimesheetFromDateChangedCopyWithImpl;
@useResult
$Res call({
 DateTime? date
});




}
/// @nodoc
class _$TimesheetFromDateChangedCopyWithImpl<$Res>
    implements $TimesheetFromDateChangedCopyWith<$Res> {
  _$TimesheetFromDateChangedCopyWithImpl(this._self, this._then);

  final TimesheetFromDateChanged _self;
  final $Res Function(TimesheetFromDateChanged) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = freezed,}) {
  return _then(TimesheetFromDateChanged(
freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class TimesheetToDateChanged extends TimesheetEvent {
  const TimesheetToDateChanged(this.date): super._();
  

 final  DateTime? date;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetToDateChangedCopyWith<TimesheetToDateChanged> get copyWith => _$TimesheetToDateChangedCopyWithImpl<TimesheetToDateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetToDateChanged&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'TimesheetEvent.toDateChanged(date: $date)';
}


}

/// @nodoc
abstract mixin class $TimesheetToDateChangedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory $TimesheetToDateChangedCopyWith(TimesheetToDateChanged value, $Res Function(TimesheetToDateChanged) _then) = _$TimesheetToDateChangedCopyWithImpl;
@useResult
$Res call({
 DateTime? date
});




}
/// @nodoc
class _$TimesheetToDateChangedCopyWithImpl<$Res>
    implements $TimesheetToDateChangedCopyWith<$Res> {
  _$TimesheetToDateChangedCopyWithImpl(this._self, this._then);

  final TimesheetToDateChanged _self;
  final $Res Function(TimesheetToDateChanged) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = freezed,}) {
  return _then(TimesheetToDateChanged(
freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class TimesheetAssignmentsChanged extends TimesheetEvent {
  const TimesheetAssignmentsChanged(final  List<ProjectAssignmentEntity> assignments): _assignments = assignments,super._();
  

 final  List<ProjectAssignmentEntity> _assignments;
 List<ProjectAssignmentEntity> get assignments {
  if (_assignments is EqualUnmodifiableListView) return _assignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignments);
}


/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetAssignmentsChangedCopyWith<TimesheetAssignmentsChanged> get copyWith => _$TimesheetAssignmentsChangedCopyWithImpl<TimesheetAssignmentsChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetAssignmentsChanged&&const DeepCollectionEquality().equals(other._assignments, _assignments));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_assignments));

@override
String toString() {
  return 'TimesheetEvent.assignmentsChanged(assignments: $assignments)';
}


}

/// @nodoc
abstract mixin class $TimesheetAssignmentsChangedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory $TimesheetAssignmentsChangedCopyWith(TimesheetAssignmentsChanged value, $Res Function(TimesheetAssignmentsChanged) _then) = _$TimesheetAssignmentsChangedCopyWithImpl;
@useResult
$Res call({
 List<ProjectAssignmentEntity> assignments
});




}
/// @nodoc
class _$TimesheetAssignmentsChangedCopyWithImpl<$Res>
    implements $TimesheetAssignmentsChangedCopyWith<$Res> {
  _$TimesheetAssignmentsChangedCopyWithImpl(this._self, this._then);

  final TimesheetAssignmentsChanged _self;
  final $Res Function(TimesheetAssignmentsChanged) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? assignments = null,}) {
  return _then(TimesheetAssignmentsChanged(
null == assignments ? _self._assignments : assignments // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,
  ));
}


}

/// @nodoc


class TimesheetDaySelected extends TimesheetEvent {
  const TimesheetDaySelected(this.date): super._();
  

 final  DateTime date;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetDaySelectedCopyWith<TimesheetDaySelected> get copyWith => _$TimesheetDaySelectedCopyWithImpl<TimesheetDaySelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetDaySelected&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'TimesheetEvent.daySelected(date: $date)';
}


}

/// @nodoc
abstract mixin class $TimesheetDaySelectedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory $TimesheetDaySelectedCopyWith(TimesheetDaySelected value, $Res Function(TimesheetDaySelected) _then) = _$TimesheetDaySelectedCopyWithImpl;
@useResult
$Res call({
 DateTime date
});




}
/// @nodoc
class _$TimesheetDaySelectedCopyWithImpl<$Res>
    implements $TimesheetDaySelectedCopyWith<$Res> {
  _$TimesheetDaySelectedCopyWithImpl(this._self, this._then);

  final TimesheetDaySelected _self;
  final $Res Function(TimesheetDaySelected) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,}) {
  return _then(TimesheetDaySelected(
null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class TimesheetSubmitRequested extends TimesheetEvent {
  const TimesheetSubmitRequested({required this.employee, required this.department, required this.approver, required this.fromDate, required this.toDate, required final  List<ProjectAssignmentEntity> assignments, required this.docStatus}): _assignments = assignments,super._();
  

 final  String employee;
 final  String department;
 final  String approver;
 final  String fromDate;
 final  String toDate;
 final  List<ProjectAssignmentEntity> _assignments;
 List<ProjectAssignmentEntity> get assignments {
  if (_assignments is EqualUnmodifiableListView) return _assignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignments);
}

 final  int docStatus;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetSubmitRequestedCopyWith<TimesheetSubmitRequested> get copyWith => _$TimesheetSubmitRequestedCopyWithImpl<TimesheetSubmitRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetSubmitRequested&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.department, department) || other.department == department)&&(identical(other.approver, approver) || other.approver == approver)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&const DeepCollectionEquality().equals(other._assignments, _assignments)&&(identical(other.docStatus, docStatus) || other.docStatus == docStatus));
}


@override
int get hashCode => Object.hash(runtimeType,employee,department,approver,fromDate,toDate,const DeepCollectionEquality().hash(_assignments),docStatus);

@override
String toString() {
  return 'TimesheetEvent.submitRequested(employee: $employee, department: $department, approver: $approver, fromDate: $fromDate, toDate: $toDate, assignments: $assignments, docStatus: $docStatus)';
}


}

/// @nodoc
abstract mixin class $TimesheetSubmitRequestedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory $TimesheetSubmitRequestedCopyWith(TimesheetSubmitRequested value, $Res Function(TimesheetSubmitRequested) _then) = _$TimesheetSubmitRequestedCopyWithImpl;
@useResult
$Res call({
 String employee, String department, String approver, String fromDate, String toDate, List<ProjectAssignmentEntity> assignments, int docStatus
});




}
/// @nodoc
class _$TimesheetSubmitRequestedCopyWithImpl<$Res>
    implements $TimesheetSubmitRequestedCopyWith<$Res> {
  _$TimesheetSubmitRequestedCopyWithImpl(this._self, this._then);

  final TimesheetSubmitRequested _self;
  final $Res Function(TimesheetSubmitRequested) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? employee = null,Object? department = null,Object? approver = null,Object? fromDate = null,Object? toDate = null,Object? assignments = null,Object? docStatus = null,}) {
  return _then(TimesheetSubmitRequested(
employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,approver: null == approver ? _self.approver : approver // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,assignments: null == assignments ? _self._assignments : assignments // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,docStatus: null == docStatus ? _self.docStatus : docStatus // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class TimesheetUpdateRequested extends TimesheetEvent {
  const TimesheetUpdateRequested({required this.name, required this.employee, required this.department, required this.approver, required this.fromDate, required this.toDate, required this.approved, required this.hoursTotal, required final  List<ProjectAssignmentEntity> assignments}): _assignments = assignments,super._();
  

 final  String name;
 final  String employee;
 final  String department;
 final  String approver;
 final  String fromDate;
 final  String toDate;
 final  int approved;
 final  double hoursTotal;
 final  List<ProjectAssignmentEntity> _assignments;
 List<ProjectAssignmentEntity> get assignments {
  if (_assignments is EqualUnmodifiableListView) return _assignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignments);
}


/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetUpdateRequestedCopyWith<TimesheetUpdateRequested> get copyWith => _$TimesheetUpdateRequestedCopyWithImpl<TimesheetUpdateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetUpdateRequested&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.department, department) || other.department == department)&&(identical(other.approver, approver) || other.approver == approver)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.hoursTotal, hoursTotal) || other.hoursTotal == hoursTotal)&&const DeepCollectionEquality().equals(other._assignments, _assignments));
}


@override
int get hashCode => Object.hash(runtimeType,name,employee,department,approver,fromDate,toDate,approved,hoursTotal,const DeepCollectionEquality().hash(_assignments));

@override
String toString() {
  return 'TimesheetEvent.updateRequested(name: $name, employee: $employee, department: $department, approver: $approver, fromDate: $fromDate, toDate: $toDate, approved: $approved, hoursTotal: $hoursTotal, assignments: $assignments)';
}


}

/// @nodoc
abstract mixin class $TimesheetUpdateRequestedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory $TimesheetUpdateRequestedCopyWith(TimesheetUpdateRequested value, $Res Function(TimesheetUpdateRequested) _then) = _$TimesheetUpdateRequestedCopyWithImpl;
@useResult
$Res call({
 String name, String employee, String department, String approver, String fromDate, String toDate, int approved, double hoursTotal, List<ProjectAssignmentEntity> assignments
});




}
/// @nodoc
class _$TimesheetUpdateRequestedCopyWithImpl<$Res>
    implements $TimesheetUpdateRequestedCopyWith<$Res> {
  _$TimesheetUpdateRequestedCopyWithImpl(this._self, this._then);

  final TimesheetUpdateRequested _self;
  final $Res Function(TimesheetUpdateRequested) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employee = null,Object? department = null,Object? approver = null,Object? fromDate = null,Object? toDate = null,Object? approved = null,Object? hoursTotal = null,Object? assignments = null,}) {
  return _then(TimesheetUpdateRequested(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,approver: null == approver ? _self.approver : approver // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as int,hoursTotal: null == hoursTotal ? _self.hoursTotal : hoursTotal // ignore: cast_nullable_to_non_nullable
as double,assignments: null == assignments ? _self._assignments : assignments // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,
  ));
}


}

/// @nodoc


class TimesheetFetchMonthWiseRequested extends TimesheetEvent {
  const TimesheetFetchMonthWiseRequested({required this.month, required this.year}): super._();
  

 final  int month;
 final  int year;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetFetchMonthWiseRequestedCopyWith<TimesheetFetchMonthWiseRequested> get copyWith => _$TimesheetFetchMonthWiseRequestedCopyWithImpl<TimesheetFetchMonthWiseRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetFetchMonthWiseRequested&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year));
}


@override
int get hashCode => Object.hash(runtimeType,month,year);

@override
String toString() {
  return 'TimesheetEvent.fetchMonthWiseRequested(month: $month, year: $year)';
}


}

/// @nodoc
abstract mixin class $TimesheetFetchMonthWiseRequestedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory $TimesheetFetchMonthWiseRequestedCopyWith(TimesheetFetchMonthWiseRequested value, $Res Function(TimesheetFetchMonthWiseRequested) _then) = _$TimesheetFetchMonthWiseRequestedCopyWithImpl;
@useResult
$Res call({
 int month, int year
});




}
/// @nodoc
class _$TimesheetFetchMonthWiseRequestedCopyWithImpl<$Res>
    implements $TimesheetFetchMonthWiseRequestedCopyWith<$Res> {
  _$TimesheetFetchMonthWiseRequestedCopyWithImpl(this._self, this._then);

  final TimesheetFetchMonthWiseRequested _self;
  final $Res Function(TimesheetFetchMonthWiseRequested) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? month = null,Object? year = null,}) {
  return _then(TimesheetFetchMonthWiseRequested(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class TimesheetDeleteEntryRequested extends TimesheetEvent {
  const TimesheetDeleteEntryRequested({required this.name, required this.parent, required this.date}): super._();
  

 final  String name;
 final  String parent;
 final  String date;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetDeleteEntryRequestedCopyWith<TimesheetDeleteEntryRequested> get copyWith => _$TimesheetDeleteEntryRequestedCopyWithImpl<TimesheetDeleteEntryRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetDeleteEntryRequested&&(identical(other.name, name) || other.name == name)&&(identical(other.parent, parent) || other.parent == parent)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,name,parent,date);

@override
String toString() {
  return 'TimesheetEvent.deleteEntryRequested(name: $name, parent: $parent, date: $date)';
}


}

/// @nodoc
abstract mixin class $TimesheetDeleteEntryRequestedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory $TimesheetDeleteEntryRequestedCopyWith(TimesheetDeleteEntryRequested value, $Res Function(TimesheetDeleteEntryRequested) _then) = _$TimesheetDeleteEntryRequestedCopyWithImpl;
@useResult
$Res call({
 String name, String parent, String date
});




}
/// @nodoc
class _$TimesheetDeleteEntryRequestedCopyWithImpl<$Res>
    implements $TimesheetDeleteEntryRequestedCopyWith<$Res> {
  _$TimesheetDeleteEntryRequestedCopyWithImpl(this._self, this._then);

  final TimesheetDeleteEntryRequested _self;
  final $Res Function(TimesheetDeleteEntryRequested) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? parent = null,Object? date = null,}) {
  return _then(TimesheetDeleteEntryRequested(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,parent: null == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TimesheetFetchOverviewRequested extends TimesheetEvent {
  const TimesheetFetchOverviewRequested({required this.month, required this.year}): super._();
  

 final  int month;
 final  int year;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetFetchOverviewRequestedCopyWith<TimesheetFetchOverviewRequested> get copyWith => _$TimesheetFetchOverviewRequestedCopyWithImpl<TimesheetFetchOverviewRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetFetchOverviewRequested&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year));
}


@override
int get hashCode => Object.hash(runtimeType,month,year);

@override
String toString() {
  return 'TimesheetEvent.fetchOverviewRequested(month: $month, year: $year)';
}


}

/// @nodoc
abstract mixin class $TimesheetFetchOverviewRequestedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory $TimesheetFetchOverviewRequestedCopyWith(TimesheetFetchOverviewRequested value, $Res Function(TimesheetFetchOverviewRequested) _then) = _$TimesheetFetchOverviewRequestedCopyWithImpl;
@useResult
$Res call({
 int month, int year
});




}
/// @nodoc
class _$TimesheetFetchOverviewRequestedCopyWithImpl<$Res>
    implements $TimesheetFetchOverviewRequestedCopyWith<$Res> {
  _$TimesheetFetchOverviewRequestedCopyWithImpl(this._self, this._then);

  final TimesheetFetchOverviewRequested _self;
  final $Res Function(TimesheetFetchOverviewRequested) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? month = null,Object? year = null,}) {
  return _then(TimesheetFetchOverviewRequested(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class TimesheetSubmitWeeklyRequested extends TimesheetEvent {
  const TimesheetSubmitWeeklyRequested(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetSubmitWeeklyRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimesheetEvent.submitWeeklyRequested()';
}


}




/// @nodoc


class TimesheetEditTaskRequested extends TimesheetEvent {
  const TimesheetEditTaskRequested({required this.task, required this.index}): super._();
  

 final  ProjectAssignmentEntity task;
 final  int index;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetEditTaskRequestedCopyWith<TimesheetEditTaskRequested> get copyWith => _$TimesheetEditTaskRequestedCopyWithImpl<TimesheetEditTaskRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetEditTaskRequested&&(identical(other.task, task) || other.task == task)&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,task,index);

@override
String toString() {
  return 'TimesheetEvent.editTaskRequested(task: $task, index: $index)';
}


}

/// @nodoc
abstract mixin class $TimesheetEditTaskRequestedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory $TimesheetEditTaskRequestedCopyWith(TimesheetEditTaskRequested value, $Res Function(TimesheetEditTaskRequested) _then) = _$TimesheetEditTaskRequestedCopyWithImpl;
@useResult
$Res call({
 ProjectAssignmentEntity task, int index
});


$ProjectAssignmentEntityCopyWith<$Res> get task;

}
/// @nodoc
class _$TimesheetEditTaskRequestedCopyWithImpl<$Res>
    implements $TimesheetEditTaskRequestedCopyWith<$Res> {
  _$TimesheetEditTaskRequestedCopyWithImpl(this._self, this._then);

  final TimesheetEditTaskRequested _self;
  final $Res Function(TimesheetEditTaskRequested) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? task = null,Object? index = null,}) {
  return _then(TimesheetEditTaskRequested(
task: null == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as ProjectAssignmentEntity,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectAssignmentEntityCopyWith<$Res> get task {
  
  return $ProjectAssignmentEntityCopyWith<$Res>(_self.task, (value) {
    return _then(_self.copyWith(task: value));
  });
}
}

/// @nodoc


class TimesheetEditTaskCleared extends TimesheetEvent {
  const TimesheetEditTaskCleared(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetEditTaskCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimesheetEvent.editTaskCleared()';
}


}




// dart format on
