// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _AuthStatusChecked value)?  authStatusChecked,TResult Function( _LogoutRequested value)?  logoutRequested,TResult Function( _LoggedIn value)?  loggedIn,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _AuthStatusChecked() when authStatusChecked != null:
return authStatusChecked(_that);case _LogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case _LoggedIn() when loggedIn != null:
return loggedIn(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _AuthStatusChecked value)  authStatusChecked,required TResult Function( _LogoutRequested value)  logoutRequested,required TResult Function( _LoggedIn value)  loggedIn,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _AuthStatusChecked():
return authStatusChecked(_that);case _LogoutRequested():
return logoutRequested(_that);case _LoggedIn():
return loggedIn(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _AuthStatusChecked value)?  authStatusChecked,TResult? Function( _LogoutRequested value)?  logoutRequested,TResult? Function( _LoggedIn value)?  loggedIn,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _AuthStatusChecked() when authStatusChecked != null:
return authStatusChecked(_that);case _LogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case _LoggedIn() when loggedIn != null:
return loggedIn(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  authStatusChecked,TResult Function()?  logoutRequested,TResult Function( UserEntity user)?  loggedIn,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _AuthStatusChecked() when authStatusChecked != null:
return authStatusChecked();case _LogoutRequested() when logoutRequested != null:
return logoutRequested();case _LoggedIn() when loggedIn != null:
return loggedIn(_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  authStatusChecked,required TResult Function()  logoutRequested,required TResult Function( UserEntity user)  loggedIn,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _AuthStatusChecked():
return authStatusChecked();case _LogoutRequested():
return logoutRequested();case _LoggedIn():
return loggedIn(_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  authStatusChecked,TResult? Function()?  logoutRequested,TResult? Function( UserEntity user)?  loggedIn,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _AuthStatusChecked() when authStatusChecked != null:
return authStatusChecked();case _LogoutRequested() when logoutRequested != null:
return logoutRequested();case _LoggedIn() when loggedIn != null:
return loggedIn(_that.user);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements AuthEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.started()';
}


}




/// @nodoc


class _AuthStatusChecked implements AuthEvent {
  const _AuthStatusChecked();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthStatusChecked);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.authStatusChecked()';
}


}




/// @nodoc


class _LogoutRequested implements AuthEvent {
  const _LogoutRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogoutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.logoutRequested()';
}


}




/// @nodoc


class _LoggedIn implements AuthEvent {
  const _LoggedIn(this.user);
  

 final  UserEntity user;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoggedInCopyWith<_LoggedIn> get copyWith => __$LoggedInCopyWithImpl<_LoggedIn>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoggedIn&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthEvent.loggedIn(user: $user)';
}


}

/// @nodoc
abstract mixin class _$LoggedInCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$LoggedInCopyWith(_LoggedIn value, $Res Function(_LoggedIn) _then) = __$LoggedInCopyWithImpl;
@useResult
$Res call({
 UserEntity user
});


$UserEntityCopyWith<$Res> get user;

}
/// @nodoc
class __$LoggedInCopyWithImpl<$Res>
    implements _$LoggedInCopyWith<$Res> {
  __$LoggedInCopyWithImpl(this._self, this._then);

  final _LoggedIn _self;
  final $Res Function(_LoggedIn) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_LoggedIn(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity,
  ));
}

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res> get user {
  
  return $UserEntityCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
