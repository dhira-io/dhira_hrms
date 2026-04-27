// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_leave_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TeamLeaveModel {

@JsonKey(name: 'employee_name') String get employeeName;@JsonKey(name: 'leave_type') String get leaveType;@JsonKey(name: 'from_date') String get fromDate;@JsonKey(name: 'to_date') String get toDate; String get employee; String? get designation; String? get image;
/// Create a copy of TeamLeaveModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamLeaveModelCopyWith<TeamLeaveModel> get copyWith => _$TeamLeaveModelCopyWithImpl<TeamLeaveModel>(this as TeamLeaveModel, _$identity);

  /// Serializes this TeamLeaveModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamLeaveModel&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeName,leaveType,fromDate,toDate,employee,designation,image);

@override
String toString() {
  return 'TeamLeaveModel(employeeName: $employeeName, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, employee: $employee, designation: $designation, image: $image)';
}


}

/// @nodoc
abstract mixin class $TeamLeaveModelCopyWith<$Res>  {
  factory $TeamLeaveModelCopyWith(TeamLeaveModel value, $Res Function(TeamLeaveModel) _then) = _$TeamLeaveModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'leave_type') String leaveType,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate, String employee, String? designation, String? image
});




}
/// @nodoc
class _$TeamLeaveModelCopyWithImpl<$Res>
    implements $TeamLeaveModelCopyWith<$Res> {
  _$TeamLeaveModelCopyWithImpl(this._self, this._then);

  final TeamLeaveModel _self;
  final $Res Function(TeamLeaveModel) _then;

/// Create a copy of TeamLeaveModel
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


/// Adds pattern-matching-related methods to [TeamLeaveModel].
extension TeamLeaveModelPatterns on TeamLeaveModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamLeaveModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamLeaveModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamLeaveModel value)  $default,){
final _that = this;
switch (_that) {
case _TeamLeaveModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamLeaveModel value)?  $default,){
final _that = this;
switch (_that) {
case _TeamLeaveModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String employee,  String? designation,  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamLeaveModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String employee,  String? designation,  String? image)  $default,) {final _that = this;
switch (_that) {
case _TeamLeaveModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'employee_name')  String employeeName, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate,  String employee,  String? designation,  String? image)?  $default,) {final _that = this;
switch (_that) {
case _TeamLeaveModel() when $default != null:
return $default(_that.employeeName,_that.leaveType,_that.fromDate,_that.toDate,_that.employee,_that.designation,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamLeaveModel extends TeamLeaveModel {
  const _TeamLeaveModel({@JsonKey(name: 'employee_name') required this.employeeName, @JsonKey(name: 'leave_type') required this.leaveType, @JsonKey(name: 'from_date') required this.fromDate, @JsonKey(name: 'to_date') required this.toDate, required this.employee, this.designation, this.image}): super._();
  factory _TeamLeaveModel.fromJson(Map<String, dynamic> json) => _$TeamLeaveModelFromJson(json);

@override@JsonKey(name: 'employee_name') final  String employeeName;
@override@JsonKey(name: 'leave_type') final  String leaveType;
@override@JsonKey(name: 'from_date') final  String fromDate;
@override@JsonKey(name: 'to_date') final  String toDate;
@override final  String employee;
@override final  String? designation;
@override final  String? image;

/// Create a copy of TeamLeaveModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamLeaveModelCopyWith<_TeamLeaveModel> get copyWith => __$TeamLeaveModelCopyWithImpl<_TeamLeaveModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamLeaveModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamLeaveModel&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeName,leaveType,fromDate,toDate,employee,designation,image);

@override
String toString() {
  return 'TeamLeaveModel(employeeName: $employeeName, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate, employee: $employee, designation: $designation, image: $image)';
}


}

/// @nodoc
abstract mixin class _$TeamLeaveModelCopyWith<$Res> implements $TeamLeaveModelCopyWith<$Res> {
  factory _$TeamLeaveModelCopyWith(_TeamLeaveModel value, $Res Function(_TeamLeaveModel) _then) = __$TeamLeaveModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'employee_name') String employeeName,@JsonKey(name: 'leave_type') String leaveType,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate, String employee, String? designation, String? image
});




}
/// @nodoc
class __$TeamLeaveModelCopyWithImpl<$Res>
    implements _$TeamLeaveModelCopyWith<$Res> {
  __$TeamLeaveModelCopyWithImpl(this._self, this._then);

  final _TeamLeaveModel _self;
  final $Res Function(_TeamLeaveModel) _then;

/// Create a copy of TeamLeaveModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeName = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,Object? employee = null,Object? designation = freezed,Object? image = freezed,}) {
  return _then(_TeamLeaveModel(
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
