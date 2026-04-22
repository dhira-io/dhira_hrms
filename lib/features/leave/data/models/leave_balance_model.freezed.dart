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

@JsonKey(name: 'total_leaves') num get totalAllocated;@JsonKey(name: 'leaves_taken') num get used;@JsonKey(name: 'leaves_pending_approval') num get pending; num get approved; num get rejected; num get applied; List<DetailedBalanceModel> get details;
/// Create a copy of LeaveBalanceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveBalanceModelCopyWith<LeaveBalanceModel> get copyWith => _$LeaveBalanceModelCopyWithImpl<LeaveBalanceModel>(this as LeaveBalanceModel, _$identity);

  /// Serializes this LeaveBalanceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveBalanceModel&&(identical(other.totalAllocated, totalAllocated) || other.totalAllocated == totalAllocated)&&(identical(other.used, used) || other.used == used)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.applied, applied) || other.applied == applied)&&const DeepCollectionEquality().equals(other.details, details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalAllocated,used,pending,approved,rejected,applied,const DeepCollectionEquality().hash(details));

@override
String toString() {
  return 'LeaveBalanceModel(totalAllocated: $totalAllocated, used: $used, pending: $pending, approved: $approved, rejected: $rejected, applied: $applied, details: $details)';
}


}

/// @nodoc
abstract mixin class $LeaveBalanceModelCopyWith<$Res>  {
  factory $LeaveBalanceModelCopyWith(LeaveBalanceModel value, $Res Function(LeaveBalanceModel) _then) = _$LeaveBalanceModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_leaves') num totalAllocated,@JsonKey(name: 'leaves_taken') num used,@JsonKey(name: 'leaves_pending_approval') num pending, num approved, num rejected, num applied, List<DetailedBalanceModel> details
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
@pragma('vm:prefer-inline') @override $Res call({Object? totalAllocated = null,Object? used = null,Object? pending = null,Object? approved = null,Object? rejected = null,Object? applied = null,Object? details = null,}) {
  return _then(_self.copyWith(
totalAllocated: null == totalAllocated ? _self.totalAllocated : totalAllocated // ignore: cast_nullable_to_non_nullable
as num,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as num,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as num,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as num,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as num,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as num,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as List<DetailedBalanceModel>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_leaves')  num totalAllocated, @JsonKey(name: 'leaves_taken')  num used, @JsonKey(name: 'leaves_pending_approval')  num pending,  num approved,  num rejected,  num applied,  List<DetailedBalanceModel> details)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveBalanceModel() when $default != null:
return $default(_that.totalAllocated,_that.used,_that.pending,_that.approved,_that.rejected,_that.applied,_that.details);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_leaves')  num totalAllocated, @JsonKey(name: 'leaves_taken')  num used, @JsonKey(name: 'leaves_pending_approval')  num pending,  num approved,  num rejected,  num applied,  List<DetailedBalanceModel> details)  $default,) {final _that = this;
switch (_that) {
case _LeaveBalanceModel():
return $default(_that.totalAllocated,_that.used,_that.pending,_that.approved,_that.rejected,_that.applied,_that.details);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_leaves')  num totalAllocated, @JsonKey(name: 'leaves_taken')  num used, @JsonKey(name: 'leaves_pending_approval')  num pending,  num approved,  num rejected,  num applied,  List<DetailedBalanceModel> details)?  $default,) {final _that = this;
switch (_that) {
case _LeaveBalanceModel() when $default != null:
return $default(_that.totalAllocated,_that.used,_that.pending,_that.approved,_that.rejected,_that.applied,_that.details);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveBalanceModel extends LeaveBalanceModel {
  const _LeaveBalanceModel({@JsonKey(name: 'total_leaves') required this.totalAllocated, @JsonKey(name: 'leaves_taken') required this.used, @JsonKey(name: 'leaves_pending_approval') required this.pending, this.approved = 0, this.rejected = 0, this.applied = 0, final  List<DetailedBalanceModel> details = const []}): _details = details,super._();
  factory _LeaveBalanceModel.fromJson(Map<String, dynamic> json) => _$LeaveBalanceModelFromJson(json);

@override@JsonKey(name: 'total_leaves') final  num totalAllocated;
@override@JsonKey(name: 'leaves_taken') final  num used;
@override@JsonKey(name: 'leaves_pending_approval') final  num pending;
@override@JsonKey() final  num approved;
@override@JsonKey() final  num rejected;
@override@JsonKey() final  num applied;
 final  List<DetailedBalanceModel> _details;
@override@JsonKey() List<DetailedBalanceModel> get details {
  if (_details is EqualUnmodifiableListView) return _details;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_details);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveBalanceModel&&(identical(other.totalAllocated, totalAllocated) || other.totalAllocated == totalAllocated)&&(identical(other.used, used) || other.used == used)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.applied, applied) || other.applied == applied)&&const DeepCollectionEquality().equals(other._details, _details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalAllocated,used,pending,approved,rejected,applied,const DeepCollectionEquality().hash(_details));

@override
String toString() {
  return 'LeaveBalanceModel(totalAllocated: $totalAllocated, used: $used, pending: $pending, approved: $approved, rejected: $rejected, applied: $applied, details: $details)';
}


}

/// @nodoc
abstract mixin class _$LeaveBalanceModelCopyWith<$Res> implements $LeaveBalanceModelCopyWith<$Res> {
  factory _$LeaveBalanceModelCopyWith(_LeaveBalanceModel value, $Res Function(_LeaveBalanceModel) _then) = __$LeaveBalanceModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_leaves') num totalAllocated,@JsonKey(name: 'leaves_taken') num used,@JsonKey(name: 'leaves_pending_approval') num pending, num approved, num rejected, num applied, List<DetailedBalanceModel> details
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
@override @pragma('vm:prefer-inline') $Res call({Object? totalAllocated = null,Object? used = null,Object? pending = null,Object? approved = null,Object? rejected = null,Object? applied = null,Object? details = null,}) {
  return _then(_LeaveBalanceModel(
totalAllocated: null == totalAllocated ? _self.totalAllocated : totalAllocated // ignore: cast_nullable_to_non_nullable
as num,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as num,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as num,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as num,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as num,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as num,details: null == details ? _self._details : details // ignore: cast_nullable_to_non_nullable
as List<DetailedBalanceModel>,
  ));
}


}


/// @nodoc
mixin _$DetailedBalanceModel {

 String get leaveType; double get allocated; double get used; double get pending;
/// Create a copy of DetailedBalanceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailedBalanceModelCopyWith<DetailedBalanceModel> get copyWith => _$DetailedBalanceModelCopyWithImpl<DetailedBalanceModel>(this as DetailedBalanceModel, _$identity);

  /// Serializes this DetailedBalanceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailedBalanceModel&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.allocated, allocated) || other.allocated == allocated)&&(identical(other.used, used) || other.used == used)&&(identical(other.pending, pending) || other.pending == pending));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leaveType,allocated,used,pending);

@override
String toString() {
  return 'DetailedBalanceModel(leaveType: $leaveType, allocated: $allocated, used: $used, pending: $pending)';
}


}

/// @nodoc
abstract mixin class $DetailedBalanceModelCopyWith<$Res>  {
  factory $DetailedBalanceModelCopyWith(DetailedBalanceModel value, $Res Function(DetailedBalanceModel) _then) = _$DetailedBalanceModelCopyWithImpl;
@useResult
$Res call({
 String leaveType, double allocated, double used, double pending
});




}
/// @nodoc
class _$DetailedBalanceModelCopyWithImpl<$Res>
    implements $DetailedBalanceModelCopyWith<$Res> {
  _$DetailedBalanceModelCopyWithImpl(this._self, this._then);

  final DetailedBalanceModel _self;
  final $Res Function(DetailedBalanceModel) _then;

/// Create a copy of DetailedBalanceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leaveType = null,Object? allocated = null,Object? used = null,Object? pending = null,}) {
  return _then(_self.copyWith(
leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,allocated: null == allocated ? _self.allocated : allocated // ignore: cast_nullable_to_non_nullable
as double,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as double,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DetailedBalanceModel].
extension DetailedBalanceModelPatterns on DetailedBalanceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DetailedBalanceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DetailedBalanceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DetailedBalanceModel value)  $default,){
final _that = this;
switch (_that) {
case _DetailedBalanceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DetailedBalanceModel value)?  $default,){
final _that = this;
switch (_that) {
case _DetailedBalanceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String leaveType,  double allocated,  double used,  double pending)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetailedBalanceModel() when $default != null:
return $default(_that.leaveType,_that.allocated,_that.used,_that.pending);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String leaveType,  double allocated,  double used,  double pending)  $default,) {final _that = this;
switch (_that) {
case _DetailedBalanceModel():
return $default(_that.leaveType,_that.allocated,_that.used,_that.pending);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String leaveType,  double allocated,  double used,  double pending)?  $default,) {final _that = this;
switch (_that) {
case _DetailedBalanceModel() when $default != null:
return $default(_that.leaveType,_that.allocated,_that.used,_that.pending);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DetailedBalanceModel extends DetailedBalanceModel {
  const _DetailedBalanceModel({required this.leaveType, required this.allocated, required this.used, required this.pending}): super._();
  factory _DetailedBalanceModel.fromJson(Map<String, dynamic> json) => _$DetailedBalanceModelFromJson(json);

@override final  String leaveType;
@override final  double allocated;
@override final  double used;
@override final  double pending;

/// Create a copy of DetailedBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailedBalanceModelCopyWith<_DetailedBalanceModel> get copyWith => __$DetailedBalanceModelCopyWithImpl<_DetailedBalanceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DetailedBalanceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailedBalanceModel&&(identical(other.leaveType, leaveType) || other.leaveType == leaveType)&&(identical(other.allocated, allocated) || other.allocated == allocated)&&(identical(other.used, used) || other.used == used)&&(identical(other.pending, pending) || other.pending == pending));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leaveType,allocated,used,pending);

@override
String toString() {
  return 'DetailedBalanceModel(leaveType: $leaveType, allocated: $allocated, used: $used, pending: $pending)';
}


}

/// @nodoc
abstract mixin class _$DetailedBalanceModelCopyWith<$Res> implements $DetailedBalanceModelCopyWith<$Res> {
  factory _$DetailedBalanceModelCopyWith(_DetailedBalanceModel value, $Res Function(_DetailedBalanceModel) _then) = __$DetailedBalanceModelCopyWithImpl;
@override @useResult
$Res call({
 String leaveType, double allocated, double used, double pending
});




}
/// @nodoc
class __$DetailedBalanceModelCopyWithImpl<$Res>
    implements _$DetailedBalanceModelCopyWith<$Res> {
  __$DetailedBalanceModelCopyWithImpl(this._self, this._then);

  final _DetailedBalanceModel _self;
  final $Res Function(_DetailedBalanceModel) _then;

/// Create a copy of DetailedBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leaveType = null,Object? allocated = null,Object? used = null,Object? pending = null,}) {
  return _then(_DetailedBalanceModel(
leaveType: null == leaveType ? _self.leaveType : leaveType // ignore: cast_nullable_to_non_nullable
as String,allocated: null == allocated ? _self.allocated : allocated // ignore: cast_nullable_to_non_nullable
as double,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as double,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
