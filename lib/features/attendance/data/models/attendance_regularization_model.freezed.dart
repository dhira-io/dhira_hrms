// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_regularization_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceRegularizationModel {

@JsonKey(name: 'docstatus') int get docStatus;@JsonKey(name: 'doctype') String get docType;@JsonKey(name: 'attendance_date') String get attendanceDate;@JsonKey(name: 'employee') String get employee;@JsonKey(name: 'manual_in_time') String get manualInTime;@JsonKey(name: 'manual_out_time') String get manualOutTime;@JsonKey(name: 'reason_category') String get reasonCategory;@JsonKey(name: 'employee_remarks') String get employeeRemarks;@JsonKey(name: 'routed_to_hr') int get routedToHr;@JsonKey(name: 'supporting_document') String? get supportingDocument;
/// Create a copy of AttendanceRegularizationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceRegularizationModelCopyWith<AttendanceRegularizationModel> get copyWith => _$AttendanceRegularizationModelCopyWithImpl<AttendanceRegularizationModel>(this as AttendanceRegularizationModel, _$identity);

  /// Serializes this AttendanceRegularizationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceRegularizationModel&&(identical(other.docStatus, docStatus) || other.docStatus == docStatus)&&(identical(other.docType, docType) || other.docType == docType)&&(identical(other.attendanceDate, attendanceDate) || other.attendanceDate == attendanceDate)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.manualInTime, manualInTime) || other.manualInTime == manualInTime)&&(identical(other.manualOutTime, manualOutTime) || other.manualOutTime == manualOutTime)&&(identical(other.reasonCategory, reasonCategory) || other.reasonCategory == reasonCategory)&&(identical(other.employeeRemarks, employeeRemarks) || other.employeeRemarks == employeeRemarks)&&(identical(other.routedToHr, routedToHr) || other.routedToHr == routedToHr)&&(identical(other.supportingDocument, supportingDocument) || other.supportingDocument == supportingDocument));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,docStatus,docType,attendanceDate,employee,manualInTime,manualOutTime,reasonCategory,employeeRemarks,routedToHr,supportingDocument);

@override
String toString() {
  return 'AttendanceRegularizationModel(docStatus: $docStatus, docType: $docType, attendanceDate: $attendanceDate, employee: $employee, manualInTime: $manualInTime, manualOutTime: $manualOutTime, reasonCategory: $reasonCategory, employeeRemarks: $employeeRemarks, routedToHr: $routedToHr, supportingDocument: $supportingDocument)';
}


}

/// @nodoc
abstract mixin class $AttendanceRegularizationModelCopyWith<$Res>  {
  factory $AttendanceRegularizationModelCopyWith(AttendanceRegularizationModel value, $Res Function(AttendanceRegularizationModel) _then) = _$AttendanceRegularizationModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'docstatus') int docStatus,@JsonKey(name: 'doctype') String docType,@JsonKey(name: 'attendance_date') String attendanceDate,@JsonKey(name: 'employee') String employee,@JsonKey(name: 'manual_in_time') String manualInTime,@JsonKey(name: 'manual_out_time') String manualOutTime,@JsonKey(name: 'reason_category') String reasonCategory,@JsonKey(name: 'employee_remarks') String employeeRemarks,@JsonKey(name: 'routed_to_hr') int routedToHr,@JsonKey(name: 'supporting_document') String? supportingDocument
});




}
/// @nodoc
class _$AttendanceRegularizationModelCopyWithImpl<$Res>
    implements $AttendanceRegularizationModelCopyWith<$Res> {
  _$AttendanceRegularizationModelCopyWithImpl(this._self, this._then);

  final AttendanceRegularizationModel _self;
  final $Res Function(AttendanceRegularizationModel) _then;

/// Create a copy of AttendanceRegularizationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? docStatus = null,Object? docType = null,Object? attendanceDate = null,Object? employee = null,Object? manualInTime = null,Object? manualOutTime = null,Object? reasonCategory = null,Object? employeeRemarks = null,Object? routedToHr = null,Object? supportingDocument = freezed,}) {
  return _then(_self.copyWith(
docStatus: null == docStatus ? _self.docStatus : docStatus // ignore: cast_nullable_to_non_nullable
as int,docType: null == docType ? _self.docType : docType // ignore: cast_nullable_to_non_nullable
as String,attendanceDate: null == attendanceDate ? _self.attendanceDate : attendanceDate // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,manualInTime: null == manualInTime ? _self.manualInTime : manualInTime // ignore: cast_nullable_to_non_nullable
as String,manualOutTime: null == manualOutTime ? _self.manualOutTime : manualOutTime // ignore: cast_nullable_to_non_nullable
as String,reasonCategory: null == reasonCategory ? _self.reasonCategory : reasonCategory // ignore: cast_nullable_to_non_nullable
as String,employeeRemarks: null == employeeRemarks ? _self.employeeRemarks : employeeRemarks // ignore: cast_nullable_to_non_nullable
as String,routedToHr: null == routedToHr ? _self.routedToHr : routedToHr // ignore: cast_nullable_to_non_nullable
as int,supportingDocument: freezed == supportingDocument ? _self.supportingDocument : supportingDocument // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceRegularizationModel].
extension AttendanceRegularizationModelPatterns on AttendanceRegularizationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceRegularizationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceRegularizationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceRegularizationModel value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceRegularizationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceRegularizationModel value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceRegularizationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'docstatus')  int docStatus, @JsonKey(name: 'doctype')  String docType, @JsonKey(name: 'attendance_date')  String attendanceDate, @JsonKey(name: 'employee')  String employee, @JsonKey(name: 'manual_in_time')  String manualInTime, @JsonKey(name: 'manual_out_time')  String manualOutTime, @JsonKey(name: 'reason_category')  String reasonCategory, @JsonKey(name: 'employee_remarks')  String employeeRemarks, @JsonKey(name: 'routed_to_hr')  int routedToHr, @JsonKey(name: 'supporting_document')  String? supportingDocument)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceRegularizationModel() when $default != null:
return $default(_that.docStatus,_that.docType,_that.attendanceDate,_that.employee,_that.manualInTime,_that.manualOutTime,_that.reasonCategory,_that.employeeRemarks,_that.routedToHr,_that.supportingDocument);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'docstatus')  int docStatus, @JsonKey(name: 'doctype')  String docType, @JsonKey(name: 'attendance_date')  String attendanceDate, @JsonKey(name: 'employee')  String employee, @JsonKey(name: 'manual_in_time')  String manualInTime, @JsonKey(name: 'manual_out_time')  String manualOutTime, @JsonKey(name: 'reason_category')  String reasonCategory, @JsonKey(name: 'employee_remarks')  String employeeRemarks, @JsonKey(name: 'routed_to_hr')  int routedToHr, @JsonKey(name: 'supporting_document')  String? supportingDocument)  $default,) {final _that = this;
switch (_that) {
case _AttendanceRegularizationModel():
return $default(_that.docStatus,_that.docType,_that.attendanceDate,_that.employee,_that.manualInTime,_that.manualOutTime,_that.reasonCategory,_that.employeeRemarks,_that.routedToHr,_that.supportingDocument);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'docstatus')  int docStatus, @JsonKey(name: 'doctype')  String docType, @JsonKey(name: 'attendance_date')  String attendanceDate, @JsonKey(name: 'employee')  String employee, @JsonKey(name: 'manual_in_time')  String manualInTime, @JsonKey(name: 'manual_out_time')  String manualOutTime, @JsonKey(name: 'reason_category')  String reasonCategory, @JsonKey(name: 'employee_remarks')  String employeeRemarks, @JsonKey(name: 'routed_to_hr')  int routedToHr, @JsonKey(name: 'supporting_document')  String? supportingDocument)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceRegularizationModel() when $default != null:
return $default(_that.docStatus,_that.docType,_that.attendanceDate,_that.employee,_that.manualInTime,_that.manualOutTime,_that.reasonCategory,_that.employeeRemarks,_that.routedToHr,_that.supportingDocument);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceRegularizationModel extends AttendanceRegularizationModel {
  const _AttendanceRegularizationModel({@JsonKey(name: 'docstatus') this.docStatus = AppConstants.docStatusDraft, @JsonKey(name: 'doctype') this.docType = 'Attendance Regularization Request', @JsonKey(name: 'attendance_date') required this.attendanceDate, @JsonKey(name: 'employee') required this.employee, @JsonKey(name: 'manual_in_time') required this.manualInTime, @JsonKey(name: 'manual_out_time') required this.manualOutTime, @JsonKey(name: 'reason_category') required this.reasonCategory, @JsonKey(name: 'employee_remarks') required this.employeeRemarks, @JsonKey(name: 'routed_to_hr') required this.routedToHr, @JsonKey(name: 'supporting_document') this.supportingDocument}): super._();
  factory _AttendanceRegularizationModel.fromJson(Map<String, dynamic> json) => _$AttendanceRegularizationModelFromJson(json);

@override@JsonKey(name: 'docstatus') final  int docStatus;
@override@JsonKey(name: 'doctype') final  String docType;
@override@JsonKey(name: 'attendance_date') final  String attendanceDate;
@override@JsonKey(name: 'employee') final  String employee;
@override@JsonKey(name: 'manual_in_time') final  String manualInTime;
@override@JsonKey(name: 'manual_out_time') final  String manualOutTime;
@override@JsonKey(name: 'reason_category') final  String reasonCategory;
@override@JsonKey(name: 'employee_remarks') final  String employeeRemarks;
@override@JsonKey(name: 'routed_to_hr') final  int routedToHr;
@override@JsonKey(name: 'supporting_document') final  String? supportingDocument;

/// Create a copy of AttendanceRegularizationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceRegularizationModelCopyWith<_AttendanceRegularizationModel> get copyWith => __$AttendanceRegularizationModelCopyWithImpl<_AttendanceRegularizationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceRegularizationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceRegularizationModel&&(identical(other.docStatus, docStatus) || other.docStatus == docStatus)&&(identical(other.docType, docType) || other.docType == docType)&&(identical(other.attendanceDate, attendanceDate) || other.attendanceDate == attendanceDate)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.manualInTime, manualInTime) || other.manualInTime == manualInTime)&&(identical(other.manualOutTime, manualOutTime) || other.manualOutTime == manualOutTime)&&(identical(other.reasonCategory, reasonCategory) || other.reasonCategory == reasonCategory)&&(identical(other.employeeRemarks, employeeRemarks) || other.employeeRemarks == employeeRemarks)&&(identical(other.routedToHr, routedToHr) || other.routedToHr == routedToHr)&&(identical(other.supportingDocument, supportingDocument) || other.supportingDocument == supportingDocument));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,docStatus,docType,attendanceDate,employee,manualInTime,manualOutTime,reasonCategory,employeeRemarks,routedToHr,supportingDocument);

@override
String toString() {
  return 'AttendanceRegularizationModel(docStatus: $docStatus, docType: $docType, attendanceDate: $attendanceDate, employee: $employee, manualInTime: $manualInTime, manualOutTime: $manualOutTime, reasonCategory: $reasonCategory, employeeRemarks: $employeeRemarks, routedToHr: $routedToHr, supportingDocument: $supportingDocument)';
}


}

/// @nodoc
abstract mixin class _$AttendanceRegularizationModelCopyWith<$Res> implements $AttendanceRegularizationModelCopyWith<$Res> {
  factory _$AttendanceRegularizationModelCopyWith(_AttendanceRegularizationModel value, $Res Function(_AttendanceRegularizationModel) _then) = __$AttendanceRegularizationModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'docstatus') int docStatus,@JsonKey(name: 'doctype') String docType,@JsonKey(name: 'attendance_date') String attendanceDate,@JsonKey(name: 'employee') String employee,@JsonKey(name: 'manual_in_time') String manualInTime,@JsonKey(name: 'manual_out_time') String manualOutTime,@JsonKey(name: 'reason_category') String reasonCategory,@JsonKey(name: 'employee_remarks') String employeeRemarks,@JsonKey(name: 'routed_to_hr') int routedToHr,@JsonKey(name: 'supporting_document') String? supportingDocument
});




}
/// @nodoc
class __$AttendanceRegularizationModelCopyWithImpl<$Res>
    implements _$AttendanceRegularizationModelCopyWith<$Res> {
  __$AttendanceRegularizationModelCopyWithImpl(this._self, this._then);

  final _AttendanceRegularizationModel _self;
  final $Res Function(_AttendanceRegularizationModel) _then;

/// Create a copy of AttendanceRegularizationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? docStatus = null,Object? docType = null,Object? attendanceDate = null,Object? employee = null,Object? manualInTime = null,Object? manualOutTime = null,Object? reasonCategory = null,Object? employeeRemarks = null,Object? routedToHr = null,Object? supportingDocument = freezed,}) {
  return _then(_AttendanceRegularizationModel(
docStatus: null == docStatus ? _self.docStatus : docStatus // ignore: cast_nullable_to_non_nullable
as int,docType: null == docType ? _self.docType : docType // ignore: cast_nullable_to_non_nullable
as String,attendanceDate: null == attendanceDate ? _self.attendanceDate : attendanceDate // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,manualInTime: null == manualInTime ? _self.manualInTime : manualInTime // ignore: cast_nullable_to_non_nullable
as String,manualOutTime: null == manualOutTime ? _self.manualOutTime : manualOutTime // ignore: cast_nullable_to_non_nullable
as String,reasonCategory: null == reasonCategory ? _self.reasonCategory : reasonCategory // ignore: cast_nullable_to_non_nullable
as String,employeeRemarks: null == employeeRemarks ? _self.employeeRemarks : employeeRemarks // ignore: cast_nullable_to_non_nullable
as String,routedToHr: null == routedToHr ? _self.routedToHr : routedToHr // ignore: cast_nullable_to_non_nullable
as int,supportingDocument: freezed == supportingDocument ? _self.supportingDocument : supportingDocument // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
