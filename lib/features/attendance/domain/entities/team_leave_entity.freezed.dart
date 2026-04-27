// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_leave_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeamLeaveEntity {

 String get employeeName; String get leaveType; String get fromDate; String get toDate; String get employee; String? get designation; String? get image;
/// Create a copy of TeamLeaveEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamLeaveEntityCopyWith<TeamLeaveEntity> get copyWith => _$TeamLeaveEntityCopyWithImpl<TeamLeaveEntity>(this as TeamLeaveEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamLeaveEntity&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.image, image) || other.image == image));
}


@override
int get hashCode => Object.hash(runtimeType,employeeName,leaveType,fromDate,toDate,employee,designation,image);

@override
String toString() {
  return 'TeamLeaveEntity(employeeName: $employeeName, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, employee: $employee, designation: $designation, image: $image)';
}


}

/// @nodoc
abstract mixin class $TeamLeaveEntityCopyWith<$Res>  {
  factory $TeamLeaveEntityCopyWith(TeamLeaveEntity value, $Res Function(TeamLeaveEntity) _then) = _$TeamLeaveEntityCopyWithImpl;
@useResult
$Res call({
 String employeeName, String leaveType, String fromDate, String toDate, String employee, String? designation, String? image
});




}
/// @nodoc
class _$TeamLeaveEntityCopyWithImpl<$Res>
    implements $TeamLeaveEntityCopyWith<$Res> {
  _$TeamLeaveEntityCopyWithImpl(this._self, this._then);

  final TeamLeaveEntity _self;
  final $Res Function(TeamLeaveEntity) _then;

/// Create a copy of TeamLeaveEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employeeName = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? employee = null,Object? designation = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamLeaveEntity].
extension TeamLeaveEntityPatterns on TeamLeaveEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamLeaveEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamLeaveEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamLeaveEntity value)  $default,){
final _that = this;
switch (_that) {
case _TeamLeaveEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamLeaveEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TeamLeaveEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String employeeName,  String leaveType,  String fromDate,  String toDate,  String employee,  String? designation,  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamLeaveEntity() when $default != null:
return $default(_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.employee,_that.designation,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String employeeName,  String leaveType,  String fromDate,  String toDate,  String employee,  String? designation,  String? image)  $default,) {final _that = this;
switch (_that) {
case _TeamLeaveEntity():
return $default(_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.employee,_that.designation,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String employeeName,  String leaveType,  String fromDate,  String toDate,  String employee,  String? designation,  String? image)?  $default,) {final _that = this;
switch (_that) {
case _TeamLeaveEntity() when $default != null:
return $default(_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.employee,_that.designation,_that.image);case _:
  return null;

}
}

}

/// @nodoc


class _TeamLeaveEntity implements TeamLeaveEntity {
  const _TeamLeaveEntity({required this.employeeName, required this.leaveType, required this.fromDate, required this.toDate, required this.employee, this.designation, this.image});
  

@override final  String employeeName;
@override final  String leaveType;
@override final  String fromDate;
@override final  String toDate;
@override final  String employee;
@override final  String? designation;
@override final  String? image;

/// Create a copy of TeamLeaveEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamLeaveEntityCopyWith<_TeamLeaveEntity> get copyWith => __$TeamLeaveEntityCopyWithImpl<_TeamLeaveEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamLeaveEntity&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.image, image) || other.image == image));
}


@override
int get hashCode => Object.hash(runtimeType,employeeName,leaveType,fromDate,toDate,employee,designation,image);

@override
String toString() {
  return 'TeamLeaveEntity(employeeName: $employeeName, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, employee: $employee, designation: $designation, image: $image)';
}


}

/// @nodoc
abstract mixin class _$TeamLeaveEntityCopyWith<$Res> implements $TeamLeaveEntityCopyWith<$Res> {
  factory _$TeamLeaveEntityCopyWith(_TeamLeaveEntity value, $Res Function(_TeamLeaveEntity) _then) = __$TeamLeaveEntityCopyWithImpl;
@override @useResult
$Res call({
 String employeeName, String leaveType, String fromDate, String toDate, String employee, String? designation, String? image
});




}
/// @nodoc
class __$TeamLeaveEntityCopyWithImpl<$Res>
    implements _$TeamLeaveEntityCopyWith<$Res> {
  __$TeamLeaveEntityCopyWithImpl(this._self, this._then);

  final _TeamLeaveEntity _self;
  final $Res Function(_TeamLeaveEntity) _then;

/// Create a copy of TeamLeaveEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeName = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? employee = null,Object? designation = freezed,Object? image = freezed,}) {
  return _then(_TeamLeaveEntity(
employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
