// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timesheet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimesheetState {

 UserEntity? get user; DateTime? get editFromDate; DateTime? get editToDate; DateTime? get selectedDate; List<TimesheetEntity> get timesheets; bool get hasMore; List<ProjectAssignmentEntity> get editAssignments; List<ProjectEntity> get projects; bool get isActionLoading; String? get activeTimesheetId; TimesheetOverviewEntity? get overview; List<ProjectAssignmentEntity> get assignmentsForSelectedDay; String? get currentWeekActiveId; String get formattedOverviewWeeks; ProjectAssignmentEntity? get editingTask; int? get editingIndex;
/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetStateCopyWith<TimesheetState> get copyWith => _$TimesheetStateCopyWithImpl<TimesheetState>(this as TimesheetState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetState&&(identical(other.user, user) || other.user == user)&&(identical(other.editFromDate, editFromDate) || other.editFromDate == editFromDate)&&(identical(other.editToDate, editToDate) || other.editToDate == editToDate)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&const DeepCollectionEquality().equals(other.timesheets, timesheets)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&const DeepCollectionEquality().equals(other.editAssignments, editAssignments)&&const DeepCollectionEquality().equals(other.projects, projects)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.activeTimesheetId, activeTimesheetId) || other.activeTimesheetId == activeTimesheetId)&&(identical(other.overview, overview) || other.overview == overview)&&const DeepCollectionEquality().equals(other.assignmentsForSelectedDay, assignmentsForSelectedDay)&&(identical(other.currentWeekActiveId, currentWeekActiveId) || other.currentWeekActiveId == currentWeekActiveId)&&(identical(other.formattedOverviewWeeks, formattedOverviewWeeks) || other.formattedOverviewWeeks == formattedOverviewWeeks)&&(identical(other.editingTask, editingTask) || other.editingTask == editingTask)&&(identical(other.editingIndex, editingIndex) || other.editingIndex == editingIndex));
}


@override
int get hashCode => Object.hash(runtimeType,user,editFromDate,editToDate,selectedDate,const DeepCollectionEquality().hash(timesheets),hasMore,const DeepCollectionEquality().hash(editAssignments),const DeepCollectionEquality().hash(projects),isActionLoading,activeTimesheetId,overview,const DeepCollectionEquality().hash(assignmentsForSelectedDay),currentWeekActiveId,formattedOverviewWeeks,editingTask,editingIndex);

@override
String toString() {
  return 'TimesheetState(user: $user, editFromDate: $editFromDate, editToDate: $editToDate, selectedDate: $selectedDate, timesheets: $timesheets, hasMore: $hasMore, editAssignments: $editAssignments, projects: $projects, isActionLoading: $isActionLoading, activeTimesheetId: $activeTimesheetId, overview: $overview, assignmentsForSelectedDay: $assignmentsForSelectedDay, currentWeekActiveId: $currentWeekActiveId, formattedOverviewWeeks: $formattedOverviewWeeks, editingTask: $editingTask, editingIndex: $editingIndex)';
}


}

/// @nodoc
abstract mixin class $TimesheetStateCopyWith<$Res>  {
  factory $TimesheetStateCopyWith(TimesheetState value, $Res Function(TimesheetState) _then) = _$TimesheetStateCopyWithImpl;
@useResult
$Res call({
 UserEntity? user, DateTime? editFromDate, DateTime? editToDate, DateTime? selectedDate, List<TimesheetEntity> timesheets, bool hasMore, List<ProjectAssignmentEntity> editAssignments, List<ProjectEntity> projects, bool isActionLoading, String? activeTimesheetId, TimesheetOverviewEntity? overview, List<ProjectAssignmentEntity> assignmentsForSelectedDay, String? currentWeekActiveId, String formattedOverviewWeeks, ProjectAssignmentEntity? editingTask, int? editingIndex
});


$UserEntityCopyWith<$Res>? get user;$TimesheetOverviewEntityCopyWith<$Res>? get overview;$ProjectAssignmentEntityCopyWith<$Res>? get editingTask;

}
/// @nodoc
class _$TimesheetStateCopyWithImpl<$Res>
    implements $TimesheetStateCopyWith<$Res> {
  _$TimesheetStateCopyWithImpl(this._self, this._then);

  final TimesheetState _self;
  final $Res Function(TimesheetState) _then;

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? editFromDate = freezed,Object? editToDate = freezed,Object? selectedDate = freezed,Object? timesheets = null,Object? hasMore = null,Object? editAssignments = null,Object? projects = null,Object? isActionLoading = null,Object? activeTimesheetId = freezed,Object? overview = freezed,Object? assignmentsForSelectedDay = null,Object? currentWeekActiveId = freezed,Object? formattedOverviewWeeks = null,Object? editingTask = freezed,Object? editingIndex = freezed,}) {
  return _then(_self.copyWith(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity?,editFromDate: freezed == editFromDate ? _self.editFromDate : editFromDate // ignore: cast_nullable_to_non_nullable
as DateTime?,editToDate: freezed == editToDate ? _self.editToDate : editToDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,timesheets: null == timesheets ? _self.timesheets : timesheets // ignore: cast_nullable_to_non_nullable
as List<TimesheetEntity>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,editAssignments: null == editAssignments ? _self.editAssignments : editAssignments // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,projects: null == projects ? _self.projects : projects // ignore: cast_nullable_to_non_nullable
as List<ProjectEntity>,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,activeTimesheetId: freezed == activeTimesheetId ? _self.activeTimesheetId : activeTimesheetId // ignore: cast_nullable_to_non_nullable
as String?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as TimesheetOverviewEntity?,assignmentsForSelectedDay: null == assignmentsForSelectedDay ? _self.assignmentsForSelectedDay : assignmentsForSelectedDay // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,currentWeekActiveId: freezed == currentWeekActiveId ? _self.currentWeekActiveId : currentWeekActiveId // ignore: cast_nullable_to_non_nullable
as String?,formattedOverviewWeeks: null == formattedOverviewWeeks ? _self.formattedOverviewWeeks : formattedOverviewWeeks // ignore: cast_nullable_to_non_nullable
as String,editingTask: freezed == editingTask ? _self.editingTask : editingTask // ignore: cast_nullable_to_non_nullable
as ProjectAssignmentEntity?,editingIndex: freezed == editingIndex ? _self.editingIndex : editingIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimesheetOverviewEntityCopyWith<$Res>? get overview {
    if (_self.overview == null) {
    return null;
  }

  return $TimesheetOverviewEntityCopyWith<$Res>(_self.overview!, (value) {
    return _then(_self.copyWith(overview: value));
  });
}/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectAssignmentEntityCopyWith<$Res>? get editingTask {
    if (_self.editingTask == null) {
    return null;
  }

  return $ProjectAssignmentEntityCopyWith<$Res>(_self.editingTask!, (value) {
    return _then(_self.copyWith(editingTask: value));
  });
}
}


/// Adds pattern-matching-related methods to [TimesheetState].
extension TimesheetStatePatterns on TimesheetState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Success value)?  success,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Success value)  success,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Success():
return success(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Success value)?  success,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( UserEntity? user,  DateTime? editFromDate,  DateTime? editToDate,  DateTime? selectedDate,  List<TimesheetEntity> timesheets,  bool hasMore,  List<ProjectAssignmentEntity> editAssignments,  List<ProjectEntity> projects,  bool isActionLoading,  String? activeTimesheetId,  TimesheetOverviewEntity? overview,  List<ProjectAssignmentEntity> assignmentsForSelectedDay,  String? currentWeekActiveId,  String formattedOverviewWeeks,  ProjectAssignmentEntity? editingTask,  int? editingIndex)?  initial,TResult Function( UserEntity? user,  DateTime? editFromDate,  DateTime? editToDate,  DateTime? selectedDate,  List<TimesheetEntity> timesheets,  bool hasMore,  List<ProjectAssignmentEntity> editAssignments,  List<ProjectEntity> projects,  bool isActionLoading,  String? activeTimesheetId,  TimesheetOverviewEntity? overview,  List<ProjectAssignmentEntity> assignmentsForSelectedDay,  String? currentWeekActiveId,  String formattedOverviewWeeks,  ProjectAssignmentEntity? editingTask,  int? editingIndex)?  loading,TResult Function( List<TimesheetEntity> timesheets,  bool hasMore,  bool isFetchingMore,  UserEntity? user,  DateTime? editFromDate,  DateTime? editToDate,  DateTime? selectedDate,  List<ProjectAssignmentEntity> editAssignments,  List<ProjectEntity> projects,  bool isActionLoading,  String? activeTimesheetId,  TimesheetOverviewEntity? overview,  List<ProjectAssignmentEntity> assignmentsForSelectedDay,  String? currentWeekActiveId,  String formattedOverviewWeeks,  ProjectAssignmentEntity? editingTask,  int? editingIndex)?  loaded,TResult Function( String message,  TimesheetSuccessType? successType,  UserEntity? user,  DateTime? editFromDate,  DateTime? editToDate,  DateTime? selectedDate,  List<TimesheetEntity> timesheets,  bool hasMore,  List<ProjectAssignmentEntity> editAssignments,  List<ProjectEntity> projects,  bool isActionLoading,  String? activeTimesheetId,  TimesheetOverviewEntity? overview,  List<ProjectAssignmentEntity> assignmentsForSelectedDay,  String? currentWeekActiveId,  String formattedOverviewWeeks,  ProjectAssignmentEntity? editingTask,  int? editingIndex)?  success,TResult Function( String message,  UserEntity? user,  DateTime? editFromDate,  DateTime? editToDate,  DateTime? selectedDate,  List<TimesheetEntity> timesheets,  bool hasMore,  List<ProjectAssignmentEntity> editAssignments,  List<ProjectEntity> projects,  bool isActionLoading,  String? activeTimesheetId,  TimesheetOverviewEntity? overview,  List<ProjectAssignmentEntity> assignmentsForSelectedDay,  String? currentWeekActiveId,  String formattedOverviewWeeks,  ProjectAssignmentEntity? editingTask,  int? editingIndex)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.user,_that.editFromDate,_that.editToDate,_that.selectedDate,_that.timesheets,_that.hasMore,_that.editAssignments,_that.projects,_that.isActionLoading,_that.activeTimesheetId,_that.overview,_that.assignmentsForSelectedDay,_that.currentWeekActiveId,_that.formattedOverviewWeeks,_that.editingTask,_that.editingIndex);case _Loading() when loading != null:
return loading(_that.user,_that.editFromDate,_that.editToDate,_that.selectedDate,_that.timesheets,_that.hasMore,_that.editAssignments,_that.projects,_that.isActionLoading,_that.activeTimesheetId,_that.overview,_that.assignmentsForSelectedDay,_that.currentWeekActiveId,_that.formattedOverviewWeeks,_that.editingTask,_that.editingIndex);case _Loaded() when loaded != null:
return loaded(_that.timesheets,_that.hasMore,_that.isFetchingMore,_that.user,_that.editFromDate,_that.editToDate,_that.selectedDate,_that.editAssignments,_that.projects,_that.isActionLoading,_that.activeTimesheetId,_that.overview,_that.assignmentsForSelectedDay,_that.currentWeekActiveId,_that.formattedOverviewWeeks,_that.editingTask,_that.editingIndex);case _Success() when success != null:
return success(_that.message,_that.successType,_that.user,_that.editFromDate,_that.editToDate,_that.selectedDate,_that.timesheets,_that.hasMore,_that.editAssignments,_that.projects,_that.isActionLoading,_that.activeTimesheetId,_that.overview,_that.assignmentsForSelectedDay,_that.currentWeekActiveId,_that.formattedOverviewWeeks,_that.editingTask,_that.editingIndex);case _Error() when error != null:
return error(_that.message,_that.user,_that.editFromDate,_that.editToDate,_that.selectedDate,_that.timesheets,_that.hasMore,_that.editAssignments,_that.projects,_that.isActionLoading,_that.activeTimesheetId,_that.overview,_that.assignmentsForSelectedDay,_that.currentWeekActiveId,_that.formattedOverviewWeeks,_that.editingTask,_that.editingIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( UserEntity? user,  DateTime? editFromDate,  DateTime? editToDate,  DateTime? selectedDate,  List<TimesheetEntity> timesheets,  bool hasMore,  List<ProjectAssignmentEntity> editAssignments,  List<ProjectEntity> projects,  bool isActionLoading,  String? activeTimesheetId,  TimesheetOverviewEntity? overview,  List<ProjectAssignmentEntity> assignmentsForSelectedDay,  String? currentWeekActiveId,  String formattedOverviewWeeks,  ProjectAssignmentEntity? editingTask,  int? editingIndex)  initial,required TResult Function( UserEntity? user,  DateTime? editFromDate,  DateTime? editToDate,  DateTime? selectedDate,  List<TimesheetEntity> timesheets,  bool hasMore,  List<ProjectAssignmentEntity> editAssignments,  List<ProjectEntity> projects,  bool isActionLoading,  String? activeTimesheetId,  TimesheetOverviewEntity? overview,  List<ProjectAssignmentEntity> assignmentsForSelectedDay,  String? currentWeekActiveId,  String formattedOverviewWeeks,  ProjectAssignmentEntity? editingTask,  int? editingIndex)  loading,required TResult Function( List<TimesheetEntity> timesheets,  bool hasMore,  bool isFetchingMore,  UserEntity? user,  DateTime? editFromDate,  DateTime? editToDate,  DateTime? selectedDate,  List<ProjectAssignmentEntity> editAssignments,  List<ProjectEntity> projects,  bool isActionLoading,  String? activeTimesheetId,  TimesheetOverviewEntity? overview,  List<ProjectAssignmentEntity> assignmentsForSelectedDay,  String? currentWeekActiveId,  String formattedOverviewWeeks,  ProjectAssignmentEntity? editingTask,  int? editingIndex)  loaded,required TResult Function( String message,  TimesheetSuccessType? successType,  UserEntity? user,  DateTime? editFromDate,  DateTime? editToDate,  DateTime? selectedDate,  List<TimesheetEntity> timesheets,  bool hasMore,  List<ProjectAssignmentEntity> editAssignments,  List<ProjectEntity> projects,  bool isActionLoading,  String? activeTimesheetId,  TimesheetOverviewEntity? overview,  List<ProjectAssignmentEntity> assignmentsForSelectedDay,  String? currentWeekActiveId,  String formattedOverviewWeeks,  ProjectAssignmentEntity? editingTask,  int? editingIndex)  success,required TResult Function( String message,  UserEntity? user,  DateTime? editFromDate,  DateTime? editToDate,  DateTime? selectedDate,  List<TimesheetEntity> timesheets,  bool hasMore,  List<ProjectAssignmentEntity> editAssignments,  List<ProjectEntity> projects,  bool isActionLoading,  String? activeTimesheetId,  TimesheetOverviewEntity? overview,  List<ProjectAssignmentEntity> assignmentsForSelectedDay,  String? currentWeekActiveId,  String formattedOverviewWeeks,  ProjectAssignmentEntity? editingTask,  int? editingIndex)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial(_that.user,_that.editFromDate,_that.editToDate,_that.selectedDate,_that.timesheets,_that.hasMore,_that.editAssignments,_that.projects,_that.isActionLoading,_that.activeTimesheetId,_that.overview,_that.assignmentsForSelectedDay,_that.currentWeekActiveId,_that.formattedOverviewWeeks,_that.editingTask,_that.editingIndex);case _Loading():
return loading(_that.user,_that.editFromDate,_that.editToDate,_that.selectedDate,_that.timesheets,_that.hasMore,_that.editAssignments,_that.projects,_that.isActionLoading,_that.activeTimesheetId,_that.overview,_that.assignmentsForSelectedDay,_that.currentWeekActiveId,_that.formattedOverviewWeeks,_that.editingTask,_that.editingIndex);case _Loaded():
return loaded(_that.timesheets,_that.hasMore,_that.isFetchingMore,_that.user,_that.editFromDate,_that.editToDate,_that.selectedDate,_that.editAssignments,_that.projects,_that.isActionLoading,_that.activeTimesheetId,_that.overview,_that.assignmentsForSelectedDay,_that.currentWeekActiveId,_that.formattedOverviewWeeks,_that.editingTask,_that.editingIndex);case _Success():
return success(_that.message,_that.successType,_that.user,_that.editFromDate,_that.editToDate,_that.selectedDate,_that.timesheets,_that.hasMore,_that.editAssignments,_that.projects,_that.isActionLoading,_that.activeTimesheetId,_that.overview,_that.assignmentsForSelectedDay,_that.currentWeekActiveId,_that.formattedOverviewWeeks,_that.editingTask,_that.editingIndex);case _Error():
return error(_that.message,_that.user,_that.editFromDate,_that.editToDate,_that.selectedDate,_that.timesheets,_that.hasMore,_that.editAssignments,_that.projects,_that.isActionLoading,_that.activeTimesheetId,_that.overview,_that.assignmentsForSelectedDay,_that.currentWeekActiveId,_that.formattedOverviewWeeks,_that.editingTask,_that.editingIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( UserEntity? user,  DateTime? editFromDate,  DateTime? editToDate,  DateTime? selectedDate,  List<TimesheetEntity> timesheets,  bool hasMore,  List<ProjectAssignmentEntity> editAssignments,  List<ProjectEntity> projects,  bool isActionLoading,  String? activeTimesheetId,  TimesheetOverviewEntity? overview,  List<ProjectAssignmentEntity> assignmentsForSelectedDay,  String? currentWeekActiveId,  String formattedOverviewWeeks,  ProjectAssignmentEntity? editingTask,  int? editingIndex)?  initial,TResult? Function( UserEntity? user,  DateTime? editFromDate,  DateTime? editToDate,  DateTime? selectedDate,  List<TimesheetEntity> timesheets,  bool hasMore,  List<ProjectAssignmentEntity> editAssignments,  List<ProjectEntity> projects,  bool isActionLoading,  String? activeTimesheetId,  TimesheetOverviewEntity? overview,  List<ProjectAssignmentEntity> assignmentsForSelectedDay,  String? currentWeekActiveId,  String formattedOverviewWeeks,  ProjectAssignmentEntity? editingTask,  int? editingIndex)?  loading,TResult? Function( List<TimesheetEntity> timesheets,  bool hasMore,  bool isFetchingMore,  UserEntity? user,  DateTime? editFromDate,  DateTime? editToDate,  DateTime? selectedDate,  List<ProjectAssignmentEntity> editAssignments,  List<ProjectEntity> projects,  bool isActionLoading,  String? activeTimesheetId,  TimesheetOverviewEntity? overview,  List<ProjectAssignmentEntity> assignmentsForSelectedDay,  String? currentWeekActiveId,  String formattedOverviewWeeks,  ProjectAssignmentEntity? editingTask,  int? editingIndex)?  loaded,TResult? Function( String message,  TimesheetSuccessType? successType,  UserEntity? user,  DateTime? editFromDate,  DateTime? editToDate,  DateTime? selectedDate,  List<TimesheetEntity> timesheets,  bool hasMore,  List<ProjectAssignmentEntity> editAssignments,  List<ProjectEntity> projects,  bool isActionLoading,  String? activeTimesheetId,  TimesheetOverviewEntity? overview,  List<ProjectAssignmentEntity> assignmentsForSelectedDay,  String? currentWeekActiveId,  String formattedOverviewWeeks,  ProjectAssignmentEntity? editingTask,  int? editingIndex)?  success,TResult? Function( String message,  UserEntity? user,  DateTime? editFromDate,  DateTime? editToDate,  DateTime? selectedDate,  List<TimesheetEntity> timesheets,  bool hasMore,  List<ProjectAssignmentEntity> editAssignments,  List<ProjectEntity> projects,  bool isActionLoading,  String? activeTimesheetId,  TimesheetOverviewEntity? overview,  List<ProjectAssignmentEntity> assignmentsForSelectedDay,  String? currentWeekActiveId,  String formattedOverviewWeeks,  ProjectAssignmentEntity? editingTask,  int? editingIndex)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.user,_that.editFromDate,_that.editToDate,_that.selectedDate,_that.timesheets,_that.hasMore,_that.editAssignments,_that.projects,_that.isActionLoading,_that.activeTimesheetId,_that.overview,_that.assignmentsForSelectedDay,_that.currentWeekActiveId,_that.formattedOverviewWeeks,_that.editingTask,_that.editingIndex);case _Loading() when loading != null:
return loading(_that.user,_that.editFromDate,_that.editToDate,_that.selectedDate,_that.timesheets,_that.hasMore,_that.editAssignments,_that.projects,_that.isActionLoading,_that.activeTimesheetId,_that.overview,_that.assignmentsForSelectedDay,_that.currentWeekActiveId,_that.formattedOverviewWeeks,_that.editingTask,_that.editingIndex);case _Loaded() when loaded != null:
return loaded(_that.timesheets,_that.hasMore,_that.isFetchingMore,_that.user,_that.editFromDate,_that.editToDate,_that.selectedDate,_that.editAssignments,_that.projects,_that.isActionLoading,_that.activeTimesheetId,_that.overview,_that.assignmentsForSelectedDay,_that.currentWeekActiveId,_that.formattedOverviewWeeks,_that.editingTask,_that.editingIndex);case _Success() when success != null:
return success(_that.message,_that.successType,_that.user,_that.editFromDate,_that.editToDate,_that.selectedDate,_that.timesheets,_that.hasMore,_that.editAssignments,_that.projects,_that.isActionLoading,_that.activeTimesheetId,_that.overview,_that.assignmentsForSelectedDay,_that.currentWeekActiveId,_that.formattedOverviewWeeks,_that.editingTask,_that.editingIndex);case _Error() when error != null:
return error(_that.message,_that.user,_that.editFromDate,_that.editToDate,_that.selectedDate,_that.timesheets,_that.hasMore,_that.editAssignments,_that.projects,_that.isActionLoading,_that.activeTimesheetId,_that.overview,_that.assignmentsForSelectedDay,_that.currentWeekActiveId,_that.formattedOverviewWeeks,_that.editingTask,_that.editingIndex);case _:
  return null;

}
}

}

/// @nodoc


class _Initial extends TimesheetState {
  const _Initial({this.user, this.editFromDate, this.editToDate, this.selectedDate, final  List<TimesheetEntity> timesheets = const [], this.hasMore = false, final  List<ProjectAssignmentEntity> editAssignments = const [], final  List<ProjectEntity> projects = const [], this.isActionLoading = false, this.activeTimesheetId, this.overview, final  List<ProjectAssignmentEntity> assignmentsForSelectedDay = const [], this.currentWeekActiveId, this.formattedOverviewWeeks = "", this.editingTask, this.editingIndex}): _timesheets = timesheets,_editAssignments = editAssignments,_projects = projects,_assignmentsForSelectedDay = assignmentsForSelectedDay,super._();
  

@override final  UserEntity? user;
@override final  DateTime? editFromDate;
@override final  DateTime? editToDate;
@override final  DateTime? selectedDate;
 final  List<TimesheetEntity> _timesheets;
@override@JsonKey() List<TimesheetEntity> get timesheets {
  if (_timesheets is EqualUnmodifiableListView) return _timesheets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timesheets);
}

@override@JsonKey() final  bool hasMore;
 final  List<ProjectAssignmentEntity> _editAssignments;
@override@JsonKey() List<ProjectAssignmentEntity> get editAssignments {
  if (_editAssignments is EqualUnmodifiableListView) return _editAssignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_editAssignments);
}

 final  List<ProjectEntity> _projects;
@override@JsonKey() List<ProjectEntity> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

@override@JsonKey() final  bool isActionLoading;
@override final  String? activeTimesheetId;
@override final  TimesheetOverviewEntity? overview;
 final  List<ProjectAssignmentEntity> _assignmentsForSelectedDay;
@override@JsonKey() List<ProjectAssignmentEntity> get assignmentsForSelectedDay {
  if (_assignmentsForSelectedDay is EqualUnmodifiableListView) return _assignmentsForSelectedDay;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignmentsForSelectedDay);
}

@override final  String? currentWeekActiveId;
@override@JsonKey() final  String formattedOverviewWeeks;
@override final  ProjectAssignmentEntity? editingTask;
@override final  int? editingIndex;

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.user, user) || other.user == user)&&(identical(other.editFromDate, editFromDate) || other.editFromDate == editFromDate)&&(identical(other.editToDate, editToDate) || other.editToDate == editToDate)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&const DeepCollectionEquality().equals(other._timesheets, _timesheets)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&const DeepCollectionEquality().equals(other._editAssignments, _editAssignments)&&const DeepCollectionEquality().equals(other._projects, _projects)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.activeTimesheetId, activeTimesheetId) || other.activeTimesheetId == activeTimesheetId)&&(identical(other.overview, overview) || other.overview == overview)&&const DeepCollectionEquality().equals(other._assignmentsForSelectedDay, _assignmentsForSelectedDay)&&(identical(other.currentWeekActiveId, currentWeekActiveId) || other.currentWeekActiveId == currentWeekActiveId)&&(identical(other.formattedOverviewWeeks, formattedOverviewWeeks) || other.formattedOverviewWeeks == formattedOverviewWeeks)&&(identical(other.editingTask, editingTask) || other.editingTask == editingTask)&&(identical(other.editingIndex, editingIndex) || other.editingIndex == editingIndex));
}


@override
int get hashCode => Object.hash(runtimeType,user,editFromDate,editToDate,selectedDate,const DeepCollectionEquality().hash(_timesheets),hasMore,const DeepCollectionEquality().hash(_editAssignments),const DeepCollectionEquality().hash(_projects),isActionLoading,activeTimesheetId,overview,const DeepCollectionEquality().hash(_assignmentsForSelectedDay),currentWeekActiveId,formattedOverviewWeeks,editingTask,editingIndex);

@override
String toString() {
  return 'TimesheetState.initial(user: $user, editFromDate: $editFromDate, editToDate: $editToDate, selectedDate: $selectedDate, timesheets: $timesheets, hasMore: $hasMore, editAssignments: $editAssignments, projects: $projects, isActionLoading: $isActionLoading, activeTimesheetId: $activeTimesheetId, overview: $overview, assignmentsForSelectedDay: $assignmentsForSelectedDay, currentWeekActiveId: $currentWeekActiveId, formattedOverviewWeeks: $formattedOverviewWeeks, editingTask: $editingTask, editingIndex: $editingIndex)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $TimesheetStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 UserEntity? user, DateTime? editFromDate, DateTime? editToDate, DateTime? selectedDate, List<TimesheetEntity> timesheets, bool hasMore, List<ProjectAssignmentEntity> editAssignments, List<ProjectEntity> projects, bool isActionLoading, String? activeTimesheetId, TimesheetOverviewEntity? overview, List<ProjectAssignmentEntity> assignmentsForSelectedDay, String? currentWeekActiveId, String formattedOverviewWeeks, ProjectAssignmentEntity? editingTask, int? editingIndex
});


@override $UserEntityCopyWith<$Res>? get user;@override $TimesheetOverviewEntityCopyWith<$Res>? get overview;@override $ProjectAssignmentEntityCopyWith<$Res>? get editingTask;

}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? editFromDate = freezed,Object? editToDate = freezed,Object? selectedDate = freezed,Object? timesheets = null,Object? hasMore = null,Object? editAssignments = null,Object? projects = null,Object? isActionLoading = null,Object? activeTimesheetId = freezed,Object? overview = freezed,Object? assignmentsForSelectedDay = null,Object? currentWeekActiveId = freezed,Object? formattedOverviewWeeks = null,Object? editingTask = freezed,Object? editingIndex = freezed,}) {
  return _then(_Initial(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity?,editFromDate: freezed == editFromDate ? _self.editFromDate : editFromDate // ignore: cast_nullable_to_non_nullable
as DateTime?,editToDate: freezed == editToDate ? _self.editToDate : editToDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,timesheets: null == timesheets ? _self._timesheets : timesheets // ignore: cast_nullable_to_non_nullable
as List<TimesheetEntity>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,editAssignments: null == editAssignments ? _self._editAssignments : editAssignments // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<ProjectEntity>,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,activeTimesheetId: freezed == activeTimesheetId ? _self.activeTimesheetId : activeTimesheetId // ignore: cast_nullable_to_non_nullable
as String?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as TimesheetOverviewEntity?,assignmentsForSelectedDay: null == assignmentsForSelectedDay ? _self._assignmentsForSelectedDay : assignmentsForSelectedDay // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,currentWeekActiveId: freezed == currentWeekActiveId ? _self.currentWeekActiveId : currentWeekActiveId // ignore: cast_nullable_to_non_nullable
as String?,formattedOverviewWeeks: null == formattedOverviewWeeks ? _self.formattedOverviewWeeks : formattedOverviewWeeks // ignore: cast_nullable_to_non_nullable
as String,editingTask: freezed == editingTask ? _self.editingTask : editingTask // ignore: cast_nullable_to_non_nullable
as ProjectAssignmentEntity?,editingIndex: freezed == editingIndex ? _self.editingIndex : editingIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimesheetOverviewEntityCopyWith<$Res>? get overview {
    if (_self.overview == null) {
    return null;
  }

  return $TimesheetOverviewEntityCopyWith<$Res>(_self.overview!, (value) {
    return _then(_self.copyWith(overview: value));
  });
}/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectAssignmentEntityCopyWith<$Res>? get editingTask {
    if (_self.editingTask == null) {
    return null;
  }

  return $ProjectAssignmentEntityCopyWith<$Res>(_self.editingTask!, (value) {
    return _then(_self.copyWith(editingTask: value));
  });
}
}

/// @nodoc


class _Loading extends TimesheetState {
  const _Loading({this.user, this.editFromDate, this.editToDate, this.selectedDate, final  List<TimesheetEntity> timesheets = const [], this.hasMore = false, final  List<ProjectAssignmentEntity> editAssignments = const [], final  List<ProjectEntity> projects = const [], this.isActionLoading = false, this.activeTimesheetId, this.overview, final  List<ProjectAssignmentEntity> assignmentsForSelectedDay = const [], this.currentWeekActiveId, this.formattedOverviewWeeks = "", this.editingTask, this.editingIndex}): _timesheets = timesheets,_editAssignments = editAssignments,_projects = projects,_assignmentsForSelectedDay = assignmentsForSelectedDay,super._();
  

@override final  UserEntity? user;
@override final  DateTime? editFromDate;
@override final  DateTime? editToDate;
@override final  DateTime? selectedDate;
 final  List<TimesheetEntity> _timesheets;
@override@JsonKey() List<TimesheetEntity> get timesheets {
  if (_timesheets is EqualUnmodifiableListView) return _timesheets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timesheets);
}

@override@JsonKey() final  bool hasMore;
 final  List<ProjectAssignmentEntity> _editAssignments;
@override@JsonKey() List<ProjectAssignmentEntity> get editAssignments {
  if (_editAssignments is EqualUnmodifiableListView) return _editAssignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_editAssignments);
}

 final  List<ProjectEntity> _projects;
@override@JsonKey() List<ProjectEntity> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

@override@JsonKey() final  bool isActionLoading;
@override final  String? activeTimesheetId;
@override final  TimesheetOverviewEntity? overview;
 final  List<ProjectAssignmentEntity> _assignmentsForSelectedDay;
@override@JsonKey() List<ProjectAssignmentEntity> get assignmentsForSelectedDay {
  if (_assignmentsForSelectedDay is EqualUnmodifiableListView) return _assignmentsForSelectedDay;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignmentsForSelectedDay);
}

@override final  String? currentWeekActiveId;
@override@JsonKey() final  String formattedOverviewWeeks;
@override final  ProjectAssignmentEntity? editingTask;
@override final  int? editingIndex;

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&(identical(other.user, user) || other.user == user)&&(identical(other.editFromDate, editFromDate) || other.editFromDate == editFromDate)&&(identical(other.editToDate, editToDate) || other.editToDate == editToDate)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&const DeepCollectionEquality().equals(other._timesheets, _timesheets)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&const DeepCollectionEquality().equals(other._editAssignments, _editAssignments)&&const DeepCollectionEquality().equals(other._projects, _projects)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.activeTimesheetId, activeTimesheetId) || other.activeTimesheetId == activeTimesheetId)&&(identical(other.overview, overview) || other.overview == overview)&&const DeepCollectionEquality().equals(other._assignmentsForSelectedDay, _assignmentsForSelectedDay)&&(identical(other.currentWeekActiveId, currentWeekActiveId) || other.currentWeekActiveId == currentWeekActiveId)&&(identical(other.formattedOverviewWeeks, formattedOverviewWeeks) || other.formattedOverviewWeeks == formattedOverviewWeeks)&&(identical(other.editingTask, editingTask) || other.editingTask == editingTask)&&(identical(other.editingIndex, editingIndex) || other.editingIndex == editingIndex));
}


@override
int get hashCode => Object.hash(runtimeType,user,editFromDate,editToDate,selectedDate,const DeepCollectionEquality().hash(_timesheets),hasMore,const DeepCollectionEquality().hash(_editAssignments),const DeepCollectionEquality().hash(_projects),isActionLoading,activeTimesheetId,overview,const DeepCollectionEquality().hash(_assignmentsForSelectedDay),currentWeekActiveId,formattedOverviewWeeks,editingTask,editingIndex);

@override
String toString() {
  return 'TimesheetState.loading(user: $user, editFromDate: $editFromDate, editToDate: $editToDate, selectedDate: $selectedDate, timesheets: $timesheets, hasMore: $hasMore, editAssignments: $editAssignments, projects: $projects, isActionLoading: $isActionLoading, activeTimesheetId: $activeTimesheetId, overview: $overview, assignmentsForSelectedDay: $assignmentsForSelectedDay, currentWeekActiveId: $currentWeekActiveId, formattedOverviewWeeks: $formattedOverviewWeeks, editingTask: $editingTask, editingIndex: $editingIndex)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $TimesheetStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@override @useResult
$Res call({
 UserEntity? user, DateTime? editFromDate, DateTime? editToDate, DateTime? selectedDate, List<TimesheetEntity> timesheets, bool hasMore, List<ProjectAssignmentEntity> editAssignments, List<ProjectEntity> projects, bool isActionLoading, String? activeTimesheetId, TimesheetOverviewEntity? overview, List<ProjectAssignmentEntity> assignmentsForSelectedDay, String? currentWeekActiveId, String formattedOverviewWeeks, ProjectAssignmentEntity? editingTask, int? editingIndex
});


@override $UserEntityCopyWith<$Res>? get user;@override $TimesheetOverviewEntityCopyWith<$Res>? get overview;@override $ProjectAssignmentEntityCopyWith<$Res>? get editingTask;

}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? editFromDate = freezed,Object? editToDate = freezed,Object? selectedDate = freezed,Object? timesheets = null,Object? hasMore = null,Object? editAssignments = null,Object? projects = null,Object? isActionLoading = null,Object? activeTimesheetId = freezed,Object? overview = freezed,Object? assignmentsForSelectedDay = null,Object? currentWeekActiveId = freezed,Object? formattedOverviewWeeks = null,Object? editingTask = freezed,Object? editingIndex = freezed,}) {
  return _then(_Loading(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity?,editFromDate: freezed == editFromDate ? _self.editFromDate : editFromDate // ignore: cast_nullable_to_non_nullable
as DateTime?,editToDate: freezed == editToDate ? _self.editToDate : editToDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,timesheets: null == timesheets ? _self._timesheets : timesheets // ignore: cast_nullable_to_non_nullable
as List<TimesheetEntity>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,editAssignments: null == editAssignments ? _self._editAssignments : editAssignments // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<ProjectEntity>,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,activeTimesheetId: freezed == activeTimesheetId ? _self.activeTimesheetId : activeTimesheetId // ignore: cast_nullable_to_non_nullable
as String?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as TimesheetOverviewEntity?,assignmentsForSelectedDay: null == assignmentsForSelectedDay ? _self._assignmentsForSelectedDay : assignmentsForSelectedDay // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,currentWeekActiveId: freezed == currentWeekActiveId ? _self.currentWeekActiveId : currentWeekActiveId // ignore: cast_nullable_to_non_nullable
as String?,formattedOverviewWeeks: null == formattedOverviewWeeks ? _self.formattedOverviewWeeks : formattedOverviewWeeks // ignore: cast_nullable_to_non_nullable
as String,editingTask: freezed == editingTask ? _self.editingTask : editingTask // ignore: cast_nullable_to_non_nullable
as ProjectAssignmentEntity?,editingIndex: freezed == editingIndex ? _self.editingIndex : editingIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimesheetOverviewEntityCopyWith<$Res>? get overview {
    if (_self.overview == null) {
    return null;
  }

  return $TimesheetOverviewEntityCopyWith<$Res>(_self.overview!, (value) {
    return _then(_self.copyWith(overview: value));
  });
}/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectAssignmentEntityCopyWith<$Res>? get editingTask {
    if (_self.editingTask == null) {
    return null;
  }

  return $ProjectAssignmentEntityCopyWith<$Res>(_self.editingTask!, (value) {
    return _then(_self.copyWith(editingTask: value));
  });
}
}

/// @nodoc


class _Loaded extends TimesheetState {
  const _Loaded({required final  List<TimesheetEntity> timesheets, this.hasMore = false, this.isFetchingMore = false, this.user, this.editFromDate, this.editToDate, this.selectedDate, final  List<ProjectAssignmentEntity> editAssignments = const [], final  List<ProjectEntity> projects = const [], this.isActionLoading = false, this.activeTimesheetId, this.overview, final  List<ProjectAssignmentEntity> assignmentsForSelectedDay = const [], this.currentWeekActiveId, this.formattedOverviewWeeks = "", this.editingTask, this.editingIndex}): _timesheets = timesheets,_editAssignments = editAssignments,_projects = projects,_assignmentsForSelectedDay = assignmentsForSelectedDay,super._();
  

 final  List<TimesheetEntity> _timesheets;
@override List<TimesheetEntity> get timesheets {
  if (_timesheets is EqualUnmodifiableListView) return _timesheets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timesheets);
}

@override@JsonKey() final  bool hasMore;
@JsonKey() final  bool isFetchingMore;
@override final  UserEntity? user;
@override final  DateTime? editFromDate;
@override final  DateTime? editToDate;
@override final  DateTime? selectedDate;
 final  List<ProjectAssignmentEntity> _editAssignments;
@override@JsonKey() List<ProjectAssignmentEntity> get editAssignments {
  if (_editAssignments is EqualUnmodifiableListView) return _editAssignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_editAssignments);
}

 final  List<ProjectEntity> _projects;
@override@JsonKey() List<ProjectEntity> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

@override@JsonKey() final  bool isActionLoading;
@override final  String? activeTimesheetId;
@override final  TimesheetOverviewEntity? overview;
 final  List<ProjectAssignmentEntity> _assignmentsForSelectedDay;
@override@JsonKey() List<ProjectAssignmentEntity> get assignmentsForSelectedDay {
  if (_assignmentsForSelectedDay is EqualUnmodifiableListView) return _assignmentsForSelectedDay;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignmentsForSelectedDay);
}

@override final  String? currentWeekActiveId;
@override@JsonKey() final  String formattedOverviewWeeks;
@override final  ProjectAssignmentEntity? editingTask;
@override final  int? editingIndex;

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._timesheets, _timesheets)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isFetchingMore, isFetchingMore) || other.isFetchingMore == isFetchingMore)&&(identical(other.user, user) || other.user == user)&&(identical(other.editFromDate, editFromDate) || other.editFromDate == editFromDate)&&(identical(other.editToDate, editToDate) || other.editToDate == editToDate)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&const DeepCollectionEquality().equals(other._editAssignments, _editAssignments)&&const DeepCollectionEquality().equals(other._projects, _projects)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.activeTimesheetId, activeTimesheetId) || other.activeTimesheetId == activeTimesheetId)&&(identical(other.overview, overview) || other.overview == overview)&&const DeepCollectionEquality().equals(other._assignmentsForSelectedDay, _assignmentsForSelectedDay)&&(identical(other.currentWeekActiveId, currentWeekActiveId) || other.currentWeekActiveId == currentWeekActiveId)&&(identical(other.formattedOverviewWeeks, formattedOverviewWeeks) || other.formattedOverviewWeeks == formattedOverviewWeeks)&&(identical(other.editingTask, editingTask) || other.editingTask == editingTask)&&(identical(other.editingIndex, editingIndex) || other.editingIndex == editingIndex));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_timesheets),hasMore,isFetchingMore,user,editFromDate,editToDate,selectedDate,const DeepCollectionEquality().hash(_editAssignments),const DeepCollectionEquality().hash(_projects),isActionLoading,activeTimesheetId,overview,const DeepCollectionEquality().hash(_assignmentsForSelectedDay),currentWeekActiveId,formattedOverviewWeeks,editingTask,editingIndex);

@override
String toString() {
  return 'TimesheetState.loaded(timesheets: $timesheets, hasMore: $hasMore, isFetchingMore: $isFetchingMore, user: $user, editFromDate: $editFromDate, editToDate: $editToDate, selectedDate: $selectedDate, editAssignments: $editAssignments, projects: $projects, isActionLoading: $isActionLoading, activeTimesheetId: $activeTimesheetId, overview: $overview, assignmentsForSelectedDay: $assignmentsForSelectedDay, currentWeekActiveId: $currentWeekActiveId, formattedOverviewWeeks: $formattedOverviewWeeks, editingTask: $editingTask, editingIndex: $editingIndex)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $TimesheetStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@override @useResult
$Res call({
 List<TimesheetEntity> timesheets, bool hasMore, bool isFetchingMore, UserEntity? user, DateTime? editFromDate, DateTime? editToDate, DateTime? selectedDate, List<ProjectAssignmentEntity> editAssignments, List<ProjectEntity> projects, bool isActionLoading, String? activeTimesheetId, TimesheetOverviewEntity? overview, List<ProjectAssignmentEntity> assignmentsForSelectedDay, String? currentWeekActiveId, String formattedOverviewWeeks, ProjectAssignmentEntity? editingTask, int? editingIndex
});


@override $UserEntityCopyWith<$Res>? get user;@override $TimesheetOverviewEntityCopyWith<$Res>? get overview;@override $ProjectAssignmentEntityCopyWith<$Res>? get editingTask;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timesheets = null,Object? hasMore = null,Object? isFetchingMore = null,Object? user = freezed,Object? editFromDate = freezed,Object? editToDate = freezed,Object? selectedDate = freezed,Object? editAssignments = null,Object? projects = null,Object? isActionLoading = null,Object? activeTimesheetId = freezed,Object? overview = freezed,Object? assignmentsForSelectedDay = null,Object? currentWeekActiveId = freezed,Object? formattedOverviewWeeks = null,Object? editingTask = freezed,Object? editingIndex = freezed,}) {
  return _then(_Loaded(
timesheets: null == timesheets ? _self._timesheets : timesheets // ignore: cast_nullable_to_non_nullable
as List<TimesheetEntity>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isFetchingMore: null == isFetchingMore ? _self.isFetchingMore : isFetchingMore // ignore: cast_nullable_to_non_nullable
as bool,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity?,editFromDate: freezed == editFromDate ? _self.editFromDate : editFromDate // ignore: cast_nullable_to_non_nullable
as DateTime?,editToDate: freezed == editToDate ? _self.editToDate : editToDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,editAssignments: null == editAssignments ? _self._editAssignments : editAssignments // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<ProjectEntity>,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,activeTimesheetId: freezed == activeTimesheetId ? _self.activeTimesheetId : activeTimesheetId // ignore: cast_nullable_to_non_nullable
as String?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as TimesheetOverviewEntity?,assignmentsForSelectedDay: null == assignmentsForSelectedDay ? _self._assignmentsForSelectedDay : assignmentsForSelectedDay // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,currentWeekActiveId: freezed == currentWeekActiveId ? _self.currentWeekActiveId : currentWeekActiveId // ignore: cast_nullable_to_non_nullable
as String?,formattedOverviewWeeks: null == formattedOverviewWeeks ? _self.formattedOverviewWeeks : formattedOverviewWeeks // ignore: cast_nullable_to_non_nullable
as String,editingTask: freezed == editingTask ? _self.editingTask : editingTask // ignore: cast_nullable_to_non_nullable
as ProjectAssignmentEntity?,editingIndex: freezed == editingIndex ? _self.editingIndex : editingIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimesheetOverviewEntityCopyWith<$Res>? get overview {
    if (_self.overview == null) {
    return null;
  }

  return $TimesheetOverviewEntityCopyWith<$Res>(_self.overview!, (value) {
    return _then(_self.copyWith(overview: value));
  });
}/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectAssignmentEntityCopyWith<$Res>? get editingTask {
    if (_self.editingTask == null) {
    return null;
  }

  return $ProjectAssignmentEntityCopyWith<$Res>(_self.editingTask!, (value) {
    return _then(_self.copyWith(editingTask: value));
  });
}
}

/// @nodoc


class _Success extends TimesheetState {
  const _Success({required this.message, this.successType, this.user, this.editFromDate, this.editToDate, this.selectedDate, final  List<TimesheetEntity> timesheets = const [], this.hasMore = false, final  List<ProjectAssignmentEntity> editAssignments = const [], final  List<ProjectEntity> projects = const [], this.isActionLoading = false, this.activeTimesheetId, this.overview, final  List<ProjectAssignmentEntity> assignmentsForSelectedDay = const [], this.currentWeekActiveId, this.formattedOverviewWeeks = "", this.editingTask, this.editingIndex}): _timesheets = timesheets,_editAssignments = editAssignments,_projects = projects,_assignmentsForSelectedDay = assignmentsForSelectedDay,super._();
  

 final  String message;
 final  TimesheetSuccessType? successType;
@override final  UserEntity? user;
@override final  DateTime? editFromDate;
@override final  DateTime? editToDate;
@override final  DateTime? selectedDate;
 final  List<TimesheetEntity> _timesheets;
@override@JsonKey() List<TimesheetEntity> get timesheets {
  if (_timesheets is EqualUnmodifiableListView) return _timesheets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timesheets);
}

@override@JsonKey() final  bool hasMore;
 final  List<ProjectAssignmentEntity> _editAssignments;
@override@JsonKey() List<ProjectAssignmentEntity> get editAssignments {
  if (_editAssignments is EqualUnmodifiableListView) return _editAssignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_editAssignments);
}

 final  List<ProjectEntity> _projects;
@override@JsonKey() List<ProjectEntity> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

@override@JsonKey() final  bool isActionLoading;
@override final  String? activeTimesheetId;
@override final  TimesheetOverviewEntity? overview;
 final  List<ProjectAssignmentEntity> _assignmentsForSelectedDay;
@override@JsonKey() List<ProjectAssignmentEntity> get assignmentsForSelectedDay {
  if (_assignmentsForSelectedDay is EqualUnmodifiableListView) return _assignmentsForSelectedDay;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignmentsForSelectedDay);
}

@override final  String? currentWeekActiveId;
@override@JsonKey() final  String formattedOverviewWeeks;
@override final  ProjectAssignmentEntity? editingTask;
@override final  int? editingIndex;

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.message, message) || other.message == message)&&(identical(other.successType, successType) || other.successType == successType)&&(identical(other.user, user) || other.user == user)&&(identical(other.editFromDate, editFromDate) || other.editFromDate == editFromDate)&&(identical(other.editToDate, editToDate) || other.editToDate == editToDate)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&const DeepCollectionEquality().equals(other._timesheets, _timesheets)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&const DeepCollectionEquality().equals(other._editAssignments, _editAssignments)&&const DeepCollectionEquality().equals(other._projects, _projects)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.activeTimesheetId, activeTimesheetId) || other.activeTimesheetId == activeTimesheetId)&&(identical(other.overview, overview) || other.overview == overview)&&const DeepCollectionEquality().equals(other._assignmentsForSelectedDay, _assignmentsForSelectedDay)&&(identical(other.currentWeekActiveId, currentWeekActiveId) || other.currentWeekActiveId == currentWeekActiveId)&&(identical(other.formattedOverviewWeeks, formattedOverviewWeeks) || other.formattedOverviewWeeks == formattedOverviewWeeks)&&(identical(other.editingTask, editingTask) || other.editingTask == editingTask)&&(identical(other.editingIndex, editingIndex) || other.editingIndex == editingIndex));
}


@override
int get hashCode => Object.hash(runtimeType,message,successType,user,editFromDate,editToDate,selectedDate,const DeepCollectionEquality().hash(_timesheets),hasMore,const DeepCollectionEquality().hash(_editAssignments),const DeepCollectionEquality().hash(_projects),isActionLoading,activeTimesheetId,overview,const DeepCollectionEquality().hash(_assignmentsForSelectedDay),currentWeekActiveId,formattedOverviewWeeks,editingTask,editingIndex);

@override
String toString() {
  return 'TimesheetState.success(message: $message, successType: $successType, user: $user, editFromDate: $editFromDate, editToDate: $editToDate, selectedDate: $selectedDate, timesheets: $timesheets, hasMore: $hasMore, editAssignments: $editAssignments, projects: $projects, isActionLoading: $isActionLoading, activeTimesheetId: $activeTimesheetId, overview: $overview, assignmentsForSelectedDay: $assignmentsForSelectedDay, currentWeekActiveId: $currentWeekActiveId, formattedOverviewWeeks: $formattedOverviewWeeks, editingTask: $editingTask, editingIndex: $editingIndex)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $TimesheetStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@override @useResult
$Res call({
 String message, TimesheetSuccessType? successType, UserEntity? user, DateTime? editFromDate, DateTime? editToDate, DateTime? selectedDate, List<TimesheetEntity> timesheets, bool hasMore, List<ProjectAssignmentEntity> editAssignments, List<ProjectEntity> projects, bool isActionLoading, String? activeTimesheetId, TimesheetOverviewEntity? overview, List<ProjectAssignmentEntity> assignmentsForSelectedDay, String? currentWeekActiveId, String formattedOverviewWeeks, ProjectAssignmentEntity? editingTask, int? editingIndex
});


@override $UserEntityCopyWith<$Res>? get user;@override $TimesheetOverviewEntityCopyWith<$Res>? get overview;@override $ProjectAssignmentEntityCopyWith<$Res>? get editingTask;

}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? successType = freezed,Object? user = freezed,Object? editFromDate = freezed,Object? editToDate = freezed,Object? selectedDate = freezed,Object? timesheets = null,Object? hasMore = null,Object? editAssignments = null,Object? projects = null,Object? isActionLoading = null,Object? activeTimesheetId = freezed,Object? overview = freezed,Object? assignmentsForSelectedDay = null,Object? currentWeekActiveId = freezed,Object? formattedOverviewWeeks = null,Object? editingTask = freezed,Object? editingIndex = freezed,}) {
  return _then(_Success(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,successType: freezed == successType ? _self.successType : successType // ignore: cast_nullable_to_non_nullable
as TimesheetSuccessType?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity?,editFromDate: freezed == editFromDate ? _self.editFromDate : editFromDate // ignore: cast_nullable_to_non_nullable
as DateTime?,editToDate: freezed == editToDate ? _self.editToDate : editToDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,timesheets: null == timesheets ? _self._timesheets : timesheets // ignore: cast_nullable_to_non_nullable
as List<TimesheetEntity>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,editAssignments: null == editAssignments ? _self._editAssignments : editAssignments // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<ProjectEntity>,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,activeTimesheetId: freezed == activeTimesheetId ? _self.activeTimesheetId : activeTimesheetId // ignore: cast_nullable_to_non_nullable
as String?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as TimesheetOverviewEntity?,assignmentsForSelectedDay: null == assignmentsForSelectedDay ? _self._assignmentsForSelectedDay : assignmentsForSelectedDay // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,currentWeekActiveId: freezed == currentWeekActiveId ? _self.currentWeekActiveId : currentWeekActiveId // ignore: cast_nullable_to_non_nullable
as String?,formattedOverviewWeeks: null == formattedOverviewWeeks ? _self.formattedOverviewWeeks : formattedOverviewWeeks // ignore: cast_nullable_to_non_nullable
as String,editingTask: freezed == editingTask ? _self.editingTask : editingTask // ignore: cast_nullable_to_non_nullable
as ProjectAssignmentEntity?,editingIndex: freezed == editingIndex ? _self.editingIndex : editingIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimesheetOverviewEntityCopyWith<$Res>? get overview {
    if (_self.overview == null) {
    return null;
  }

  return $TimesheetOverviewEntityCopyWith<$Res>(_self.overview!, (value) {
    return _then(_self.copyWith(overview: value));
  });
}/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectAssignmentEntityCopyWith<$Res>? get editingTask {
    if (_self.editingTask == null) {
    return null;
  }

  return $ProjectAssignmentEntityCopyWith<$Res>(_self.editingTask!, (value) {
    return _then(_self.copyWith(editingTask: value));
  });
}
}

/// @nodoc


class _Error extends TimesheetState {
  const _Error({required this.message, this.user, this.editFromDate, this.editToDate, this.selectedDate, final  List<TimesheetEntity> timesheets = const [], this.hasMore = false, final  List<ProjectAssignmentEntity> editAssignments = const [], final  List<ProjectEntity> projects = const [], this.isActionLoading = false, this.activeTimesheetId, this.overview, final  List<ProjectAssignmentEntity> assignmentsForSelectedDay = const [], this.currentWeekActiveId, this.formattedOverviewWeeks = "", this.editingTask, this.editingIndex}): _timesheets = timesheets,_editAssignments = editAssignments,_projects = projects,_assignmentsForSelectedDay = assignmentsForSelectedDay,super._();
  

 final  String message;
@override final  UserEntity? user;
@override final  DateTime? editFromDate;
@override final  DateTime? editToDate;
@override final  DateTime? selectedDate;
 final  List<TimesheetEntity> _timesheets;
@override@JsonKey() List<TimesheetEntity> get timesheets {
  if (_timesheets is EqualUnmodifiableListView) return _timesheets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timesheets);
}

@override@JsonKey() final  bool hasMore;
 final  List<ProjectAssignmentEntity> _editAssignments;
@override@JsonKey() List<ProjectAssignmentEntity> get editAssignments {
  if (_editAssignments is EqualUnmodifiableListView) return _editAssignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_editAssignments);
}

 final  List<ProjectEntity> _projects;
@override@JsonKey() List<ProjectEntity> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

@override@JsonKey() final  bool isActionLoading;
@override final  String? activeTimesheetId;
@override final  TimesheetOverviewEntity? overview;
 final  List<ProjectAssignmentEntity> _assignmentsForSelectedDay;
@override@JsonKey() List<ProjectAssignmentEntity> get assignmentsForSelectedDay {
  if (_assignmentsForSelectedDay is EqualUnmodifiableListView) return _assignmentsForSelectedDay;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignmentsForSelectedDay);
}

@override final  String? currentWeekActiveId;
@override@JsonKey() final  String formattedOverviewWeeks;
@override final  ProjectAssignmentEntity? editingTask;
@override final  int? editingIndex;

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message)&&(identical(other.user, user) || other.user == user)&&(identical(other.editFromDate, editFromDate) || other.editFromDate == editFromDate)&&(identical(other.editToDate, editToDate) || other.editToDate == editToDate)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&const DeepCollectionEquality().equals(other._timesheets, _timesheets)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&const DeepCollectionEquality().equals(other._editAssignments, _editAssignments)&&const DeepCollectionEquality().equals(other._projects, _projects)&&(identical(other.isActionLoading, isActionLoading) || other.isActionLoading == isActionLoading)&&(identical(other.activeTimesheetId, activeTimesheetId) || other.activeTimesheetId == activeTimesheetId)&&(identical(other.overview, overview) || other.overview == overview)&&const DeepCollectionEquality().equals(other._assignmentsForSelectedDay, _assignmentsForSelectedDay)&&(identical(other.currentWeekActiveId, currentWeekActiveId) || other.currentWeekActiveId == currentWeekActiveId)&&(identical(other.formattedOverviewWeeks, formattedOverviewWeeks) || other.formattedOverviewWeeks == formattedOverviewWeeks)&&(identical(other.editingTask, editingTask) || other.editingTask == editingTask)&&(identical(other.editingIndex, editingIndex) || other.editingIndex == editingIndex));
}


@override
int get hashCode => Object.hash(runtimeType,message,user,editFromDate,editToDate,selectedDate,const DeepCollectionEquality().hash(_timesheets),hasMore,const DeepCollectionEquality().hash(_editAssignments),const DeepCollectionEquality().hash(_projects),isActionLoading,activeTimesheetId,overview,const DeepCollectionEquality().hash(_assignmentsForSelectedDay),currentWeekActiveId,formattedOverviewWeeks,editingTask,editingIndex);

@override
String toString() {
  return 'TimesheetState.error(message: $message, user: $user, editFromDate: $editFromDate, editToDate: $editToDate, selectedDate: $selectedDate, timesheets: $timesheets, hasMore: $hasMore, editAssignments: $editAssignments, projects: $projects, isActionLoading: $isActionLoading, activeTimesheetId: $activeTimesheetId, overview: $overview, assignmentsForSelectedDay: $assignmentsForSelectedDay, currentWeekActiveId: $currentWeekActiveId, formattedOverviewWeeks: $formattedOverviewWeeks, editingTask: $editingTask, editingIndex: $editingIndex)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $TimesheetStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@override @useResult
$Res call({
 String message, UserEntity? user, DateTime? editFromDate, DateTime? editToDate, DateTime? selectedDate, List<TimesheetEntity> timesheets, bool hasMore, List<ProjectAssignmentEntity> editAssignments, List<ProjectEntity> projects, bool isActionLoading, String? activeTimesheetId, TimesheetOverviewEntity? overview, List<ProjectAssignmentEntity> assignmentsForSelectedDay, String? currentWeekActiveId, String formattedOverviewWeeks, ProjectAssignmentEntity? editingTask, int? editingIndex
});


@override $UserEntityCopyWith<$Res>? get user;@override $TimesheetOverviewEntityCopyWith<$Res>? get overview;@override $ProjectAssignmentEntityCopyWith<$Res>? get editingTask;

}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? user = freezed,Object? editFromDate = freezed,Object? editToDate = freezed,Object? selectedDate = freezed,Object? timesheets = null,Object? hasMore = null,Object? editAssignments = null,Object? projects = null,Object? isActionLoading = null,Object? activeTimesheetId = freezed,Object? overview = freezed,Object? assignmentsForSelectedDay = null,Object? currentWeekActiveId = freezed,Object? formattedOverviewWeeks = null,Object? editingTask = freezed,Object? editingIndex = freezed,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity?,editFromDate: freezed == editFromDate ? _self.editFromDate : editFromDate // ignore: cast_nullable_to_non_nullable
as DateTime?,editToDate: freezed == editToDate ? _self.editToDate : editToDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,timesheets: null == timesheets ? _self._timesheets : timesheets // ignore: cast_nullable_to_non_nullable
as List<TimesheetEntity>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,editAssignments: null == editAssignments ? _self._editAssignments : editAssignments // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<ProjectEntity>,isActionLoading: null == isActionLoading ? _self.isActionLoading : isActionLoading // ignore: cast_nullable_to_non_nullable
as bool,activeTimesheetId: freezed == activeTimesheetId ? _self.activeTimesheetId : activeTimesheetId // ignore: cast_nullable_to_non_nullable
as String?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as TimesheetOverviewEntity?,assignmentsForSelectedDay: null == assignmentsForSelectedDay ? _self._assignmentsForSelectedDay : assignmentsForSelectedDay // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>,currentWeekActiveId: freezed == currentWeekActiveId ? _self.currentWeekActiveId : currentWeekActiveId // ignore: cast_nullable_to_non_nullable
as String?,formattedOverviewWeeks: null == formattedOverviewWeeks ? _self.formattedOverviewWeeks : formattedOverviewWeeks // ignore: cast_nullable_to_non_nullable
as String,editingTask: freezed == editingTask ? _self.editingTask : editingTask // ignore: cast_nullable_to_non_nullable
as ProjectAssignmentEntity?,editingIndex: freezed == editingIndex ? _self.editingIndex : editingIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimesheetOverviewEntityCopyWith<$Res>? get overview {
    if (_self.overview == null) {
    return null;
  }

  return $TimesheetOverviewEntityCopyWith<$Res>(_self.overview!, (value) {
    return _then(_self.copyWith(overview: value));
  });
}/// Create a copy of TimesheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectAssignmentEntityCopyWith<$Res>? get editingTask {
    if (_self.editingTask == null) {
    return null;
  }

  return $ProjectAssignmentEntityCopyWith<$Res>(_self.editingTask!, (value) {
    return _then(_self.copyWith(editingTask: value));
  });
}
}

// dart format on
