// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kra_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KraModel {

@JsonKey(name: 'name') String? get docName;@JsonKey(name: 'kra') String get name; double get weightage; int? get idx;
/// Create a copy of KraModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KraModelCopyWith<KraModel> get copyWith => _$KraModelCopyWithImpl<KraModel>(this as KraModel, _$identity);

  /// Serializes this KraModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KraModel&&(identical(other.docName, docName) || other.docName == docName)&&(identical(other.name, name) || other.name == name)&&(identical(other.weightage, weightage) || other.weightage == weightage)&&(identical(other.idx, idx) || other.idx == idx));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,docName,name,weightage,idx);

@override
String toString() {
  return 'KraModel(docName: $docName, name: $name, weightage: $weightage, idx: $idx)';
}


}

/// @nodoc
abstract mixin class $KraModelCopyWith<$Res>  {
  factory $KraModelCopyWith(KraModel value, $Res Function(KraModel) _then) = _$KraModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'name') String? docName,@JsonKey(name: 'kra') String name, double weightage, int? idx
});




}
/// @nodoc
class _$KraModelCopyWithImpl<$Res>
    implements $KraModelCopyWith<$Res> {
  _$KraModelCopyWithImpl(this._self, this._then);

  final KraModel _self;
  final $Res Function(KraModel) _then;

/// Create a copy of KraModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? docName = freezed,Object? name = null,Object? weightage = null,Object? idx = freezed,}) {
  return _then(_self.copyWith(
docName: freezed == docName ? _self.docName : docName // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,weightage: null == weightage ? _self.weightage : weightage // ignore: cast_nullable_to_non_nullable
as double,idx: freezed == idx ? _self.idx : idx // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [KraModel].
extension KraModelPatterns on KraModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KraModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KraModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KraModel value)  $default,){
final _that = this;
switch (_that) {
case _KraModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KraModel value)?  $default,){
final _that = this;
switch (_that) {
case _KraModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'name')  String? docName, @JsonKey(name: 'kra')  String name,  double weightage,  int? idx)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KraModel() when $default != null:
return $default(_that.docName,_that.name,_that.weightage,_that.idx);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'name')  String? docName, @JsonKey(name: 'kra')  String name,  double weightage,  int? idx)  $default,) {final _that = this;
switch (_that) {
case _KraModel():
return $default(_that.docName,_that.name,_that.weightage,_that.idx);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'name')  String? docName, @JsonKey(name: 'kra')  String name,  double weightage,  int? idx)?  $default,) {final _that = this;
switch (_that) {
case _KraModel() when $default != null:
return $default(_that.docName,_that.name,_that.weightage,_that.idx);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KraModel extends KraModel {
  const _KraModel({@JsonKey(name: 'name') this.docName, @JsonKey(name: 'kra') required this.name, this.weightage = 0.0, this.idx}): super._();
  factory _KraModel.fromJson(Map<String, dynamic> json) => _$KraModelFromJson(json);

@override@JsonKey(name: 'name') final  String? docName;
@override@JsonKey(name: 'kra') final  String name;
@override@JsonKey() final  double weightage;
@override final  int? idx;

/// Create a copy of KraModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KraModelCopyWith<_KraModel> get copyWith => __$KraModelCopyWithImpl<_KraModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KraModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KraModel&&(identical(other.docName, docName) || other.docName == docName)&&(identical(other.name, name) || other.name == name)&&(identical(other.weightage, weightage) || other.weightage == weightage)&&(identical(other.idx, idx) || other.idx == idx));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,docName,name,weightage,idx);

@override
String toString() {
  return 'KraModel(docName: $docName, name: $name, weightage: $weightage, idx: $idx)';
}


}

/// @nodoc
abstract mixin class _$KraModelCopyWith<$Res> implements $KraModelCopyWith<$Res> {
  factory _$KraModelCopyWith(_KraModel value, $Res Function(_KraModel) _then) = __$KraModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'name') String? docName,@JsonKey(name: 'kra') String name, double weightage, int? idx
});




}
/// @nodoc
class __$KraModelCopyWithImpl<$Res>
    implements _$KraModelCopyWith<$Res> {
  __$KraModelCopyWithImpl(this._self, this._then);

  final _KraModel _self;
  final $Res Function(_KraModel) _then;

/// Create a copy of KraModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? docName = freezed,Object? name = null,Object? weightage = null,Object? idx = freezed,}) {
  return _then(_KraModel(
docName: freezed == docName ? _self.docName : docName // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,weightage: null == weightage ? _self.weightage : weightage // ignore: cast_nullable_to_non_nullable
as double,idx: freezed == idx ? _self.idx : idx // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
