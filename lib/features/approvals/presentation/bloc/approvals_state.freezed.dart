// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approvals_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApprovalsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApprovalsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApprovalsState()';
}


}

/// @nodoc
class $ApprovalsStateCopyWith<$Res>  {
$ApprovalsStateCopyWith(ApprovalsState _, $Res Function(ApprovalsState) __);
}


/// Adds pattern-matching-related methods to [ApprovalsState].
extension ApprovalsStatePatterns on ApprovalsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Loading value)?  loading,TResult Function( Success value)?  success,TResult Function( Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case Failure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Loading value)  loading,required TResult Function( Success value)  success,required TResult Function( Failure value)  failure,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Loading():
return loading(_that);case Success():
return success(_that);case Failure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Loading value)?  loading,TResult? Function( Success value)?  success,TResult? Function( Failure value)?  failure,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case Failure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ApprovalsAccessEntity access,  ApprovalsSummaryEntity summary,  List<ApprovalRequestEntity> requests,  bool isListLoading,  List<CommentEntity> comments,  bool isCommentsLoading,  TimesheetApprovalEntity? editingTimesheet,  bool isTimesheetLoading,  List<ProjectEntity> projects,  List<Map<String, dynamic>> employees,  String? successMessage,  String? errorMessage)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.access,_that.summary,_that.requests,_that.isListLoading,_that.comments,_that.isCommentsLoading,_that.editingTimesheet,_that.isTimesheetLoading,_that.projects,_that.employees,_that.successMessage,_that.errorMessage);case Failure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ApprovalsAccessEntity access,  ApprovalsSummaryEntity summary,  List<ApprovalRequestEntity> requests,  bool isListLoading,  List<CommentEntity> comments,  bool isCommentsLoading,  TimesheetApprovalEntity? editingTimesheet,  bool isTimesheetLoading,  List<ProjectEntity> projects,  List<Map<String, dynamic>> employees,  String? successMessage,  String? errorMessage)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case Loading():
return loading();case Success():
return success(_that.access,_that.summary,_that.requests,_that.isListLoading,_that.comments,_that.isCommentsLoading,_that.editingTimesheet,_that.isTimesheetLoading,_that.projects,_that.employees,_that.successMessage,_that.errorMessage);case Failure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ApprovalsAccessEntity access,  ApprovalsSummaryEntity summary,  List<ApprovalRequestEntity> requests,  bool isListLoading,  List<CommentEntity> comments,  bool isCommentsLoading,  TimesheetApprovalEntity? editingTimesheet,  bool isTimesheetLoading,  List<ProjectEntity> projects,  List<Map<String, dynamic>> employees,  String? successMessage,  String? errorMessage)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.access,_that.summary,_that.requests,_that.isListLoading,_that.comments,_that.isCommentsLoading,_that.editingTimesheet,_that.isTimesheetLoading,_that.projects,_that.employees,_that.successMessage,_that.errorMessage);case Failure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements ApprovalsState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApprovalsState.initial()';
}


}




/// @nodoc


class Loading implements ApprovalsState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApprovalsState.loading()';
}


}




/// @nodoc


class Success implements ApprovalsState {
  const Success({required this.access, required this.summary, final  List<ApprovalRequestEntity> requests = const [], this.isListLoading = false, final  List<CommentEntity> comments = const [], this.isCommentsLoading = false, this.editingTimesheet, this.isTimesheetLoading = false, final  List<ProjectEntity> projects = const [], final  List<Map<String, dynamic>> employees = const [], this.successMessage, this.errorMessage}): _requests = requests,_comments = comments,_projects = projects,_employees = employees;
  

 final  ApprovalsAccessEntity access;
 final  ApprovalsSummaryEntity summary;
 final  List<ApprovalRequestEntity> _requests;
@JsonKey() List<ApprovalRequestEntity> get requests {
  if (_requests is EqualUnmodifiableListView) return _requests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requests);
}

@JsonKey() final  bool isListLoading;
 final  List<CommentEntity> _comments;
@JsonKey() List<CommentEntity> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

@JsonKey() final  bool isCommentsLoading;
 final  TimesheetApprovalEntity? editingTimesheet;
@JsonKey() final  bool isTimesheetLoading;
 final  List<ProjectEntity> _projects;
@JsonKey() List<ProjectEntity> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

 final  List<Map<String, dynamic>> _employees;
@JsonKey() List<Map<String, dynamic>> get employees {
  if (_employees is EqualUnmodifiableListView) return _employees;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_employees);
}

 final  String? successMessage;
 final  String? errorMessage;

/// Create a copy of ApprovalsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<Success> get copyWith => _$SuccessCopyWithImpl<Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success&&(identical(other.access, access) || other.access == access)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._requests, _requests)&&(identical(other.isListLoading, isListLoading) || other.isListLoading == isListLoading)&&const DeepCollectionEquality().equals(other._comments, _comments)&&(identical(other.isCommentsLoading, isCommentsLoading) || other.isCommentsLoading == isCommentsLoading)&&(identical(other.editingTimesheet, editingTimesheet) || other.editingTimesheet == editingTimesheet)&&(identical(other.isTimesheetLoading, isTimesheetLoading) || other.isTimesheetLoading == isTimesheetLoading)&&const DeepCollectionEquality().equals(other._projects, _projects)&&const DeepCollectionEquality().equals(other._employees, _employees)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,access,summary,const DeepCollectionEquality().hash(_requests),isListLoading,const DeepCollectionEquality().hash(_comments),isCommentsLoading,editingTimesheet,isTimesheetLoading,const DeepCollectionEquality().hash(_projects),const DeepCollectionEquality().hash(_employees),successMessage,errorMessage);

@override
String toString() {
  return 'ApprovalsState.success(access: $access, summary: $summary, requests: $requests, isListLoading: $isListLoading, comments: $comments, isCommentsLoading: $isCommentsLoading, editingTimesheet: $editingTimesheet, isTimesheetLoading: $isTimesheetLoading, projects: $projects, employees: $employees, successMessage: $successMessage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<$Res> implements $ApprovalsStateCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) _then) = _$SuccessCopyWithImpl;
@useResult
$Res call({
 ApprovalsAccessEntity access, ApprovalsSummaryEntity summary, List<ApprovalRequestEntity> requests, bool isListLoading, List<CommentEntity> comments, bool isCommentsLoading, TimesheetApprovalEntity? editingTimesheet, bool isTimesheetLoading, List<ProjectEntity> projects, List<Map<String, dynamic>> employees, String? successMessage, String? errorMessage
});


$ApprovalsAccessEntityCopyWith<$Res> get access;$ApprovalsSummaryEntityCopyWith<$Res> get summary;$TimesheetApprovalEntityCopyWith<$Res>? get editingTimesheet;

}
/// @nodoc
class _$SuccessCopyWithImpl<$Res>
    implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success _self;
  final $Res Function(Success) _then;

/// Create a copy of ApprovalsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? access = null,Object? summary = null,Object? requests = null,Object? isListLoading = null,Object? comments = null,Object? isCommentsLoading = null,Object? editingTimesheet = freezed,Object? isTimesheetLoading = null,Object? projects = null,Object? employees = null,Object? successMessage = freezed,Object? errorMessage = freezed,}) {
  return _then(Success(
access: null == access ? _self.access : access // ignore: cast_nullable_to_non_nullable
as ApprovalsAccessEntity,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ApprovalsSummaryEntity,requests: null == requests ? _self._requests : requests // ignore: cast_nullable_to_non_nullable
as List<ApprovalRequestEntity>,isListLoading: null == isListLoading ? _self.isListLoading : isListLoading // ignore: cast_nullable_to_non_nullable
as bool,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommentEntity>,isCommentsLoading: null == isCommentsLoading ? _self.isCommentsLoading : isCommentsLoading // ignore: cast_nullable_to_non_nullable
as bool,editingTimesheet: freezed == editingTimesheet ? _self.editingTimesheet : editingTimesheet // ignore: cast_nullable_to_non_nullable
as TimesheetApprovalEntity?,isTimesheetLoading: null == isTimesheetLoading ? _self.isTimesheetLoading : isTimesheetLoading // ignore: cast_nullable_to_non_nullable
as bool,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<ProjectEntity>,employees: null == employees ? _self._employees : employees // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ApprovalsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApprovalsAccessEntityCopyWith<$Res> get access {
  
  return $ApprovalsAccessEntityCopyWith<$Res>(_self.access, (value) {
    return _then(_self.copyWith(access: value));
  });
}/// Create a copy of ApprovalsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApprovalsSummaryEntityCopyWith<$Res> get summary {
  
  return $ApprovalsSummaryEntityCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of ApprovalsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimesheetApprovalEntityCopyWith<$Res>? get editingTimesheet {
    if (_self.editingTimesheet == null) {
    return null;
  }

  return $TimesheetApprovalEntityCopyWith<$Res>(_self.editingTimesheet!, (value) {
    return _then(_self.copyWith(editingTimesheet: value));
  });
}
}

/// @nodoc


class Failure implements ApprovalsState {
  const Failure(this.message);
  

 final  String message;

/// Create a copy of ApprovalsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ApprovalsState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res> implements $ApprovalsStateCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of ApprovalsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Failure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
