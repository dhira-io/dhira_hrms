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

 Map<String, dynamic> get employee;@JsonKey(name: 'leave_type') String get leaveType;@JsonKey(name: 'from_date') String get fromDate;@JsonKey(name: 'to_date') String get toDate;
/// Create a copy of TeamLeaveModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamLeaveModelCopyWith<TeamLeaveModel> get copyWith => _$TeamLeaveModelCopyWithImpl<TeamLeaveModel>(this as TeamLeaveModel, _$identity);

  /// Serializes this TeamLeaveModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamLeaveModel&&const DeepCollectionEquality().equals(other.employee, employee)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(employee),leaveType,fromDate,toDate);

@override
String toString() {
  return 'TeamLeaveModel(employee: $employee, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate)';
}


}

/// @nodoc
abstract mixin class $TeamLeaveModelCopyWith<$Res>  {
  factory $TeamLeaveModelCopyWith(TeamLeaveModel value, $Res Function(TeamLeaveModel) _then) = _$TeamLeaveModelCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> employee,@JsonKey(name: 'leave_type') String leaveType,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate
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
@pragma('vm:prefer-inline') @override $Res call({Object? employee = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,}) {
  return _then(_self.copyWith(
employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, dynamic> employee, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamLeaveModel() when $default != null:
return $default(_that.employee,_that.leaveType,_that.fromDate,_that.toDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, dynamic> employee, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate)  $default,) {final _that = this;
switch (_that) {
case _TeamLeaveModel():
return $default(_that.employee,_that.leaveType,_that.fromDate,_that.toDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, dynamic> employee, @JsonKey(name: 'leave_type')  String leaveType, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate)?  $default,) {final _that = this;
switch (_that) {
case _TeamLeaveModel() when $default != null:
return $default(_that.employee,_that.leaveType,_that.fromDate,_that.toDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamLeaveModel extends TeamLeaveModel {
  const _TeamLeaveModel({required final  Map<String, dynamic> employee, @JsonKey(name: 'leave_type') required this.leaveType, @JsonKey(name: 'from_date') required this.fromDate, @JsonKey(name: 'to_date') required this.toDate}): _employee = employee,super._();
  factory _TeamLeaveModel.fromJson(Map<String, dynamic> json) => _$TeamLeaveModelFromJson(json);

 final  Map<String, dynamic> _employee;
@override Map<String, dynamic> get employee {
  if (_employee is EqualUnmodifiableMapView) return _employee;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_employee);
}

@override@JsonKey(name: 'leave_type') final  String leaveType;
@override@JsonKey(name: 'from_date') final  String fromDate;
@override@JsonKey(name: 'to_date') final  String toDate;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamLeaveModel&&const DeepCollectionEquality().equals(other._employee, _employee)&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_employee),leaveType,fromDate,toDate);

@override
String toString() {
  return 'TeamLeaveModel(employee: $employee, leaveType: $leaveType, fromDate: $fromDate, toDate: $toDate)';
}


}

/// @nodoc
abstract mixin class _$TeamLeaveModelCopyWith<$Res> implements $TeamLeaveModelCopyWith<$Res> {
  factory _$TeamLeaveModelCopyWith(_TeamLeaveModel value, $Res Function(_TeamLeaveModel) _then) = __$TeamLeaveModelCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> employee,@JsonKey(name: 'leave_type') String leaveType,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate
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
@override @pragma('vm:prefer-inline') $Res call({Object? employee = null,Object? leaveType = null,Object? fromDate = null,Object? toDate = null,}) {
  return _then(_TeamLeaveModel(
employee: null == employee ? _self._employee : employee // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
