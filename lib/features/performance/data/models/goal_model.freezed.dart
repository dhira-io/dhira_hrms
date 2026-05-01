// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GoalModel {

 String get name; String get status;@JsonKey(name: 'employee') String get employeeId; List<KraModel> get kras; List<KpiModel> get kpis;
/// Create a copy of GoalModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalModelCopyWith<GoalModel> get copyWith => _$GoalModelCopyWithImpl<GoalModel>(this as GoalModel, _$identity);

  /// Serializes this GoalModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalModel&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&const DeepCollectionEquality().equals(other.kras, kras)&&const DeepCollectionEquality().equals(other.kpis, kpis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,status,employeeId,const DeepCollectionEquality().hash(kras),const DeepCollectionEquality().hash(kpis));

@override
String toString() {
  return 'GoalModel(name: $name, status: $status, employeeId: $employeeId, kras: $kras, kpis: $kpis)';
}


}

/// @nodoc
abstract mixin class $GoalModelCopyWith<$Res>  {
  factory $GoalModelCopyWith(GoalModel value, $Res Function(GoalModel) _then) = _$GoalModelCopyWithImpl;
@useResult
$Res call({
 String name, String status,@JsonKey(name: 'employee') String employeeId, List<KraModel> kras, List<KpiModel> kpis
});




}
/// @nodoc
class _$GoalModelCopyWithImpl<$Res>
    implements $GoalModelCopyWith<$Res> {
  _$GoalModelCopyWithImpl(this._self, this._then);

  final GoalModel _self;
  final $Res Function(GoalModel) _then;

/// Create a copy of GoalModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? status = null,Object? employeeId = null,Object? kras = null,Object? kpis = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,kras: null == kras ? _self.kras : kras // ignore: cast_nullable_to_non_nullable
as List<KraModel>,kpis: null == kpis ? _self.kpis : kpis // ignore: cast_nullable_to_non_nullable
as List<KpiModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalModel].
extension GoalModelPatterns on GoalModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalModel value)  $default,){
final _that = this;
switch (_that) {
case _GoalModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalModel value)?  $default,){
final _that = this;
switch (_that) {
case _GoalModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String status, @JsonKey(name: 'employee')  String employeeId,  List<KraModel> kras,  List<KpiModel> kpis)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalModel() when $default != null:
return $default(_that.name,_that.status,_that.employeeId,_that.kras,_that.kpis);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String status, @JsonKey(name: 'employee')  String employeeId,  List<KraModel> kras,  List<KpiModel> kpis)  $default,) {final _that = this;
switch (_that) {
case _GoalModel():
return $default(_that.name,_that.status,_that.employeeId,_that.kras,_that.kpis);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String status, @JsonKey(name: 'employee')  String employeeId,  List<KraModel> kras,  List<KpiModel> kpis)?  $default,) {final _that = this;
switch (_that) {
case _GoalModel() when $default != null:
return $default(_that.name,_that.status,_that.employeeId,_that.kras,_that.kpis);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoalModel extends GoalModel {
  const _GoalModel({required this.name, this.status = 'Draft', @JsonKey(name: 'employee') this.employeeId = '', final  List<KraModel> kras = const [], final  List<KpiModel> kpis = const []}): _kras = kras,_kpis = kpis,super._();
  factory _GoalModel.fromJson(Map<String, dynamic> json) => _$GoalModelFromJson(json);

@override final  String name;
@override@JsonKey() final  String status;
@override@JsonKey(name: 'employee') final  String employeeId;
 final  List<KraModel> _kras;
@override@JsonKey() List<KraModel> get kras {
  if (_kras is EqualUnmodifiableListView) return _kras;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_kras);
}

 final  List<KpiModel> _kpis;
@override@JsonKey() List<KpiModel> get kpis {
  if (_kpis is EqualUnmodifiableListView) return _kpis;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_kpis);
}


/// Create a copy of GoalModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalModelCopyWith<_GoalModel> get copyWith => __$GoalModelCopyWithImpl<_GoalModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalModel&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&const DeepCollectionEquality().equals(other._kras, _kras)&&const DeepCollectionEquality().equals(other._kpis, _kpis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,status,employeeId,const DeepCollectionEquality().hash(_kras),const DeepCollectionEquality().hash(_kpis));

@override
String toString() {
  return 'GoalModel(name: $name, status: $status, employeeId: $employeeId, kras: $kras, kpis: $kpis)';
}


}

/// @nodoc
abstract mixin class _$GoalModelCopyWith<$Res> implements $GoalModelCopyWith<$Res> {
  factory _$GoalModelCopyWith(_GoalModel value, $Res Function(_GoalModel) _then) = __$GoalModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String status,@JsonKey(name: 'employee') String employeeId, List<KraModel> kras, List<KpiModel> kpis
});




}
/// @nodoc
class __$GoalModelCopyWithImpl<$Res>
    implements _$GoalModelCopyWith<$Res> {
  __$GoalModelCopyWithImpl(this._self, this._then);

  final _GoalModel _self;
  final $Res Function(_GoalModel) _then;

/// Create a copy of GoalModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? status = null,Object? employeeId = null,Object? kras = null,Object? kpis = null,}) {
  return _then(_GoalModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,kras: null == kras ? _self._kras : kras // ignore: cast_nullable_to_non_nullable
as List<KraModel>,kpis: null == kpis ? _self._kpis : kpis // ignore: cast_nullable_to_non_nullable
as List<KpiModel>,
  ));
}


}

// dart format on
