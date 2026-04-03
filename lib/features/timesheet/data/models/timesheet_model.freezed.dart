// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timesheet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimesheetModel {

 String get name; String get employee;@JsonKey(name: 'employee_name') String get employeeName;@JsonKey(name: 'total_hours') double get hoursTotal;@JsonKey(name: 'start_date') String get fromDate;@JsonKey(name: 'end_date') String get toDate; int get docstatus;@JsonKey(name: 'total_billable_hours') double get totalSpentHours; String get approver;@JsonKey(name: 'leave_approver_name') String get approverName;@JsonKey(name: 'time_logs') List<ProjectAssignmentModel>? get projectAssignments;
/// Create a copy of TimesheetModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetModelCopyWith<TimesheetModel> get copyWith => _$TimesheetModelCopyWithImpl<TimesheetModel>(this as TimesheetModel, _$identity);

  /// Serializes this TimesheetModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetModel&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.hoursTotal, hoursTotal) || other.hoursTotal == hoursTotal)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.totalSpentHours, totalSpentHours) || other.totalSpentHours == totalSpentHours)&&(identical(other.approver, approver) || other.approver == approver)&&(identical(other.approverName, approverName) || other.approverName == approverName)&&const DeepCollectionEquality().equals(other.projectAssignments, projectAssignments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,hoursTotal,fromDate,toDate,docstatus,totalSpentHours,approver,approverName,const DeepCollectionEquality().hash(projectAssignments));

@override
String toString() {
  return 'TimesheetModel(name: $name, employee: $employee, employeeName: $employeeName, hoursTotal: $hoursTotal, fromDate: $fromDate, toDate: $toDate, docstatus: $docstatus, totalSpentHours: $totalSpentHours, approver: $approver, approverName: $approverName, projectAssignments: $projectAssignments)';
}


}

/// @nodoc
abstract mixin class $TimesheetModelCopyWith<$Res>  {
  factory $TimesheetModelCopyWith(TimesheetModel value, $Res Function(TimesheetModel) _then) = _$TimesheetModelCopyWithImpl;
@useResult
$Res call({
 String name, String employee,@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'total_hours') double hoursTotal,@JsonKey(name: 'start_date') String fromDate,@JsonKey(name: 'end_date') String toDate, int docstatus,@JsonKey(name: 'total_billable_hours') double totalSpentHours, String approver,@JsonKey(name: 'leave_approver_name') String approverName,@JsonKey(name: 'time_logs') List<ProjectAssignmentModel>? projectAssignments
});




}
/// @nodoc
class _$TimesheetModelCopyWithImpl<$Res>
    implements $TimesheetModelCopyWith<$Res> {
  _$TimesheetModelCopyWithImpl(this._self, this._then);

  final TimesheetModel _self;
  final $Res Function(TimesheetModel) _then;

/// Create a copy of TimesheetModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? hoursTotal = null,Object? fromDate = null,Object? toDate = null,Object? docstatus = null,Object? totalSpentHours = null,Object? approver = null,Object? approverName = null,Object? projectAssignments = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,hoursTotal: null == hoursTotal ? _self.hoursTotal : hoursTotal // ignore: cast_nullable_to_non_nullable
as double,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,docstatus: null == docstatus ? _self.docstatus : docstatus // ignore: cast_nullable_to_non_nullable
as int,totalSpentHours: null == totalSpentHours ? _self.totalSpentHours : totalSpentHours // ignore: cast_nullable_to_non_nullable
as double,approver: null == approver ? _self.approver : approver // ignore: cast_nullable_to_non_nullable
as String,approverName: null == approverName ? _self.approverName : approverName // ignore: cast_nullable_to_non_nullable
as String,projectAssignments: freezed == projectAssignments ? _self.projectAssignments : projectAssignments // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [TimesheetModel].
extension TimesheetModelPatterns on TimesheetModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimesheetModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimesheetModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimesheetModel value)  $default,){
final _that = this;
switch (_that) {
case _TimesheetModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimesheetModel value)?  $default,){
final _that = this;
switch (_that) {
case _TimesheetModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String employee, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'total_hours')  double hoursTotal, @JsonKey(name: 'start_date')  String fromDate, @JsonKey(name: 'end_date')  String toDate,  int docstatus, @JsonKey(name: 'total_billable_hours')  double totalSpentHours,  String approver, @JsonKey(name: 'leave_approver_name')  String approverName, @JsonKey(name: 'time_logs')  List<ProjectAssignmentModel>? projectAssignments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimesheetModel() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.hoursTotal,_that.fromDate,_that.toDate,_that.docstatus,_that.totalSpentHours,_that.approver,_that.approverName,_that.projectAssignments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String employee, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'total_hours')  double hoursTotal, @JsonKey(name: 'start_date')  String fromDate, @JsonKey(name: 'end_date')  String toDate,  int docstatus, @JsonKey(name: 'total_billable_hours')  double totalSpentHours,  String approver, @JsonKey(name: 'leave_approver_name')  String approverName, @JsonKey(name: 'time_logs')  List<ProjectAssignmentModel>? projectAssignments)  $default,) {final _that = this;
switch (_that) {
case _TimesheetModel():
return $default(_that.name,_that.employee,_that.employeeName,_that.hoursTotal,_that.fromDate,_that.toDate,_that.docstatus,_that.totalSpentHours,_that.approver,_that.approverName,_that.projectAssignments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String employee, @JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'total_hours')  double hoursTotal, @JsonKey(name: 'start_date')  String fromDate, @JsonKey(name: 'end_date')  String toDate,  int docstatus, @JsonKey(name: 'total_billable_hours')  double totalSpentHours,  String approver, @JsonKey(name: 'leave_approver_name')  String approverName, @JsonKey(name: 'time_logs')  List<ProjectAssignmentModel>? projectAssignments)?  $default,) {final _that = this;
switch (_that) {
case _TimesheetModel() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.hoursTotal,_that.fromDate,_that.toDate,_that.docstatus,_that.totalSpentHours,_that.approver,_that.approverName,_that.projectAssignments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimesheetModel extends TimesheetModel {
  const _TimesheetModel({required this.name, required this.employee, @JsonKey(name: 'employee_name') required this.employeeName, @JsonKey(name: 'total_hours') required this.hoursTotal, @JsonKey(name: 'start_date') required this.fromDate, @JsonKey(name: 'end_date') required this.toDate, required this.docstatus, @JsonKey(name: 'total_billable_hours') required this.totalSpentHours, required this.approver, @JsonKey(name: 'leave_approver_name') required this.approverName, @JsonKey(name: 'time_logs') final  List<ProjectAssignmentModel>? projectAssignments}): _projectAssignments = projectAssignments,super._();
  factory _TimesheetModel.fromJson(Map<String, dynamic> json) => _$TimesheetModelFromJson(json);

@override final  String name;
@override final  String employee;
@override@JsonKey(name: 'employee_name') final  String employeeName;
@override@JsonKey(name: 'total_hours') final  double hoursTotal;
@override@JsonKey(name: 'start_date') final  String fromDate;
@override@JsonKey(name: 'end_date') final  String toDate;
@override final  int docstatus;
@override@JsonKey(name: 'total_billable_hours') final  double totalSpentHours;
@override final  String approver;
@override@JsonKey(name: 'leave_approver_name') final  String approverName;
 final  List<ProjectAssignmentModel>? _projectAssignments;
@override@JsonKey(name: 'time_logs') List<ProjectAssignmentModel>? get projectAssignments {
  final value = _projectAssignments;
  if (value == null) return null;
  if (_projectAssignments is EqualUnmodifiableListView) return _projectAssignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of TimesheetModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimesheetModelCopyWith<_TimesheetModel> get copyWith => __$TimesheetModelCopyWithImpl<_TimesheetModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimesheetModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimesheetModel&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.hoursTotal, hoursTotal) || other.hoursTotal == hoursTotal)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.docstatus, docstatus) || other.docstatus == docstatus)&&(identical(other.totalSpentHours, totalSpentHours) || other.totalSpentHours == totalSpentHours)&&(identical(other.approver, approver) || other.approver == approver)&&(identical(other.approverName, approverName) || other.approverName == approverName)&&const DeepCollectionEquality().equals(other._projectAssignments, _projectAssignments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,hoursTotal,fromDate,toDate,docstatus,totalSpentHours,approver,approverName,const DeepCollectionEquality().hash(_projectAssignments));

@override
String toString() {
  return 'TimesheetModel(name: $name, employee: $employee, employeeName: $employeeName, hoursTotal: $hoursTotal, fromDate: $fromDate, toDate: $toDate, docstatus: $docstatus, totalSpentHours: $totalSpentHours, approver: $approver, approverName: $approverName, projectAssignments: $projectAssignments)';
}


}

/// @nodoc
abstract mixin class _$TimesheetModelCopyWith<$Res> implements $TimesheetModelCopyWith<$Res> {
  factory _$TimesheetModelCopyWith(_TimesheetModel value, $Res Function(_TimesheetModel) _then) = __$TimesheetModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String employee,@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'total_hours') double hoursTotal,@JsonKey(name: 'start_date') String fromDate,@JsonKey(name: 'end_date') String toDate, int docstatus,@JsonKey(name: 'total_billable_hours') double totalSpentHours, String approver,@JsonKey(name: 'leave_approver_name') String approverName,@JsonKey(name: 'time_logs') List<ProjectAssignmentModel>? projectAssignments
});




}
/// @nodoc
class __$TimesheetModelCopyWithImpl<$Res>
    implements _$TimesheetModelCopyWith<$Res> {
  __$TimesheetModelCopyWithImpl(this._self, this._then);

  final _TimesheetModel _self;
  final $Res Function(_TimesheetModel) _then;

/// Create a copy of TimesheetModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? hoursTotal = null,Object? fromDate = null,Object? toDate = null,Object? docstatus = null,Object? totalSpentHours = null,Object? approver = null,Object? approverName = null,Object? projectAssignments = freezed,}) {
  return _then(_TimesheetModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,hoursTotal: null == hoursTotal ? _self.hoursTotal : hoursTotal // ignore: cast_nullable_to_non_nullable
as double,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,docstatus: null == docstatus ? _self.docstatus : docstatus // ignore: cast_nullable_to_non_nullable
as int,totalSpentHours: null == totalSpentHours ? _self.totalSpentHours : totalSpentHours // ignore: cast_nullable_to_non_nullable
as double,approver: null == approver ? _self.approver : approver // ignore: cast_nullable_to_non_nullable
as String,approverName: null == approverName ? _self.approverName : approverName // ignore: cast_nullable_to_non_nullable
as String,projectAssignments: freezed == projectAssignments ? _self._projectAssignments : projectAssignments // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentModel>?,
  ));
}


}

// dart format on
