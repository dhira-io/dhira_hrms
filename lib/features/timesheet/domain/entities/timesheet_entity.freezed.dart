// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timesheet_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimesheetEntity {

 String get name; String get employee; String get employeeName; double get hoursTotal; String get fromDate; String get toDate; int get docStatus; double get expectedHoursTotal; double get remainingHours; double get totalSpentHours; String get approver; String get approverName; String? get department; List<ProjectAssignmentEntity>? get projectAssignments;
/// Create a copy of TimesheetEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesheetEntityCopyWith<TimesheetEntity> get copyWith => _$TimesheetEntityCopyWithImpl<TimesheetEntity>(this as TimesheetEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesheetEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.hoursTotal, hoursTotal) || other.hoursTotal == hoursTotal)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.docStatus, docStatus) || other.docStatus == docStatus)&&(identical(other.expectedHoursTotal, expectedHoursTotal) || other.expectedHoursTotal == expectedHoursTotal)&&(identical(other.remainingHours, remainingHours) || other.remainingHours == remainingHours)&&(identical(other.totalSpentHours, totalSpentHours) || other.totalSpentHours == totalSpentHours)&&(identical(other.approver, approver) || other.approver == approver)&&(identical(other.approverName, approverName) || other.approverName == approverName)&&(identical(other.department, department) || other.department == department)&&const DeepCollectionEquality().equals(other.projectAssignments, projectAssignments));
}


@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,hoursTotal,fromDate,toDate,docStatus,expectedHoursTotal,remainingHours,totalSpentHours,approver,approverName,department,const DeepCollectionEquality().hash(projectAssignments));

@override
String toString() {
  return 'TimesheetEntity(name: $name, employee: $employee, employeeName: $employeeName, hoursTotal: $hoursTotal, fromDate: $fromDate, toDate: $toDate, docStatus: $docStatus, expectedHoursTotal: $expectedHoursTotal, remainingHours: $remainingHours, totalSpentHours: $totalSpentHours, approver: $approver, approverName: $approverName, department: $department, projectAssignments: $projectAssignments)';
}


}

/// @nodoc
abstract mixin class $TimesheetEntityCopyWith<$Res>  {
  factory $TimesheetEntityCopyWith(TimesheetEntity value, $Res Function(TimesheetEntity) _then) = _$TimesheetEntityCopyWithImpl;
@useResult
$Res call({
 String name, String employee, String employeeName, double hoursTotal, String fromDate, String toDate, int docStatus, double expectedHoursTotal, double remainingHours, double totalSpentHours, String approver, String approverName, String? department, List<ProjectAssignmentEntity>? projectAssignments
});




}
/// @nodoc
class _$TimesheetEntityCopyWithImpl<$Res>
    implements $TimesheetEntityCopyWith<$Res> {
  _$TimesheetEntityCopyWithImpl(this._self, this._then);

  final TimesheetEntity _self;
  final $Res Function(TimesheetEntity) _then;

/// Create a copy of TimesheetEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? hoursTotal = null,Object? fromDate = null,Object? toDate = null,Object? docStatus = null,Object? expectedHoursTotal = null,Object? remainingHours = null,Object? totalSpentHours = null,Object? approver = null,Object? approverName = null,Object? department = freezed,Object? projectAssignments = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,hoursTotal: null == hoursTotal ? _self.hoursTotal : hoursTotal // ignore: cast_nullable_to_non_nullable
as double,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,docStatus: null == docStatus ? _self.docStatus : docStatus // ignore: cast_nullable_to_non_nullable
as int,expectedHoursTotal: null == expectedHoursTotal ? _self.expectedHoursTotal : expectedHoursTotal // ignore: cast_nullable_to_non_nullable
as double,remainingHours: null == remainingHours ? _self.remainingHours : remainingHours // ignore: cast_nullable_to_non_nullable
as double,totalSpentHours: null == totalSpentHours ? _self.totalSpentHours : totalSpentHours // ignore: cast_nullable_to_non_nullable
as double,approver: null == approver ? _self.approver : approver // ignore: cast_nullable_to_non_nullable
as String,approverName: null == approverName ? _self.approverName : approverName // ignore: cast_nullable_to_non_nullable
as String,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,projectAssignments: freezed == projectAssignments ? _self.projectAssignments : projectAssignments // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>?,
  ));
}

}


/// Adds pattern-matching-related methods to [TimesheetEntity].
extension TimesheetEntityPatterns on TimesheetEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimesheetEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimesheetEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimesheetEntity value)  $default,){
final _that = this;
switch (_that) {
case _TimesheetEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimesheetEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TimesheetEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String employee,  String employeeName,  double hoursTotal,  String fromDate,  String toDate,  int docStatus,  double expectedHoursTotal,  double remainingHours,  double totalSpentHours,  String approver,  String approverName,  String? department,  List<ProjectAssignmentEntity>? projectAssignments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimesheetEntity() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.hoursTotal,_that.fromDate,_that.toDate,_that.docStatus,_that.expectedHoursTotal,_that.remainingHours,_that.totalSpentHours,_that.approver,_that.approverName,_that.department,_that.projectAssignments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String employee,  String employeeName,  double hoursTotal,  String fromDate,  String toDate,  int docStatus,  double expectedHoursTotal,  double remainingHours,  double totalSpentHours,  String approver,  String approverName,  String? department,  List<ProjectAssignmentEntity>? projectAssignments)  $default,) {final _that = this;
switch (_that) {
case _TimesheetEntity():
return $default(_that.name,_that.employee,_that.employeeName,_that.hoursTotal,_that.fromDate,_that.toDate,_that.docStatus,_that.expectedHoursTotal,_that.remainingHours,_that.totalSpentHours,_that.approver,_that.approverName,_that.department,_that.projectAssignments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String employee,  String employeeName,  double hoursTotal,  String fromDate,  String toDate,  int docStatus,  double expectedHoursTotal,  double remainingHours,  double totalSpentHours,  String approver,  String approverName,  String? department,  List<ProjectAssignmentEntity>? projectAssignments)?  $default,) {final _that = this;
switch (_that) {
case _TimesheetEntity() when $default != null:
return $default(_that.name,_that.employee,_that.employeeName,_that.hoursTotal,_that.fromDate,_that.toDate,_that.docStatus,_that.expectedHoursTotal,_that.remainingHours,_that.totalSpentHours,_that.approver,_that.approverName,_that.department,_that.projectAssignments);case _:
  return null;

}
}

}

/// @nodoc


class _TimesheetEntity extends TimesheetEntity {
  const _TimesheetEntity({required this.name, required this.employee, required this.employeeName, required this.hoursTotal, required this.fromDate, required this.toDate, required this.docStatus, required this.expectedHoursTotal, required this.remainingHours, required this.totalSpentHours, required this.approver, required this.approverName, required this.department, final  List<ProjectAssignmentEntity>? projectAssignments}): _projectAssignments = projectAssignments,super._();
  

@override final  String name;
@override final  String employee;
@override final  String employeeName;
@override final  double hoursTotal;
@override final  String fromDate;
@override final  String toDate;
@override final  int docStatus;
@override final  double expectedHoursTotal;
@override final  double remainingHours;
@override final  double totalSpentHours;
@override final  String approver;
@override final  String approverName;
@override final  String? department;
 final  List<ProjectAssignmentEntity>? _projectAssignments;
@override List<ProjectAssignmentEntity>? get projectAssignments {
  final value = _projectAssignments;
  if (value == null) return null;
  if (_projectAssignments is EqualUnmodifiableListView) return _projectAssignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of TimesheetEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimesheetEntityCopyWith<_TimesheetEntity> get copyWith => __$TimesheetEntityCopyWithImpl<_TimesheetEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimesheetEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.hoursTotal, hoursTotal) || other.hoursTotal == hoursTotal)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.docStatus, docStatus) || other.docStatus == docStatus)&&(identical(other.expectedHoursTotal, expectedHoursTotal) || other.expectedHoursTotal == expectedHoursTotal)&&(identical(other.remainingHours, remainingHours) || other.remainingHours == remainingHours)&&(identical(other.totalSpentHours, totalSpentHours) || other.totalSpentHours == totalSpentHours)&&(identical(other.approver, approver) || other.approver == approver)&&(identical(other.approverName, approverName) || other.approverName == approverName)&&(identical(other.department, department) || other.department == department)&&const DeepCollectionEquality().equals(other._projectAssignments, _projectAssignments));
}


@override
int get hashCode => Object.hash(runtimeType,name,employee,employeeName,hoursTotal,fromDate,toDate,docStatus,expectedHoursTotal,remainingHours,totalSpentHours,approver,approverName,department,const DeepCollectionEquality().hash(_projectAssignments));

@override
String toString() {
  return 'TimesheetEntity(name: $name, employee: $employee, employeeName: $employeeName, hoursTotal: $hoursTotal, fromDate: $fromDate, toDate: $toDate, docStatus: $docStatus, expectedHoursTotal: $expectedHoursTotal, remainingHours: $remainingHours, totalSpentHours: $totalSpentHours, approver: $approver, approverName: $approverName, department: $department, projectAssignments: $projectAssignments)';
}


}

/// @nodoc
abstract mixin class _$TimesheetEntityCopyWith<$Res> implements $TimesheetEntityCopyWith<$Res> {
  factory _$TimesheetEntityCopyWith(_TimesheetEntity value, $Res Function(_TimesheetEntity) _then) = __$TimesheetEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String employee, String employeeName, double hoursTotal, String fromDate, String toDate, int docStatus, double expectedHoursTotal, double remainingHours, double totalSpentHours, String approver, String approverName, String? department, List<ProjectAssignmentEntity>? projectAssignments
});




}
/// @nodoc
class __$TimesheetEntityCopyWithImpl<$Res>
    implements _$TimesheetEntityCopyWith<$Res> {
  __$TimesheetEntityCopyWithImpl(this._self, this._then);

  final _TimesheetEntity _self;
  final $Res Function(_TimesheetEntity) _then;

/// Create a copy of TimesheetEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? employee = null,Object? employeeName = null,Object? hoursTotal = null,Object? fromDate = null,Object? toDate = null,Object? docStatus = null,Object? expectedHoursTotal = null,Object? remainingHours = null,Object? totalSpentHours = null,Object? approver = null,Object? approverName = null,Object? department = freezed,Object? projectAssignments = freezed,}) {
  return _then(_TimesheetEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,hoursTotal: null == hoursTotal ? _self.hoursTotal : hoursTotal // ignore: cast_nullable_to_non_nullable
as double,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,docStatus: null == docStatus ? _self.docStatus : docStatus // ignore: cast_nullable_to_non_nullable
as int,expectedHoursTotal: null == expectedHoursTotal ? _self.expectedHoursTotal : expectedHoursTotal // ignore: cast_nullable_to_non_nullable
as double,remainingHours: null == remainingHours ? _self.remainingHours : remainingHours // ignore: cast_nullable_to_non_nullable
as double,totalSpentHours: null == totalSpentHours ? _self.totalSpentHours : totalSpentHours // ignore: cast_nullable_to_non_nullable
as double,approver: null == approver ? _self.approver : approver // ignore: cast_nullable_to_non_nullable
as String,approverName: null == approverName ? _self.approverName : approverName // ignore: cast_nullable_to_non_nullable
as String,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,projectAssignments: freezed == projectAssignments ? _self._projectAssignments : projectAssignments // ignore: cast_nullable_to_non_nullable
as List<ProjectAssignmentEntity>?,
  ));
}


}

// dart format on
