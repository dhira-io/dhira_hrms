// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'overlap_leave_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OverlapLeaveEntity {

 String get id; String get employeeId; String get employeeName; String get designation; String? get image; String? get department; List<String>? get sharedProjects; String get leaveType; String get fromDate; String get toDate; double get days; String get status; String? get description;
/// Create a copy of OverlapLeaveEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OverlapLeaveEntityCopyWith<OverlapLeaveEntity> get copyWith => _$OverlapLeaveEntityCopyWithImpl<OverlapLeaveEntity>(this as OverlapLeaveEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OverlapLeaveEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.image, image) || other.image == image)&&(identical(other.department, department) || other.department == department)&&const DeepCollectionEquality().equals(other.sharedProjects, sharedProjects)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.days, days) || other.days == days)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,employeeId,employeeName,designation,image,department,const DeepCollectionEquality().hash(sharedProjects),leaveType,fromDate,toDate,days,status,description);

@override
String toString() {
  return 'OverlapLeaveEntity(id: $id, employeeId: $employeeId, employeeName: $employeeName, designation: $designation, image: $image, department: $department, sharedProjects: $sharedProjects, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, days: $days, status: $status, description: $description)';
}


}

/// @nodoc
abstract mixin class $OverlapLeaveEntityCopyWith<$Res>  {
  factory $OverlapLeaveEntityCopyWith(OverlapLeaveEntity value, $Res Function(OverlapLeaveEntity) _then) = _$OverlapLeaveEntityCopyWithImpl;
@useResult
$Res call({
 String id, String employeeId, String employeeName, String designation, String? image, String? department, List<String>? sharedProjects, String leaveType, String fromDate, String toDate, double days, String status, String? description
});




}
/// @nodoc
class _$OverlapLeaveEntityCopyWithImpl<$Res>
    implements $OverlapLeaveEntityCopyWith<$Res> {
  _$OverlapLeaveEntityCopyWithImpl(this._self, this._then);

  final OverlapLeaveEntity _self;
  final $Res Function(OverlapLeaveEntity) _then;

/// Create a copy of OverlapLeaveEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? employeeId = null,Object? employeeName = null,Object? designation = null,Object? image = freezed,Object? department = freezed,Object? sharedProjects = freezed,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? days = null,Object? status = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,designation: null == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,sharedProjects: freezed == sharedProjects ? _self.sharedProjects : sharedProjects // ignore: cast_nullable_to_non_nullable
as List<String>?,leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OverlapLeaveEntity].
extension OverlapLeaveEntityPatterns on OverlapLeaveEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OverlapLeaveEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OverlapLeaveEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OverlapLeaveEntity value)  $default,){
final _that = this;
switch (_that) {
case _OverlapLeaveEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OverlapLeaveEntity value)?  $default,){
final _that = this;
switch (_that) {
case _OverlapLeaveEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String employeeId,  String employeeName,  String designation,  String? image,  String? department,  List<String>? sharedProjects,  String leaveType,  String fromDate,  String toDate,  double days,  String status,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OverlapLeaveEntity() when $default != null:
return $default(_that.id,_that.employeeId,_that.employeeName,_that.designation,_that.image,_that.department,_that.sharedProjects,_that.leaveType,_that.fromDate,_that.toDate,_that.days,_that.status,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String employeeId,  String employeeName,  String designation,  String? image,  String? department,  List<String>? sharedProjects,  String leaveType,  String fromDate,  String toDate,  double days,  String status,  String? description)  $default,) {final _that = this;
switch (_that) {
case _OverlapLeaveEntity():
return $default(_that.id,_that.employeeId,_that.employeeName,_that.designation,_that.image,_that.department,_that.sharedProjects,_that.leaveType,_that.fromDate,_that.toDate,_that.days,_that.status,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String employeeId,  String employeeName,  String designation,  String? image,  String? department,  List<String>? sharedProjects,  String leaveType,  String fromDate,  String toDate,  double days,  String status,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _OverlapLeaveEntity() when $default != null:
return $default(_that.id,_that.employeeId,_that.employeeName,_that.designation,_that.image,_that.department,_that.sharedProjects,_that.leaveType,_that.fromDate,_that.toDate,_that.days,_that.status,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _OverlapLeaveEntity implements OverlapLeaveEntity {
  const _OverlapLeaveEntity({required this.id, required this.employeeId, required this.employeeName, required this.designation, this.image, this.department, final  List<String>? sharedProjects, required this.leaveType, required this.fromDate, required this.toDate, required this.days, required this.status, this.description}): _sharedProjects = sharedProjects;
  

@override final  String id;
@override final  String employeeId;
@override final  String employeeName;
@override final  String designation;
@override final  String? image;
@override final  String? department;
 final  List<String>? _sharedProjects;
@override List<String>? get sharedProjects {
  final value = _sharedProjects;
  if (value == null) return null;
  if (_sharedProjects is EqualUnmodifiableListView) return _sharedProjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String leaveType;
@override final  String fromDate;
@override final  String toDate;
@override final  double days;
@override final  String status;
@override final  String? description;

/// Create a copy of OverlapLeaveEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OverlapLeaveEntityCopyWith<_OverlapLeaveEntity> get copyWith => __$OverlapLeaveEntityCopyWithImpl<_OverlapLeaveEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OverlapLeaveEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.image, image) || other.image == image)&&(identical(other.department, department) || other.department == department)&&const DeepCollectionEquality().equals(other._sharedProjects, _sharedProjects)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.days, days) || other.days == days)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,employeeId,employeeName,designation,image,department,const DeepCollectionEquality().hash(_sharedProjects),leaveType,fromDate,toDate,days,status,description);

@override
String toString() {
  return 'OverlapLeaveEntity(id: $id, employeeId: $employeeId, employeeName: $employeeName, designation: $designation, image: $image, department: $department, sharedProjects: $sharedProjects, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, days: $days, status: $status, description: $description)';
}


}

/// @nodoc
abstract mixin class _$OverlapLeaveEntityCopyWith<$Res> implements $OverlapLeaveEntityCopyWith<$Res> {
  factory _$OverlapLeaveEntityCopyWith(_OverlapLeaveEntity value, $Res Function(_OverlapLeaveEntity) _then) = __$OverlapLeaveEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String employeeId, String employeeName, String designation, String? image, String? department, List<String>? sharedProjects, String leaveType, String fromDate, String toDate, double days, String status, String? description
});




}
/// @nodoc
class __$OverlapLeaveEntityCopyWithImpl<$Res>
    implements _$OverlapLeaveEntityCopyWith<$Res> {
  __$OverlapLeaveEntityCopyWithImpl(this._self, this._then);

  final _OverlapLeaveEntity _self;
  final $Res Function(_OverlapLeaveEntity) _then;

/// Create a copy of OverlapLeaveEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? employeeId = null,Object? employeeName = null,Object? designation = null,Object? image = freezed,Object? department = freezed,Object? sharedProjects = freezed,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? days = null,Object? status = null,Object? description = freezed,}) {
  return _then(_OverlapLeaveEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,designation: null == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,sharedProjects: freezed == sharedProjects ? _self._sharedProjects : sharedProjects // ignore: cast_nullable_to_non_nullable
as List<String>?,leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
