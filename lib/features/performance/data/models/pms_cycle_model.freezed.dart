// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pms_cycle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PmsCycleModel {

 String get name;@JsonKey(name: 'cycle_name') String get cycleName;
/// Create a copy of PmsCycleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PmsCycleModelCopyWith<PmsCycleModel> get copyWith => _$PmsCycleModelCopyWithImpl<PmsCycleModel>(this as PmsCycleModel, _$identity);

  /// Serializes this PmsCycleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PmsCycleModel&&(identical(other.name, name) || other.name == name)&&(identical(other.cycleName, cycleName) || other.cycleName == cycleName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,cycleName);

@override
String toString() {
  return 'PmsCycleModel(name: $name, cycleName: $cycleName)';
}


}

/// @nodoc
abstract mixin class $PmsCycleModelCopyWith<$Res>  {
  factory $PmsCycleModelCopyWith(PmsCycleModel value, $Res Function(PmsCycleModel) _then) = _$PmsCycleModelCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'cycle_name') String cycleName
});




}
/// @nodoc
class _$PmsCycleModelCopyWithImpl<$Res>
    implements $PmsCycleModelCopyWith<$Res> {
  _$PmsCycleModelCopyWithImpl(this._self, this._then);

  final PmsCycleModel _self;
  final $Res Function(PmsCycleModel) _then;

/// Create a copy of PmsCycleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? cycleName = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cycleName: null == cycleName ? _self.cycleName : cycleName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PmsCycleModel].
extension PmsCycleModelPatterns on PmsCycleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PmsCycleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PmsCycleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PmsCycleModel value)  $default,){
final _that = this;
switch (_that) {
case _PmsCycleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PmsCycleModel value)?  $default,){
final _that = this;
switch (_that) {
case _PmsCycleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'cycle_name')  String cycleName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PmsCycleModel() when $default != null:
return $default(_that.name,_that.cycleName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'cycle_name')  String cycleName)  $default,) {final _that = this;
switch (_that) {
case _PmsCycleModel():
return $default(_that.name,_that.cycleName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'cycle_name')  String cycleName)?  $default,) {final _that = this;
switch (_that) {
case _PmsCycleModel() when $default != null:
return $default(_that.name,_that.cycleName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PmsCycleModel extends PmsCycleModel {
  const _PmsCycleModel({required this.name, @JsonKey(name: 'cycle_name') required this.cycleName}): super._();
  factory _PmsCycleModel.fromJson(Map<String, dynamic> json) => _$PmsCycleModelFromJson(json);

@override final  String name;
@override@JsonKey(name: 'cycle_name') final  String cycleName;

/// Create a copy of PmsCycleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PmsCycleModelCopyWith<_PmsCycleModel> get copyWith => __$PmsCycleModelCopyWithImpl<_PmsCycleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PmsCycleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PmsCycleModel&&(identical(other.name, name) || other.name == name)&&(identical(other.cycleName, cycleName) || other.cycleName == cycleName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,cycleName);

@override
String toString() {
  return 'PmsCycleModel(name: $name, cycleName: $cycleName)';
}


}

/// @nodoc
abstract mixin class _$PmsCycleModelCopyWith<$Res> implements $PmsCycleModelCopyWith<$Res> {
  factory _$PmsCycleModelCopyWith(_PmsCycleModel value, $Res Function(_PmsCycleModel) _then) = __$PmsCycleModelCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'cycle_name') String cycleName
});




}
/// @nodoc
class __$PmsCycleModelCopyWithImpl<$Res>
    implements _$PmsCycleModelCopyWith<$Res> {
  __$PmsCycleModelCopyWithImpl(this._self, this._then);

  final _PmsCycleModel _self;
  final $Res Function(_PmsCycleModel) _then;

/// Create a copy of PmsCycleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? cycleName = null,}) {
  return _then(_PmsCycleModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cycleName: null == cycleName ? _self.cycleName : cycleName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
