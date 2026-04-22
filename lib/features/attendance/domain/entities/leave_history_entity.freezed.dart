// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_history_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LeaveHistoryEntity {

 String get name; String get employee; String get employeeName; String get leaveType; String get fromDate; String get toDate; String get status; String? get leaveApprover; int get docstatus; String? get leaveApproverName; double get totalLeaveDays;
/// Create a copy of LeaveHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveHistoryEntityCopyWith<LeaveHistoryEntity> get copyWith => _$LeaveHistoryEntityCopyWithImpl<LeaveHistoryEntity>(this as LeaveHistoryEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveHistoryEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.leaveApprover, leaveApprover) || other.leaveApprover == leaveApprover)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.leaveApproverName, leaveApproverName) || other.leaveApproverName == leaveApproverName)&&(identical(other.totalLeaveDays, totalLeaveDays) || other.totalLeaveDays == totalLeaveDays));
}


@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,leaveType,fromDate,toDate,status,leaveApprover,docstatus,leaveApproverName,totalLeaveDays);

@override
String toString() {
  return 'LeaveHistoryEntity(name: $name, employee: $employee, employeeName: $employeeName, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, status: $status, leaveApprover: $leaveApprover, docstatus: $docstatus, leaveApproverName: $leaveApproverName, totalLeaveDays: $totalLeaveDays)';
}


}

/// @nodoc
abstract mixin class $LeaveHistoryEntityCopyWith<$Res>  {
  factory $LeaveHistoryEntityCopyWith(LeaveHistoryEntity value, $Res Function(LeaveHistoryEntity) _then) = _$LeaveHistoryEntityCopyWithImpl;
@useResult
$Res call({
 String name, String employee, String employeeName, String leaveType, String fromDate, String toDate, String status, String? leaveApprover, int docstatus, String? leaveApproverName, double totalLeaveDays
});




}
/// @nodoc
class _$LeaveHistoryEntityCopyWithImpl<$Res>
    implements $LeaveHistoryEntityCopyWith<$Res> {
  _$LeaveHistoryEntityCopyWithImpl(this._self, this._then);

  final LeaveHistoryEntity _self;
  final $Res Function(LeaveHistoryEntity) _then;

/// Create a copy of LeaveHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? status = null,Object? leaveApprover = freezed,Object? docstatus = null,Object? leaveApproverName = freezed,Object? totalLeaveDays = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,leaveApprover: freezed == leaveApprover ? _self.leaveApprover : leaveApprover // ignore: cast_nullable_to_non_nullable
as String?,docstatus: null == docstatus ? _self.docstatus : docstatus // ignore: cast_nullable_to_non_nullable
as int,leaveApproverName: freezed == leaveApproverName ? _self.leaveApproverName : leaveApproverName // ignore: cast_nullable_to_non_nullable
as String?,totalLeaveDays: null == totalLeaveDays ? _self.totalLeaveDays : totalLeaveDays // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveHistoryEntity].
extension LeaveHistoryEntityPatterns on LeaveHistoryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveHistoryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveHistoryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveHistoryEntity value)  $default,){
final _that = this;
switch (_that) {
case _LeaveHistoryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveHistoryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveHistoryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String employee,  String employeeName,  String leaveType,  String fromDate,  String toDate,  String status,  String? leaveApprover,  int docstatus,  String? leaveApproverName,  double totalLeaveDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveHistoryEntity() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.status,_that.leaveApprover,_that.docstatus,_that.leaveApproverName,_that.totalLeaveDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String employee,  String employeeName,  String leaveType,  String fromDate,  String toDate,  String status,  String? leaveApprover,  int docstatus,  String? leaveApproverName,  double totalLeaveDays)  $default,) {final _that = this;
switch (_that) {
case _LeaveHistoryEntity():
return $default(_that.name,_that.employee,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.status,_that.leaveApprover,_that.docstatus,_that.leaveApproverName,_that.totalLeaveDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String employee,  String employeeName,  String leaveType,  String fromDate,  String toDate,  String status,  String? leaveApprover,  int docstatus,  String? leaveApproverName,  double totalLeaveDays)?  $default,) {final _that = this;
switch (_that) {
case _LeaveHistoryEntity() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.status,_that.leaveApprover,_that.docstatus,_that.leaveApproverName,_that.totalLeaveDays);case _:
  return null;

}
}

}

/// @nodoc


class _LeaveHistoryEntity implements LeaveHistoryEntity {
  const _LeaveHistoryEntity({required this.name, required this.employee, required this.employeeName, required this.leaveType, required this.fromDate, required this.toDate, required this.status, this.leaveApprover, required this.docstatus, this.leaveApproverName, required this.totalLeaveDays});
  

@override final  String name;
@override final  String employee;
@override final  String employeeName;
@override final  String leaveType;
@override final  String fromDate;
@override final  String toDate;
@override final  String status;
@override final  String? leaveApprover;
@override final  int docstatus;
@override final  String? leaveApproverName;
@override final  double totalLeaveDays;

/// Create a copy of LeaveHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveHistoryEntityCopyWith<_LeaveHistoryEntity> get copyWith => __$LeaveHistoryEntityCopyWithImpl<_LeaveHistoryEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveHistoryEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.leaveApprover, leaveApprover) || other.leaveApprover == leaveApprover)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.leaveApproverName, leaveApproverName) || other.leaveApproverName == leaveApproverName)&&(identical(other.totalLeaveDays, totalLeaveDays) || other.totalLeaveDays == totalLeaveDays));
}


@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,leaveType,fromDate,toDate,status,leaveApprover,docstatus,leaveApproverName,totalLeaveDays);

@override
String toString() {
  return 'LeaveHistoryEntity(name: $name, employee: $employee, employeeName: $employeeName, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, status: $status, leaveApprover: $leaveApprover, docstatus: $docstatus, leaveApproverName: $leaveApproverName, totalLeaveDays: $totalLeaveDays)';
}


}

/// @nodoc
abstract mixin class _$LeaveHistoryEntityCopyWith<$Res> implements $LeaveHistoryEntityCopyWith<$Res> {
  factory _$LeaveHistoryEntityCopyWith(_LeaveHistoryEntity value, $Res Function(_LeaveHistoryEntity) _then) = __$LeaveHistoryEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String employee, String employeeName, String leaveType, String fromDate, String toDate, String status, String? leaveApprover, int docstatus, String? leaveApproverName, double totalLeaveDays
});




}
/// @nodoc
class __$LeaveHistoryEntityCopyWithImpl<$Res>
    implements _$LeaveHistoryEntityCopyWith<$Res> {
  __$LeaveHistoryEntityCopyWithImpl(this._self, this._then);

  final _LeaveHistoryEntity _self;
  final $Res Function(_LeaveHistoryEntity) _then;

/// Create a copy of LeaveHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? status = null,Object? leaveApprover = freezed,Object? docstatus = null,Object? leaveApproverName = freezed,Object? totalLeaveDays = null,}) {
  return _then(_LeaveHistoryEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,leaveApprover: freezed == leaveApprover ? _self.leaveApprover : leaveApprover // ignore: cast_nullable_to_non_nullable
as String?,docstatus: null == docstatus ? _self.docstatus : docstatus // ignore: cast_nullable_to_non_nullable
as int,leaveApproverName: freezed == leaveApproverName ? _self.leaveApproverName : leaveApproverName // ignore: cast_nullable_to_non_nullable
as String?,totalLeaveDays: null == totalLeaveDays ? _self.totalLeaveDays : totalLeaveDays // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
