// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approvals_summary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApprovalsSummaryEntity {

 int get leaveApprovalsPending; int get attendanceRegularizationPending; int get timesheetApprovalsPending; int get compensatoryLeavePending; int get totalAllPending;
/// Create a copy of ApprovalsSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApprovalsSummaryEntityCopyWith<ApprovalsSummaryEntity> get copyWith => _$ApprovalsSummaryEntityCopyWithImpl<ApprovalsSummaryEntity>(this as ApprovalsSummaryEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApprovalsSummaryEntity&&(identical(other.leaveApprovalsPending, leaveApprovalsPending) || other.leaveApprovalsPending == leaveApprovalsPending)&&(identical(other.attendanceRegularizationPending, attendanceRegularizationPending) || other.attendanceRegularizationPending == attendanceRegularizationPending)&&(identical(other.timesheetApprovalsPending, timesheetApprovalsPending) || other.timesheetApprovalsPending == timesheetApprovalsPending)&&(identical(other.compensatoryLeavePending, compensatoryLeavePending) || other.compensatoryLeavePending == compensatoryLeavePending)&&(identical(other.totalAllPending, totalAllPending) || other.totalAllPending == totalAllPending));
}


@override
int get hashCode => Object.hash(runtimeType,leaveApprovalsPending,attendanceRegularizationPending,timesheetApprovalsPending,compensatoryLeavePending,totalAllPending);

@override
String toString() {
  return 'ApprovalsSummaryEntity(leaveApprovalsPending: $leaveApprovalsPending, attendanceRegularizationPending: $attendanceRegularizationPending, timesheetApprovalsPending: $timesheetApprovalsPending, compensatoryLeavePending: $compensatoryLeavePending, totalAllPending: $totalAllPending)';
}


}

/// @nodoc
abstract mixin class $ApprovalsSummaryEntityCopyWith<$Res>  {
  factory $ApprovalsSummaryEntityCopyWith(ApprovalsSummaryEntity value, $Res Function(ApprovalsSummaryEntity) _then) = _$ApprovalsSummaryEntityCopyWithImpl;
@useResult
$Res call({
 int leaveApprovalsPending, int attendanceRegularizationPending, int timesheetApprovalsPending, int compensatoryLeavePending, int totalAllPending
});




}
/// @nodoc
class _$ApprovalsSummaryEntityCopyWithImpl<$Res>
    implements $ApprovalsSummaryEntityCopyWith<$Res> {
  _$ApprovalsSummaryEntityCopyWithImpl(this._self, this._then);

  final ApprovalsSummaryEntity _self;
  final $Res Function(ApprovalsSummaryEntity) _then;

/// Create a copy of ApprovalsSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leaveApprovalsPending = null,Object? attendanceRegularizationPending = null,Object? timesheetApprovalsPending = null,Object? compensatoryLeavePending = null,Object? totalAllPending = null,}) {
  return _then(_self.copyWith(
leaveApprovalsPending: null == leaveApprovalsPending ? _self.leaveApprovalsPending : leaveApprovalsPending // ignore: cast_nullable_to_non_nullable
as int,attendanceRegularizationPending: null == attendanceRegularizationPending ? _self.attendanceRegularizationPending : attendanceRegularizationPending // ignore: cast_nullable_to_non_nullable
as int,timesheetApprovalsPending: null == timesheetApprovalsPending ? _self.timesheetApprovalsPending : timesheetApprovalsPending // ignore: cast_nullable_to_non_nullable
as int,compensatoryLeavePending: null == compensatoryLeavePending ? _self.compensatoryLeavePending : compensatoryLeavePending // ignore: cast_nullable_to_non_nullable
as int,totalAllPending: null == totalAllPending ? _self.totalAllPending : totalAllPending // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ApprovalsSummaryEntity].
extension ApprovalsSummaryEntityPatterns on ApprovalsSummaryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApprovalsSummaryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApprovalsSummaryEntity() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApprovalsSummaryEntity value)  $default,){
final _that = this;
switch (_that) {
case _ApprovalsSummaryEntity():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApprovalsSummaryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ApprovalsSummaryEntity() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int leaveApprovalsPending,  int attendanceRegularizationPending,  int timesheetApprovalsPending,  int compensatoryLeavePending,  int totalAllPending)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApprovalsSummaryEntity() when $default != null:
return $default(_that.leaveApprovalsPending,_that.attendanceRegularizationPending,_that.timesheetApprovalsPending,_that.compensatoryLeavePending,_that.totalAllPending);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int leaveApprovalsPending,  int attendanceRegularizationPending,  int timesheetApprovalsPending,  int compensatoryLeavePending,  int totalAllPending)  $default,) {final _that = this;
switch (_that) {
case _ApprovalsSummaryEntity():
return $default(_that.leaveApprovalsPending,_that.attendanceRegularizationPending,_that.timesheetApprovalsPending,_that.compensatoryLeavePending,_that.totalAllPending);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int leaveApprovalsPending,  int attendanceRegularizationPending,  int timesheetApprovalsPending,  int compensatoryLeavePending,  int totalAllPending)?  $default,) {final _that = this;
switch (_that) {
case _ApprovalsSummaryEntity() when $default != null:
return $default(_that.leaveApprovalsPending,_that.attendanceRegularizationPending,_that.timesheetApprovalsPending,_that.compensatoryLeavePending,_that.totalAllPending);case _:
  return null;

}
}

}

/// @nodoc


class _ApprovalsSummaryEntity implements ApprovalsSummaryEntity {
  const _ApprovalsSummaryEntity({required this.leaveApprovalsPending, required this.attendanceRegularizationPending, required this.timesheetApprovalsPending, required this.compensatoryLeavePending, required this.totalAllPending});
  

@override final  int leaveApprovalsPending;
@override final  int attendanceRegularizationPending;
@override final  int timesheetApprovalsPending;
@override final  int compensatoryLeavePending;
@override final  int totalAllPending;

/// Create a copy of ApprovalsSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApprovalsSummaryEntityCopyWith<_ApprovalsSummaryEntity> get copyWith => __$ApprovalsSummaryEntityCopyWithImpl<_ApprovalsSummaryEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApprovalsSummaryEntity&&(identical(other.leaveApprovalsPending, leaveApprovalsPending) || other.leaveApprovalsPending == leaveApprovalsPending)&&(identical(other.attendanceRegularizationPending, attendanceRegularizationPending) || other.attendanceRegularizationPending == attendanceRegularizationPending)&&(identical(other.timesheetApprovalsPending, timesheetApprovalsPending) || other.timesheetApprovalsPending == timesheetApprovalsPending)&&(identical(other.compensatoryLeavePending, compensatoryLeavePending) || other.compensatoryLeavePending == compensatoryLeavePending)&&(identical(other.totalAllPending, totalAllPending) || other.totalAllPending == totalAllPending));
}


@override
int get hashCode => Object.hash(runtimeType,leaveApprovalsPending,attendanceRegularizationPending,timesheetApprovalsPending,compensatoryLeavePending,totalAllPending);

@override
String toString() {
  return 'ApprovalsSummaryEntity(leaveApprovalsPending: $leaveApprovalsPending, attendanceRegularizationPending: $attendanceRegularizationPending, timesheetApprovalsPending: $timesheetApprovalsPending, compensatoryLeavePending: $compensatoryLeavePending, totalAllPending: $totalAllPending)';
}


}

/// @nodoc
abstract mixin class _$ApprovalsSummaryEntityCopyWith<$Res> implements $ApprovalsSummaryEntityCopyWith<$Res> {
  factory _$ApprovalsSummaryEntityCopyWith(_ApprovalsSummaryEntity value, $Res Function(_ApprovalsSummaryEntity) _then) = __$ApprovalsSummaryEntityCopyWithImpl;
@override @useResult
$Res call({
 int leaveApprovalsPending, int attendanceRegularizationPending, int timesheetApprovalsPending, int compensatoryLeavePending, int totalAllPending
});




}
/// @nodoc
class __$ApprovalsSummaryEntityCopyWithImpl<$Res>
    implements _$ApprovalsSummaryEntityCopyWith<$Res> {
  __$ApprovalsSummaryEntityCopyWithImpl(this._self, this._then);

  final _ApprovalsSummaryEntity _self;
  final $Res Function(_ApprovalsSummaryEntity) _then;

/// Create a copy of ApprovalsSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leaveApprovalsPending = null,Object? attendanceRegularizationPending = null,Object? timesheetApprovalsPending = null,Object? compensatoryLeavePending = null,Object? totalAllPending = null,}) {
  return _then(_ApprovalsSummaryEntity(
leaveApprovalsPending: null == leaveApprovalsPending ? _self.leaveApprovalsPending : leaveApprovalsPending // ignore: cast_nullable_to_non_nullable
as int,attendanceRegularizationPending: null == attendanceRegularizationPending ? _self.attendanceRegularizationPending : attendanceRegularizationPending // ignore: cast_nullable_to_non_nullable
as int,timesheetApprovalsPending: null == timesheetApprovalsPending ? _self.timesheetApprovalsPending : timesheetApprovalsPending // ignore: cast_nullable_to_non_nullable
as int,compensatoryLeavePending: null == compensatoryLeavePending ? _self.compensatoryLeavePending : compensatoryLeavePending // ignore: cast_nullable_to_non_nullable
as int,totalAllPending: null == totalAllPending ? _self.totalAllPending : totalAllPending // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
