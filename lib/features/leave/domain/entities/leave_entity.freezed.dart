// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LeaveEntity {

 String get name; String get employee; String get employeeName; String get leaveType; String get fromDate; String get toDate; String get status; String? get leaveApprover; int? get docstatus; String? get leaveApproverName; double? get totalLeaveDays; int get halfDay; String? get halfDayDate; String? get halfDaySegment; String? get description; bool get isMyLeave; bool get isApprover; bool get showEditDelete; bool get showCancel; bool get showApprovalActions;
/// Create a copy of LeaveEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveEntityCopyWith<LeaveEntity> get copyWith => _$LeaveEntityCopyWithImpl<LeaveEntity>(this as LeaveEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.leaveApprover, leaveApprover) || other.leaveApprover == leaveApprover)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.leaveApproverName, leaveApproverName) || other.leaveApproverName == leaveApproverName)&&(identical(other.totalLeaveDays, totalLeaveDays) || other.totalLeaveDays == totalLeaveDays)&&(identical(other.halfDay, halfDay) || other.halfDay == halfDay)&&(identical(other.halfDayDate, halfDayDate) || other.halfDayDate == halfDayDate)&&(identical(other.halfDaySegment, halfDaySegment) || other.halfDaySegment == halfDaySegment)&&(identical(other.description, description) || other.description == description)&&(identical(other.isMyLeave, isMyLeave) || other.isMyLeave == isMyLeave)&&(identical(other.isApprover, isApprover) || other.isApprover == isApprover)&&(identical(other.showEditDelete, showEditDelete) || other.showEditDelete == showEditDelete)&&(identical(other.showCancel, showCancel) || other.showCancel == showCancel)&&(identical(other.showApprovalActions, showApprovalActions) || other.showApprovalActions == showApprovalActions));
}


@override
int get hashCode => Object.hashAll([runtimeType,name,employee,employeeName,leaveType,fromDate,toDate,status,leaveApprover,docstatus,leaveApproverName,totalLeaveDays,halfDay,halfDayDate,halfDaySegment,description,isMyLeave,isApprover,showEditDelete,showCancel,showApprovalActions]);

@override
String toString() {
  return 'LeaveEntity(name: $name, employee: $employee, employeeName: $employeeName, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, status: $status, leaveApprover: $leaveApprover, docstatus: $docstatus, leaveApproverName: $leaveApproverName, totalLeaveDays: $totalLeaveDays, halfDay: $halfDay, halfDayDate: $halfDayDate, halfDaySegment: $halfDaySegment, description: $description, isMyLeave: $isMyLeave, isApprover: $isApprover, showEditDelete: $showEditDelete, showCancel: $showCancel, showApprovalActions: $showApprovalActions)';
}


}

/// @nodoc
abstract mixin class $LeaveEntityCopyWith<$Res>  {
  factory $LeaveEntityCopyWith(LeaveEntity value, $Res Function(LeaveEntity) _then) = _$LeaveEntityCopyWithImpl;
@useResult
$Res call({
 String name, String employee, String employeeName, String leaveType, String fromDate, String toDate, String status, String? leaveApprover, int? docstatus, String? leaveApproverName, double? totalLeaveDays, int halfDay, String? halfDayDate, String? halfDaySegment, String? description, bool isMyLeave, bool isApprover, bool showEditDelete, bool showCancel, bool showApprovalActions
});




}
/// @nodoc
class _$LeaveEntityCopyWithImpl<$Res>
    implements $LeaveEntityCopyWith<$Res> {
  _$LeaveEntityCopyWithImpl(this._self, this._then);

  final LeaveEntity _self;
  final $Res Function(LeaveEntity) _then;

/// Create a copy of LeaveEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? status = null,Object? leaveApprover = freezed,Object? docstatus = freezed,Object? leaveApproverName = freezed,Object? totalLeaveDays = freezed,Object? halfDay = null,Object? halfDayDate = freezed,Object? halfDaySegment = freezed,Object? description = freezed,Object? isMyLeave = null,Object? isApprover = null,Object? showEditDelete = null,Object? showCancel = null,Object? showApprovalActions = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,leaveApprover: freezed == leaveApprover ? _self.leaveApprover : leaveApprover // ignore: cast_nullable_to_non_nullable
as String?,docstatus: freezed == docstatus ? _self.docstatus : docstatus // ignore: cast_nullable_to_non_nullable
as int?,leaveApproverName: freezed == leaveApproverName ? _self.leaveApproverName : leaveApproverName // ignore: cast_nullable_to_non_nullable
as String?,totalLeaveDays: freezed == totalLeaveDays ? _self.totalLeaveDays : totalLeaveDays // ignore: cast_nullable_to_non_nullable
as double?,halfDay: null == halfDay ? _self.halfDay : halfDay // ignore: cast_nullable_to_non_nullable
as int,halfDayDate: freezed == halfDayDate ? _self.halfDayDate : halfDayDate // ignore: cast_nullable_to_non_nullable
as String?,halfDaySegment: freezed == halfDaySegment ? _self.halfDaySegment : halfDaySegment // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isMyLeave: null == isMyLeave ? _self.isMyLeave : isMyLeave // ignore: cast_nullable_to_non_nullable
as bool,isApprover: null == isApprover ? _self.isApprover : isApprover // ignore: cast_nullable_to_non_nullable
as bool,showEditDelete: null == showEditDelete ? _self.showEditDelete : showEditDelete // ignore: cast_nullable_to_non_nullable
as bool,showCancel: null == showCancel ? _self.showCancel : showCancel // ignore: cast_nullable_to_non_nullable
as bool,showApprovalActions: null == showApprovalActions ? _self.showApprovalActions : showApprovalActions // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveEntity].
extension LeaveEntityPatterns on LeaveEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveEntity value)  $default,){
final _that = this;
switch (_that) {
case _LeaveEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String employee,  String employeeName,  String leaveType,  String fromDate,  String toDate,  String status,  String? leaveApprover,  int? docstatus,  String? leaveApproverName,  double? totalLeaveDays,  int halfDay,  String? halfDayDate,  String? halfDaySegment,  String? description,  bool isMyLeave,  bool isApprover,  bool showEditDelete,  bool showCancel,  bool showApprovalActions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveEntity() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.status,_that.leaveApprover,_that.docstatus,_that.leaveApproverName,_that.totalLeaveDays,_that.halfDay,_that.halfDayDate,_that.halfDaySegment,_that.description,_that.isMyLeave,_that.isApprover,_that.showEditDelete,_that.showCancel,_that.showApprovalActions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String employee,  String employeeName,  String leaveType,  String fromDate,  String toDate,  String status,  String? leaveApprover,  int? docstatus,  String? leaveApproverName,  double? totalLeaveDays,  int halfDay,  String? halfDayDate,  String? halfDaySegment,  String? description,  bool isMyLeave,  bool isApprover,  bool showEditDelete,  bool showCancel,  bool showApprovalActions)  $default,) {final _that = this;
switch (_that) {
case _LeaveEntity():
return $default(_that.name,_that.employee,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.status,_that.leaveApprover,_that.docstatus,_that.leaveApproverName,_that.totalLeaveDays,_that.halfDay,_that.halfDayDate,_that.halfDaySegment,_that.description,_that.isMyLeave,_that.isApprover,_that.showEditDelete,_that.showCancel,_that.showApprovalActions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String employee,  String employeeName,  String leaveType,  String fromDate,  String toDate,  String status,  String? leaveApprover,  int? docstatus,  String? leaveApproverName,  double? totalLeaveDays,  int halfDay,  String? halfDayDate,  String? halfDaySegment,  String? description,  bool isMyLeave,  bool isApprover,  bool showEditDelete,  bool showCancel,  bool showApprovalActions)?  $default,) {final _that = this;
switch (_that) {
case _LeaveEntity() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.status,_that.leaveApprover,_that.docstatus,_that.leaveApproverName,_that.totalLeaveDays,_that.halfDay,_that.halfDayDate,_that.halfDaySegment,_that.description,_that.isMyLeave,_that.isApprover,_that.showEditDelete,_that.showCancel,_that.showApprovalActions);case _:
  return null;

}
}

}

/// @nodoc


class _LeaveEntity extends LeaveEntity {
  const _LeaveEntity({required this.name, required this.employee, required this.employeeName, required this.leaveType, required this.fromDate, required this.toDate, required this.status, this.leaveApprover, this.docstatus, this.leaveApproverName, this.totalLeaveDays, this.halfDay = 0, this.halfDayDate, this.halfDaySegment, this.description, this.isMyLeave = false, this.isApprover = false, this.showEditDelete = false, this.showCancel = false, this.showApprovalActions = false}): super._();
  

@override final  String name;
@override final  String employee;
@override final  String employeeName;
@override final  String leaveType;
@override final  String fromDate;
@override final  String toDate;
@override final  String status;
@override final  String? leaveApprover;
@override final  int? docstatus;
@override final  String? leaveApproverName;
@override final  double? totalLeaveDays;
@override@JsonKey() final  int halfDay;
@override final  String? halfDayDate;
@override final  String? halfDaySegment;
@override final  String? description;
@override@JsonKey() final  bool isMyLeave;
@override@JsonKey() final  bool isApprover;
@override@JsonKey() final  bool showEditDelete;
@override@JsonKey() final  bool showCancel;
@override@JsonKey() final  bool showApprovalActions;

/// Create a copy of LeaveEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveEntityCopyWith<_LeaveEntity> get copyWith => __$LeaveEntityCopyWithImpl<_LeaveEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.leaveApprover, leaveApprover) || other.leaveApprover == leaveApprover)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.leaveApproverName, leaveApproverName) || other.leaveApproverName == leaveApproverName)&&(identical(other.totalLeaveDays, totalLeaveDays) || other.totalLeaveDays == totalLeaveDays)&&(identical(other.halfDay, halfDay) || other.halfDay == halfDay)&&(identical(other.halfDayDate, halfDayDate) || other.halfDayDate == halfDayDate)&&(identical(other.halfDaySegment, halfDaySegment) || other.halfDaySegment == halfDaySegment)&&(identical(other.description, description) || other.description == description)&&(identical(other.isMyLeave, isMyLeave) || other.isMyLeave == isMyLeave)&&(identical(other.isApprover, isApprover) || other.isApprover == isApprover)&&(identical(other.showEditDelete, showEditDelete) || other.showEditDelete == showEditDelete)&&(identical(other.showCancel, showCancel) || other.showCancel == showCancel)&&(identical(other.showApprovalActions, showApprovalActions) || other.showApprovalActions == showApprovalActions));
}


@override
int get hashCode => Object.hashAll([runtimeType,name,employee,employeeName,leaveType,fromDate,toDate,status,leaveApprover,docstatus,leaveApproverName,totalLeaveDays,halfDay,halfDayDate,halfDaySegment,description,isMyLeave,isApprover,showEditDelete,showCancel,showApprovalActions]);

@override
String toString() {
  return 'LeaveEntity(name: $name, employee: $employee, employeeName: $employeeName, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, status: $status, leaveApprover: $leaveApprover, docstatus: $docstatus, leaveApproverName: $leaveApproverName, totalLeaveDays: $totalLeaveDays, halfDay: $halfDay, halfDayDate: $halfDayDate, halfDaySegment: $halfDaySegment, description: $description, isMyLeave: $isMyLeave, isApprover: $isApprover, showEditDelete: $showEditDelete, showCancel: $showCancel, showApprovalActions: $showApprovalActions)';
}


}

/// @nodoc
abstract mixin class _$LeaveEntityCopyWith<$Res> implements $LeaveEntityCopyWith<$Res> {
  factory _$LeaveEntityCopyWith(_LeaveEntity value, $Res Function(_LeaveEntity) _then) = __$LeaveEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String employee, String employeeName, String leaveType, String fromDate, String toDate, String status, String? leaveApprover, int? docstatus, String? leaveApproverName, double? totalLeaveDays, int halfDay, String? halfDayDate, String? halfDaySegment, String? description, bool isMyLeave, bool isApprover, bool showEditDelete, bool showCancel, bool showApprovalActions
});




}
/// @nodoc
class __$LeaveEntityCopyWithImpl<$Res>
    implements _$LeaveEntityCopyWith<$Res> {
  __$LeaveEntityCopyWithImpl(this._self, this._then);

  final _LeaveEntity _self;
  final $Res Function(_LeaveEntity) _then;

/// Create a copy of LeaveEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? status = null,Object? leaveApprover = freezed,Object? docstatus = freezed,Object? leaveApproverName = freezed,Object? totalLeaveDays = freezed,Object? halfDay = null,Object? halfDayDate = freezed,Object? halfDaySegment = freezed,Object? description = freezed,Object? isMyLeave = null,Object? isApprover = null,Object? showEditDelete = null,Object? showCancel = null,Object? showApprovalActions = null,}) {
  return _then(_LeaveEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,leaveApprover: freezed == leaveApprover ? _self.leaveApprover : leaveApprover // ignore: cast_nullable_to_non_nullable
as String?,docstatus: freezed == docstatus ? _self.docstatus : docstatus // ignore: cast_nullable_to_non_nullable
as int?,leaveApproverName: freezed == leaveApproverName ? _self.leaveApproverName : leaveApproverName // ignore: cast_nullable_to_non_nullable
as String?,totalLeaveDays: freezed == totalLeaveDays ? _self.totalLeaveDays : totalLeaveDays // ignore: cast_nullable_to_non_nullable
as double?,halfDay: null == halfDay ? _self.halfDay : halfDay // ignore: cast_nullable_to_non_nullable
as int,halfDayDate: freezed == halfDayDate ? _self.halfDayDate : halfDayDate // ignore: cast_nullable_to_non_nullable
as String?,halfDaySegment: freezed == halfDaySegment ? _self.halfDaySegment : halfDaySegment // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isMyLeave: null == isMyLeave ? _self.isMyLeave : isMyLeave // ignore: cast_nullable_to_non_nullable
as bool,isApprover: null == isApprover ? _self.isApprover : isApprover // ignore: cast_nullable_to_non_nullable
as bool,showEditDelete: null == showEditDelete ? _self.showEditDelete : showEditDelete // ignore: cast_nullable_to_non_nullable
as bool,showCancel: null == showCancel ? _self.showCancel : showCancel // ignore: cast_nullable_to_non_nullable
as bool,showApprovalActions: null == showApprovalActions ? _self.showApprovalActions : showApprovalActions // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
