// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaveModel {

 String get name; String get employee;@JsonKey(name: 'employee_name') String get employeeName;@JsonKey(name: 'leave_type') String get leaveType;@JsonKey(name: 'from_date') String get fromDate;@JsonKey(name: 'to_date') String get toDate; String get status;@JsonKey(name: 'leave_approver') String? get leaveApprover; int? get docstatus;@JsonKey(name: 'leave_approver_name') String? get leaveApproverName;@JsonKey(name: 'total_leave_days') double? get totalLeaveDays;@JsonKey(name: 'half_day', defaultValue: 0) int get halfDay;@JsonKey(name: 'half_day_date') String? get halfDayDate; String? get description;
/// Create a copy of LeaveModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveModelCopyWith<LeaveModel> get copyWith => _$LeaveModelCopyWithImpl<LeaveModel>(this as LeaveModel, _$identity);

  /// Serializes this LeaveModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveModel&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.leaveApprover, leaveApprover) || other.leaveApprover == leaveApprover)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.leaveApproverName, leaveApproverName) || other.leaveApproverName == leaveApproverName)&&(identical(other.totalLeaveDays, totalLeaveDays) || other.totalLeaveDays == totalLeaveDays)&&(identical(other.halfDay, halfDay) || other.halfDay == halfDay)&&(identical(other.halfDayDate, halfDayDate) || other.halfDayDate == halfDayDate)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,leaveType,fromDate,toDate,status,leaveApprover,docstatus,leaveApproverName,totalLeaveDays,halfDay,halfDayDate,description);

@override
String toString() {
  return 'LeaveModel(name: $name, employee: $employee, employeeName: $employeeName, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, status: $status, leaveApprover: $leaveApprover, docstatus: $docstatus, leaveApproverName: $leaveApproverName, totalLeaveDays: $totalLeaveDays, halfDay: $halfDay, halfDayDate: $halfDayDate, description: $description)';
}


}

/// @nodoc
abstract mixin class $LeaveModelCopyWith<$Res>  {
  factory $LeaveModelCopyWith(LeaveModel value, $Res Function(LeaveModel) _then) = _$LeaveModelCopyWithImpl;
@useResult
$Res call({
 String name, String employee,@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'leave_type') String leaveType,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate, String status,@JsonKey(name: 'leave_approver') String? leaveApprover, int? docstatus,@JsonKey(name: 'leave_approver_name') String? leaveApproverName,@JsonKey(name: 'total_leave_days') double? totalLeaveDays,@JsonKey(name: 'half_day', defaultValue: 0) int halfDay,@JsonKey(name: 'half_day_date') String? halfDayDate, String? description
});




}
/// @nodoc
class _$LeaveModelCopyWithImpl<$Res>
    implements $LeaveModelCopyWith<$Res> {
  _$LeaveModelCopyWithImpl(this._self, this._then);

  final LeaveModel _self;
  final $Res Function(LeaveModel) _then;

/// Create a copy of LeaveModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? status = null,Object? leaveApprover = freezed,Object? docstatus = freezed,Object? leaveApproverName = freezed,Object? totalLeaveDays = freezed,Object? halfDay = null,Object? halfDayDate = freezed,Object? description = freezed,}) {
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
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveModel].
extension LeaveModelPatterns on LeaveModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaveModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String employee, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String status, @JsonKey(name: 'leave_approver')  String? leaveApprover,  int? docstatus, @JsonKey(name: 'leave_approver_name')  String? leaveApproverName, @JsonKey(name: 'total_leave_days')  double? totalLeaveDays, @JsonKey(name: 'half_day', defaultValue: 0)  int halfDay, @JsonKey(name: 'half_day_date')  String? halfDayDate,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveModel() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.status,_that.leaveApprover,_that.docstatus,_that.leaveApproverName,_that.totalLeaveDays,_that.halfDay,_that.halfDayDate,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String employee, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String status, @JsonKey(name: 'leave_approver')  String? leaveApprover,  int? docstatus, @JsonKey(name: 'leave_approver_name')  String? leaveApproverName, @JsonKey(name: 'total_leave_days')  double? totalLeaveDays, @JsonKey(name: 'half_day', defaultValue: 0)  int halfDay, @JsonKey(name: 'half_day_date')  String? halfDayDate,  String? description)  $default,) {final _that = this;
switch (_that) {
case _LeaveModel():
return $default(_that.name,_that.employee,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.status,_that.leaveApprover,_that.docstatus,_that.leaveApproverName,_that.totalLeaveDays,_that.halfDay,_that.halfDayDate,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String employee, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String status, @JsonKey(name: 'leave_approver')  String? leaveApprover,  int? docstatus, @JsonKey(name: 'leave_approver_name')  String? leaveApproverName, @JsonKey(name: 'total_leave_days')  double? totalLeaveDays, @JsonKey(name: 'half_day', defaultValue: 0)  int halfDay, @JsonKey(name: 'half_day_date')  String? halfDayDate,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _LeaveModel() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.status,_that.leaveApprover,_that.docstatus,_that.leaveApproverName,_that.totalLeaveDays,_that.halfDay,_that.halfDayDate,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveModel extends LeaveModel {
  const _LeaveModel({required this.name, required this.employee, @JsonKey(name: 'employee_name') required this.employeeName, @JsonKey(name: 'leave_type') required this.leaveType, @JsonKey(name: 'from_date') required this.fromDate, @JsonKey(name: 'to_date') required this.toDate, required this.status, @JsonKey(name: 'leave_approver') this.leaveApprover, this.docstatus, @JsonKey(name: 'leave_approver_name') this.leaveApproverName, @JsonKey(name: 'total_leave_days') this.totalLeaveDays, @JsonKey(name: 'half_day', defaultValue: 0) this.halfDay = 0, @JsonKey(name: 'half_day_date') this.halfDayDate, this.description}): super._();
  factory _LeaveModel.fromJson(Map<String, dynamic> json) => _$LeaveModelFromJson(json);

@override final  String name;
@override final  String employee;
@override@JsonKey(name: 'employee_name') final  String employeeName;
@override@JsonKey(name: 'leave_type') final  String leaveType;
@override@JsonKey(name: 'from_date') final  String fromDate;
@override@JsonKey(name: 'to_date') final  String toDate;
@override final  String status;
@override@JsonKey(name: 'leave_approver') final  String? leaveApprover;
@override final  int? docstatus;
@override@JsonKey(name: 'leave_approver_name') final  String? leaveApproverName;
@override@JsonKey(name: 'total_leave_days') final  double? totalLeaveDays;
@override@JsonKey(name: 'half_day', defaultValue: 0) final  int halfDay;
@override@JsonKey(name: 'half_day_date') final  String? halfDayDate;
@override final  String? description;

/// Create a copy of LeaveModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveModelCopyWith<_LeaveModel> get copyWith => __$LeaveModelCopyWithImpl<_LeaveModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveModel&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.leaveApprover, leaveApprover) || other.leaveApprover == leaveApprover)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.leaveApproverName, leaveApproverName) || other.leaveApproverName == leaveApproverName)&&(identical(other.totalLeaveDays, totalLeaveDays) || other.totalLeaveDays == totalLeaveDays)&&(identical(other.halfDay, halfDay) || other.halfDay == halfDay)&&(identical(other.halfDayDate, halfDayDate) || other.halfDayDate == halfDayDate)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,leaveType,fromDate,toDate,status,leaveApprover,docstatus,leaveApproverName,totalLeaveDays,halfDay,halfDayDate,description);

@override
String toString() {
  return 'LeaveModel(name: $name, employee: $employee, employeeName: $employeeName, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, status: $status, leaveApprover: $leaveApprover, docstatus: $docstatus, leaveApproverName: $leaveApproverName, totalLeaveDays: $totalLeaveDays, halfDay: $halfDay, halfDayDate: $halfDayDate, description: $description)';
}


}

/// @nodoc
abstract mixin class _$LeaveModelCopyWith<$Res> implements $LeaveModelCopyWith<$Res> {
  factory _$LeaveModelCopyWith(_LeaveModel value, $Res Function(_LeaveModel) _then) = __$LeaveModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String employee,@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'leave_type') String leaveType,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate, String status,@JsonKey(name: 'leave_approver') String? leaveApprover, int? docstatus,@JsonKey(name: 'leave_approver_name') String? leaveApproverName,@JsonKey(name: 'total_leave_days') double? totalLeaveDays,@JsonKey(name: 'half_day', defaultValue: 0) int halfDay,@JsonKey(name: 'half_day_date') String? halfDayDate, String? description
});




}
/// @nodoc
class __$LeaveModelCopyWithImpl<$Res>
    implements _$LeaveModelCopyWith<$Res> {
  __$LeaveModelCopyWithImpl(this._self, this._then);

  final _LeaveModel _self;
  final $Res Function(_LeaveModel) _then;

/// Create a copy of LeaveModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? status = null,Object? leaveApprover = freezed,Object? docstatus = freezed,Object? leaveApproverName = freezed,Object? totalLeaveDays = freezed,Object? halfDay = null,Object? halfDayDate = freezed,Object? description = freezed,}) {
  return _then(_LeaveModel(
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
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
