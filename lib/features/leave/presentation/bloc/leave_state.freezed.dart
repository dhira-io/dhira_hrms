// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LeaveState {

 List<LeaveTypeEntity> get leaveTypes; LeaveBalanceEntity get balance; bool get isLoading; String get currentEmpId; String get userEmail; String? get errorMessage; bool get success;
/// Create a copy of LeaveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveStateCopyWith<LeaveState> get copyWith => _$LeaveStateCopyWithImpl<LeaveState>(this as LeaveState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveState&&const DeepCollectionEquality().equals(other.leaveTypes, leaveTypes)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.currentEmpId, currentEmpId) || other.currentEmpId == currentEmpId)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.success, success) || other.success == success));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(leaveTypes),balance,isLoading,currentEmpId,userEmail,errorMessage,success);

@override
String toString() {
  return 'LeaveState(leaveTypes: $leaveTypes, balance: $balance, isLoading: $isLoading, currentEmpId: $currentEmpId, userEmail: $userEmail, errorMessage: $errorMessage, success: $success)';
}


}

/// @nodoc
abstract mixin class $LeaveStateCopyWith<$Res>  {
  factory $LeaveStateCopyWith(LeaveState value, $Res Function(LeaveState) _then) = _$LeaveStateCopyWithImpl;
@useResult
$Res call({
 List<LeaveTypeEntity> leaveTypes, LeaveBalanceEntity balance, bool isLoading, String currentEmpId, String userEmail, String? errorMessage, bool success
});


$LeaveBalanceEntityCopyWith<$Res> get balance;

}
/// @nodoc
class _$LeaveStateCopyWithImpl<$Res>
    implements $LeaveStateCopyWith<$Res> {
  _$LeaveStateCopyWithImpl(this._self, this._then);

  final LeaveState _self;
  final $Res Function(LeaveState) _then;

/// Create a copy of LeaveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leaveTypes = null,Object? balance = null,Object? isLoading = null,Object? currentEmpId = null,Object? userEmail = null,Object? errorMessage = freezed,Object? success = null,}) {
  return _then(_self.copyWith(
leaveTypes: null == leaveTypes ? _self.leaveTypes : leaveTypes // ignore: cast_nullable_to_non_nullable
as List<LeaveTypeEntity>,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as LeaveBalanceEntity,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,currentEmpId: null == currentEmpId ? _self.currentEmpId : currentEmpId // ignore: cast_nullable_to_non_nullable
as String,userEmail: null == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of LeaveState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveBalanceEntityCopyWith<$Res> get balance {
  
  return $LeaveBalanceEntityCopyWith<$Res>(_self.balance, (value) {
    return _then(_self.copyWith(balance: value));
  });
}
}


/// Adds pattern-matching-related methods to [LeaveState].
extension LeaveStatePatterns on LeaveState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveState value)  $default,){
final _that = this;
switch (_that) {
case _LeaveState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveState value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LeaveTypeEntity> leaveTypes,  LeaveBalanceEntity balance,  bool isLoading,  String currentEmpId,  String userEmail,  String? errorMessage,  bool success)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveState() when $default != null:
return $default(_that.leaveTypes,_that.balance,_that.isLoading,_that.currentEmpId,_that.userEmail,_that.errorMessage,_that.success);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LeaveTypeEntity> leaveTypes,  LeaveBalanceEntity balance,  bool isLoading,  String currentEmpId,  String userEmail,  String? errorMessage,  bool success)  $default,) {final _that = this;
switch (_that) {
case _LeaveState():
return $default(_that.leaveTypes,_that.balance,_that.isLoading,_that.currentEmpId,_that.userEmail,_that.errorMessage,_that.success);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LeaveTypeEntity> leaveTypes,  LeaveBalanceEntity balance,  bool isLoading,  String currentEmpId,  String userEmail,  String? errorMessage,  bool success)?  $default,) {final _that = this;
switch (_that) {
case _LeaveState() when $default != null:
return $default(_that.leaveTypes,_that.balance,_that.isLoading,_that.currentEmpId,_that.userEmail,_that.errorMessage,_that.success);case _:
  return null;

}
}

}

/// @nodoc


class _LeaveState extends LeaveState {
  const _LeaveState({final  List<LeaveTypeEntity> leaveTypes = const [], this.balance = const LeaveBalanceEntity(totalAllocated: 0, used: 0, pending: 0, approved: 0, rejected: 0, applied: 0, available: 0), this.isLoading = false, this.currentEmpId = '', this.userEmail = '', this.errorMessage, this.success = false}): _leaveTypes = leaveTypes,super._();
  

 final  List<LeaveTypeEntity> _leaveTypes;
@override@JsonKey() List<LeaveTypeEntity> get leaveTypes {
  if (_leaveTypes is EqualUnmodifiableListView) return _leaveTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_leaveTypes);
}

@override@JsonKey() final  LeaveBalanceEntity balance;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  String currentEmpId;
@override@JsonKey() final  String userEmail;
@override final  String? errorMessage;
@override@JsonKey() final  bool success;

/// Create a copy of LeaveState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveStateCopyWith<_LeaveState> get copyWith => __$LeaveStateCopyWithImpl<_LeaveState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveState&&const DeepCollectionEquality().equals(other._leaveTypes, _leaveTypes)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.currentEmpId, currentEmpId) || other.currentEmpId == currentEmpId)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.success, success) || other.success == success));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_leaveTypes),balance,isLoading,currentEmpId,userEmail,errorMessage,success);

@override
String toString() {
  return 'LeaveState(leaveTypes: $leaveTypes, balance: $balance, isLoading: $isLoading, currentEmpId: $currentEmpId, userEmail: $userEmail, errorMessage: $errorMessage, success: $success)';
}


}

/// @nodoc
abstract mixin class _$LeaveStateCopyWith<$Res> implements $LeaveStateCopyWith<$Res> {
  factory _$LeaveStateCopyWith(_LeaveState value, $Res Function(_LeaveState) _then) = __$LeaveStateCopyWithImpl;
@override @useResult
$Res call({
 List<LeaveTypeEntity> leaveTypes, LeaveBalanceEntity balance, bool isLoading, String currentEmpId, String userEmail, String? errorMessage, bool success
});


@override $LeaveBalanceEntityCopyWith<$Res> get balance;

}
/// @nodoc
class __$LeaveStateCopyWithImpl<$Res>
    implements _$LeaveStateCopyWith<$Res> {
  __$LeaveStateCopyWithImpl(this._self, this._then);

  final _LeaveState _self;
  final $Res Function(_LeaveState) _then;

/// Create a copy of LeaveState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leaveTypes = null,Object? balance = null,Object? isLoading = null,Object? currentEmpId = null,Object? userEmail = null,Object? errorMessage = freezed,Object? success = null,}) {
  return _then(_LeaveState(
leaveTypes: null == leaveTypes ? _self._leaveTypes : leaveTypes // ignore: cast_nullable_to_non_nullable
as List<LeaveTypeEntity>,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as LeaveBalanceEntity,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,currentEmpId: null == currentEmpId ? _self.currentEmpId : currentEmpId // ignore: cast_nullable_to_non_nullable
as String,userEmail: null == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LeaveState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveBalanceEntityCopyWith<$Res> get balance {
  
  return $LeaveBalanceEntityCopyWith<$Res>(_self.balance, (value) {
    return _then(_self.copyWith(balance: value));
  });
}
}

// dart format on
