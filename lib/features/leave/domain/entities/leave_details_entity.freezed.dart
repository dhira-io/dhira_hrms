// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_details_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LeaveDetailsEntity {

 Map<String, LeaveAllocationEntity> get leaveAllocation; String get leaveApprover; List<String> get lwps;
/// Create a copy of LeaveDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveDetailsEntityCopyWith<LeaveDetailsEntity> get copyWith => _$LeaveDetailsEntityCopyWithImpl<LeaveDetailsEntity>(this as LeaveDetailsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveDetailsEntity&&const DeepCollectionEquality().equals(other.leaveAllocation, leaveAllocation)&&(identical(other.leaveApprover, leaveApprover) || other.leaveApprover == leaveApprover)&&const DeepCollectionEquality().equals(other.lwps, lwps));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(leaveAllocation),leaveApprover,const DeepCollectionEquality().hash(lwps));

@override
String toString() {
  return 'LeaveDetailsEntity(leaveAllocation: $leaveAllocation, leaveApprover: $leaveApprover, lwps: $lwps)';
}


}

/// @nodoc
abstract mixin class $LeaveDetailsEntityCopyWith<$Res>  {
  factory $LeaveDetailsEntityCopyWith(LeaveDetailsEntity value, $Res Function(LeaveDetailsEntity) _then) = _$LeaveDetailsEntityCopyWithImpl;
@useResult
$Res call({
 Map<String, LeaveAllocationEntity> leaveAllocation, String leaveApprover, List<String> lwps
});




}
/// @nodoc
class _$LeaveDetailsEntityCopyWithImpl<$Res>
    implements $LeaveDetailsEntityCopyWith<$Res> {
  _$LeaveDetailsEntityCopyWithImpl(this._self, this._then);

  final LeaveDetailsEntity _self;
  final $Res Function(LeaveDetailsEntity) _then;

/// Create a copy of LeaveDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leaveAllocation = null,Object? leaveApprover = null,Object? lwps = null,}) {
  return _then(_self.copyWith(
leaveAllocation: null == leaveAllocation ? _self.leaveAllocation : leaveAllocation // ignore: cast_nullable_to_non_nullable
as Map<String, LeaveAllocationEntity>,leaveApprover: null == leaveApprover ? _self.leaveApprover : leaveApprover // ignore: cast_nullable_to_non_nullable
as String,lwps: null == lwps ? _self.lwps : lwps // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveDetailsEntity].
extension LeaveDetailsEntityPatterns on LeaveDetailsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveDetailsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveDetailsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveDetailsEntity value)  $default,){
final _that = this;
switch (_that) {
case _LeaveDetailsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveDetailsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveDetailsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, LeaveAllocationEntity> leaveAllocation,  String leaveApprover,  List<String> lwps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveDetailsEntity() when $default != null:
return $default(_that.leaveAllocation,_that.leaveApprover,_that.lwps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, LeaveAllocationEntity> leaveAllocation,  String leaveApprover,  List<String> lwps)  $default,) {final _that = this;
switch (_that) {
case _LeaveDetailsEntity():
return $default(_that.leaveAllocation,_that.leaveApprover,_that.lwps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, LeaveAllocationEntity> leaveAllocation,  String leaveApprover,  List<String> lwps)?  $default,) {final _that = this;
switch (_that) {
case _LeaveDetailsEntity() when $default != null:
return $default(_that.leaveAllocation,_that.leaveApprover,_that.lwps);case _:
  return null;

}
}

}

/// @nodoc


class _LeaveDetailsEntity implements LeaveDetailsEntity {
  const _LeaveDetailsEntity({required final  Map<String, LeaveAllocationEntity> leaveAllocation, required this.leaveApprover, required final  List<String> lwps}): _leaveAllocation = leaveAllocation,_lwps = lwps;
  

 final  Map<String, LeaveAllocationEntity> _leaveAllocation;
@override Map<String, LeaveAllocationEntity> get leaveAllocation {
  if (_leaveAllocation is EqualUnmodifiableMapView) return _leaveAllocation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_leaveAllocation);
}

@override final  String leaveApprover;
 final  List<String> _lwps;
@override List<String> get lwps {
  if (_lwps is EqualUnmodifiableListView) return _lwps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lwps);
}


/// Create a copy of LeaveDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveDetailsEntityCopyWith<_LeaveDetailsEntity> get copyWith => __$LeaveDetailsEntityCopyWithImpl<_LeaveDetailsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveDetailsEntity&&const DeepCollectionEquality().equals(other._leaveAllocation, _leaveAllocation)&&(identical(other.leaveApprover, leaveApprover) || other.leaveApprover == leaveApprover)&&const DeepCollectionEquality().equals(other._lwps, _lwps));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_leaveAllocation),leaveApprover,const DeepCollectionEquality().hash(_lwps));

@override
String toString() {
  return 'LeaveDetailsEntity(leaveAllocation: $leaveAllocation, leaveApprover: $leaveApprover, lwps: $lwps)';
}


}

/// @nodoc
abstract mixin class _$LeaveDetailsEntityCopyWith<$Res> implements $LeaveDetailsEntityCopyWith<$Res> {
  factory _$LeaveDetailsEntityCopyWith(_LeaveDetailsEntity value, $Res Function(_LeaveDetailsEntity) _then) = __$LeaveDetailsEntityCopyWithImpl;
@override @useResult
$Res call({
 Map<String, LeaveAllocationEntity> leaveAllocation, String leaveApprover, List<String> lwps
});




}
/// @nodoc
class __$LeaveDetailsEntityCopyWithImpl<$Res>
    implements _$LeaveDetailsEntityCopyWith<$Res> {
  __$LeaveDetailsEntityCopyWithImpl(this._self, this._then);

  final _LeaveDetailsEntity _self;
  final $Res Function(_LeaveDetailsEntity) _then;

/// Create a copy of LeaveDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leaveAllocation = null,Object? leaveApprover = null,Object? lwps = null,}) {
  return _then(_LeaveDetailsEntity(
leaveAllocation: null == leaveAllocation ? _self._leaveAllocation : leaveAllocation // ignore: cast_nullable_to_non_nullable
as Map<String, LeaveAllocationEntity>,leaveApprover: null == leaveApprover ? _self.leaveApprover : leaveApprover // ignore: cast_nullable_to_non_nullable
as String,lwps: null == lwps ? _self._lwps : lwps // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$LeaveAllocationEntity {

 double get totalLeaves; int get expiredLeaves; double get leavesTaken; double get leavesPendingApproval; double get remainingLeaves;
/// Create a copy of LeaveAllocationEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveAllocationEntityCopyWith<LeaveAllocationEntity> get copyWith => _$LeaveAllocationEntityCopyWithImpl<LeaveAllocationEntity>(this as LeaveAllocationEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveAllocationEntity&&(identical(other.totalLeaves, totalLeaves) || other.totalLeaves == totalLeaves)&&(identical(other.expiredLeaves, expiredLeaves) || other.expiredLeaves == expiredLeaves)&&(identical(other.leavesTaken, leavesTaken) || other.leavesTaken == leavesTaken)&&(identical(other.leavesPendingApproval, leavesPendingApproval) || other.leavesPendingApproval == leavesPendingApproval)&&(identical(other.remainingLeaves, remainingLeaves) || other.remainingLeaves == remainingLeaves));
}


@override
int get hashCode => Object.hash(runtimeType,totalLeaves,expiredLeaves,leavesTaken,leavesPendingApproval,remainingLeaves);

@override
String toString() {
  return 'LeaveAllocationEntity(totalLeaves: $totalLeaves, expiredLeaves: $expiredLeaves, leavesTaken: $leavesTaken, leavesPendingApproval: $leavesPendingApproval, remainingLeaves: $remainingLeaves)';
}


}

/// @nodoc
abstract mixin class $LeaveAllocationEntityCopyWith<$Res>  {
  factory $LeaveAllocationEntityCopyWith(LeaveAllocationEntity value, $Res Function(LeaveAllocationEntity) _then) = _$LeaveAllocationEntityCopyWithImpl;
@useResult
$Res call({
 double totalLeaves, int expiredLeaves, double leavesTaken, double leavesPendingApproval, double remainingLeaves
});




}
/// @nodoc
class _$LeaveAllocationEntityCopyWithImpl<$Res>
    implements $LeaveAllocationEntityCopyWith<$Res> {
  _$LeaveAllocationEntityCopyWithImpl(this._self, this._then);

  final LeaveAllocationEntity _self;
  final $Res Function(LeaveAllocationEntity) _then;

/// Create a copy of LeaveAllocationEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalLeaves = null,Object? expiredLeaves = null,Object? leavesTaken = null,Object? leavesPendingApproval = null,Object? remainingLeaves = null,}) {
  return _then(_self.copyWith(
totalLeaves: null == totalLeaves ? _self.totalLeaves : totalLeaves // ignore: cast_nullable_to_non_nullable
as double,expiredLeaves: null == expiredLeaves ? _self.expiredLeaves : expiredLeaves // ignore: cast_nullable_to_non_nullable
as int,leavesTaken: null == leavesTaken ? _self.leavesTaken : leavesTaken // ignore: cast_nullable_to_non_nullable
as double,leavesPendingApproval: null == leavesPendingApproval ? _self.leavesPendingApproval : leavesPendingApproval // ignore: cast_nullable_to_non_nullable
as double,remainingLeaves: null == remainingLeaves ? _self.remainingLeaves : remainingLeaves // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveAllocationEntity].
extension LeaveAllocationEntityPatterns on LeaveAllocationEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveAllocationEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveAllocationEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveAllocationEntity value)  $default,){
final _that = this;
switch (_that) {
case _LeaveAllocationEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveAllocationEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveAllocationEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalLeaves,  int expiredLeaves,  double leavesTaken,  double leavesPendingApproval,  double remainingLeaves)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveAllocationEntity() when $default != null:
return $default(_that.totalLeaves,_that.expiredLeaves,_that.leavesTaken,_that.leavesPendingApproval,_that.remainingLeaves);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalLeaves,  int expiredLeaves,  double leavesTaken,  double leavesPendingApproval,  double remainingLeaves)  $default,) {final _that = this;
switch (_that) {
case _LeaveAllocationEntity():
return $default(_that.totalLeaves,_that.expiredLeaves,_that.leavesTaken,_that.leavesPendingApproval,_that.remainingLeaves);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalLeaves,  int expiredLeaves,  double leavesTaken,  double leavesPendingApproval,  double remainingLeaves)?  $default,) {final _that = this;
switch (_that) {
case _LeaveAllocationEntity() when $default != null:
return $default(_that.totalLeaves,_that.expiredLeaves,_that.leavesTaken,_that.leavesPendingApproval,_that.remainingLeaves);case _:
  return null;

}
}

}

/// @nodoc


class _LeaveAllocationEntity implements LeaveAllocationEntity {
  const _LeaveAllocationEntity({required this.totalLeaves, required this.expiredLeaves, required this.leavesTaken, required this.leavesPendingApproval, required this.remainingLeaves});
  

@override final  double totalLeaves;
@override final  int expiredLeaves;
@override final  double leavesTaken;
@override final  double leavesPendingApproval;
@override final  double remainingLeaves;

/// Create a copy of LeaveAllocationEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveAllocationEntityCopyWith<_LeaveAllocationEntity> get copyWith => __$LeaveAllocationEntityCopyWithImpl<_LeaveAllocationEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveAllocationEntity&&(identical(other.totalLeaves, totalLeaves) || other.totalLeaves == totalLeaves)&&(identical(other.expiredLeaves, expiredLeaves) || other.expiredLeaves == expiredLeaves)&&(identical(other.leavesTaken, leavesTaken) || other.leavesTaken == leavesTaken)&&(identical(other.leavesPendingApproval, leavesPendingApproval) || other.leavesPendingApproval == leavesPendingApproval)&&(identical(other.remainingLeaves, remainingLeaves) || other.remainingLeaves == remainingLeaves));
}


@override
int get hashCode => Object.hash(runtimeType,totalLeaves,expiredLeaves,leavesTaken,leavesPendingApproval,remainingLeaves);

@override
String toString() {
  return 'LeaveAllocationEntity(totalLeaves: $totalLeaves, expiredLeaves: $expiredLeaves, leavesTaken: $leavesTaken, leavesPendingApproval: $leavesPendingApproval, remainingLeaves: $remainingLeaves)';
}


}

/// @nodoc
abstract mixin class _$LeaveAllocationEntityCopyWith<$Res> implements $LeaveAllocationEntityCopyWith<$Res> {
  factory _$LeaveAllocationEntityCopyWith(_LeaveAllocationEntity value, $Res Function(_LeaveAllocationEntity) _then) = __$LeaveAllocationEntityCopyWithImpl;
@override @useResult
$Res call({
 double totalLeaves, int expiredLeaves, double leavesTaken, double leavesPendingApproval, double remainingLeaves
});




}
/// @nodoc
class __$LeaveAllocationEntityCopyWithImpl<$Res>
    implements _$LeaveAllocationEntityCopyWith<$Res> {
  __$LeaveAllocationEntityCopyWithImpl(this._self, this._then);

  final _LeaveAllocationEntity _self;
  final $Res Function(_LeaveAllocationEntity) _then;

/// Create a copy of LeaveAllocationEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalLeaves = null,Object? expiredLeaves = null,Object? leavesTaken = null,Object? leavesPendingApproval = null,Object? remainingLeaves = null,}) {
  return _then(_LeaveAllocationEntity(
totalLeaves: null == totalLeaves ? _self.totalLeaves : totalLeaves // ignore: cast_nullable_to_non_nullable
as double,expiredLeaves: null == expiredLeaves ? _self.expiredLeaves : expiredLeaves // ignore: cast_nullable_to_non_nullable
as int,leavesTaken: null == leavesTaken ? _self.leavesTaken : leavesTaken // ignore: cast_nullable_to_non_nullable
as double,leavesPendingApproval: null == leavesPendingApproval ? _self.leavesPendingApproval : leavesPendingApproval // ignore: cast_nullable_to_non_nullable
as double,remainingLeaves: null == remainingLeaves ? _self.remainingLeaves : remainingLeaves // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
