// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent()';
}


}

/// @nodoc
class $ProfileEventCopyWith<$Res>  {
$ProfileEventCopyWith(ProfileEvent _, $Res Function(ProfileEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileEvent].
extension ProfileEventPatterns on ProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _AvatarUpdateRequested value)?  avatarUpdateRequested,TResult Function( _PasswordChangeRequested value)?  passwordChangeRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _AvatarUpdateRequested() when avatarUpdateRequested != null:
return avatarUpdateRequested(_that);case _PasswordChangeRequested() when passwordChangeRequested != null:
return passwordChangeRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _AvatarUpdateRequested value)  avatarUpdateRequested,required TResult Function( _PasswordChangeRequested value)  passwordChangeRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _AvatarUpdateRequested():
return avatarUpdateRequested(_that);case _PasswordChangeRequested():
return passwordChangeRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _AvatarUpdateRequested value)?  avatarUpdateRequested,TResult? Function( _PasswordChangeRequested value)?  passwordChangeRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _AvatarUpdateRequested() when avatarUpdateRequested != null:
return avatarUpdateRequested(_that);case _PasswordChangeRequested() when passwordChangeRequested != null:
return passwordChangeRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String filePath)?  avatarUpdateRequested,TResult Function( String oldPassword,  String newPassword,  String logoutAllSessions)?  passwordChangeRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _AvatarUpdateRequested() when avatarUpdateRequested != null:
return avatarUpdateRequested(_that.filePath);case _PasswordChangeRequested() when passwordChangeRequested != null:
return passwordChangeRequested(_that.oldPassword,_that.newPassword,_that.logoutAllSessions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String filePath)  avatarUpdateRequested,required TResult Function( String oldPassword,  String newPassword,  String logoutAllSessions)  passwordChangeRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _AvatarUpdateRequested():
return avatarUpdateRequested(_that.filePath);case _PasswordChangeRequested():
return passwordChangeRequested(_that.oldPassword,_that.newPassword,_that.logoutAllSessions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String filePath)?  avatarUpdateRequested,TResult? Function( String oldPassword,  String newPassword,  String logoutAllSessions)?  passwordChangeRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _AvatarUpdateRequested() when avatarUpdateRequested != null:
return avatarUpdateRequested(_that.filePath);case _PasswordChangeRequested() when passwordChangeRequested != null:
return passwordChangeRequested(_that.oldPassword,_that.newPassword,_that.logoutAllSessions);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements ProfileEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.started()';
}


}




/// @nodoc


class _AvatarUpdateRequested implements ProfileEvent {
  const _AvatarUpdateRequested({required this.filePath});
  

 final  String filePath;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvatarUpdateRequestedCopyWith<_AvatarUpdateRequested> get copyWith => __$AvatarUpdateRequestedCopyWithImpl<_AvatarUpdateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvatarUpdateRequested&&(identical(other.filePath, filePath) || other.filePath == filePath));
}


@override
int get hashCode => Object.hash(runtimeType,filePath);

@override
String toString() {
  return 'ProfileEvent.avatarUpdateRequested(filePath: $filePath)';
}


}

/// @nodoc
abstract mixin class _$AvatarUpdateRequestedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory _$AvatarUpdateRequestedCopyWith(_AvatarUpdateRequested value, $Res Function(_AvatarUpdateRequested) _then) = __$AvatarUpdateRequestedCopyWithImpl;
@useResult
$Res call({
 String filePath
});




}
/// @nodoc
class __$AvatarUpdateRequestedCopyWithImpl<$Res>
    implements _$AvatarUpdateRequestedCopyWith<$Res> {
  __$AvatarUpdateRequestedCopyWithImpl(this._self, this._then);

  final _AvatarUpdateRequested _self;
  final $Res Function(_AvatarUpdateRequested) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filePath = null,}) {
  return _then(_AvatarUpdateRequested(
filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PasswordChangeRequested implements ProfileEvent {
  const _PasswordChangeRequested({required this.oldPassword, required this.newPassword, required this.logoutAllSessions});
  

 final  String oldPassword;
 final  String newPassword;
 final  String logoutAllSessions;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PasswordChangeRequestedCopyWith<_PasswordChangeRequested> get copyWith => __$PasswordChangeRequestedCopyWithImpl<_PasswordChangeRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordChangeRequested&&(identical(other.oldPassword, oldPassword) || other.oldPassword == oldPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.logoutAllSessions, logoutAllSessions) || other.logoutAllSessions == logoutAllSessions));
}


@override
int get hashCode => Object.hash(runtimeType,oldPassword,newPassword,logoutAllSessions);

@override
String toString() {
  return 'ProfileEvent.passwordChangeRequested(oldPassword: $oldPassword, newPassword: $newPassword, logoutAllSessions: $logoutAllSessions)';
}


}

/// @nodoc
abstract mixin class _$PasswordChangeRequestedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory _$PasswordChangeRequestedCopyWith(_PasswordChangeRequested value, $Res Function(_PasswordChangeRequested) _then) = __$PasswordChangeRequestedCopyWithImpl;
@useResult
$Res call({
 String oldPassword, String newPassword, String logoutAllSessions
});




}
/// @nodoc
class __$PasswordChangeRequestedCopyWithImpl<$Res>
    implements _$PasswordChangeRequestedCopyWith<$Res> {
  __$PasswordChangeRequestedCopyWithImpl(this._self, this._then);

  final _PasswordChangeRequested _self;
  final $Res Function(_PasswordChangeRequested) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldPassword = null,Object? newPassword = null,Object? logoutAllSessions = null,}) {
  return _then(_PasswordChangeRequested(
oldPassword: null == oldPassword ? _self.oldPassword : oldPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,logoutAllSessions: null == logoutAllSessions ? _self.logoutAllSessions : logoutAllSessions // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
