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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _UserInitRequested value)?  userInitRequested,TResult Function( _FromDateChanged value)?  fromDateChanged,TResult Function( _ToDateChanged value)?  toDateChanged,TResult Function( _AssignmentsChanged value)?  assignmentsChanged,TResult Function( _DaySelected value)?  daySelected,TResult Function( _SubmitRequested value)?  submitRequested,TResult Function( _UpdateRequested value)?  updateRequested,TResult Function( _FetchMonthWiseRequested value)?  fetchMonthWiseRequested,TResult Function( _DeleteEntryRequested value)?  deleteEntryRequested,TResult Function( _FetchOverviewRequested value)?  fetchOverviewRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _UserInitRequested() when userInitRequested != null:
return userInitRequested(_that);case _FromDateChanged() when fromDateChanged != null:
return fromDateChanged(_that);case _ToDateChanged() when toDateChanged != null:
return toDateChanged(_that);case _AssignmentsChanged() when assignmentsChanged != null:
return assignmentsChanged(_that);case _DaySelected() when daySelected != null:
return daySelected(_that);case _SubmitRequested() when submitRequested != null:
return submitRequested(_that);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that);case _FetchMonthWiseRequested() when fetchMonthWiseRequested != null:
return fetchMonthWiseRequested(_that);case _DeleteEntryRequested() when deleteEntryRequested != null:
return deleteEntryRequested(_that);case _FetchOverviewRequested() when fetchOverviewRequested != null:
return fetchOverviewRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _UserInitRequested value)  userInitRequested,required TResult Function( _FromDateChanged value)  fromDateChanged,required TResult Function( _ToDateChanged value)  toDateChanged,required TResult Function( _AssignmentsChanged value)  assignmentsChanged,required TResult Function( _DaySelected value)  daySelected,required TResult Function( _SubmitRequested value)  submitRequested,required TResult Function( _UpdateRequested value)  updateRequested,required TResult Function( _FetchMonthWiseRequested value)  fetchMonthWiseRequested,required TResult Function( _DeleteEntryRequested value)  deleteEntryRequested,required TResult Function( _FetchOverviewRequested value)  fetchOverviewRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _UserInitRequested():
return userInitRequested(_that);case _FromDateChanged():
return fromDateChanged(_that);case _ToDateChanged():
return toDateChanged(_that);case _AssignmentsChanged():
return assignmentsChanged(_that);case _DaySelected():
return daySelected(_that);case _SubmitRequested():
return submitRequested(_that);case _UpdateRequested():
return updateRequested(_that);case _FetchMonthWiseRequested():
return fetchMonthWiseRequested(_that);case _DeleteEntryRequested():
return deleteEntryRequested(_that);case _FetchOverviewRequested():
return fetchOverviewRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _UserInitRequested value)?  userInitRequested,TResult? Function( _FromDateChanged value)?  fromDateChanged,TResult? Function( _ToDateChanged value)?  toDateChanged,TResult? Function( _AssignmentsChanged value)?  assignmentsChanged,TResult? Function( _DaySelected value)?  daySelected,TResult? Function( _SubmitRequested value)?  submitRequested,TResult? Function( _UpdateRequested value)?  updateRequested,TResult? Function( _FetchMonthWiseRequested value)?  fetchMonthWiseRequested,TResult? Function( _DeleteEntryRequested value)?  deleteEntryRequested,TResult? Function( _FetchOverviewRequested value)?  fetchOverviewRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _UserInitRequested() when userInitRequested != null:
return userInitRequested(_that);case _FromDateChanged() when fromDateChanged != null:
return fromDateChanged(_that);case _ToDateChanged() when toDateChanged != null:
return toDateChanged(_that);case _AssignmentsChanged() when assignmentsChanged != null:
return assignmentsChanged(_that);case _DaySelected() when daySelected != null:
return daySelected(_that);case _SubmitRequested() when submitRequested != null:
return submitRequested(_that);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that);case _FetchMonthWiseRequested() when fetchMonthWiseRequested != null:
return fetchMonthWiseRequested(_that);case _DeleteEntryRequested() when deleteEntryRequested != null:
return deleteEntryRequested(_that);case _FetchOverviewRequested() when fetchOverviewRequested != null:
return fetchOverviewRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  userInitRequested,TResult Function( DateTime? date)?  fromDateChanged,TResult Function( DateTime? date)?  toDateChanged,TResult Function( List<ProjectAssignmentEntity> assignments)?  assignmentsChanged,TResult Function( DateTime date)?  daySelected,TResult Function( String employee,  String department,  String approver,  String fromDate,  String toDate,  List<ProjectAssignmentEntity> assignments,  int docStatus)?  submitRequested,TResult Function( String name,  String employee,  String department,  String approver,  String fromDate,  String toDate,  int approved,  double hoursTotal,  List<ProjectAssignmentEntity> assignments)?  updateRequested,TResult Function( int month,  int year)?  fetchMonthWiseRequested,TResult Function( String name,  String parent,  String date)?  deleteEntryRequested,TResult Function( int month,  int year)?  fetchOverviewRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _UserInitRequested() when userInitRequested != null:
return userInitRequested();case _FromDateChanged() when fromDateChanged != null:
return fromDateChanged(_that.date);case _ToDateChanged() when toDateChanged != null:
return toDateChanged(_that.date);case _AssignmentsChanged() when assignmentsChanged != null:
return assignmentsChanged(_that.assignments);case _DaySelected() when daySelected != null:
return daySelected(_that.date);case _SubmitRequested() when submitRequested != null:
return submitRequested(_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.assignments,_that.docStatus);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that.name,_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.approved,_that.hoursTotal,_that.assignments);case _FetchMonthWiseRequested() when fetchMonthWiseRequested != null:
return fetchMonthWiseRequested(_that.month,_that.year);case _DeleteEntryRequested() when deleteEntryRequested != null:
return deleteEntryRequested(_that.name,_that.parent,_that.date);case _FetchOverviewRequested() when fetchOverviewRequested != null:
return fetchOverviewRequested(_that.month,_that.year);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  userInitRequested,required TResult Function( DateTime? date)  fromDateChanged,required TResult Function( DateTime? date)  toDateChanged,required TResult Function( List<ProjectAssignmentEntity> assignments)  assignmentsChanged,required TResult Function( DateTime date)  daySelected,required TResult Function( String employee,  String department,  String approver,  String fromDate,  String toDate,  List<ProjectAssignmentEntity> assignments,  int docStatus)  submitRequested,required TResult Function( String name,  String employee,  String department,  String approver,  String fromDate,  String toDate,  int approved,  double hoursTotal,  List<ProjectAssignmentEntity> assignments)  updateRequested,required TResult Function( int month,  int year)  fetchMonthWiseRequested,required TResult Function( String name,  String parent,  String date)  deleteEntryRequested,required TResult Function( int month,  int year)  fetchOverviewRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _UserInitRequested():
return userInitRequested();case _FromDateChanged():
return fromDateChanged(_that.date);case _ToDateChanged():
return toDateChanged(_that.date);case _AssignmentsChanged():
return assignmentsChanged(_that.assignments);case _DaySelected():
return daySelected(_that.date);case _SubmitRequested():
return submitRequested(_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.assignments,_that.docStatus);case _UpdateRequested():
return updateRequested(_that.name,_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.approved,_that.hoursTotal,_that.assignments);case _FetchMonthWiseRequested():
return fetchMonthWiseRequested(_that.month,_that.year);case _DeleteEntryRequested():
return deleteEntryRequested(_that.name,_that.parent,_that.date);case _FetchOverviewRequested():
return fetchOverviewRequested(_that.month,_that.year);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  userInitRequested,TResult? Function( DateTime? date)?  fromDateChanged,TResult? Function( DateTime? date)?  toDateChanged,TResult? Function( List<ProjectAssignmentEntity> assignments)?  assignmentsChanged,TResult? Function( DateTime date)?  daySelected,TResult? Function( String employee,  String department,  String approver,  String fromDate,  String toDate,  List<ProjectAssignmentEntity> assignments,  int docStatus)?  submitRequested,TResult? Function( String name,  String employee,  String department,  String approver,  String fromDate,  String toDate,  int approved,  double hoursTotal,  List<ProjectAssignmentEntity> assignments)?  updateRequested,TResult? Function( int month,  int year)?  fetchMonthWiseRequested,TResult? Function( String name,  String parent,  String date)?  deleteEntryRequested,TResult? Function( int month,  int year)?  fetchOverviewRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _UserInitRequested() when userInitRequested != null:
return userInitRequested();case _FromDateChanged() when fromDateChanged != null:
return fromDateChanged(_that.date);case _ToDateChanged() when toDateChanged != null:
return toDateChanged(_that.date);case _AssignmentsChanged() when assignmentsChanged != null:
return assignmentsChanged(_that.assignments);case _DaySelected() when daySelected != null:
return daySelected(_that.date);case _SubmitRequested() when submitRequested != null:
return submitRequested(_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.assignments,_that.docStatus);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that.name,_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.approved,_that.hoursTotal,_that.assignments);case _FetchMonthWiseRequested() when fetchMonthWiseRequested != null:
return fetchMonthWiseRequested(_that.month,_that.year);case _DeleteEntryRequested() when deleteEntryRequested != null:
return deleteEntryRequested(_that.name,_that.parent,_that.date);case _FetchOverviewRequested() when fetchOverviewRequested != null:
return fetchOverviewRequested(_that.month,_that.year);case _:
  return null;

}
}

}

/// @nodoc


class _Started extends TimesheetEvent {
  const _Started(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimesheetEvent.started()';
}


}




/// @nodoc


class _UserInitRequested extends TimesheetEvent {
  const _UserInitRequested(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserInitRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimesheetEvent.userInitRequested()';
}


}




/// @nodoc


class _FromDateChanged extends TimesheetEvent {
  const _FromDateChanged(this.date): super._();
  

 final  DateTime? date;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FromDateChangedCopyWith<_FromDateChanged> get copyWith => __$FromDateChangedCopyWithImpl<_FromDateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FromDateChanged&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'TimesheetEvent.fromDateChanged(date: $date)';
}


}

/// @nodoc
abstract mixin class _$FromDateChangedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory _$FromDateChangedCopyWith(_FromDateChanged value, $Res Function(_FromDateChanged) _then) = __$FromDateChangedCopyWithImpl;
@useResult
$Res call({
 DateTime? date
});




}
/// @nodoc
class __$FromDateChangedCopyWithImpl<$Res>
    implements _$FromDateChangedCopyWith<$Res> {
  __$FromDateChangedCopyWithImpl(this._self, this._then);

  final _FromDateChanged _self;
  final $Res Function(_FromDateChanged) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = freezed,}) {
  return _then(_FromDateChanged(
freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class _ToDateChanged extends TimesheetEvent {
  const _ToDateChanged(this.date): super._();
  

 final  DateTime? date;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToDateChangedCopyWith<_ToDateChanged> get copyWith => __$ToDateChangedCopyWithImpl<_ToDateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToDateChanged&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'TimesheetEvent.toDateChanged(date: $date)';
}


}

/// @nodoc
abstract mixin class _$ToDateChangedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory _$ToDateChangedCopyWith(_ToDateChanged value, $Res Function(_ToDateChanged) _then) = __$ToDateChangedCopyWithImpl;
@useResult
$Res call({
 DateTime? date
});




}
/// @nodoc
class __$ToDateChangedCopyWithImpl<$Res>
    implements _$ToDateChangedCopyWith<$Res> {
  __$ToDateChangedCopyWithImpl(this._self, this._then);

  final _ToDateChanged _self;
  final $Res Function(_ToDateChanged) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = freezed,}) {
  return _then(_ToDateChanged(
freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class _AssignmentsChanged extends TimesheetEvent {
  const _AssignmentsChanged(final  List<ProjectAssignmentEntity> assignments): _assignments = assignments,super._();
  

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
_$AssignmentsChangedCopyWith<_AssignmentsChanged> get copyWith => __$AssignmentsChangedCopyWithImpl<_AssignmentsChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssignmentsChanged&&const DeepCollectionEquality().equals(other._assignments, _assignments));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_assignments));

@override
String toString() {
  return 'TimesheetEvent.assignmentsChanged(assignments: $assignments)';
}


}

/// @nodoc
abstract mixin class _$AssignmentsChangedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory _$AssignmentsChangedCopyWith(_AssignmentsChanged value, $Res Function(_AssignmentsChanged) _then) = __$AssignmentsChangedCopyWithImpl;
@useResult
$Res call({
 List<ProjectAssignmentEntity> assignments
});




}
/// @nodoc
class __$AssignmentsChangedCopyWithImpl<$Res>
    implements _$AssignmentsChangedCopyWith<$Res> {
  __$AssignmentsChangedCopyWithImpl(this._self, this._then);

  final _AssignmentsChanged _self;
  final $Res Function(_AssignmentsChanged) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? assignments = null,}) {
  return _then(_AssignmentsChanged(
null == assignments ? _self._assignments : assignments // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,
  ));
}


}

/// @nodoc


class _DaySelected extends TimesheetEvent {
  const _DaySelected(this.date): super._();
  

 final  DateTime date;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DaySelectedCopyWith<_DaySelected> get copyWith => __$DaySelectedCopyWithImpl<_DaySelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DaySelected&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'TimesheetEvent.daySelected(date: $date)';
}


}

/// @nodoc
abstract mixin class _$DaySelectedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory _$DaySelectedCopyWith(_DaySelected value, $Res Function(_DaySelected) _then) = __$DaySelectedCopyWithImpl;
@useResult
$Res call({
 DateTime date
});




}
/// @nodoc
class __$DaySelectedCopyWithImpl<$Res>
    implements _$DaySelectedCopyWith<$Res> {
  __$DaySelectedCopyWithImpl(this._self, this._then);

  final _DaySelected _self;
  final $Res Function(_DaySelected) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,}) {
  return _then(_DaySelected(
null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class _SubmitRequested extends TimesheetEvent {
  const _SubmitRequested({required this.employee, required this.department, required this.approver, required this.fromDate, required this.toDate, required final  List<ProjectAssignmentEntity> assignments, required this.docStatus}): _assignments = assignments,super._();
  

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
_$SubmitRequestedCopyWith<_SubmitRequested> get copyWith => __$SubmitRequestedCopyWithImpl<_SubmitRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitRequested&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.department, department) || other.department == department)&&(identical(other.approver, approver) || other.approver == approver)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&const DeepCollectionEquality().equals(other._assignments, _assignments)&&(identical(other.docStatus, docStatus) || other.docStatus == docStatus));
}


@override
int get hashCode => Object.hash(runtimeType,employee,department,approver,fromDate,toDate,const DeepCollectionEquality().hash(_assignments),docStatus);

@override
String toString() {
  return 'TimesheetEvent.submitRequested(employee: $employee, department: $department, approver: $approver, fromDate: $fromDate, toDate: $toDate, assignments: $assignments, docStatus: $docStatus)';
}


}

/// @nodoc
abstract mixin class _$SubmitRequestedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory _$SubmitRequestedCopyWith(_SubmitRequested value, $Res Function(_SubmitRequested) _then) = __$SubmitRequestedCopyWithImpl;
@useResult
$Res call({
 String employee, String department, String approver, String fromDate, String toDate, List<ProjectAssignmentEntity> assignments, int docStatus
});




}
/// @nodoc
class __$SubmitRequestedCopyWithImpl<$Res>
    implements _$SubmitRequestedCopyWith<$Res> {
  __$SubmitRequestedCopyWithImpl(this._self, this._then);

  final _SubmitRequested _self;
  final $Res Function(_SubmitRequested) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? employee = null,Object? department = null,Object? approver = null,Object? fromDate = null,Object? toDate = null,Object? assignments = null,Object? docStatus = null,}) {
  return _then(_SubmitRequested(
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


class _UpdateRequested extends TimesheetEvent {
  const _UpdateRequested({required this.name, required this.employee, required this.department, required this.approver, required this.fromDate, required this.toDate, required this.approved, required this.hoursTotal, required final  List<ProjectAssignmentEntity> assignments}): _assignments = assignments,super._();
  

 final  String name;
 final  String employee;
 final  String department;
 final  String approver;
 final  String fromDate;
 final  String toDate;
 final  int approved;
// This serves as docStatus
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
_$UpdateRequestedCopyWith<_UpdateRequested> get copyWith => __$UpdateRequestedCopyWithImpl<_UpdateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateRequested&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.department, department) || other.department == department)&&(identical(other.approver, approver) || other.approver == approver)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.hoursTotal, hoursTotal) || other.hoursTotal == hoursTotal)&&const DeepCollectionEquality().equals(other._assignments, _assignments));
}


@override
int get hashCode => Object.hash(runtimeType,name,employee,department,approver,fromDate,toDate,approved,hoursTotal,const DeepCollectionEquality().hash(_assignments));

@override
String toString() {
  return 'TimesheetEvent.updateRequested(name: $name, employee: $employee, department: $department, approver: $approver, fromDate: $fromDate, toDate: $toDate, approved: $approved, hoursTotal: $hoursTotal, assignments: $assignments)';
}


}

/// @nodoc
abstract mixin class _$UpdateRequestedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory _$UpdateRequestedCopyWith(_UpdateRequested value, $Res Function(_UpdateRequested) _then) = __$UpdateRequestedCopyWithImpl;
@useResult
$Res call({
 String name, String employee, String department, String approver, String fromDate, String toDate, int approved, double hoursTotal, List<ProjectAssignmentEntity> assignments
});




}
/// @nodoc
class __$UpdateRequestedCopyWithImpl<$Res>
    implements _$UpdateRequestedCopyWith<$Res> {
  __$UpdateRequestedCopyWithImpl(this._self, this._then);

  final _UpdateRequested _self;
  final $Res Function(_UpdateRequested) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employee = null,Object? department = null,Object? approver = null,Object? fromDate = null,Object? toDate = null,Object? approved = null,Object? hoursTotal = null,Object? assignments = null,}) {
  return _then(_UpdateRequested(
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


class _FetchMonthWiseRequested extends TimesheetEvent {
  const _FetchMonthWiseRequested({required this.month, required this.year}): super._();
  

 final  int month;
 final  int year;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchMonthWiseRequestedCopyWith<_FetchMonthWiseRequested> get copyWith => __$FetchMonthWiseRequestedCopyWithImpl<_FetchMonthWiseRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchMonthWiseRequested&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year));
}


@override
int get hashCode => Object.hash(runtimeType,month,year);

@override
String toString() {
  return 'TimesheetEvent.fetchMonthWiseRequested(month: $month, year: $year)';
}


}

/// @nodoc
abstract mixin class _$FetchMonthWiseRequestedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory _$FetchMonthWiseRequestedCopyWith(_FetchMonthWiseRequested value, $Res Function(_FetchMonthWiseRequested) _then) = __$FetchMonthWiseRequestedCopyWithImpl;
@useResult
$Res call({
 int month, int year
});




}
/// @nodoc
class __$FetchMonthWiseRequestedCopyWithImpl<$Res>
    implements _$FetchMonthWiseRequestedCopyWith<$Res> {
  __$FetchMonthWiseRequestedCopyWithImpl(this._self, this._then);

  final _FetchMonthWiseRequested _self;
  final $Res Function(_FetchMonthWiseRequested) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? month = null,Object? year = null,}) {
  return _then(_FetchMonthWiseRequested(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _DeleteEntryRequested extends TimesheetEvent {
  const _DeleteEntryRequested({required this.name, required this.parent, required this.date}): super._();
  

 final  String name;
 final  String parent;
 final  String date;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteEntryRequestedCopyWith<_DeleteEntryRequested> get copyWith => __$DeleteEntryRequestedCopyWithImpl<_DeleteEntryRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteEntryRequested&&(identical(other.name, name) || other.name == name)&&(identical(other.parent, parent) || other.parent == parent)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,name,parent,date);

@override
String toString() {
  return 'TimesheetEvent.deleteEntryRequested(name: $name, parent: $parent, date: $date)';
}


}

/// @nodoc
abstract mixin class _$DeleteEntryRequestedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory _$DeleteEntryRequestedCopyWith(_DeleteEntryRequested value, $Res Function(_DeleteEntryRequested) _then) = __$DeleteEntryRequestedCopyWithImpl;
@useResult
$Res call({
 String name, String parent, String date
});




}
/// @nodoc
class __$DeleteEntryRequestedCopyWithImpl<$Res>
    implements _$DeleteEntryRequestedCopyWith<$Res> {
  __$DeleteEntryRequestedCopyWithImpl(this._self, this._then);

  final _DeleteEntryRequested _self;
  final $Res Function(_DeleteEntryRequested) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? parent = null,Object? date = null,}) {
  return _then(_DeleteEntryRequested(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,parent: null == parent ? _self.parent : parent // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FetchOverviewRequested extends TimesheetEvent {
  const _FetchOverviewRequested({required this.month, required this.year}): super._();
  

 final  int month;
 final  int year;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchOverviewRequestedCopyWith<_FetchOverviewRequested> get copyWith => __$FetchOverviewRequestedCopyWithImpl<_FetchOverviewRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchOverviewRequested&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year));
}


@override
int get hashCode => Object.hash(runtimeType,month,year);

@override
String toString() {
  return 'TimesheetEvent.fetchOverviewRequested(month: $month, year: $year)';
}


}

/// @nodoc
abstract mixin class _$FetchOverviewRequestedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory _$FetchOverviewRequestedCopyWith(_FetchOverviewRequested value, $Res Function(_FetchOverviewRequested) _then) = __$FetchOverviewRequestedCopyWithImpl;
@useResult
$Res call({
 int month, int year
});




}
/// @nodoc
class __$FetchOverviewRequestedCopyWithImpl<$Res>
    implements _$FetchOverviewRequestedCopyWith<$Res> {
  __$FetchOverviewRequestedCopyWithImpl(this._self, this._then);

  final _FetchOverviewRequested _self;
  final $Res Function(_FetchOverviewRequested) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? month = null,Object? year = null,}) {
  return _then(_FetchOverviewRequested(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
