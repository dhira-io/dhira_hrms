// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approvals_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApprovalsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApprovalsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApprovalsEvent()';
}


}

/// @nodoc
class $ApprovalsEventCopyWith<$Res>  {
$ApprovalsEventCopyWith(ApprovalsEvent _, $Res Function(ApprovalsEvent) __);
}


/// Adds pattern-matching-related methods to [ApprovalsEvent].
extension ApprovalsEventPatterns on ApprovalsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( CategoryChanged value)?  categoryChanged,TResult Function( RefreshSummary value)?  refreshSummary,TResult Function( WorkflowActionSubmitted value)?  workflowActionSubmitted,TResult Function( CommentSubmitted value)?  commentSubmitted,TResult Function( CommentsRequested value)?  commentsRequested,TResult Function( EditTimesheetRequested value)?  editTimesheetRequested,TResult Function( UpdateTimesheetRequested value)?  updateTimesheetRequested,TResult Function( DeleteTimesheetRequested value)?  deleteTimesheetRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case CategoryChanged() when categoryChanged != null:
return categoryChanged(_that);case RefreshSummary() when refreshSummary != null:
return refreshSummary(_that);case WorkflowActionSubmitted() when workflowActionSubmitted != null:
return workflowActionSubmitted(_that);case CommentSubmitted() when commentSubmitted != null:
return commentSubmitted(_that);case CommentsRequested() when commentsRequested != null:
return commentsRequested(_that);case EditTimesheetRequested() when editTimesheetRequested != null:
return editTimesheetRequested(_that);case UpdateTimesheetRequested() when updateTimesheetRequested != null:
return updateTimesheetRequested(_that);case DeleteTimesheetRequested() when deleteTimesheetRequested != null:
return deleteTimesheetRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( CategoryChanged value)  categoryChanged,required TResult Function( RefreshSummary value)  refreshSummary,required TResult Function( WorkflowActionSubmitted value)  workflowActionSubmitted,required TResult Function( CommentSubmitted value)  commentSubmitted,required TResult Function( CommentsRequested value)  commentsRequested,required TResult Function( EditTimesheetRequested value)  editTimesheetRequested,required TResult Function( UpdateTimesheetRequested value)  updateTimesheetRequested,required TResult Function( DeleteTimesheetRequested value)  deleteTimesheetRequested,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case CategoryChanged():
return categoryChanged(_that);case RefreshSummary():
return refreshSummary(_that);case WorkflowActionSubmitted():
return workflowActionSubmitted(_that);case CommentSubmitted():
return commentSubmitted(_that);case CommentsRequested():
return commentsRequested(_that);case EditTimesheetRequested():
return editTimesheetRequested(_that);case UpdateTimesheetRequested():
return updateTimesheetRequested(_that);case DeleteTimesheetRequested():
return deleteTimesheetRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( CategoryChanged value)?  categoryChanged,TResult? Function( RefreshSummary value)?  refreshSummary,TResult? Function( WorkflowActionSubmitted value)?  workflowActionSubmitted,TResult? Function( CommentSubmitted value)?  commentSubmitted,TResult? Function( CommentsRequested value)?  commentsRequested,TResult? Function( EditTimesheetRequested value)?  editTimesheetRequested,TResult? Function( UpdateTimesheetRequested value)?  updateTimesheetRequested,TResult? Function( DeleteTimesheetRequested value)?  deleteTimesheetRequested,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case CategoryChanged() when categoryChanged != null:
return categoryChanged(_that);case RefreshSummary() when refreshSummary != null:
return refreshSummary(_that);case WorkflowActionSubmitted() when workflowActionSubmitted != null:
return workflowActionSubmitted(_that);case CommentSubmitted() when commentSubmitted != null:
return commentSubmitted(_that);case CommentsRequested() when commentsRequested != null:
return commentsRequested(_that);case EditTimesheetRequested() when editTimesheetRequested != null:
return editTimesheetRequested(_that);case UpdateTimesheetRequested() when updateTimesheetRequested != null:
return updateTimesheetRequested(_that);case DeleteTimesheetRequested() when deleteTimesheetRequested != null:
return deleteTimesheetRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( ApprovalType type,  ApprovalCategory category)?  categoryChanged,TResult Function()?  refreshSummary,TResult Function( String requestId,  String action,  ApprovalType type,  ApprovalCategory category)?  workflowActionSubmitted,TResult Function( String requestId,  String comment,  ApprovalType type)?  commentSubmitted,TResult Function( String requestId,  String doctype)?  commentsRequested,TResult Function( String requestId)?  editTimesheetRequested,TResult Function( Map<String, dynamic> payload)?  updateTimesheetRequested,TResult Function( String requestId)?  deleteTimesheetRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case CategoryChanged() when categoryChanged != null:
return categoryChanged(_that.type,_that.category);case RefreshSummary() when refreshSummary != null:
return refreshSummary();case WorkflowActionSubmitted() when workflowActionSubmitted != null:
return workflowActionSubmitted(_that.requestId,_that.action,_that.type,_that.category);case CommentSubmitted() when commentSubmitted != null:
return commentSubmitted(_that.requestId,_that.comment,_that.type);case CommentsRequested() when commentsRequested != null:
return commentsRequested(_that.requestId,_that.doctype);case EditTimesheetRequested() when editTimesheetRequested != null:
return editTimesheetRequested(_that.requestId);case UpdateTimesheetRequested() when updateTimesheetRequested != null:
return updateTimesheetRequested(_that.payload);case DeleteTimesheetRequested() when deleteTimesheetRequested != null:
return deleteTimesheetRequested(_that.requestId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( ApprovalType type,  ApprovalCategory category)  categoryChanged,required TResult Function()  refreshSummary,required TResult Function( String requestId,  String action,  ApprovalType type,  ApprovalCategory category)  workflowActionSubmitted,required TResult Function( String requestId,  String comment,  ApprovalType type)  commentSubmitted,required TResult Function( String requestId,  String doctype)  commentsRequested,required TResult Function( String requestId)  editTimesheetRequested,required TResult Function( Map<String, dynamic> payload)  updateTimesheetRequested,required TResult Function( String requestId)  deleteTimesheetRequested,}) {final _that = this;
switch (_that) {
case Started():
return started();case CategoryChanged():
return categoryChanged(_that.type,_that.category);case RefreshSummary():
return refreshSummary();case WorkflowActionSubmitted():
return workflowActionSubmitted(_that.requestId,_that.action,_that.type,_that.category);case CommentSubmitted():
return commentSubmitted(_that.requestId,_that.comment,_that.type);case CommentsRequested():
return commentsRequested(_that.requestId,_that.doctype);case EditTimesheetRequested():
return editTimesheetRequested(_that.requestId);case UpdateTimesheetRequested():
return updateTimesheetRequested(_that.payload);case DeleteTimesheetRequested():
return deleteTimesheetRequested(_that.requestId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( ApprovalType type,  ApprovalCategory category)?  categoryChanged,TResult? Function()?  refreshSummary,TResult? Function( String requestId,  String action,  ApprovalType type,  ApprovalCategory category)?  workflowActionSubmitted,TResult? Function( String requestId,  String comment,  ApprovalType type)?  commentSubmitted,TResult? Function( String requestId,  String doctype)?  commentsRequested,TResult? Function( String requestId)?  editTimesheetRequested,TResult? Function( Map<String, dynamic> payload)?  updateTimesheetRequested,TResult? Function( String requestId)?  deleteTimesheetRequested,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case CategoryChanged() when categoryChanged != null:
return categoryChanged(_that.type,_that.category);case RefreshSummary() when refreshSummary != null:
return refreshSummary();case WorkflowActionSubmitted() when workflowActionSubmitted != null:
return workflowActionSubmitted(_that.requestId,_that.action,_that.type,_that.category);case CommentSubmitted() when commentSubmitted != null:
return commentSubmitted(_that.requestId,_that.comment,_that.type);case CommentsRequested() when commentsRequested != null:
return commentsRequested(_that.requestId,_that.doctype);case EditTimesheetRequested() when editTimesheetRequested != null:
return editTimesheetRequested(_that.requestId);case UpdateTimesheetRequested() when updateTimesheetRequested != null:
return updateTimesheetRequested(_that.payload);case DeleteTimesheetRequested() when deleteTimesheetRequested != null:
return deleteTimesheetRequested(_that.requestId);case _:
  return null;

}
}

}

/// @nodoc


class Started implements ApprovalsEvent {
  const Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApprovalsEvent.started()';
}


}




/// @nodoc


class CategoryChanged implements ApprovalsEvent {
  const CategoryChanged(this.type, this.category);
  

 final  ApprovalType type;
 final  ApprovalCategory category;

/// Create a copy of ApprovalsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryChangedCopyWith<CategoryChanged> get copyWith => _$CategoryChangedCopyWithImpl<CategoryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryChanged&&(identical(other.type, type) || other.type == type)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,type,category);

@override
String toString() {
  return 'ApprovalsEvent.categoryChanged(type: $type, category: $category)';
}


}

/// @nodoc
abstract mixin class $CategoryChangedCopyWith<$Res> implements $ApprovalsEventCopyWith<$Res> {
  factory $CategoryChangedCopyWith(CategoryChanged value, $Res Function(CategoryChanged) _then) = _$CategoryChangedCopyWithImpl;
@useResult
$Res call({
 ApprovalType type, ApprovalCategory category
});




}
/// @nodoc
class _$CategoryChangedCopyWithImpl<$Res>
    implements $CategoryChangedCopyWith<$Res> {
  _$CategoryChangedCopyWithImpl(this._self, this._then);

  final CategoryChanged _self;
  final $Res Function(CategoryChanged) _then;

/// Create a copy of ApprovalsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,Object? category = null,}) {
  return _then(CategoryChanged(
null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ApprovalType,null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ApprovalCategory,
  ));
}


}

/// @nodoc


class RefreshSummary implements ApprovalsEvent {
  const RefreshSummary();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshSummary);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApprovalsEvent.refreshSummary()';
}


}




/// @nodoc


class WorkflowActionSubmitted implements ApprovalsEvent {
  const WorkflowActionSubmitted({required this.requestId, required this.action, required this.type, required this.category});
  

 final  String requestId;
 final  String action;
 final  ApprovalType type;
 final  ApprovalCategory category;

/// Create a copy of ApprovalsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkflowActionSubmittedCopyWith<WorkflowActionSubmitted> get copyWith => _$WorkflowActionSubmittedCopyWithImpl<WorkflowActionSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkflowActionSubmitted&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.action, action) || other.action == action)&&(identical(other.type, type) || other.type == type)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,requestId,action,type,category);

@override
String toString() {
  return 'ApprovalsEvent.workflowActionSubmitted(requestId: $requestId, action: $action, type: $type, category: $category)';
}


}

/// @nodoc
abstract mixin class $WorkflowActionSubmittedCopyWith<$Res> implements $ApprovalsEventCopyWith<$Res> {
  factory $WorkflowActionSubmittedCopyWith(WorkflowActionSubmitted value, $Res Function(WorkflowActionSubmitted) _then) = _$WorkflowActionSubmittedCopyWithImpl;
@useResult
$Res call({
 String requestId, String action, ApprovalType type, ApprovalCategory category
});




}
/// @nodoc
class _$WorkflowActionSubmittedCopyWithImpl<$Res>
    implements $WorkflowActionSubmittedCopyWith<$Res> {
  _$WorkflowActionSubmittedCopyWithImpl(this._self, this._then);

  final WorkflowActionSubmitted _self;
  final $Res Function(WorkflowActionSubmitted) _then;

/// Create a copy of ApprovalsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? action = null,Object? type = null,Object? category = null,}) {
  return _then(WorkflowActionSubmitted(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ApprovalType,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ApprovalCategory,
  ));
}


}

/// @nodoc


class CommentSubmitted implements ApprovalsEvent {
  const CommentSubmitted({required this.requestId, required this.comment, required this.type});
  

 final  String requestId;
 final  String comment;
 final  ApprovalType type;

/// Create a copy of ApprovalsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentSubmittedCopyWith<CommentSubmitted> get copyWith => _$CommentSubmittedCopyWithImpl<CommentSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentSubmitted&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,requestId,comment,type);

@override
String toString() {
  return 'ApprovalsEvent.commentSubmitted(requestId: $requestId, comment: $comment, type: $type)';
}


}

/// @nodoc
abstract mixin class $CommentSubmittedCopyWith<$Res> implements $ApprovalsEventCopyWith<$Res> {
  factory $CommentSubmittedCopyWith(CommentSubmitted value, $Res Function(CommentSubmitted) _then) = _$CommentSubmittedCopyWithImpl;
@useResult
$Res call({
 String requestId, String comment, ApprovalType type
});




}
/// @nodoc
class _$CommentSubmittedCopyWithImpl<$Res>
    implements $CommentSubmittedCopyWith<$Res> {
  _$CommentSubmittedCopyWithImpl(this._self, this._then);

  final CommentSubmitted _self;
  final $Res Function(CommentSubmitted) _then;

/// Create a copy of ApprovalsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? comment = null,Object? type = null,}) {
  return _then(CommentSubmitted(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ApprovalType,
  ));
}


}

/// @nodoc


class CommentsRequested implements ApprovalsEvent {
  const CommentsRequested({required this.requestId, required this.doctype});
  

 final  String requestId;
 final  String doctype;

/// Create a copy of ApprovalsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentsRequestedCopyWith<CommentsRequested> get copyWith => _$CommentsRequestedCopyWithImpl<CommentsRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentsRequested&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.doctype, doctype) || other.doctype == doctype));
}


@override
int get hashCode => Object.hash(runtimeType,requestId,doctype);

@override
String toString() {
  return 'ApprovalsEvent.commentsRequested(requestId: $requestId, doctype: $doctype)';
}


}

/// @nodoc
abstract mixin class $CommentsRequestedCopyWith<$Res> implements $ApprovalsEventCopyWith<$Res> {
  factory $CommentsRequestedCopyWith(CommentsRequested value, $Res Function(CommentsRequested) _then) = _$CommentsRequestedCopyWithImpl;
@useResult
$Res call({
 String requestId, String doctype
});




}
/// @nodoc
class _$CommentsRequestedCopyWithImpl<$Res>
    implements $CommentsRequestedCopyWith<$Res> {
  _$CommentsRequestedCopyWithImpl(this._self, this._then);

  final CommentsRequested _self;
  final $Res Function(CommentsRequested) _then;

/// Create a copy of ApprovalsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? doctype = null,}) {
  return _then(CommentsRequested(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,doctype: null == doctype ? _self.doctype : doctype // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class EditTimesheetRequested implements ApprovalsEvent {
  const EditTimesheetRequested({required this.requestId});
  

 final  String requestId;

/// Create a copy of ApprovalsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditTimesheetRequestedCopyWith<EditTimesheetRequested> get copyWith => _$EditTimesheetRequestedCopyWithImpl<EditTimesheetRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditTimesheetRequested&&(identical(other.requestId, requestId) || other.requestId == requestId));
}


@override
int get hashCode => Object.hash(runtimeType,requestId);

@override
String toString() {
  return 'ApprovalsEvent.editTimesheetRequested(requestId: $requestId)';
}


}

/// @nodoc
abstract mixin class $EditTimesheetRequestedCopyWith<$Res> implements $ApprovalsEventCopyWith<$Res> {
  factory $EditTimesheetRequestedCopyWith(EditTimesheetRequested value, $Res Function(EditTimesheetRequested) _then) = _$EditTimesheetRequestedCopyWithImpl;
@useResult
$Res call({
 String requestId
});




}
/// @nodoc
class _$EditTimesheetRequestedCopyWithImpl<$Res>
    implements $EditTimesheetRequestedCopyWith<$Res> {
  _$EditTimesheetRequestedCopyWithImpl(this._self, this._then);

  final EditTimesheetRequested _self;
  final $Res Function(EditTimesheetRequested) _then;

/// Create a copy of ApprovalsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requestId = null,}) {
  return _then(EditTimesheetRequested(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UpdateTimesheetRequested implements ApprovalsEvent {
  const UpdateTimesheetRequested({required final  Map<String, dynamic> payload}): _payload = payload;
  

 final  Map<String, dynamic> _payload;
 Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}


/// Create a copy of ApprovalsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateTimesheetRequestedCopyWith<UpdateTimesheetRequested> get copyWith => _$UpdateTimesheetRequestedCopyWithImpl<UpdateTimesheetRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateTimesheetRequested&&const DeepCollectionEquality().equals(other._payload, _payload));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'ApprovalsEvent.updateTimesheetRequested(payload: $payload)';
}


}

/// @nodoc
abstract mixin class $UpdateTimesheetRequestedCopyWith<$Res> implements $ApprovalsEventCopyWith<$Res> {
  factory $UpdateTimesheetRequestedCopyWith(UpdateTimesheetRequested value, $Res Function(UpdateTimesheetRequested) _then) = _$UpdateTimesheetRequestedCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> payload
});




}
/// @nodoc
class _$UpdateTimesheetRequestedCopyWithImpl<$Res>
    implements $UpdateTimesheetRequestedCopyWith<$Res> {
  _$UpdateTimesheetRequestedCopyWithImpl(this._self, this._then);

  final UpdateTimesheetRequested _self;
  final $Res Function(UpdateTimesheetRequested) _then;

/// Create a copy of ApprovalsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? payload = null,}) {
  return _then(UpdateTimesheetRequested(
payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class DeleteTimesheetRequested implements ApprovalsEvent {
  const DeleteTimesheetRequested({required this.requestId});
  

 final  String requestId;

/// Create a copy of ApprovalsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteTimesheetRequestedCopyWith<DeleteTimesheetRequested> get copyWith => _$DeleteTimesheetRequestedCopyWithImpl<DeleteTimesheetRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteTimesheetRequested&&(identical(other.requestId, requestId) || other.requestId == requestId));
}


@override
int get hashCode => Object.hash(runtimeType,requestId);

@override
String toString() {
  return 'ApprovalsEvent.deleteTimesheetRequested(requestId: $requestId)';
}


}

/// @nodoc
abstract mixin class $DeleteTimesheetRequestedCopyWith<$Res> implements $ApprovalsEventCopyWith<$Res> {
  factory $DeleteTimesheetRequestedCopyWith(DeleteTimesheetRequested value, $Res Function(DeleteTimesheetRequested) _then) = _$DeleteTimesheetRequestedCopyWithImpl;
@useResult
$Res call({
 String requestId
});




}
/// @nodoc
class _$DeleteTimesheetRequestedCopyWithImpl<$Res>
    implements $DeleteTimesheetRequestedCopyWith<$Res> {
  _$DeleteTimesheetRequestedCopyWithImpl(this._self, this._then);

  final DeleteTimesheetRequested _self;
  final $Res Function(DeleteTimesheetRequested) _then;

/// Create a copy of ApprovalsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requestId = null,}) {
  return _then(DeleteTimesheetRequested(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
