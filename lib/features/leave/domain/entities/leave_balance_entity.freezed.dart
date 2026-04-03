// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_balance_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LeaveBalanceEntity {

 int get totalAllocated; int get used; int get pending; int get available;
/// Create a copy of LeaveBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveBalanceEntityCopyWith<LeaveBalanceEntity> get copyWith => _$LeaveBalanceEntityCopyWithImpl<LeaveBalanceEntity>(this as LeaveBalanceEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveBalanceEntity&&(identical(other.totalAllocated, totalAllocated) || other.totalAllocated == totalAllocated)&&(identical(other.used, used) || other.used == used)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.available, available) || other.available == available));
}


@override
int get hashCode => Object.hash(runtimeType,totalAllocated,used,pending,available);

@override
String toString() {
  return 'LeaveBalanceEntity(totalAllocated: $totalAllocated, used: $used, pending: $pending, available: $available)';
}


}

/// @nodoc
abstract mixin class $LeaveBalanceEntityCopyWith<$Res>  {
  factory $LeaveBalanceEntityCopyWith(LeaveBalanceEntity value, $Res Function(LeaveBalanceEntity) _then) = _$LeaveBalanceEntityCopyWithImpl;
@useResult
$Res call({
 int totalAllocated, int used, int pending, int available
});




}
/// @nodoc
class _$LeaveBalanceEntityCopyWithImpl<$Res>
    implements $LeaveBalanceEntityCopyWith<$Res> {
  _$LeaveBalanceEntityCopyWithImpl(this._self, this._then);

  final LeaveBalanceEntity _self;
  final $Res Function(LeaveBalanceEntity) _then;

/// Create a copy of LeaveBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalAllocated = null,Object? used = null,Object? pending = null,Object? available = null,}) {
  return _then(_self.copyWith(
totalAllocated: null == totalAllocated ? _self.totalAllocated : totalAllocated // ignore: cast_nullable_to_non_nullable
as int,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveBalanceEntity].
extension LeaveBalanceEntityPatterns on LeaveBalanceEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveBalanceEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveBalanceEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveBalanceEntity value)  $default,){
final _that = this;
switch (_that) {
case _LeaveBalanceEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveBalanceEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveBalanceEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalAllocated,  int used,  int pending,  int available)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveBalanceEntity() when $default != null:
return $default(_that.totalAllocated,_that.used,_that.pending,_that.available);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalAllocated,  int used,  int pending,  int available)  $default,) {final _that = this;
switch (_that) {
case _LeaveBalanceEntity():
return $default(_that.totalAllocated,_that.used,_that.pending,_that.available);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalAllocated,  int used,  int pending,  int available)?  $default,) {final _that = this;
switch (_that) {
case _LeaveBalanceEntity() when $default != null:
return $default(_that.totalAllocated,_that.used,_that.pending,_that.available);case _:
  return null;

}
}

}

/// @nodoc


class _LeaveBalanceEntity extends LeaveBalanceEntity {
  const _LeaveBalanceEntity({required this.totalAllocated, required this.used, required this.pending, required this.available}): super._();
  

@override final  int totalAllocated;
@override final  int used;
@override final  int pending;
@override final  int available;

/// Create a copy of LeaveBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveBalanceEntityCopyWith<_LeaveBalanceEntity> get copyWith => __$LeaveBalanceEntityCopyWithImpl<_LeaveBalanceEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveBalanceEntity&&(identical(other.totalAllocated, totalAllocated) || other.totalAllocated == totalAllocated)&&(identical(other.used, used) || other.used == used)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.available, available) || other.available == available));
}


@override
int get hashCode => Object.hash(runtimeType,totalAllocated,used,pending,available);

@override
String toString() {
  return 'LeaveBalanceEntity(totalAllocated: $totalAllocated, used: $used, pending: $pending, available: $available)';
}


}

/// @nodoc
abstract mixin class _$LeaveBalanceEntityCopyWith<$Res> implements $LeaveBalanceEntityCopyWith<$Res> {
  factory _$LeaveBalanceEntityCopyWith(_LeaveBalanceEntity value, $Res Function(_LeaveBalanceEntity) _then) = __$LeaveBalanceEntityCopyWithImpl;
@override @useResult
$Res call({
 int totalAllocated, int used, int pending, int available
});




}
/// @nodoc
class __$LeaveBalanceEntityCopyWithImpl<$Res>
    implements _$LeaveBalanceEntityCopyWith<$Res> {
  __$LeaveBalanceEntityCopyWithImpl(this._self, this._then);

  final _LeaveBalanceEntity _self;
  final $Res Function(_LeaveBalanceEntity) _then;

/// Create a copy of LeaveBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalAllocated = null,Object? used = null,Object? pending = null,Object? available = null,}) {
  return _then(_LeaveBalanceEntity(
totalAllocated: null == totalAllocated ? _self.totalAllocated : totalAllocated // ignore: cast_nullable_to_non_nullable
as int,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
