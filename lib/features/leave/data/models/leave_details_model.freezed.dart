// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaveDetailsModel {

@JsonKey(name: 'leave_allocation') Map<String, LeaveAllocationModel> get leaveAllocation;@JsonKey(name: 'leave_approver') String get leaveApprover; List<String> get lwps;
/// Create a copy of LeaveDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveDetailsModelCopyWith<LeaveDetailsModel> get copyWith => _$LeaveDetailsModelCopyWithImpl<LeaveDetailsModel>(this as LeaveDetailsModel, _$identity);

  /// Serializes this LeaveDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveDetailsModel&&const DeepCollectionEquality().equals(other.leaveAllocation, leaveAllocation)&&(identical(other.leaveApprover, leaveApprover) || other.leaveApprover == leaveApprover)&&const DeepCollectionEquality().equals(other.lwps, lwps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(leaveAllocation),leaveApprover,const DeepCollectionEquality().hash(lwps));

@override
String toString() {
  return 'LeaveDetailsModel(leaveAllocation: $leaveAllocation, leaveApprover: $leaveApprover, lwps: $lwps)';
}


}

/// @nodoc
abstract mixin class $LeaveDetailsModelCopyWith<$Res>  {
  factory $LeaveDetailsModelCopyWith(LeaveDetailsModel value, $Res Function(LeaveDetailsModel) _then) = _$LeaveDetailsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'leave_allocation') Map<String, LeaveAllocationModel> leaveAllocation,@JsonKey(name: 'leave_approver') String leaveApprover, List<String> lwps
});




}
/// @nodoc
class _$LeaveDetailsModelCopyWithImpl<$Res>
    implements $LeaveDetailsModelCopyWith<$Res> {
  _$LeaveDetailsModelCopyWithImpl(this._self, this._then);

  final LeaveDetailsModel _self;
  final $Res Function(LeaveDetailsModel) _then;

/// Create a copy of LeaveDetailsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leaveAllocation = null,Object? leaveApprover = null,Object? lwps = null,}) {
  return _then(_self.copyWith(
leaveAllocation: null == leaveAllocation ? _self.leaveAllocation : leaveAllocation // ignore: cast_nullable_to_non_nullable
as Map<String, LeaveAllocationModel>,leaveApprover: null == leaveApprover ? _self.leaveApprover : leaveApprover // ignore: cast_nullable_to_non_nullable
as String,lwps: null == lwps ? _self.lwps : lwps // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveDetailsModel].
extension LeaveDetailsModelPatterns on LeaveDetailsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveDetailsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveDetailsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveDetailsModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaveDetailsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveDetailsModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveDetailsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'leave_allocation')  Map<String, LeaveAllocationModel> leaveAllocation, @JsonKey(name: 'leave_approver')  String leaveApprover,  List<String> lwps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveDetailsModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'leave_allocation')  Map<String, LeaveAllocationModel> leaveAllocation, @JsonKey(name: 'leave_approver')  String leaveApprover,  List<String> lwps)  $default,) {final _that = this;
switch (_that) {
case _LeaveDetailsModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'leave_allocation')  Map<String, LeaveAllocationModel> leaveAllocation, @JsonKey(name: 'leave_approver')  String leaveApprover,  List<String> lwps)?  $default,) {final _that = this;
switch (_that) {
case _LeaveDetailsModel() when $default != null:
return $default(_that.leaveAllocation,_that.leaveApprover,_that.lwps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveDetailsModel extends LeaveDetailsModel {
  const _LeaveDetailsModel({@JsonKey(name: 'leave_allocation') required final  Map<String, LeaveAllocationModel> leaveAllocation, @JsonKey(name: 'leave_approver') required this.leaveApprover, required final  List<String> lwps}): _leaveAllocation = leaveAllocation,_lwps = lwps,super._();
  factory _LeaveDetailsModel.fromJson(Map<String, dynamic> json) => _$LeaveDetailsModelFromJson(json);

 final  Map<String, LeaveAllocationModel> _leaveAllocation;
@override@JsonKey(name: 'leave_allocation') Map<String, LeaveAllocationModel> get leaveAllocation {
  if (_leaveAllocation is EqualUnmodifiableMapView) return _leaveAllocation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_leaveAllocation);
}

@override@JsonKey(name: 'leave_approver') final  String leaveApprover;
 final  List<String> _lwps;
@override List<String> get lwps {
  if (_lwps is EqualUnmodifiableListView) return _lwps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lwps);
}


/// Create a copy of LeaveDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveDetailsModelCopyWith<_LeaveDetailsModel> get copyWith => __$LeaveDetailsModelCopyWithImpl<_LeaveDetailsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveDetailsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveDetailsModel&&const DeepCollectionEquality().equals(other._leaveAllocation, _leaveAllocation)&&(identical(other.leaveApprover, leaveApprover) || other.leaveApprover == leaveApprover)&&const DeepCollectionEquality().equals(other._lwps, _lwps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_leaveAllocation),leaveApprover,const DeepCollectionEquality().hash(_lwps));

@override
String toString() {
  return 'LeaveDetailsModel(leaveAllocation: $leaveAllocation, leaveApprover: $leaveApprover, lwps: $lwps)';
}


}

/// @nodoc
abstract mixin class _$LeaveDetailsModelCopyWith<$Res> implements $LeaveDetailsModelCopyWith<$Res> {
  factory _$LeaveDetailsModelCopyWith(_LeaveDetailsModel value, $Res Function(_LeaveDetailsModel) _then) = __$LeaveDetailsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'leave_allocation') Map<String, LeaveAllocationModel> leaveAllocation,@JsonKey(name: 'leave_approver') String leaveApprover, List<String> lwps
});




}
/// @nodoc
class __$LeaveDetailsModelCopyWithImpl<$Res>
    implements _$LeaveDetailsModelCopyWith<$Res> {
  __$LeaveDetailsModelCopyWithImpl(this._self, this._then);

  final _LeaveDetailsModel _self;
  final $Res Function(_LeaveDetailsModel) _then;

/// Create a copy of LeaveDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leaveAllocation = null,Object? leaveApprover = null,Object? lwps = null,}) {
  return _then(_LeaveDetailsModel(
leaveAllocation: null == leaveAllocation ? _self._leaveAllocation : leaveAllocation // ignore: cast_nullable_to_non_nullable
as Map<String, LeaveAllocationModel>,leaveApprover: null == leaveApprover ? _self.leaveApprover : leaveApprover // ignore: cast_nullable_to_non_nullable
as String,lwps: null == lwps ? _self._lwps : lwps // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$LeaveAllocationModel {

@JsonKey(name: 'total_leaves') double get totalLeaves;@JsonKey(name: 'expired_leaves') int get expiredLeaves;@JsonKey(name: 'leaves_taken') double get leavesTaken;@JsonKey(name: 'leaves_pending_approval') double get leavesPendingApproval;@JsonKey(name: 'remaining_leaves') double get remainingLeaves;
/// Create a copy of LeaveAllocationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveAllocationModelCopyWith<LeaveAllocationModel> get copyWith => _$LeaveAllocationModelCopyWithImpl<LeaveAllocationModel>(this as LeaveAllocationModel, _$identity);

  /// Serializes this LeaveAllocationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveAllocationModel&&(identical(other.totalLeaves, totalLeaves) || other.totalLeaves == totalLeaves)&&(identical(other.expiredLeaves, expiredLeaves) || other.expiredLeaves == expiredLeaves)&&(identical(other.leavesTaken, leavesTaken) || other.leavesTaken == leavesTaken)&&(identical(other.leavesPendingApproval, leavesPendingApproval) || other.leavesPendingApproval == leavesPendingApproval)&&(identical(other.remainingLeaves, remainingLeaves) || other.remainingLeaves == remainingLeaves));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalLeaves,expiredLeaves,leavesTaken,leavesPendingApproval,remainingLeaves);

@override
String toString() {
  return 'LeaveAllocationModel(totalLeaves: $totalLeaves, expiredLeaves: $expiredLeaves, leavesTaken: $leavesTaken, leavesPendingApproval: $leavesPendingApproval, remainingLeaves: $remainingLeaves)';
}


}

/// @nodoc
abstract mixin class $LeaveAllocationModelCopyWith<$Res>  {
  factory $LeaveAllocationModelCopyWith(LeaveAllocationModel value, $Res Function(LeaveAllocationModel) _then) = _$LeaveAllocationModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_leaves') double totalLeaves,@JsonKey(name: 'expired_leaves') int expiredLeaves,@JsonKey(name: 'leaves_taken') double leavesTaken,@JsonKey(name: 'leaves_pending_approval') double leavesPendingApproval,@JsonKey(name: 'remaining_leaves') double remainingLeaves
});




}
/// @nodoc
class _$LeaveAllocationModelCopyWithImpl<$Res>
    implements $LeaveAllocationModelCopyWith<$Res> {
  _$LeaveAllocationModelCopyWithImpl(this._self, this._then);

  final LeaveAllocationModel _self;
  final $Res Function(LeaveAllocationModel) _then;

/// Create a copy of LeaveAllocationModel
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


/// Adds pattern-matching-related methods to [LeaveAllocationModel].
extension LeaveAllocationModelPatterns on LeaveAllocationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveAllocationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveAllocationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveAllocationModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaveAllocationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveAllocationModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveAllocationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_leaves')  double totalLeaves, @JsonKey(name: 'expired_leaves')  int expiredLeaves, @JsonKey(name: 'leaves_taken')  double leavesTaken, @JsonKey(name: 'leaves_pending_approval')  double leavesPendingApproval, @JsonKey(name: 'remaining_leaves')  double remainingLeaves)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveAllocationModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_leaves')  double totalLeaves, @JsonKey(name: 'expired_leaves')  int expiredLeaves, @JsonKey(name: 'leaves_taken')  double leavesTaken, @JsonKey(name: 'leaves_pending_approval')  double leavesPendingApproval, @JsonKey(name: 'remaining_leaves')  double remainingLeaves)  $default,) {final _that = this;
switch (_that) {
case _LeaveAllocationModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_leaves')  double totalLeaves, @JsonKey(name: 'expired_leaves')  int expiredLeaves, @JsonKey(name: 'leaves_taken')  double leavesTaken, @JsonKey(name: 'leaves_pending_approval')  double leavesPendingApproval, @JsonKey(name: 'remaining_leaves')  double remainingLeaves)?  $default,) {final _that = this;
switch (_that) {
case _LeaveAllocationModel() when $default != null:
return $default(_that.totalLeaves,_that.expiredLeaves,_that.leavesTaken,_that.leavesPendingApproval,_that.remainingLeaves);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveAllocationModel extends LeaveAllocationModel {
  const _LeaveAllocationModel({@JsonKey(name: 'total_leaves') required this.totalLeaves, @JsonKey(name: 'expired_leaves') required this.expiredLeaves, @JsonKey(name: 'leaves_taken') required this.leavesTaken, @JsonKey(name: 'leaves_pending_approval') required this.leavesPendingApproval, @JsonKey(name: 'remaining_leaves') required this.remainingLeaves}): super._();
  factory _LeaveAllocationModel.fromJson(Map<String, dynamic> json) => _$LeaveAllocationModelFromJson(json);

@override@JsonKey(name: 'total_leaves') final  double totalLeaves;
@override@JsonKey(name: 'expired_leaves') final  int expiredLeaves;
@override@JsonKey(name: 'leaves_taken') final  double leavesTaken;
@override@JsonKey(name: 'leaves_pending_approval') final  double leavesPendingApproval;
@override@JsonKey(name: 'remaining_leaves') final  double remainingLeaves;

/// Create a copy of LeaveAllocationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveAllocationModelCopyWith<_LeaveAllocationModel> get copyWith => __$LeaveAllocationModelCopyWithImpl<_LeaveAllocationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveAllocationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveAllocationModel&&(identical(other.totalLeaves, totalLeaves) || other.totalLeaves == totalLeaves)&&(identical(other.expiredLeaves, expiredLeaves) || other.expiredLeaves == expiredLeaves)&&(identical(other.leavesTaken, leavesTaken) || other.leavesTaken == leavesTaken)&&(identical(other.leavesPendingApproval, leavesPendingApproval) || other.leavesPendingApproval == leavesPendingApproval)&&(identical(other.remainingLeaves, remainingLeaves) || other.remainingLeaves == remainingLeaves));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalLeaves,expiredLeaves,leavesTaken,leavesPendingApproval,remainingLeaves);

@override
String toString() {
  return 'LeaveAllocationModel(totalLeaves: $totalLeaves, expiredLeaves: $expiredLeaves, leavesTaken: $leavesTaken, leavesPendingApproval: $leavesPendingApproval, remainingLeaves: $remainingLeaves)';
}


}

/// @nodoc
abstract mixin class _$LeaveAllocationModelCopyWith<$Res> implements $LeaveAllocationModelCopyWith<$Res> {
  factory _$LeaveAllocationModelCopyWith(_LeaveAllocationModel value, $Res Function(_LeaveAllocationModel) _then) = __$LeaveAllocationModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_leaves') double totalLeaves,@JsonKey(name: 'expired_leaves') int expiredLeaves,@JsonKey(name: 'leaves_taken') double leavesTaken,@JsonKey(name: 'leaves_pending_approval') double leavesPendingApproval,@JsonKey(name: 'remaining_leaves') double remainingLeaves
});




}
/// @nodoc
class __$LeaveAllocationModelCopyWithImpl<$Res>
    implements _$LeaveAllocationModelCopyWith<$Res> {
  __$LeaveAllocationModelCopyWithImpl(this._self, this._then);

  final _LeaveAllocationModel _self;
  final $Res Function(_LeaveAllocationModel) _then;

/// Create a copy of LeaveAllocationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalLeaves = null,Object? expiredLeaves = null,Object? leavesTaken = null,Object? leavesPendingApproval = null,Object? remainingLeaves = null,}) {
  return _then(_LeaveAllocationModel(
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
