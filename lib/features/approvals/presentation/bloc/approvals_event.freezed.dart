// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approvals_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ApprovalsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(ApprovalType type, ApprovalCategory category)
    categoryChanged,
    required TResult Function() refreshSummary,
    required TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )
    workflowActionSubmitted,
    required TResult Function(
      String requestId,
      String comment,
      ApprovalType type,
    )
    commentSubmitted,
    required TResult Function(String requestId, String doctype)
    commentsRequested,
    required TResult Function(String requestId) editTimesheetRequested,
    required TResult Function(Map<String, dynamic> payload)
    updateTimesheetRequested,
    required TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )
    syncTimesheetRequested,
    required TResult Function(String requestId) deleteTimesheetRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult? Function()? refreshSummary,
    TResult? Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult? Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult? Function(String requestId, String doctype)? commentsRequested,
    TResult? Function(String requestId)? editTimesheetRequested,
    TResult? Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult? Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult? Function(String requestId)? deleteTimesheetRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult Function()? refreshSummary,
    TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult Function(String requestId, String doctype)? commentsRequested,
    TResult Function(String requestId)? editTimesheetRequested,
    TResult Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult Function(String requestId)? deleteTimesheetRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(CategoryChanged value) categoryChanged,
    required TResult Function(RefreshSummary value) refreshSummary,
    required TResult Function(WorkflowActionSubmitted value)
    workflowActionSubmitted,
    required TResult Function(CommentSubmitted value) commentSubmitted,
    required TResult Function(CommentsRequested value) commentsRequested,
    required TResult Function(EditTimesheetRequested value)
    editTimesheetRequested,
    required TResult Function(UpdateTimesheetRequested value)
    updateTimesheetRequested,
    required TResult Function(SyncTimesheetRequested value)
    syncTimesheetRequested,
    required TResult Function(DeleteTimesheetRequested value)
    deleteTimesheetRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(CategoryChanged value)? categoryChanged,
    TResult? Function(RefreshSummary value)? refreshSummary,
    TResult? Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult? Function(CommentSubmitted value)? commentSubmitted,
    TResult? Function(CommentsRequested value)? commentsRequested,
    TResult? Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult? Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult? Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult? Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(CategoryChanged value)? categoryChanged,
    TResult Function(RefreshSummary value)? refreshSummary,
    TResult Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult Function(CommentSubmitted value)? commentSubmitted,
    TResult Function(CommentsRequested value)? commentsRequested,
    TResult Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalsEventCopyWith<$Res> {
  factory $ApprovalsEventCopyWith(
    ApprovalsEvent value,
    $Res Function(ApprovalsEvent) then,
  ) = _$ApprovalsEventCopyWithImpl<$Res, ApprovalsEvent>;
}

/// @nodoc
class _$ApprovalsEventCopyWithImpl<$Res, $Val extends ApprovalsEvent>
    implements $ApprovalsEventCopyWith<$Res> {
  _$ApprovalsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
    _$StartedImpl value,
    $Res Function(_$StartedImpl) then,
  ) = __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$ApprovalsEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
    _$StartedImpl _value,
    $Res Function(_$StartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'ApprovalsEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(ApprovalType type, ApprovalCategory category)
    categoryChanged,
    required TResult Function() refreshSummary,
    required TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )
    workflowActionSubmitted,
    required TResult Function(
      String requestId,
      String comment,
      ApprovalType type,
    )
    commentSubmitted,
    required TResult Function(String requestId, String doctype)
    commentsRequested,
    required TResult Function(String requestId) editTimesheetRequested,
    required TResult Function(Map<String, dynamic> payload)
    updateTimesheetRequested,
    required TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )
    syncTimesheetRequested,
    required TResult Function(String requestId) deleteTimesheetRequested,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult? Function()? refreshSummary,
    TResult? Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult? Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult? Function(String requestId, String doctype)? commentsRequested,
    TResult? Function(String requestId)? editTimesheetRequested,
    TResult? Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult? Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult? Function(String requestId)? deleteTimesheetRequested,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult Function()? refreshSummary,
    TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult Function(String requestId, String doctype)? commentsRequested,
    TResult Function(String requestId)? editTimesheetRequested,
    TResult Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult Function(String requestId)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(CategoryChanged value) categoryChanged,
    required TResult Function(RefreshSummary value) refreshSummary,
    required TResult Function(WorkflowActionSubmitted value)
    workflowActionSubmitted,
    required TResult Function(CommentSubmitted value) commentSubmitted,
    required TResult Function(CommentsRequested value) commentsRequested,
    required TResult Function(EditTimesheetRequested value)
    editTimesheetRequested,
    required TResult Function(UpdateTimesheetRequested value)
    updateTimesheetRequested,
    required TResult Function(SyncTimesheetRequested value)
    syncTimesheetRequested,
    required TResult Function(DeleteTimesheetRequested value)
    deleteTimesheetRequested,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(CategoryChanged value)? categoryChanged,
    TResult? Function(RefreshSummary value)? refreshSummary,
    TResult? Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult? Function(CommentSubmitted value)? commentSubmitted,
    TResult? Function(CommentsRequested value)? commentsRequested,
    TResult? Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult? Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult? Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult? Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(CategoryChanged value)? categoryChanged,
    TResult Function(RefreshSummary value)? refreshSummary,
    TResult Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult Function(CommentSubmitted value)? commentSubmitted,
    TResult Function(CommentsRequested value)? commentsRequested,
    TResult Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class Started implements ApprovalsEvent {
  const factory Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$CategoryChangedImplCopyWith<$Res> {
  factory _$$CategoryChangedImplCopyWith(
    _$CategoryChangedImpl value,
    $Res Function(_$CategoryChangedImpl) then,
  ) = __$$CategoryChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ApprovalType type, ApprovalCategory category});
}

/// @nodoc
class __$$CategoryChangedImplCopyWithImpl<$Res>
    extends _$ApprovalsEventCopyWithImpl<$Res, _$CategoryChangedImpl>
    implements _$$CategoryChangedImplCopyWith<$Res> {
  __$$CategoryChangedImplCopyWithImpl(
    _$CategoryChangedImpl _value,
    $Res Function(_$CategoryChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? category = null}) {
    return _then(
      _$CategoryChangedImpl(
        null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ApprovalType,
        null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as ApprovalCategory,
      ),
    );
  }
}

/// @nodoc

class _$CategoryChangedImpl implements CategoryChanged {
  const _$CategoryChangedImpl(this.type, this.category);

  @override
  final ApprovalType type;
  @override
  final ApprovalCategory category;

  @override
  String toString() {
    return 'ApprovalsEvent.categoryChanged(type: $type, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryChangedImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, category);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryChangedImplCopyWith<_$CategoryChangedImpl> get copyWith =>
      __$$CategoryChangedImplCopyWithImpl<_$CategoryChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(ApprovalType type, ApprovalCategory category)
    categoryChanged,
    required TResult Function() refreshSummary,
    required TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )
    workflowActionSubmitted,
    required TResult Function(
      String requestId,
      String comment,
      ApprovalType type,
    )
    commentSubmitted,
    required TResult Function(String requestId, String doctype)
    commentsRequested,
    required TResult Function(String requestId) editTimesheetRequested,
    required TResult Function(Map<String, dynamic> payload)
    updateTimesheetRequested,
    required TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )
    syncTimesheetRequested,
    required TResult Function(String requestId) deleteTimesheetRequested,
  }) {
    return categoryChanged(type, category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult? Function()? refreshSummary,
    TResult? Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult? Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult? Function(String requestId, String doctype)? commentsRequested,
    TResult? Function(String requestId)? editTimesheetRequested,
    TResult? Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult? Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult? Function(String requestId)? deleteTimesheetRequested,
  }) {
    return categoryChanged?.call(type, category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult Function()? refreshSummary,
    TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult Function(String requestId, String doctype)? commentsRequested,
    TResult Function(String requestId)? editTimesheetRequested,
    TResult Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult Function(String requestId)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (categoryChanged != null) {
      return categoryChanged(type, category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(CategoryChanged value) categoryChanged,
    required TResult Function(RefreshSummary value) refreshSummary,
    required TResult Function(WorkflowActionSubmitted value)
    workflowActionSubmitted,
    required TResult Function(CommentSubmitted value) commentSubmitted,
    required TResult Function(CommentsRequested value) commentsRequested,
    required TResult Function(EditTimesheetRequested value)
    editTimesheetRequested,
    required TResult Function(UpdateTimesheetRequested value)
    updateTimesheetRequested,
    required TResult Function(SyncTimesheetRequested value)
    syncTimesheetRequested,
    required TResult Function(DeleteTimesheetRequested value)
    deleteTimesheetRequested,
  }) {
    return categoryChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(CategoryChanged value)? categoryChanged,
    TResult? Function(RefreshSummary value)? refreshSummary,
    TResult? Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult? Function(CommentSubmitted value)? commentSubmitted,
    TResult? Function(CommentsRequested value)? commentsRequested,
    TResult? Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult? Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult? Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult? Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
  }) {
    return categoryChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(CategoryChanged value)? categoryChanged,
    TResult Function(RefreshSummary value)? refreshSummary,
    TResult Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult Function(CommentSubmitted value)? commentSubmitted,
    TResult Function(CommentsRequested value)? commentsRequested,
    TResult Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (categoryChanged != null) {
      return categoryChanged(this);
    }
    return orElse();
  }
}

abstract class CategoryChanged implements ApprovalsEvent {
  const factory CategoryChanged(
    final ApprovalType type,
    final ApprovalCategory category,
  ) = _$CategoryChangedImpl;

  ApprovalType get type;
  ApprovalCategory get category;

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryChangedImplCopyWith<_$CategoryChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshSummaryImplCopyWith<$Res> {
  factory _$$RefreshSummaryImplCopyWith(
    _$RefreshSummaryImpl value,
    $Res Function(_$RefreshSummaryImpl) then,
  ) = __$$RefreshSummaryImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshSummaryImplCopyWithImpl<$Res>
    extends _$ApprovalsEventCopyWithImpl<$Res, _$RefreshSummaryImpl>
    implements _$$RefreshSummaryImplCopyWith<$Res> {
  __$$RefreshSummaryImplCopyWithImpl(
    _$RefreshSummaryImpl _value,
    $Res Function(_$RefreshSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshSummaryImpl implements RefreshSummary {
  const _$RefreshSummaryImpl();

  @override
  String toString() {
    return 'ApprovalsEvent.refreshSummary()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshSummaryImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(ApprovalType type, ApprovalCategory category)
    categoryChanged,
    required TResult Function() refreshSummary,
    required TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )
    workflowActionSubmitted,
    required TResult Function(
      String requestId,
      String comment,
      ApprovalType type,
    )
    commentSubmitted,
    required TResult Function(String requestId, String doctype)
    commentsRequested,
    required TResult Function(String requestId) editTimesheetRequested,
    required TResult Function(Map<String, dynamic> payload)
    updateTimesheetRequested,
    required TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )
    syncTimesheetRequested,
    required TResult Function(String requestId) deleteTimesheetRequested,
  }) {
    return refreshSummary();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult? Function()? refreshSummary,
    TResult? Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult? Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult? Function(String requestId, String doctype)? commentsRequested,
    TResult? Function(String requestId)? editTimesheetRequested,
    TResult? Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult? Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult? Function(String requestId)? deleteTimesheetRequested,
  }) {
    return refreshSummary?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult Function()? refreshSummary,
    TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult Function(String requestId, String doctype)? commentsRequested,
    TResult Function(String requestId)? editTimesheetRequested,
    TResult Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult Function(String requestId)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (refreshSummary != null) {
      return refreshSummary();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(CategoryChanged value) categoryChanged,
    required TResult Function(RefreshSummary value) refreshSummary,
    required TResult Function(WorkflowActionSubmitted value)
    workflowActionSubmitted,
    required TResult Function(CommentSubmitted value) commentSubmitted,
    required TResult Function(CommentsRequested value) commentsRequested,
    required TResult Function(EditTimesheetRequested value)
    editTimesheetRequested,
    required TResult Function(UpdateTimesheetRequested value)
    updateTimesheetRequested,
    required TResult Function(SyncTimesheetRequested value)
    syncTimesheetRequested,
    required TResult Function(DeleteTimesheetRequested value)
    deleteTimesheetRequested,
  }) {
    return refreshSummary(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(CategoryChanged value)? categoryChanged,
    TResult? Function(RefreshSummary value)? refreshSummary,
    TResult? Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult? Function(CommentSubmitted value)? commentSubmitted,
    TResult? Function(CommentsRequested value)? commentsRequested,
    TResult? Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult? Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult? Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult? Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
  }) {
    return refreshSummary?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(CategoryChanged value)? categoryChanged,
    TResult Function(RefreshSummary value)? refreshSummary,
    TResult Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult Function(CommentSubmitted value)? commentSubmitted,
    TResult Function(CommentsRequested value)? commentsRequested,
    TResult Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (refreshSummary != null) {
      return refreshSummary(this);
    }
    return orElse();
  }
}

abstract class RefreshSummary implements ApprovalsEvent {
  const factory RefreshSummary() = _$RefreshSummaryImpl;
}

/// @nodoc
abstract class _$$WorkflowActionSubmittedImplCopyWith<$Res> {
  factory _$$WorkflowActionSubmittedImplCopyWith(
    _$WorkflowActionSubmittedImpl value,
    $Res Function(_$WorkflowActionSubmittedImpl) then,
  ) = __$$WorkflowActionSubmittedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String requestId,
    String action,
    ApprovalType type,
    ApprovalCategory category,
  });
}

/// @nodoc
class __$$WorkflowActionSubmittedImplCopyWithImpl<$Res>
    extends _$ApprovalsEventCopyWithImpl<$Res, _$WorkflowActionSubmittedImpl>
    implements _$$WorkflowActionSubmittedImplCopyWith<$Res> {
  __$$WorkflowActionSubmittedImplCopyWithImpl(
    _$WorkflowActionSubmittedImpl _value,
    $Res Function(_$WorkflowActionSubmittedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = null,
    Object? action = null,
    Object? type = null,
    Object? category = null,
  }) {
    return _then(
      _$WorkflowActionSubmittedImpl(
        requestId: null == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as String,
        action: null == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ApprovalType,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as ApprovalCategory,
      ),
    );
  }
}

/// @nodoc

class _$WorkflowActionSubmittedImpl implements WorkflowActionSubmitted {
  const _$WorkflowActionSubmittedImpl({
    required this.requestId,
    required this.action,
    required this.type,
    required this.category,
  });

  @override
  final String requestId;
  @override
  final String action;
  @override
  final ApprovalType type;
  @override
  final ApprovalCategory category;

  @override
  String toString() {
    return 'ApprovalsEvent.workflowActionSubmitted(requestId: $requestId, action: $action, type: $type, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkflowActionSubmittedImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, requestId, action, type, category);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkflowActionSubmittedImplCopyWith<_$WorkflowActionSubmittedImpl>
  get copyWith =>
      __$$WorkflowActionSubmittedImplCopyWithImpl<
        _$WorkflowActionSubmittedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(ApprovalType type, ApprovalCategory category)
    categoryChanged,
    required TResult Function() refreshSummary,
    required TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )
    workflowActionSubmitted,
    required TResult Function(
      String requestId,
      String comment,
      ApprovalType type,
    )
    commentSubmitted,
    required TResult Function(String requestId, String doctype)
    commentsRequested,
    required TResult Function(String requestId) editTimesheetRequested,
    required TResult Function(Map<String, dynamic> payload)
    updateTimesheetRequested,
    required TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )
    syncTimesheetRequested,
    required TResult Function(String requestId) deleteTimesheetRequested,
  }) {
    return workflowActionSubmitted(requestId, action, type, category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult? Function()? refreshSummary,
    TResult? Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult? Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult? Function(String requestId, String doctype)? commentsRequested,
    TResult? Function(String requestId)? editTimesheetRequested,
    TResult? Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult? Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult? Function(String requestId)? deleteTimesheetRequested,
  }) {
    return workflowActionSubmitted?.call(requestId, action, type, category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult Function()? refreshSummary,
    TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult Function(String requestId, String doctype)? commentsRequested,
    TResult Function(String requestId)? editTimesheetRequested,
    TResult Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult Function(String requestId)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (workflowActionSubmitted != null) {
      return workflowActionSubmitted(requestId, action, type, category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(CategoryChanged value) categoryChanged,
    required TResult Function(RefreshSummary value) refreshSummary,
    required TResult Function(WorkflowActionSubmitted value)
    workflowActionSubmitted,
    required TResult Function(CommentSubmitted value) commentSubmitted,
    required TResult Function(CommentsRequested value) commentsRequested,
    required TResult Function(EditTimesheetRequested value)
    editTimesheetRequested,
    required TResult Function(UpdateTimesheetRequested value)
    updateTimesheetRequested,
    required TResult Function(SyncTimesheetRequested value)
    syncTimesheetRequested,
    required TResult Function(DeleteTimesheetRequested value)
    deleteTimesheetRequested,
  }) {
    return workflowActionSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(CategoryChanged value)? categoryChanged,
    TResult? Function(RefreshSummary value)? refreshSummary,
    TResult? Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult? Function(CommentSubmitted value)? commentSubmitted,
    TResult? Function(CommentsRequested value)? commentsRequested,
    TResult? Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult? Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult? Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult? Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
  }) {
    return workflowActionSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(CategoryChanged value)? categoryChanged,
    TResult Function(RefreshSummary value)? refreshSummary,
    TResult Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult Function(CommentSubmitted value)? commentSubmitted,
    TResult Function(CommentsRequested value)? commentsRequested,
    TResult Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (workflowActionSubmitted != null) {
      return workflowActionSubmitted(this);
    }
    return orElse();
  }
}

abstract class WorkflowActionSubmitted implements ApprovalsEvent {
  const factory WorkflowActionSubmitted({
    required final String requestId,
    required final String action,
    required final ApprovalType type,
    required final ApprovalCategory category,
  }) = _$WorkflowActionSubmittedImpl;

  String get requestId;
  String get action;
  ApprovalType get type;
  ApprovalCategory get category;

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkflowActionSubmittedImplCopyWith<_$WorkflowActionSubmittedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CommentSubmittedImplCopyWith<$Res> {
  factory _$$CommentSubmittedImplCopyWith(
    _$CommentSubmittedImpl value,
    $Res Function(_$CommentSubmittedImpl) then,
  ) = __$$CommentSubmittedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String requestId, String comment, ApprovalType type});
}

/// @nodoc
class __$$CommentSubmittedImplCopyWithImpl<$Res>
    extends _$ApprovalsEventCopyWithImpl<$Res, _$CommentSubmittedImpl>
    implements _$$CommentSubmittedImplCopyWith<$Res> {
  __$$CommentSubmittedImplCopyWithImpl(
    _$CommentSubmittedImpl _value,
    $Res Function(_$CommentSubmittedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = null,
    Object? comment = null,
    Object? type = null,
  }) {
    return _then(
      _$CommentSubmittedImpl(
        requestId: null == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as String,
        comment: null == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ApprovalType,
      ),
    );
  }
}

/// @nodoc

class _$CommentSubmittedImpl implements CommentSubmitted {
  const _$CommentSubmittedImpl({
    required this.requestId,
    required this.comment,
    required this.type,
  });

  @override
  final String requestId;
  @override
  final String comment;
  @override
  final ApprovalType type;

  @override
  String toString() {
    return 'ApprovalsEvent.commentSubmitted(requestId: $requestId, comment: $comment, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentSubmittedImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, requestId, comment, type);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentSubmittedImplCopyWith<_$CommentSubmittedImpl> get copyWith =>
      __$$CommentSubmittedImplCopyWithImpl<_$CommentSubmittedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(ApprovalType type, ApprovalCategory category)
    categoryChanged,
    required TResult Function() refreshSummary,
    required TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )
    workflowActionSubmitted,
    required TResult Function(
      String requestId,
      String comment,
      ApprovalType type,
    )
    commentSubmitted,
    required TResult Function(String requestId, String doctype)
    commentsRequested,
    required TResult Function(String requestId) editTimesheetRequested,
    required TResult Function(Map<String, dynamic> payload)
    updateTimesheetRequested,
    required TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )
    syncTimesheetRequested,
    required TResult Function(String requestId) deleteTimesheetRequested,
  }) {
    return commentSubmitted(requestId, comment, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult? Function()? refreshSummary,
    TResult? Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult? Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult? Function(String requestId, String doctype)? commentsRequested,
    TResult? Function(String requestId)? editTimesheetRequested,
    TResult? Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult? Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult? Function(String requestId)? deleteTimesheetRequested,
  }) {
    return commentSubmitted?.call(requestId, comment, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult Function()? refreshSummary,
    TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult Function(String requestId, String doctype)? commentsRequested,
    TResult Function(String requestId)? editTimesheetRequested,
    TResult Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult Function(String requestId)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (commentSubmitted != null) {
      return commentSubmitted(requestId, comment, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(CategoryChanged value) categoryChanged,
    required TResult Function(RefreshSummary value) refreshSummary,
    required TResult Function(WorkflowActionSubmitted value)
    workflowActionSubmitted,
    required TResult Function(CommentSubmitted value) commentSubmitted,
    required TResult Function(CommentsRequested value) commentsRequested,
    required TResult Function(EditTimesheetRequested value)
    editTimesheetRequested,
    required TResult Function(UpdateTimesheetRequested value)
    updateTimesheetRequested,
    required TResult Function(SyncTimesheetRequested value)
    syncTimesheetRequested,
    required TResult Function(DeleteTimesheetRequested value)
    deleteTimesheetRequested,
  }) {
    return commentSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(CategoryChanged value)? categoryChanged,
    TResult? Function(RefreshSummary value)? refreshSummary,
    TResult? Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult? Function(CommentSubmitted value)? commentSubmitted,
    TResult? Function(CommentsRequested value)? commentsRequested,
    TResult? Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult? Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult? Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult? Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
  }) {
    return commentSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(CategoryChanged value)? categoryChanged,
    TResult Function(RefreshSummary value)? refreshSummary,
    TResult Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult Function(CommentSubmitted value)? commentSubmitted,
    TResult Function(CommentsRequested value)? commentsRequested,
    TResult Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (commentSubmitted != null) {
      return commentSubmitted(this);
    }
    return orElse();
  }
}

abstract class CommentSubmitted implements ApprovalsEvent {
  const factory CommentSubmitted({
    required final String requestId,
    required final String comment,
    required final ApprovalType type,
  }) = _$CommentSubmittedImpl;

  String get requestId;
  String get comment;
  ApprovalType get type;

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentSubmittedImplCopyWith<_$CommentSubmittedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CommentsRequestedImplCopyWith<$Res> {
  factory _$$CommentsRequestedImplCopyWith(
    _$CommentsRequestedImpl value,
    $Res Function(_$CommentsRequestedImpl) then,
  ) = __$$CommentsRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String requestId, String doctype});
}

/// @nodoc
class __$$CommentsRequestedImplCopyWithImpl<$Res>
    extends _$ApprovalsEventCopyWithImpl<$Res, _$CommentsRequestedImpl>
    implements _$$CommentsRequestedImplCopyWith<$Res> {
  __$$CommentsRequestedImplCopyWithImpl(
    _$CommentsRequestedImpl _value,
    $Res Function(_$CommentsRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? requestId = null, Object? doctype = null}) {
    return _then(
      _$CommentsRequestedImpl(
        requestId: null == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as String,
        doctype: null == doctype
            ? _value.doctype
            : doctype // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CommentsRequestedImpl implements CommentsRequested {
  const _$CommentsRequestedImpl({
    required this.requestId,
    required this.doctype,
  });

  @override
  final String requestId;
  @override
  final String doctype;

  @override
  String toString() {
    return 'ApprovalsEvent.commentsRequested(requestId: $requestId, doctype: $doctype)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentsRequestedImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.doctype, doctype) || other.doctype == doctype));
  }

  @override
  int get hashCode => Object.hash(runtimeType, requestId, doctype);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentsRequestedImplCopyWith<_$CommentsRequestedImpl> get copyWith =>
      __$$CommentsRequestedImplCopyWithImpl<_$CommentsRequestedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(ApprovalType type, ApprovalCategory category)
    categoryChanged,
    required TResult Function() refreshSummary,
    required TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )
    workflowActionSubmitted,
    required TResult Function(
      String requestId,
      String comment,
      ApprovalType type,
    )
    commentSubmitted,
    required TResult Function(String requestId, String doctype)
    commentsRequested,
    required TResult Function(String requestId) editTimesheetRequested,
    required TResult Function(Map<String, dynamic> payload)
    updateTimesheetRequested,
    required TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )
    syncTimesheetRequested,
    required TResult Function(String requestId) deleteTimesheetRequested,
  }) {
    return commentsRequested(requestId, doctype);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult? Function()? refreshSummary,
    TResult? Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult? Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult? Function(String requestId, String doctype)? commentsRequested,
    TResult? Function(String requestId)? editTimesheetRequested,
    TResult? Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult? Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult? Function(String requestId)? deleteTimesheetRequested,
  }) {
    return commentsRequested?.call(requestId, doctype);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult Function()? refreshSummary,
    TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult Function(String requestId, String doctype)? commentsRequested,
    TResult Function(String requestId)? editTimesheetRequested,
    TResult Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult Function(String requestId)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (commentsRequested != null) {
      return commentsRequested(requestId, doctype);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(CategoryChanged value) categoryChanged,
    required TResult Function(RefreshSummary value) refreshSummary,
    required TResult Function(WorkflowActionSubmitted value)
    workflowActionSubmitted,
    required TResult Function(CommentSubmitted value) commentSubmitted,
    required TResult Function(CommentsRequested value) commentsRequested,
    required TResult Function(EditTimesheetRequested value)
    editTimesheetRequested,
    required TResult Function(UpdateTimesheetRequested value)
    updateTimesheetRequested,
    required TResult Function(SyncTimesheetRequested value)
    syncTimesheetRequested,
    required TResult Function(DeleteTimesheetRequested value)
    deleteTimesheetRequested,
  }) {
    return commentsRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(CategoryChanged value)? categoryChanged,
    TResult? Function(RefreshSummary value)? refreshSummary,
    TResult? Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult? Function(CommentSubmitted value)? commentSubmitted,
    TResult? Function(CommentsRequested value)? commentsRequested,
    TResult? Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult? Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult? Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult? Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
  }) {
    return commentsRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(CategoryChanged value)? categoryChanged,
    TResult Function(RefreshSummary value)? refreshSummary,
    TResult Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult Function(CommentSubmitted value)? commentSubmitted,
    TResult Function(CommentsRequested value)? commentsRequested,
    TResult Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (commentsRequested != null) {
      return commentsRequested(this);
    }
    return orElse();
  }
}

abstract class CommentsRequested implements ApprovalsEvent {
  const factory CommentsRequested({
    required final String requestId,
    required final String doctype,
  }) = _$CommentsRequestedImpl;

  String get requestId;
  String get doctype;

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentsRequestedImplCopyWith<_$CommentsRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditTimesheetRequestedImplCopyWith<$Res> {
  factory _$$EditTimesheetRequestedImplCopyWith(
    _$EditTimesheetRequestedImpl value,
    $Res Function(_$EditTimesheetRequestedImpl) then,
  ) = __$$EditTimesheetRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String requestId});
}

/// @nodoc
class __$$EditTimesheetRequestedImplCopyWithImpl<$Res>
    extends _$ApprovalsEventCopyWithImpl<$Res, _$EditTimesheetRequestedImpl>
    implements _$$EditTimesheetRequestedImplCopyWith<$Res> {
  __$$EditTimesheetRequestedImplCopyWithImpl(
    _$EditTimesheetRequestedImpl _value,
    $Res Function(_$EditTimesheetRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? requestId = null}) {
    return _then(
      _$EditTimesheetRequestedImpl(
        requestId: null == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$EditTimesheetRequestedImpl implements EditTimesheetRequested {
  const _$EditTimesheetRequestedImpl({required this.requestId});

  @override
  final String requestId;

  @override
  String toString() {
    return 'ApprovalsEvent.editTimesheetRequested(requestId: $requestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditTimesheetRequestedImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, requestId);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditTimesheetRequestedImplCopyWith<_$EditTimesheetRequestedImpl>
  get copyWith =>
      __$$EditTimesheetRequestedImplCopyWithImpl<_$EditTimesheetRequestedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(ApprovalType type, ApprovalCategory category)
    categoryChanged,
    required TResult Function() refreshSummary,
    required TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )
    workflowActionSubmitted,
    required TResult Function(
      String requestId,
      String comment,
      ApprovalType type,
    )
    commentSubmitted,
    required TResult Function(String requestId, String doctype)
    commentsRequested,
    required TResult Function(String requestId) editTimesheetRequested,
    required TResult Function(Map<String, dynamic> payload)
    updateTimesheetRequested,
    required TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )
    syncTimesheetRequested,
    required TResult Function(String requestId) deleteTimesheetRequested,
  }) {
    return editTimesheetRequested(requestId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult? Function()? refreshSummary,
    TResult? Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult? Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult? Function(String requestId, String doctype)? commentsRequested,
    TResult? Function(String requestId)? editTimesheetRequested,
    TResult? Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult? Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult? Function(String requestId)? deleteTimesheetRequested,
  }) {
    return editTimesheetRequested?.call(requestId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult Function()? refreshSummary,
    TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult Function(String requestId, String doctype)? commentsRequested,
    TResult Function(String requestId)? editTimesheetRequested,
    TResult Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult Function(String requestId)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (editTimesheetRequested != null) {
      return editTimesheetRequested(requestId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(CategoryChanged value) categoryChanged,
    required TResult Function(RefreshSummary value) refreshSummary,
    required TResult Function(WorkflowActionSubmitted value)
    workflowActionSubmitted,
    required TResult Function(CommentSubmitted value) commentSubmitted,
    required TResult Function(CommentsRequested value) commentsRequested,
    required TResult Function(EditTimesheetRequested value)
    editTimesheetRequested,
    required TResult Function(UpdateTimesheetRequested value)
    updateTimesheetRequested,
    required TResult Function(SyncTimesheetRequested value)
    syncTimesheetRequested,
    required TResult Function(DeleteTimesheetRequested value)
    deleteTimesheetRequested,
  }) {
    return editTimesheetRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(CategoryChanged value)? categoryChanged,
    TResult? Function(RefreshSummary value)? refreshSummary,
    TResult? Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult? Function(CommentSubmitted value)? commentSubmitted,
    TResult? Function(CommentsRequested value)? commentsRequested,
    TResult? Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult? Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult? Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult? Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
  }) {
    return editTimesheetRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(CategoryChanged value)? categoryChanged,
    TResult Function(RefreshSummary value)? refreshSummary,
    TResult Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult Function(CommentSubmitted value)? commentSubmitted,
    TResult Function(CommentsRequested value)? commentsRequested,
    TResult Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (editTimesheetRequested != null) {
      return editTimesheetRequested(this);
    }
    return orElse();
  }
}

abstract class EditTimesheetRequested implements ApprovalsEvent {
  const factory EditTimesheetRequested({required final String requestId}) =
      _$EditTimesheetRequestedImpl;

  String get requestId;

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditTimesheetRequestedImplCopyWith<_$EditTimesheetRequestedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateTimesheetRequestedImplCopyWith<$Res> {
  factory _$$UpdateTimesheetRequestedImplCopyWith(
    _$UpdateTimesheetRequestedImpl value,
    $Res Function(_$UpdateTimesheetRequestedImpl) then,
  ) = __$$UpdateTimesheetRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> payload});
}

/// @nodoc
class __$$UpdateTimesheetRequestedImplCopyWithImpl<$Res>
    extends _$ApprovalsEventCopyWithImpl<$Res, _$UpdateTimesheetRequestedImpl>
    implements _$$UpdateTimesheetRequestedImplCopyWith<$Res> {
  __$$UpdateTimesheetRequestedImplCopyWithImpl(
    _$UpdateTimesheetRequestedImpl _value,
    $Res Function(_$UpdateTimesheetRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? payload = null}) {
    return _then(
      _$UpdateTimesheetRequestedImpl(
        payload: null == payload
            ? _value._payload
            : payload // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$UpdateTimesheetRequestedImpl implements UpdateTimesheetRequested {
  const _$UpdateTimesheetRequestedImpl({
    required final Map<String, dynamic> payload,
  }) : _payload = payload;

  final Map<String, dynamic> _payload;
  @override
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  @override
  String toString() {
    return 'ApprovalsEvent.updateTimesheetRequested(payload: $payload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTimesheetRequestedImpl &&
            const DeepCollectionEquality().equals(other._payload, _payload));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_payload));

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTimesheetRequestedImplCopyWith<_$UpdateTimesheetRequestedImpl>
  get copyWith =>
      __$$UpdateTimesheetRequestedImplCopyWithImpl<
        _$UpdateTimesheetRequestedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(ApprovalType type, ApprovalCategory category)
    categoryChanged,
    required TResult Function() refreshSummary,
    required TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )
    workflowActionSubmitted,
    required TResult Function(
      String requestId,
      String comment,
      ApprovalType type,
    )
    commentSubmitted,
    required TResult Function(String requestId, String doctype)
    commentsRequested,
    required TResult Function(String requestId) editTimesheetRequested,
    required TResult Function(Map<String, dynamic> payload)
    updateTimesheetRequested,
    required TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )
    syncTimesheetRequested,
    required TResult Function(String requestId) deleteTimesheetRequested,
  }) {
    return updateTimesheetRequested(payload);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult? Function()? refreshSummary,
    TResult? Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult? Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult? Function(String requestId, String doctype)? commentsRequested,
    TResult? Function(String requestId)? editTimesheetRequested,
    TResult? Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult? Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult? Function(String requestId)? deleteTimesheetRequested,
  }) {
    return updateTimesheetRequested?.call(payload);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult Function()? refreshSummary,
    TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult Function(String requestId, String doctype)? commentsRequested,
    TResult Function(String requestId)? editTimesheetRequested,
    TResult Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult Function(String requestId)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (updateTimesheetRequested != null) {
      return updateTimesheetRequested(payload);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(CategoryChanged value) categoryChanged,
    required TResult Function(RefreshSummary value) refreshSummary,
    required TResult Function(WorkflowActionSubmitted value)
    workflowActionSubmitted,
    required TResult Function(CommentSubmitted value) commentSubmitted,
    required TResult Function(CommentsRequested value) commentsRequested,
    required TResult Function(EditTimesheetRequested value)
    editTimesheetRequested,
    required TResult Function(UpdateTimesheetRequested value)
    updateTimesheetRequested,
    required TResult Function(SyncTimesheetRequested value)
    syncTimesheetRequested,
    required TResult Function(DeleteTimesheetRequested value)
    deleteTimesheetRequested,
  }) {
    return updateTimesheetRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(CategoryChanged value)? categoryChanged,
    TResult? Function(RefreshSummary value)? refreshSummary,
    TResult? Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult? Function(CommentSubmitted value)? commentSubmitted,
    TResult? Function(CommentsRequested value)? commentsRequested,
    TResult? Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult? Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult? Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult? Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
  }) {
    return updateTimesheetRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(CategoryChanged value)? categoryChanged,
    TResult Function(RefreshSummary value)? refreshSummary,
    TResult Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult Function(CommentSubmitted value)? commentSubmitted,
    TResult Function(CommentsRequested value)? commentsRequested,
    TResult Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (updateTimesheetRequested != null) {
      return updateTimesheetRequested(this);
    }
    return orElse();
  }
}

abstract class UpdateTimesheetRequested implements ApprovalsEvent {
  const factory UpdateTimesheetRequested({
    required final Map<String, dynamic> payload,
  }) = _$UpdateTimesheetRequestedImpl;

  Map<String, dynamic> get payload;

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateTimesheetRequestedImplCopyWith<_$UpdateTimesheetRequestedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SyncTimesheetRequestedImplCopyWith<$Res> {
  factory _$$SyncTimesheetRequestedImplCopyWith(
    _$SyncTimesheetRequestedImpl value,
    $Res Function(_$SyncTimesheetRequestedImpl) then,
  ) = __$$SyncTimesheetRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    TimesheetApprovalEntity timesheet,
    List<ProjectAssignmentApprovalEntity> assignments,
  });

  $TimesheetApprovalEntityCopyWith<$Res> get timesheet;
}

/// @nodoc
class __$$SyncTimesheetRequestedImplCopyWithImpl<$Res>
    extends _$ApprovalsEventCopyWithImpl<$Res, _$SyncTimesheetRequestedImpl>
    implements _$$SyncTimesheetRequestedImplCopyWith<$Res> {
  __$$SyncTimesheetRequestedImplCopyWithImpl(
    _$SyncTimesheetRequestedImpl _value,
    $Res Function(_$SyncTimesheetRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? timesheet = null, Object? assignments = null}) {
    return _then(
      _$SyncTimesheetRequestedImpl(
        timesheet: null == timesheet
            ? _value.timesheet
            : timesheet // ignore: cast_nullable_to_non_nullable
                  as TimesheetApprovalEntity,
        assignments: null == assignments
            ? _value._assignments
            : assignments // ignore: cast_nullable_to_non_nullable
                  as List<ProjectAssignmentApprovalEntity>,
      ),
    );
  }

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimesheetApprovalEntityCopyWith<$Res> get timesheet {
    return $TimesheetApprovalEntityCopyWith<$Res>(_value.timesheet, (value) {
      return _then(_value.copyWith(timesheet: value));
    });
  }
}

/// @nodoc

class _$SyncTimesheetRequestedImpl implements SyncTimesheetRequested {
  const _$SyncTimesheetRequestedImpl({
    required this.timesheet,
    required final List<ProjectAssignmentApprovalEntity> assignments,
  }) : _assignments = assignments;

  @override
  final TimesheetApprovalEntity timesheet;
  final List<ProjectAssignmentApprovalEntity> _assignments;
  @override
  List<ProjectAssignmentApprovalEntity> get assignments {
    if (_assignments is EqualUnmodifiableListView) return _assignments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignments);
  }

  @override
  String toString() {
    return 'ApprovalsEvent.syncTimesheetRequested(timesheet: $timesheet, assignments: $assignments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncTimesheetRequestedImpl &&
            (identical(other.timesheet, timesheet) ||
                other.timesheet == timesheet) &&
            const DeepCollectionEquality().equals(
              other._assignments,
              _assignments,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    timesheet,
    const DeepCollectionEquality().hash(_assignments),
  );

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncTimesheetRequestedImplCopyWith<_$SyncTimesheetRequestedImpl>
  get copyWith =>
      __$$SyncTimesheetRequestedImplCopyWithImpl<_$SyncTimesheetRequestedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(ApprovalType type, ApprovalCategory category)
    categoryChanged,
    required TResult Function() refreshSummary,
    required TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )
    workflowActionSubmitted,
    required TResult Function(
      String requestId,
      String comment,
      ApprovalType type,
    )
    commentSubmitted,
    required TResult Function(String requestId, String doctype)
    commentsRequested,
    required TResult Function(String requestId) editTimesheetRequested,
    required TResult Function(Map<String, dynamic> payload)
    updateTimesheetRequested,
    required TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )
    syncTimesheetRequested,
    required TResult Function(String requestId) deleteTimesheetRequested,
  }) {
    return syncTimesheetRequested(timesheet, assignments);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult? Function()? refreshSummary,
    TResult? Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult? Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult? Function(String requestId, String doctype)? commentsRequested,
    TResult? Function(String requestId)? editTimesheetRequested,
    TResult? Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult? Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult? Function(String requestId)? deleteTimesheetRequested,
  }) {
    return syncTimesheetRequested?.call(timesheet, assignments);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult Function()? refreshSummary,
    TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult Function(String requestId, String doctype)? commentsRequested,
    TResult Function(String requestId)? editTimesheetRequested,
    TResult Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult Function(String requestId)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (syncTimesheetRequested != null) {
      return syncTimesheetRequested(timesheet, assignments);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(CategoryChanged value) categoryChanged,
    required TResult Function(RefreshSummary value) refreshSummary,
    required TResult Function(WorkflowActionSubmitted value)
    workflowActionSubmitted,
    required TResult Function(CommentSubmitted value) commentSubmitted,
    required TResult Function(CommentsRequested value) commentsRequested,
    required TResult Function(EditTimesheetRequested value)
    editTimesheetRequested,
    required TResult Function(UpdateTimesheetRequested value)
    updateTimesheetRequested,
    required TResult Function(SyncTimesheetRequested value)
    syncTimesheetRequested,
    required TResult Function(DeleteTimesheetRequested value)
    deleteTimesheetRequested,
  }) {
    return syncTimesheetRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(CategoryChanged value)? categoryChanged,
    TResult? Function(RefreshSummary value)? refreshSummary,
    TResult? Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult? Function(CommentSubmitted value)? commentSubmitted,
    TResult? Function(CommentsRequested value)? commentsRequested,
    TResult? Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult? Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult? Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult? Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
  }) {
    return syncTimesheetRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(CategoryChanged value)? categoryChanged,
    TResult Function(RefreshSummary value)? refreshSummary,
    TResult Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult Function(CommentSubmitted value)? commentSubmitted,
    TResult Function(CommentsRequested value)? commentsRequested,
    TResult Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (syncTimesheetRequested != null) {
      return syncTimesheetRequested(this);
    }
    return orElse();
  }
}

abstract class SyncTimesheetRequested implements ApprovalsEvent {
  const factory SyncTimesheetRequested({
    required final TimesheetApprovalEntity timesheet,
    required final List<ProjectAssignmentApprovalEntity> assignments,
  }) = _$SyncTimesheetRequestedImpl;

  TimesheetApprovalEntity get timesheet;
  List<ProjectAssignmentApprovalEntity> get assignments;

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncTimesheetRequestedImplCopyWith<_$SyncTimesheetRequestedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteTimesheetRequestedImplCopyWith<$Res> {
  factory _$$DeleteTimesheetRequestedImplCopyWith(
    _$DeleteTimesheetRequestedImpl value,
    $Res Function(_$DeleteTimesheetRequestedImpl) then,
  ) = __$$DeleteTimesheetRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String requestId});
}

/// @nodoc
class __$$DeleteTimesheetRequestedImplCopyWithImpl<$Res>
    extends _$ApprovalsEventCopyWithImpl<$Res, _$DeleteTimesheetRequestedImpl>
    implements _$$DeleteTimesheetRequestedImplCopyWith<$Res> {
  __$$DeleteTimesheetRequestedImplCopyWithImpl(
    _$DeleteTimesheetRequestedImpl _value,
    $Res Function(_$DeleteTimesheetRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? requestId = null}) {
    return _then(
      _$DeleteTimesheetRequestedImpl(
        requestId: null == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeleteTimesheetRequestedImpl implements DeleteTimesheetRequested {
  const _$DeleteTimesheetRequestedImpl({required this.requestId});

  @override
  final String requestId;

  @override
  String toString() {
    return 'ApprovalsEvent.deleteTimesheetRequested(requestId: $requestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteTimesheetRequestedImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, requestId);

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteTimesheetRequestedImplCopyWith<_$DeleteTimesheetRequestedImpl>
  get copyWith =>
      __$$DeleteTimesheetRequestedImplCopyWithImpl<
        _$DeleteTimesheetRequestedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(ApprovalType type, ApprovalCategory category)
    categoryChanged,
    required TResult Function() refreshSummary,
    required TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )
    workflowActionSubmitted,
    required TResult Function(
      String requestId,
      String comment,
      ApprovalType type,
    )
    commentSubmitted,
    required TResult Function(String requestId, String doctype)
    commentsRequested,
    required TResult Function(String requestId) editTimesheetRequested,
    required TResult Function(Map<String, dynamic> payload)
    updateTimesheetRequested,
    required TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )
    syncTimesheetRequested,
    required TResult Function(String requestId) deleteTimesheetRequested,
  }) {
    return deleteTimesheetRequested(requestId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult? Function()? refreshSummary,
    TResult? Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult? Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult? Function(String requestId, String doctype)? commentsRequested,
    TResult? Function(String requestId)? editTimesheetRequested,
    TResult? Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult? Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult? Function(String requestId)? deleteTimesheetRequested,
  }) {
    return deleteTimesheetRequested?.call(requestId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(ApprovalType type, ApprovalCategory category)?
    categoryChanged,
    TResult Function()? refreshSummary,
    TResult Function(
      String requestId,
      String action,
      ApprovalType type,
      ApprovalCategory category,
    )?
    workflowActionSubmitted,
    TResult Function(String requestId, String comment, ApprovalType type)?
    commentSubmitted,
    TResult Function(String requestId, String doctype)? commentsRequested,
    TResult Function(String requestId)? editTimesheetRequested,
    TResult Function(Map<String, dynamic> payload)? updateTimesheetRequested,
    TResult Function(
      TimesheetApprovalEntity timesheet,
      List<ProjectAssignmentApprovalEntity> assignments,
    )?
    syncTimesheetRequested,
    TResult Function(String requestId)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (deleteTimesheetRequested != null) {
      return deleteTimesheetRequested(requestId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(CategoryChanged value) categoryChanged,
    required TResult Function(RefreshSummary value) refreshSummary,
    required TResult Function(WorkflowActionSubmitted value)
    workflowActionSubmitted,
    required TResult Function(CommentSubmitted value) commentSubmitted,
    required TResult Function(CommentsRequested value) commentsRequested,
    required TResult Function(EditTimesheetRequested value)
    editTimesheetRequested,
    required TResult Function(UpdateTimesheetRequested value)
    updateTimesheetRequested,
    required TResult Function(SyncTimesheetRequested value)
    syncTimesheetRequested,
    required TResult Function(DeleteTimesheetRequested value)
    deleteTimesheetRequested,
  }) {
    return deleteTimesheetRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(CategoryChanged value)? categoryChanged,
    TResult? Function(RefreshSummary value)? refreshSummary,
    TResult? Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult? Function(CommentSubmitted value)? commentSubmitted,
    TResult? Function(CommentsRequested value)? commentsRequested,
    TResult? Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult? Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult? Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult? Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
  }) {
    return deleteTimesheetRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(CategoryChanged value)? categoryChanged,
    TResult Function(RefreshSummary value)? refreshSummary,
    TResult Function(WorkflowActionSubmitted value)? workflowActionSubmitted,
    TResult Function(CommentSubmitted value)? commentSubmitted,
    TResult Function(CommentsRequested value)? commentsRequested,
    TResult Function(EditTimesheetRequested value)? editTimesheetRequested,
    TResult Function(UpdateTimesheetRequested value)? updateTimesheetRequested,
    TResult Function(SyncTimesheetRequested value)? syncTimesheetRequested,
    TResult Function(DeleteTimesheetRequested value)? deleteTimesheetRequested,
    required TResult orElse(),
  }) {
    if (deleteTimesheetRequested != null) {
      return deleteTimesheetRequested(this);
    }
    return orElse();
  }
}

abstract class DeleteTimesheetRequested implements ApprovalsEvent {
  const factory DeleteTimesheetRequested({required final String requestId}) =
      _$DeleteTimesheetRequestedImpl;

  String get requestId;

  /// Create a copy of ApprovalsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteTimesheetRequestedImplCopyWith<_$DeleteTimesheetRequestedImpl>
  get copyWith => throw _privateConstructorUsedError;
}
