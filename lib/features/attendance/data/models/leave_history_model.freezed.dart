// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaveHistoryModel {

 String get name; String get employee;@JsonKey(name: 'employee_name') String get employeeName;@JsonKey(name: 'leave_type') String get leaveType;@JsonKey(name: 'from_date') String get fromDate;@JsonKey(name: 'to_date') String get toDate; String get status;@JsonKey(name: 'leave_approver') String? get leaveApprover; int get docstatus;@JsonKey(name: 'leave_approver_name') String? get leaveApproverName;@JsonKey(name: 'total_leave_days') double get totalLeaveDays;
/// Create a copy of LeaveHistoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveHistoryModelCopyWith<LeaveHistoryModel> get copyWith => _$LeaveHistoryModelCopyWithImpl<LeaveHistoryModel>(this as LeaveHistoryModel, _$identity);

  /// Serializes this LeaveHistoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveHistoryModel&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.leaveApprover, leaveApprover) || other.leaveApprover == leaveApprover)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.leaveApproverName, leaveApproverName) || other.leaveApproverName == leaveApproverName)&&(identical(other.totalLeaveDays, totalLeaveDays) || other.totalLeaveDays == totalLeaveDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,leaveType,fromDate,toDate,status,leaveApprover,docstatus,leaveApproverName,totalLeaveDays);

@override
String toString() {
  return 'LeaveHistoryModel(name: $name, employee: $employee, employeeName: $employeeName, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, status: $status, leaveApprover: $leaveApprover, docstatus: $docstatus, leaveApproverName: $leaveApproverName, totalLeaveDays: $totalLeaveDays)';
}


}

/// @nodoc
abstract mixin class $LeaveHistoryModelCopyWith<$Res>  {
  factory $LeaveHistoryModelCopyWith(LeaveHistoryModel value, $Res Function(LeaveHistoryModel) _then) = _$LeaveHistoryModelCopyWithImpl;
@useResult
$Res call({
 String name, String employee,@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'leave_type') String leaveType,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate, String status,@JsonKey(name: 'leave_approver') String? leaveApprover, int docstatus,@JsonKey(name: 'leave_approver_name') String? leaveApproverName,@JsonKey(name: 'total_leave_days') double totalLeaveDays
});




}
/// @nodoc
class _$LeaveHistoryModelCopyWithImpl<$Res>
    implements $LeaveHistoryModelCopyWith<$Res> {
  _$LeaveHistoryModelCopyWithImpl(this._self, this._then);

  final LeaveHistoryModel _self;
  final $Res Function(LeaveHistoryModel) _then;

/// Create a copy of LeaveHistoryModel
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


/// Adds pattern-matching-related methods to [LeaveHistoryModel].
extension LeaveHistoryModelPatterns on LeaveHistoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveHistoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveHistoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveHistoryModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaveHistoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveHistoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveHistoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String employee, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String status, @JsonKey(name: 'leave_approver')  String? leaveApprover,  int docstatus, @JsonKey(name: 'leave_approver_name')  String? leaveApproverName, @JsonKey(name: 'total_leave_days')  double totalLeaveDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveHistoryModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String employee, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String status, @JsonKey(name: 'leave_approver')  String? leaveApprover,  int docstatus, @JsonKey(name: 'leave_approver_name')  String? leaveApproverName, @JsonKey(name: 'total_leave_days')  double totalLeaveDays)  $default,) {final _that = this;
switch (_that) {
case _LeaveHistoryModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String employee, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String status, @JsonKey(name: 'leave_approver')  String? leaveApprover,  int docstatus, @JsonKey(name: 'leave_approver_name')  String? leaveApproverName, @JsonKey(name: 'total_leave_days')  double totalLeaveDays)?  $default,) {final _that = this;
switch (_that) {
case _LeaveHistoryModel() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.status,_that.leaveApprover,_that.docstatus,_that.leaveApproverName,_that.totalLeaveDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveHistoryModel extends LeaveHistoryModel {
  const _LeaveHistoryModel({required this.name, required this.employee, @JsonKey(name: 'employee_name') required this.employeeName, @JsonKey(name: 'leave_type') required this.leaveType, @JsonKey(name: 'from_date') required this.fromDate, @JsonKey(name: 'to_date') required this.toDate, required this.status, @JsonKey(name: 'leave_approver') this.leaveApprover, required this.docstatus, @JsonKey(name: 'leave_approver_name') this.leaveApproverName, @JsonKey(name: 'total_leave_days') required this.totalLeaveDays}): super._();
  factory _LeaveHistoryModel.fromJson(Map<String, dynamic> json) => _$LeaveHistoryModelFromJson(json);

@override final  String name;
@override final  String employee;
@override@JsonKey(name: 'employee_name') final  String employeeName;
@override@JsonKey(name: 'leave_type') final  String leaveType;
@override@JsonKey(name: 'from_date') final  String fromDate;
@override@JsonKey(name: 'to_date') final  String toDate;
@override final  String status;
@override@JsonKey(name: 'leave_approver') final  String? leaveApprover;
@override final  int docstatus;
@override@JsonKey(name: 'leave_approver_name') final  String? leaveApproverName;
@override@JsonKey(name: 'total_leave_days') final  double totalLeaveDays;

/// Create a copy of LeaveHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveHistoryModelCopyWith<_LeaveHistoryModel> get copyWith => __$LeaveHistoryModelCopyWithImpl<_LeaveHistoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveHistoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveHistoryModel&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.leaveApprover, leaveApprover) || other.leaveApprover == leaveApprover)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.leaveApproverName, leaveApproverName) || other.leaveApproverName == leaveApproverName)&&(identical(other.totalLeaveDays, totalLeaveDays) || other.totalLeaveDays == totalLeaveDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,leaveType,fromDate,toDate,status,leaveApprover,docstatus,leaveApproverName,totalLeaveDays);

@override
String toString() {
  return 'LeaveHistoryModel(name: $name, employee: $employee, employeeName: $employeeName, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, status: $status, leaveApprover: $leaveApprover, docstatus: $docstatus, leaveApproverName: $leaveApproverName, totalLeaveDays: $totalLeaveDays)';
}


}

/// @nodoc
abstract mixin class _$LeaveHistoryModelCopyWith<$Res> implements $LeaveHistoryModelCopyWith<$Res> {
  factory _$LeaveHistoryModelCopyWith(_LeaveHistoryModel value, $Res Function(_LeaveHistoryModel) _then) = __$LeaveHistoryModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String employee,@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'leave_type') String leaveType,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate, String status,@JsonKey(name: 'leave_approver') String? leaveApprover, int docstatus,@JsonKey(name: 'leave_approver_name') String? leaveApproverName,@JsonKey(name: 'total_leave_days') double totalLeaveDays
});




}
/// @nodoc
class __$LeaveHistoryModelCopyWithImpl<$Res>
    implements _$LeaveHistoryModelCopyWith<$Res> {
  __$LeaveHistoryModelCopyWithImpl(this._self, this._then);

  final _LeaveHistoryModel _self;
  final $Res Function(_LeaveHistoryModel) _then;

/// Create a copy of LeaveHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? status = null,Object? leaveApprover = freezed,Object? docstatus = null,Object? leaveApproverName = freezed,Object? totalLeaveDays = null,}) {
  return _then(_LeaveHistoryModel(
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
