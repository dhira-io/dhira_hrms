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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _UserInitRequested value)?  userInitRequested,TResult Function( _LoadMoreRequested value)?  loadMoreRequested,TResult Function( _FetchDetailsRequested value)?  fetchDetailsRequested,TResult Function( _FromDateChanged value)?  fromDateChanged,TResult Function( _ToDateChanged value)?  toDateChanged,TResult Function( _AssignmentsChanged value)?  assignmentsChanged,TResult Function( _SubmitRequested value)?  submitRequested,TResult Function( _UpdateRequested value)?  updateRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _UserInitRequested() when userInitRequested != null:
return userInitRequested(_that);case _LoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that);case _FetchDetailsRequested() when fetchDetailsRequested != null:
return fetchDetailsRequested(_that);case _FromDateChanged() when fromDateChanged != null:
return fromDateChanged(_that);case _ToDateChanged() when toDateChanged != null:
return toDateChanged(_that);case _AssignmentsChanged() when assignmentsChanged != null:
return assignmentsChanged(_that);case _SubmitRequested() when submitRequested != null:
return submitRequested(_that);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _UserInitRequested value)  userInitRequested,required TResult Function( _LoadMoreRequested value)  loadMoreRequested,required TResult Function( _FetchDetailsRequested value)  fetchDetailsRequested,required TResult Function( _FromDateChanged value)  fromDateChanged,required TResult Function( _ToDateChanged value)  toDateChanged,required TResult Function( _AssignmentsChanged value)  assignmentsChanged,required TResult Function( _SubmitRequested value)  submitRequested,required TResult Function( _UpdateRequested value)  updateRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _UserInitRequested():
return userInitRequested(_that);case _LoadMoreRequested():
return loadMoreRequested(_that);case _FetchDetailsRequested():
return fetchDetailsRequested(_that);case _FromDateChanged():
return fromDateChanged(_that);case _ToDateChanged():
return toDateChanged(_that);case _AssignmentsChanged():
return assignmentsChanged(_that);case _SubmitRequested():
return submitRequested(_that);case _UpdateRequested():
return updateRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _UserInitRequested value)?  userInitRequested,TResult? Function( _LoadMoreRequested value)?  loadMoreRequested,TResult? Function( _FetchDetailsRequested value)?  fetchDetailsRequested,TResult? Function( _FromDateChanged value)?  fromDateChanged,TResult? Function( _ToDateChanged value)?  toDateChanged,TResult? Function( _AssignmentsChanged value)?  assignmentsChanged,TResult? Function( _SubmitRequested value)?  submitRequested,TResult? Function( _UpdateRequested value)?  updateRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _UserInitRequested() when userInitRequested != null:
return userInitRequested(_that);case _LoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that);case _FetchDetailsRequested() when fetchDetailsRequested != null:
return fetchDetailsRequested(_that);case _FromDateChanged() when fromDateChanged != null:
return fromDateChanged(_that);case _ToDateChanged() when toDateChanged != null:
return toDateChanged(_that);case _AssignmentsChanged() when assignmentsChanged != null:
return assignmentsChanged(_that);case _SubmitRequested() when submitRequested != null:
return submitRequested(_that);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id)?  started,TResult Function()?  userInitRequested,TResult Function( String id)?  loadMoreRequested,TResult Function( String timesheetId)?  fetchDetailsRequested,TResult Function( DateTime? date)?  fromDateChanged,TResult Function( DateTime? date)?  toDateChanged,TResult Function( List<ProjectAssignmentEntity> assignments)?  assignmentsChanged,TResult Function( String employee,  String department,  String approver,  String fromDate,  String toDate,  List<ProjectAssignmentEntity> assignments)?  submitRequested,TResult Function( String name,  String employee,  String department,  String approver,  String fromDate,  String toDate,  int approved,  double hoursTotal,  List<ProjectAssignmentEntity> assignments)?  updateRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.id);case _UserInitRequested() when userInitRequested != null:
return userInitRequested();case _LoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that.id);case _FetchDetailsRequested() when fetchDetailsRequested != null:
return fetchDetailsRequested(_that.timesheetId);case _FromDateChanged() when fromDateChanged != null:
return fromDateChanged(_that.date);case _ToDateChanged() when toDateChanged != null:
return toDateChanged(_that.date);case _AssignmentsChanged() when assignmentsChanged != null:
return assignmentsChanged(_that.assignments);case _SubmitRequested() when submitRequested != null:
return submitRequested(_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.assignments);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that.name,_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.approved,_that.hoursTotal,_that.assignments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id)  started,required TResult Function()  userInitRequested,required TResult Function( String id)  loadMoreRequested,required TResult Function( String timesheetId)  fetchDetailsRequested,required TResult Function( DateTime? date)  fromDateChanged,required TResult Function( DateTime? date)  toDateChanged,required TResult Function( List<ProjectAssignmentEntity> assignments)  assignmentsChanged,required TResult Function( String employee,  String department,  String approver,  String fromDate,  String toDate,  List<ProjectAssignmentEntity> assignments)  submitRequested,required TResult Function( String name,  String employee,  String department,  String approver,  String fromDate,  String toDate,  int approved,  double hoursTotal,  List<ProjectAssignmentEntity> assignments)  updateRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.id);case _UserInitRequested():
return userInitRequested();case _LoadMoreRequested():
return loadMoreRequested(_that.id);case _FetchDetailsRequested():
return fetchDetailsRequested(_that.timesheetId);case _FromDateChanged():
return fromDateChanged(_that.date);case _ToDateChanged():
return toDateChanged(_that.date);case _AssignmentsChanged():
return assignmentsChanged(_that.assignments);case _SubmitRequested():
return submitRequested(_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.assignments);case _UpdateRequested():
return updateRequested(_that.name,_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.approved,_that.hoursTotal,_that.assignments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id)?  started,TResult? Function()?  userInitRequested,TResult? Function( String id)?  loadMoreRequested,TResult? Function( String timesheetId)?  fetchDetailsRequested,TResult? Function( DateTime? date)?  fromDateChanged,TResult? Function( DateTime? date)?  toDateChanged,TResult? Function( List<ProjectAssignmentEntity> assignments)?  assignmentsChanged,TResult? Function( String employee,  String department,  String approver,  String fromDate,  String toDate,  List<ProjectAssignmentEntity> assignments)?  submitRequested,TResult? Function( String name,  String employee,  String department,  String approver,  String fromDate,  String toDate,  int approved,  double hoursTotal,  List<ProjectAssignmentEntity> assignments)?  updateRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.id);case _UserInitRequested() when userInitRequested != null:
return userInitRequested();case _LoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that.id);case _FetchDetailsRequested() when fetchDetailsRequested != null:
return fetchDetailsRequested(_that.timesheetId);case _FromDateChanged() when fromDateChanged != null:
return fromDateChanged(_that.date);case _ToDateChanged() when toDateChanged != null:
return toDateChanged(_that.date);case _AssignmentsChanged() when assignmentsChanged != null:
return assignmentsChanged(_that.assignments);case _SubmitRequested() when submitRequested != null:
return submitRequested(_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.assignments);case _UpdateRequested() when updateRequested != null:
return updateRequested(_that.name,_that.employee,_that.department,_that.approver,_that.fromDate,_that.toDate,_that.approved,_that.hoursTotal,_that.assignments);case _:
  return null;

}
}

}

/// @nodoc


class _Started extends TimesheetEvent {
  const _Started(this.id): super._();
  

 final  String id;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartedCopyWith<_Started> get copyWith => __$StartedCopyWithImpl<_Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TimesheetEvent.started(id: $id)';
}


}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) = __$StartedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$StartedCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_Started(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
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


class _LoadMoreRequested extends TimesheetEvent {
  const _LoadMoreRequested(this.id): super._();
  

 final  String id;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadMoreRequestedCopyWith<_LoadMoreRequested> get copyWith => __$LoadMoreRequestedCopyWithImpl<_LoadMoreRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMoreRequested&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TimesheetEvent.loadMoreRequested(id: $id)';
}


}

/// @nodoc
abstract mixin class _$LoadMoreRequestedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory _$LoadMoreRequestedCopyWith(_LoadMoreRequested value, $Res Function(_LoadMoreRequested) _then) = __$LoadMoreRequestedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$LoadMoreRequestedCopyWithImpl<$Res>
    implements _$LoadMoreRequestedCopyWith<$Res> {
  __$LoadMoreRequestedCopyWithImpl(this._self, this._then);

  final _LoadMoreRequested _self;
  final $Res Function(_LoadMoreRequested) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_LoadMoreRequested(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FetchDetailsRequested extends TimesheetEvent {
  const _FetchDetailsRequested(this.timesheetId): super._();
  

 final  String timesheetId;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchDetailsRequestedCopyWith<_FetchDetailsRequested> get copyWith => __$FetchDetailsRequestedCopyWithImpl<_FetchDetailsRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchDetailsRequested&&(identical(other.timesheetId, timesheetId) || other.timesheetId == timesheetId));
}


@override
int get hashCode => Object.hash(runtimeType,timesheetId);

@override
String toString() {
  return 'TimesheetEvent.fetchDetailsRequested(timesheetId: $timesheetId)';
}


}

/// @nodoc
abstract mixin class _$FetchDetailsRequestedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory _$FetchDetailsRequestedCopyWith(_FetchDetailsRequested value, $Res Function(_FetchDetailsRequested) _then) = __$FetchDetailsRequestedCopyWithImpl;
@useResult
$Res call({
 String timesheetId
});




}
/// @nodoc
class __$FetchDetailsRequestedCopyWithImpl<$Res>
    implements _$FetchDetailsRequestedCopyWith<$Res> {
  __$FetchDetailsRequestedCopyWithImpl(this._self, this._then);

  final _FetchDetailsRequested _self;
  final $Res Function(_FetchDetailsRequested) _then;

/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? timesheetId = null,}) {
  return _then(_FetchDetailsRequested(
null == timesheetId ? _self.timesheetId : timesheetId // ignore: cast_nullable_to_non_nullable
as String,
  ));
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


class _SubmitRequested extends TimesheetEvent {
  const _SubmitRequested({required this.employee, required this.department, required this.approver, required this.fromDate, required this.toDate, required final  List<ProjectAssignmentEntity> assignments}): _assignments = assignments,super._();
  

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


/// Create a copy of TimesheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitRequestedCopyWith<_SubmitRequested> get copyWith => __$SubmitRequestedCopyWithImpl<_SubmitRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitRequested&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.department, department) || other.department == department)&&(identical(other.approver, approver) || other.approver == approver)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&const DeepCollectionEquality().equals(other._assignments, _assignments));
}


@override
int get hashCode => Object.hash(runtimeType,employee,department,approver,fromDate,toDate,const DeepCollectionEquality().hash(_assignments));

@override
String toString() {
  return 'TimesheetEvent.submitRequested(employee: $employee, department: $department, approver: $approver, fromDate: $fromDate, toDate: $toDate, assignments: $assignments)';
}


}

/// @nodoc
abstract mixin class _$SubmitRequestedCopyWith<$Res> implements $TimesheetEventCopyWith<$Res> {
  factory _$SubmitRequestedCopyWith(_SubmitRequested value, $Res Function(_SubmitRequested) _then) = __$SubmitRequestedCopyWithImpl;
@useResult
$Res call({
 String employee, String department, String approver, String fromDate, String toDate, List<ProjectAssignmentEntity> assignments
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
@pragma('vm:prefer-inline') $Res call({Object? employee = null,Object? department = null,Object? approver = null,Object? fromDate = null,Object? toDate = null,Object? assignments = null,}) {
  return _then(_SubmitRequested(
employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,approver: null == approver ? _self.approver : approver // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,assignments: null == assignments ? _self._assignments : assignments // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,
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

// dart format on
