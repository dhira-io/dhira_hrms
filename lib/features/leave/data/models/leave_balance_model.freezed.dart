// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_balance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaveBalanceModel {

@JsonKey(name: 'total_leaves') int get totalAllocated;@JsonKey(name: 'leaves_taken') int get used;@JsonKey(name: 'leaves_pending_approval') int get pending;
/// Create a copy of LeaveBalanceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveBalanceModelCopyWith<LeaveBalanceModel> get copyWith => _$LeaveBalanceModelCopyWithImpl<LeaveBalanceModel>(this as LeaveBalanceModel, _$identity);

  /// Serializes this LeaveBalanceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveBalanceModel&&(identical(other.totalAllocated, totalAllocated) || other.totalAllocated == totalAllocated)&&(identical(other.used, used) || other.used == used)&&(identical(other.pending, pending) || other.pending == pending));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalAllocated,used,pending);

@override
String toString() {
  return 'LeaveBalanceModel(totalAllocated: $totalAllocated, used: $used, pending: $pending)';
}


}

/// @nodoc
abstract mixin class $LeaveBalanceModelCopyWith<$Res>  {
  factory $LeaveBalanceModelCopyWith(LeaveBalanceModel value, $Res Function(LeaveBalanceModel) _then) = _$LeaveBalanceModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_leaves') int totalAllocated,@JsonKey(name: 'leaves_taken') int used,@JsonKey(name: 'leaves_pending_approval') int pending
});




}
/// @nodoc
class _$LeaveBalanceModelCopyWithImpl<$Res>
    implements $LeaveBalanceModelCopyWith<$Res> {
  _$LeaveBalanceModelCopyWithImpl(this._self, this._then);

  final LeaveBalanceModel _self;
  final $Res Function(LeaveBalanceModel) _then;

/// Create a copy of LeaveBalanceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalAllocated = null,Object? used = null,Object? pending = null,}) {
  return _then(_self.copyWith(
totalAllocated: null == totalAllocated ? _self.totalAllocated : totalAllocated // ignore: cast_nullable_to_non_nullable
as int,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveBalanceModel].
extension LeaveBalanceModelPatterns on LeaveBalanceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveBalanceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveBalanceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveBalanceModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaveBalanceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveBalanceModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveBalanceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_leaves')  int totalAllocated, @JsonKey(name: 'leaves_taken')  int used, @JsonKey(name: 'leaves_pending_approval')  int pending)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveBalanceModel() when $default != null:
return $default(_that.totalAllocated,_that.used,_that.pending);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_leaves')  int totalAllocated, @JsonKey(name: 'leaves_taken')  int used, @JsonKey(name: 'leaves_pending_approval')  int pending)  $default,) {final _that = this;
switch (_that) {
case _LeaveBalanceModel():
return $default(_that.totalAllocated,_that.used,_that.pending);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_leaves')  int totalAllocated, @JsonKey(name: 'leaves_taken')  int used, @JsonKey(name: 'leaves_pending_approval')  int pending)?  $default,) {final _that = this;
switch (_that) {
case _LeaveBalanceModel() when $default != null:
return $default(_that.totalAllocated,_that.used,_that.pending);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveBalanceModel extends LeaveBalanceModel {
  const _LeaveBalanceModel({@JsonKey(name: 'total_leaves') required this.totalAllocated, @JsonKey(name: 'leaves_taken') required this.used, @JsonKey(name: 'leaves_pending_approval') required this.pending}): super._();
  factory _LeaveBalanceModel.fromJson(Map<String, dynamic> json) => _$LeaveBalanceModelFromJson(json);

@override@JsonKey(name: 'total_leaves') final  int totalAllocated;
@override@JsonKey(name: 'leaves_taken') final  int used;
@override@JsonKey(name: 'leaves_pending_approval') final  int pending;

/// Create a copy of LeaveBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveBalanceModelCopyWith<_LeaveBalanceModel> get copyWith => __$LeaveBalanceModelCopyWithImpl<_LeaveBalanceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveBalanceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveBalanceModel&&(identical(other.totalAllocated, totalAllocated) || other.totalAllocated == totalAllocated)&&(identical(other.used, used) || other.used == used)&&(identical(other.pending, pending) || other.pending == pending));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalAllocated,used,pending);

@override
String toString() {
  return 'LeaveBalanceModel(totalAllocated: $totalAllocated, used: $used, pending: $pending)';
}


}

/// @nodoc
abstract mixin class _$LeaveBalanceModelCopyWith<$Res> implements $LeaveBalanceModelCopyWith<$Res> {
  factory _$LeaveBalanceModelCopyWith(_LeaveBalanceModel value, $Res Function(_LeaveBalanceModel) _then) = __$LeaveBalanceModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_leaves') int totalAllocated,@JsonKey(name: 'leaves_taken') int used,@JsonKey(name: 'leaves_pending_approval') int pending
});




}
/// @nodoc
class __$LeaveBalanceModelCopyWithImpl<$Res>
    implements _$LeaveBalanceModelCopyWith<$Res> {
  __$LeaveBalanceModelCopyWithImpl(this._self, this._then);

  final _LeaveBalanceModel _self;
  final $Res Function(_LeaveBalanceModel) _then;

/// Create a copy of LeaveBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalAllocated = null,Object? used = null,Object? pending = null,}) {
  return _then(_LeaveBalanceModel(
totalAllocated: null == totalAllocated ? _self.totalAllocated : totalAllocated // ignore: cast_nullable_to_non_nullable
as int,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
