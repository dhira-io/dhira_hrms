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

 num get totalAllocated; num get used; num get pending; num get approved; num get rejected; num get applied; num get available; List<LeaveDetailedBalanceEntity> get details;
/// Create a copy of LeaveBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveBalanceEntityCopyWith<LeaveBalanceEntity> get copyWith => _$LeaveBalanceEntityCopyWithImpl<LeaveBalanceEntity>(this as LeaveBalanceEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveBalanceEntity&&(identical(other.totalAllocated, totalAllocated) || other.totalAllocated == totalAllocated)&&(identical(other.used, used) || other.used == used)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.applied, applied) || other.applied == applied)&&(identical(other.available, available) || other.available == available)&&const DeepCollectionEquality().equals(other.details, details));
}


@override
int get hashCode => Object.hash(runtimeType,totalAllocated,used,pending,approved,rejected,applied,available,const DeepCollectionEquality().hash(details));

@override
String toString() {
  return 'LeaveBalanceEntity(totalAllocated: $totalAllocated, used: $used, pending: $pending, approved: $approved, rejected: $rejected, applied: $applied, available: $available, details: $details)';
}


}

/// @nodoc
abstract mixin class $LeaveBalanceEntityCopyWith<$Res>  {
  factory $LeaveBalanceEntityCopyWith(LeaveBalanceEntity value, $Res Function(LeaveBalanceEntity) _then) = _$LeaveBalanceEntityCopyWithImpl;
@useResult
$Res call({
 num totalAllocated, num used, num pending, num approved, num rejected, num applied, num available, List<LeaveDetailedBalanceEntity> details
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
@pragma('vm:prefer-inline') @override $Res call({Object? totalAllocated = null,Object? used = null,Object? pending = null,Object? approved = null,Object? rejected = null,Object? applied = null,Object? available = null,Object? details = null,}) {
  return _then(_self.copyWith(
totalAllocated: null == totalAllocated ? _self.totalAllocated : totalAllocated // ignore: cast_nullable_to_non_nullable
as num,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as num,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as num,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as num,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as num,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as num,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as num,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as List<LeaveDetailedBalanceEntity>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num totalAllocated,  num used,  num pending,  num approved,  num rejected,  num applied,  num available,  List<LeaveDetailedBalanceEntity> details)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveBalanceEntity() when $default != null:
return $default(_that.totalAllocated,_that.used,_that.pending,_that.approved,_that.rejected,_that.applied,_that.available,_that.details);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num totalAllocated,  num used,  num pending,  num approved,  num rejected,  num applied,  num available,  List<LeaveDetailedBalanceEntity> details)  $default,) {final _that = this;
switch (_that) {
case _LeaveBalanceEntity():
return $default(_that.totalAllocated,_that.used,_that.pending,_that.approved,_that.rejected,_that.applied,_that.available,_that.details);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num totalAllocated,  num used,  num pending,  num approved,  num rejected,  num applied,  num available,  List<LeaveDetailedBalanceEntity> details)?  $default,) {final _that = this;
switch (_that) {
case _LeaveBalanceEntity() when $default != null:
return $default(_that.totalAllocated,_that.used,_that.pending,_that.approved,_that.rejected,_that.applied,_that.available,_that.details);case _:
  return null;

}
}

}

/// @nodoc


class _LeaveBalanceEntity extends LeaveBalanceEntity {
  const _LeaveBalanceEntity({required this.totalAllocated, required this.used, required this.pending, required this.approved, required this.rejected, required this.applied, required this.available, final  List<LeaveDetailedBalanceEntity> details = const []}): _details = details,super._();
  

@override final  num totalAllocated;
@override final  num used;
@override final  num pending;
@override final  num approved;
@override final  num rejected;
@override final  num applied;
@override final  num available;
 final  List<LeaveDetailedBalanceEntity> _details;
@override@JsonKey() List<LeaveDetailedBalanceEntity> get details {
  if (_details is EqualUnmodifiableListView) return _details;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_details);
}


/// Create a copy of LeaveBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveBalanceEntityCopyWith<_LeaveBalanceEntity> get copyWith => __$LeaveBalanceEntityCopyWithImpl<_LeaveBalanceEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveBalanceEntity&&(identical(other.totalAllocated, totalAllocated) || other.totalAllocated == totalAllocated)&&(identical(other.used, used) || other.used == used)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.applied, applied) || other.applied == applied)&&(identical(other.available, available) || other.available == available)&&const DeepCollectionEquality().equals(other._details, _details));
}


@override
int get hashCode => Object.hash(runtimeType,totalAllocated,used,pending,approved,rejected,applied,available,const DeepCollectionEquality().hash(_details));

@override
String toString() {
  return 'LeaveBalanceEntity(totalAllocated: $totalAllocated, used: $used, pending: $pending, approved: $approved, rejected: $rejected, applied: $applied, available: $available, details: $details)';
}


}

/// @nodoc
abstract mixin class _$LeaveBalanceEntityCopyWith<$Res> implements $LeaveBalanceEntityCopyWith<$Res> {
  factory _$LeaveBalanceEntityCopyWith(_LeaveBalanceEntity value, $Res Function(_LeaveBalanceEntity) _then) = __$LeaveBalanceEntityCopyWithImpl;
@override @useResult
$Res call({
 num totalAllocated, num used, num pending, num approved, num rejected, num applied, num available, List<LeaveDetailedBalanceEntity> details
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
@override @pragma('vm:prefer-inline') $Res call({Object? totalAllocated = null,Object? used = null,Object? pending = null,Object? approved = null,Object? rejected = null,Object? applied = null,Object? available = null,Object? details = null,}) {
  return _then(_LeaveBalanceEntity(
totalAllocated: null == totalAllocated ? _self.totalAllocated : totalAllocated // ignore: cast_nullable_to_non_nullable
as num,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as num,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as num,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as num,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as num,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as num,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as num,details: null == details ? _self._details : details // ignore: cast_nullable_to_non_nullable
as List<LeaveDetailedBalanceEntity>,
  ));
}


}

/// @nodoc
mixin _$LeaveDetailedBalanceEntity {

 String get leaveType; double get allocated; double get used; double get pending; double get available;
/// Create a copy of LeaveDetailedBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveDetailedBalanceEntityCopyWith<LeaveDetailedBalanceEntity> get copyWith => _$LeaveDetailedBalanceEntityCopyWithImpl<LeaveDetailedBalanceEntity>(this as LeaveDetailedBalanceEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveDetailedBalanceEntity&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.allocated, allocated) || other.allocated == allocated)&&(identical(other.used, used) || other.used == used)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.available, available) || other.available == available));
}


@override
int get hashCode => Object.hash(runtimeType,leaveType,allocated,used,pending,available);

@override
String toString() {
  return 'LeaveDetailedBalanceEntity(leaveType: $leaveType, allocated: $allocated, used: $used, pending: $pending, available: $available)';
}


}

/// @nodoc
abstract mixin class $LeaveDetailedBalanceEntityCopyWith<$Res>  {
  factory $LeaveDetailedBalanceEntityCopyWith(LeaveDetailedBalanceEntity value, $Res Function(LeaveDetailedBalanceEntity) _then) = _$LeaveDetailedBalanceEntityCopyWithImpl;
@useResult
$Res call({
 String leaveType, double allocated, double used, double pending, double available
});




}
/// @nodoc
class _$LeaveDetailedBalanceEntityCopyWithImpl<$Res>
    implements $LeaveDetailedBalanceEntityCopyWith<$Res> {
  _$LeaveDetailedBalanceEntityCopyWithImpl(this._self, this._then);

  final LeaveDetailedBalanceEntity _self;
  final $Res Function(LeaveDetailedBalanceEntity) _then;

/// Create a copy of LeaveDetailedBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leaveType = null,Object? allocated = null,Object? used = null,Object? pending = null,Object? available = null,}) {
  return _then(_self.copyWith(
leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,allocated: null == allocated ? _self.allocated : allocated // ignore: cast_nullable_to_non_nullable
as double,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as double,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as double,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveDetailedBalanceEntity].
extension LeaveDetailedBalanceEntityPatterns on LeaveDetailedBalanceEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveDetailedBalanceEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveDetailedBalanceEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveDetailedBalanceEntity value)  $default,){
final _that = this;
switch (_that) {
case _LeaveDetailedBalanceEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveDetailedBalanceEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveDetailedBalanceEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String leaveType,  double allocated,  double used,  double pending,  double available)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveDetailedBalanceEntity() when $default != null:
return $default(_that.leaveType,_that.allocated,_that.used,_that.pending,_that.available);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String leaveType,  double allocated,  double used,  double pending,  double available)  $default,) {final _that = this;
switch (_that) {
case _LeaveDetailedBalanceEntity():
return $default(_that.leaveType,_that.allocated,_that.used,_that.pending,_that.available);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String leaveType,  double allocated,  double used,  double pending,  double available)?  $default,) {final _that = this;
switch (_that) {
case _LeaveDetailedBalanceEntity() when $default != null:
return $default(_that.leaveType,_that.allocated,_that.used,_that.pending,_that.available);case _:
  return null;

}
}

}

/// @nodoc


class _LeaveDetailedBalanceEntity extends LeaveDetailedBalanceEntity {
  const _LeaveDetailedBalanceEntity({required this.leaveType, required this.allocated, required this.used, required this.pending, required this.available}): super._();
  

@override final  String leaveType;
@override final  double allocated;
@override final  double used;
@override final  double pending;
@override final  double available;

/// Create a copy of LeaveDetailedBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveDetailedBalanceEntityCopyWith<_LeaveDetailedBalanceEntity> get copyWith => __$LeaveDetailedBalanceEntityCopyWithImpl<_LeaveDetailedBalanceEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveDetailedBalanceEntity&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.allocated, allocated) || other.allocated == allocated)&&(identical(other.used, used) || other.used == used)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.available, available) || other.available == available));
}


@override
int get hashCode => Object.hash(runtimeType,leaveType,allocated,used,pending,available);

@override
String toString() {
  return 'LeaveDetailedBalanceEntity(leaveType: $leaveType, allocated: $allocated, used: $used, pending: $pending, available: $available)';
}


}

/// @nodoc
abstract mixin class _$LeaveDetailedBalanceEntityCopyWith<$Res> implements $LeaveDetailedBalanceEntityCopyWith<$Res> {
  factory _$LeaveDetailedBalanceEntityCopyWith(_LeaveDetailedBalanceEntity value, $Res Function(_LeaveDetailedBalanceEntity) _then) = __$LeaveDetailedBalanceEntityCopyWithImpl;
@override @useResult
$Res call({
 String leaveType, double allocated, double used, double pending, double available
});




}
/// @nodoc
class __$LeaveDetailedBalanceEntityCopyWithImpl<$Res>
    implements _$LeaveDetailedBalanceEntityCopyWith<$Res> {
  __$LeaveDetailedBalanceEntityCopyWithImpl(this._self, this._then);

  final _LeaveDetailedBalanceEntity _self;
  final $Res Function(_LeaveDetailedBalanceEntity) _then;

/// Create a copy of LeaveDetailedBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leaveType = null,Object? allocated = null,Object? used = null,Object? pending = null,Object? available = null,}) {
  return _then(_LeaveDetailedBalanceEntity(
leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,allocated: null == allocated ? _self.allocated : allocated // ignore: cast_nullable_to_non_nullable
as double,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as double,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as double,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
