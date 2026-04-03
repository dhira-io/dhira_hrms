// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_type_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

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

// dart format on
