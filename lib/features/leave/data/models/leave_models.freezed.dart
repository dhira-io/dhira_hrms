// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaveModel {

 String get name; String get employee;@JsonKey(name: 'employee_name') String get employeeName;@JsonKey(name: 'leave_type') String get leaveType;@JsonKey(name: 'from_date') String get fromDate;@JsonKey(name: 'to_date') String get toDate; String get status;@JsonKey(name: 'leave_approver') String? get leaveApprover; int? get docstatus;@JsonKey(name: 'leave_approver_name') String? get leaveApproverName;@JsonKey(name: 'total_leave_days') double? get totalLeaveDays;@JsonKey(name: 'half_day') int get halfDay;
/// Create a copy of LeaveModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveModelCopyWith<LeaveModel> get copyWith => _$LeaveModelCopyWithImpl<LeaveModel>(this as LeaveModel, _$identity);

  /// Serializes this LeaveModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveModel&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.leaveApprover, leaveApprover) || other.leaveApprover == leaveApprover)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.leaveApproverName, leaveApproverName) || other.leaveApproverName == leaveApproverName)&&(identical(other.totalLeaveDays, totalLeaveDays) || other.totalLeaveDays == totalLeaveDays)&&(identical(other.halfDay, halfDay) || other.halfDay == halfDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,leaveType,fromDate,toDate,status,leaveApprover,docstatus,leaveApproverName,totalLeaveDays,halfDay);

@override
String toString() {
  return 'LeaveModel(name: $name, employee: $employee, employeeName: $employeeName, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, status: $status, leaveApprover: $leaveApprover, docstatus: $docstatus, leaveApproverName: $leaveApproverName, totalLeaveDays: $totalLeaveDays, halfDay: $halfDay)';
}


}

/// @nodoc
abstract mixin class $LeaveModelCopyWith<$Res>  {
  factory $LeaveModelCopyWith(LeaveModel value, $Res Function(LeaveModel) _then) = _$LeaveModelCopyWithImpl;
@useResult
$Res call({
 String name, String employee,@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'leave_type') String leaveType,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate, String status,@JsonKey(name: 'leave_approver') String? leaveApprover, int? docstatus,@JsonKey(name: 'leave_approver_name') String? leaveApproverName,@JsonKey(name: 'total_leave_days') double? totalLeaveDays,@JsonKey(name: 'half_day') int halfDay
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
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? status = null,Object? leaveApprover = freezed,Object? docstatus = freezed,Object? leaveApproverName = freezed,Object? totalLeaveDays = freezed,Object? halfDay = null,}) {
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
as int,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String employee, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String status, @JsonKey(name: 'leave_approver')  String? leaveApprover,  int? docstatus, @JsonKey(name: 'leave_approver_name')  String? leaveApproverName, @JsonKey(name: 'total_leave_days')  double? totalLeaveDays, @JsonKey(name: 'half_day')  int halfDay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveModel() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.status,_that.leaveApprover,_that.docstatus,_that.leaveApproverName,_that.totalLeaveDays,_that.halfDay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String employee, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String status, @JsonKey(name: 'leave_approver')  String? leaveApprover,  int? docstatus, @JsonKey(name: 'leave_approver_name')  String? leaveApproverName, @JsonKey(name: 'total_leave_days')  double? totalLeaveDays, @JsonKey(name: 'half_day')  int halfDay)  $default,) {final _that = this;
switch (_that) {
case _LeaveModel():
return $default(_that.name,_that.employee,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.status,_that.leaveApprover,_that.docstatus,_that.leaveApproverName,_that.totalLeaveDays,_that.halfDay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String employee, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String status, @JsonKey(name: 'leave_approver')  String? leaveApprover,  int? docstatus, @JsonKey(name: 'leave_approver_name')  String? leaveApproverName, @JsonKey(name: 'total_leave_days')  double? totalLeaveDays, @JsonKey(name: 'half_day')  int halfDay)?  $default,) {final _that = this;
switch (_that) {
case _LeaveModel() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.status,_that.leaveApprover,_that.docstatus,_that.leaveApproverName,_that.totalLeaveDays,_that.halfDay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveModel extends LeaveModel {
  const _LeaveModel({required this.name, required this.employee, @JsonKey(name: 'employee_name') required this.employeeName, @JsonKey(name: 'leave_type') required this.leaveType, @JsonKey(name: 'from_date') required this.fromDate, @JsonKey(name: 'to_date') required this.toDate, required this.status, @JsonKey(name: 'leave_approver') this.leaveApprover, this.docstatus, @JsonKey(name: 'leave_approver_name') this.leaveApproverName, @JsonKey(name: 'total_leave_days') this.totalLeaveDays, @JsonKey(name: 'half_day') required this.halfDay}): super._();
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
@override@JsonKey(name: 'half_day') final  int halfDay;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveModel&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.leaveApprover, leaveApprover) || other.leaveApprover == leaveApprover)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.leaveApproverName, leaveApproverName) || other.leaveApproverName == leaveApproverName)&&(identical(other.totalLeaveDays, totalLeaveDays) || other.totalLeaveDays == totalLeaveDays)&&(identical(other.halfDay, halfDay) || other.halfDay == halfDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,leaveType,fromDate,toDate,status,leaveApprover,docstatus,leaveApproverName,totalLeaveDays,halfDay);

@override
String toString() {
  return 'LeaveModel(name: $name, employee: $employee, employeeName: $employeeName, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, status: $status, leaveApprover: $leaveApprover, docstatus: $docstatus, leaveApproverName: $leaveApproverName, totalLeaveDays: $totalLeaveDays, halfDay: $halfDay)';
}


}

/// @nodoc
abstract mixin class _$LeaveModelCopyWith<$Res> implements $LeaveModelCopyWith<$Res> {
  factory _$LeaveModelCopyWith(_LeaveModel value, $Res Function(_LeaveModel) _then) = __$LeaveModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String employee,@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'leave_type') String leaveType,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate, String status,@JsonKey(name: 'leave_approver') String? leaveApprover, int? docstatus,@JsonKey(name: 'leave_approver_name') String? leaveApproverName,@JsonKey(name: 'total_leave_days') double? totalLeaveDays,@JsonKey(name: 'half_day') int halfDay
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
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? status = null,Object? leaveApprover = freezed,Object? docstatus = freezed,Object? leaveApproverName = freezed,Object? totalLeaveDays = freezed,Object? halfDay = null,}) {
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
as int,
  ));
}


}


/// @nodoc
mixin _$LeaveTypeModel {

 String get name;@JsonKey(name: 'leave_type_name') String get leaveTypeName;
/// Create a copy of LeaveTypeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveTypeModelCopyWith<LeaveTypeModel> get copyWith => _$LeaveTypeModelCopyWithImpl<LeaveTypeModel>(this as LeaveTypeModel, _$identity);

  /// Serializes this LeaveTypeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveTypeModel&&(identical(other.name, name) || other.name == name)&&(identical(other.leaveTypeName, leaveTypeName) || other.leaveTypeName == leaveTypeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,leaveTypeName);

@override
String toString() {
  return 'LeaveTypeModel(name: $name, leaveTypeName: $leaveTypeName)';
}


}

/// @nodoc
abstract mixin class $LeaveTypeModelCopyWith<$Res>  {
  factory $LeaveTypeModelCopyWith(LeaveTypeModel value, $Res Function(LeaveTypeModel) _then) = _$LeaveTypeModelCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'leave_type_name') String leaveTypeName
});




}
/// @nodoc
class _$LeaveTypeModelCopyWithImpl<$Res>
    implements $LeaveTypeModelCopyWith<$Res> {
  _$LeaveTypeModelCopyWithImpl(this._self, this._then);

  final LeaveTypeModel _self;
  final $Res Function(LeaveTypeModel) _then;

/// Create a copy of LeaveTypeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? leaveTypeName = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,leaveTypeName: null == leaveTypeName ? _self.leaveTypeName : leaveTypeName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveTypeModel].
extension LeaveTypeModelPatterns on LeaveTypeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveTypeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveTypeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveTypeModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaveTypeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveTypeModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveTypeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'leave_type_name')  String leaveTypeName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveTypeModel() when $default != null:
return $default(_that.name,_that.leaveTypeName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'leave_type_name')  String leaveTypeName)  $default,) {final _that = this;
switch (_that) {
case _LeaveTypeModel():
return $default(_that.name,_that.leaveTypeName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'leave_type_name')  String leaveTypeName)?  $default,) {final _that = this;
switch (_that) {
case _LeaveTypeModel() when $default != null:
return $default(_that.name,_that.leaveTypeName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveTypeModel extends LeaveTypeModel {
  const _LeaveTypeModel({required this.name, @JsonKey(name: 'leave_type_name') required this.leaveTypeName}): super._();
  factory _LeaveTypeModel.fromJson(Map<String, dynamic> json) => _$LeaveTypeModelFromJson(json);

@override final  String name;
@override@JsonKey(name: 'leave_type_name') final  String leaveTypeName;

/// Create a copy of LeaveTypeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveTypeModelCopyWith<_LeaveTypeModel> get copyWith => __$LeaveTypeModelCopyWithImpl<_LeaveTypeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveTypeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveTypeModel&&(identical(other.name, name) || other.name == name)&&(identical(other.leaveTypeName, leaveTypeName) || other.leaveTypeName == leaveTypeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,leaveTypeName);

@override
String toString() {
  return 'LeaveTypeModel(name: $name, leaveTypeName: $leaveTypeName)';
}


}

/// @nodoc
abstract mixin class _$LeaveTypeModelCopyWith<$Res> implements $LeaveTypeModelCopyWith<$Res> {
  factory _$LeaveTypeModelCopyWith(_LeaveTypeModel value, $Res Function(_LeaveTypeModel) _then) = __$LeaveTypeModelCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'leave_type_name') String leaveTypeName
});




}
/// @nodoc
class __$LeaveTypeModelCopyWithImpl<$Res>
    implements _$LeaveTypeModelCopyWith<$Res> {
  __$LeaveTypeModelCopyWithImpl(this._self, this._then);

  final _LeaveTypeModel _self;
  final $Res Function(_LeaveTypeModel) _then;

/// Create a copy of LeaveTypeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? leaveTypeName = null,}) {
  return _then(_LeaveTypeModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,leaveTypeName: null == leaveTypeName ? _self.leaveTypeName : leaveTypeName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LeaveBalanceModel {

@JsonKey(name: 'total_leaves') int get totalAllocated;@JsonKey(name: 'leaves_taken') int get used;@JsonKey(name: 'leaves_pending_approval') int get pending;
/// Create a copy of LeaveBalanceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveBalanceModelCopyWith<LeaveBalanceModel> get copyWith => _$LeaveBalanceModelCopyWithImpl<LeaveBalanceModel>(this as LeaveBalanceModel, _$identity);

  /// Serializes this LeaveBalanceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveBalanceModel&&(identical(other.totalAllocated, totalAllocated) || other.totalAllocated == totalAllocated)&&(identical(other.used, used) || other.used == used)&&(identical(other.pending, pending) || other.pending == pending));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalAllocated,used,pending);

@override
String toString() {
  return 'LeaveBalanceModel(totalAllocated: $totalAllocated, used: $used, pending: $pending)';
}


}

/// @nodoc
abstract mixin class $LeaveBalanceModelCopyWith<$Res>  {
  factory $LeaveBalanceModelCopyWith(LeaveBalanceModel value, $Res Function(LeaveBalanceModel) _then) = _$LeaveBalanceModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_leaves') int totalAllocated,@JsonKey(name: 'leaves_taken') int used,@JsonKey(name: 'leaves_pending_approval') int pending
});




}
/// @nodoc
class _$LeaveBalanceModelCopyWithImpl<$Res>
    implements $LeaveBalanceModelCopyWith<$Res> {
  _$LeaveBalanceModelCopyWithImpl(this._self, this._then);

  final LeaveBalanceModel _self;
  final $Res Function(LeaveBalanceModel) _then;

/// Create a copy of LeaveBalanceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalAllocated = null,Object? used = null,Object? pending = null,}) {
  return _then(_self.copyWith(
totalAllocated: null == totalAllocated ? _self.totalAllocated : totalAllocated // ignore: cast_nullable_to_non_nullable
as int,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveBalanceModel].
extension LeaveBalanceModelPatterns on LeaveBalanceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveBalanceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveBalanceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveBalanceModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaveBalanceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveBalanceModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveBalanceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_leaves')  int totalAllocated, @JsonKey(name: 'leaves_taken')  int used, @JsonKey(name: 'leaves_pending_approval')  int pending)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveBalanceModel() when $default != null:
return $default(_that.totalAllocated,_that.used,_that.pending);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_leaves')  int totalAllocated, @JsonKey(name: 'leaves_taken')  int used, @JsonKey(name: 'leaves_pending_approval')  int pending)  $default,) {final _that = this;
switch (_that) {
case _LeaveBalanceModel():
return $default(_that.totalAllocated,_that.used,_that.pending);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_leaves')  int totalAllocated, @JsonKey(name: 'leaves_taken')  int used, @JsonKey(name: 'leaves_pending_approval')  int pending)?  $default,) {final _that = this;
switch (_that) {
case _LeaveBalanceModel() when $default != null:
return $default(_that.totalAllocated,_that.used,_that.pending);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveBalanceModel extends LeaveBalanceModel {
  const _LeaveBalanceModel({@JsonKey(name: 'total_leaves') required this.totalAllocated, @JsonKey(name: 'leaves_taken') required this.used, @JsonKey(name: 'leaves_pending_approval') required this.pending}): super._();
  factory _LeaveBalanceModel.fromJson(Map<String, dynamic> json) => _$LeaveBalanceModelFromJson(json);

@override@JsonKey(name: 'total_leaves') final  int totalAllocated;
@override@JsonKey(name: 'leaves_taken') final  int used;
@override@JsonKey(name: 'leaves_pending_approval') final  int pending;

/// Create a copy of LeaveBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveBalanceModelCopyWith<_LeaveBalanceModel> get copyWith => __$LeaveBalanceModelCopyWithImpl<_LeaveBalanceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveBalanceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveBalanceModel&&(identical(other.totalAllocated, totalAllocated) || other.totalAllocated == totalAllocated)&&(identical(other.used, used) || other.used == used)&&(identical(other.pending, pending) || other.pending == pending));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalAllocated,used,pending);

@override
String toString() {
  return 'LeaveBalanceModel(totalAllocated: $totalAllocated, used: $used, pending: $pending)';
}


}

/// @nodoc
abstract mixin class _$LeaveBalanceModelCopyWith<$Res> implements $LeaveBalanceModelCopyWith<$Res> {
  factory _$LeaveBalanceModelCopyWith(_LeaveBalanceModel value, $Res Function(_LeaveBalanceModel) _then) = __$LeaveBalanceModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_leaves') int totalAllocated,@JsonKey(name: 'leaves_taken') int used,@JsonKey(name: 'leaves_pending_approval') int pending
});




}
/// @nodoc
class __$LeaveBalanceModelCopyWithImpl<$Res>
    implements _$LeaveBalanceModelCopyWith<$Res> {
  __$LeaveBalanceModelCopyWithImpl(this._self, this._then);

  final _LeaveBalanceModel _self;
  final $Res Function(_LeaveBalanceModel) _then;

/// Create a copy of LeaveBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalAllocated = null,Object? used = null,Object? pending = null,}) {
  return _then(_LeaveBalanceModel(
totalAllocated: null == totalAllocated ? _self.totalAllocated : totalAllocated // ignore: cast_nullable_to_non_nullable
as int,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
