// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kpi_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KpiModel {

 String get name;@JsonKey(name: 'kpi') String get title;@JsonKey(name: 'kras') String get kra; String get description; double get weightage; double get target;
/// Create a copy of KpiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KpiModelCopyWith<KpiModel> get copyWith => _$KpiModelCopyWithImpl<KpiModel>(this as KpiModel, _$identity);

  /// Serializes this KpiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KpiModel&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.kra, kra) || other.kra == kra)&&(identical(other.description, description) || other.description == description)&&(identical(other.weightage, weightage) || other.weightage == weightage)&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,title,kra,description,weightage,target);

@override
String toString() {
  return 'KpiModel(name: $name, title: $title, kra: $kra, description: $description, weightage: $weightage, target: $target)';
}


}

/// @nodoc
abstract mixin class $KpiModelCopyWith<$Res>  {
  factory $KpiModelCopyWith(KpiModel value, $Res Function(KpiModel) _then) = _$KpiModelCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'kpi') String title,@JsonKey(name: 'kras') String kra, String description, double weightage, double target
});




}
/// @nodoc
class _$KpiModelCopyWithImpl<$Res>
    implements $KpiModelCopyWith<$Res> {
  _$KpiModelCopyWithImpl(this._self, this._then);

  final KpiModel _self;
  final $Res Function(KpiModel) _then;

/// Create a copy of KpiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? title = null,Object? kra = null,Object? description = null,Object? weightage = null,Object? target = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kra: null == kra ? _self.kra : kra // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,weightage: null == weightage ? _self.weightage : weightage // ignore: cast_nullable_to_non_nullable
as double,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [KpiModel].
extension KpiModelPatterns on KpiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KpiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KpiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KpiModel value)  $default,){
final _that = this;
switch (_that) {
case _KpiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KpiModel value)?  $default,){
final _that = this;
switch (_that) {
case _KpiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'kpi')  String title, @JsonKey(name: 'kras')  String kra,  String description,  double weightage,  double target)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KpiModel() when $default != null:
return $default(_that.name,_that.title,_that.kra,_that.description,_that.weightage,_that.target);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'kpi')  String title, @JsonKey(name: 'kras')  String kra,  String description,  double weightage,  double target)  $default,) {final _that = this;
switch (_that) {
case _KpiModel():
return $default(_that.name,_that.title,_that.kra,_that.description,_that.weightage,_that.target);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'kpi')  String title, @JsonKey(name: 'kras')  String kra,  String description,  double weightage,  double target)?  $default,) {final _that = this;
switch (_that) {
case _KpiModel() when $default != null:
return $default(_that.name,_that.title,_that.kra,_that.description,_that.weightage,_that.target);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KpiModel extends KpiModel {
  const _KpiModel({required this.name, @JsonKey(name: 'kpi') this.title = '', @JsonKey(name: 'kras') this.kra = '', this.description = '', this.weightage = 0.0, this.target = 0.0}): super._();
  factory _KpiModel.fromJson(Map<String, dynamic> json) => _$KpiModelFromJson(json);

@override final  String name;
@override@JsonKey(name: 'kpi') final  String title;
@override@JsonKey(name: 'kras') final  String kra;
@override@JsonKey() final  String description;
@override@JsonKey() final  double weightage;
@override@JsonKey() final  double target;

/// Create a copy of KpiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KpiModelCopyWith<_KpiModel> get copyWith => __$KpiModelCopyWithImpl<_KpiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KpiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KpiModel&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.kra, kra) || other.kra == kra)&&(identical(other.description, description) || other.description == description)&&(identical(other.weightage, weightage) || other.weightage == weightage)&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,title,kra,description,weightage,target);

@override
String toString() {
  return 'KpiModel(name: $name, title: $title, kra: $kra, description: $description, weightage: $weightage, target: $target)';
}


}

/// @nodoc
abstract mixin class _$KpiModelCopyWith<$Res> implements $KpiModelCopyWith<$Res> {
  factory _$KpiModelCopyWith(_KpiModel value, $Res Function(_KpiModel) _then) = __$KpiModelCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'kpi') String title,@JsonKey(name: 'kras') String kra, String description, double weightage, double target
});




}
/// @nodoc
class __$KpiModelCopyWithImpl<$Res>
    implements _$KpiModelCopyWith<$Res> {
  __$KpiModelCopyWithImpl(this._self, this._then);

  final _KpiModel _self;
  final $Res Function(_KpiModel) _then;

/// Create a copy of KpiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? title = null,Object? kra = null,Object? description = null,Object? weightage = null,Object? target = null,}) {
  return _then(_KpiModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kra: null == kra ? _self.kra : kra // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,weightage: null == weightage ? _self.weightage : weightage // ignore: cast_nullable_to_non_nullable
as double,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
