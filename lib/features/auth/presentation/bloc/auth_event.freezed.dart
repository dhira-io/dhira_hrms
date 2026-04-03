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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _LoginRequested value)?  loginRequested,TResult Function( _LogoutRequested value)?  logoutRequested,TResult Function( _AuthStatusChecked value)?  authStatusChecked,TResult Function( _ForgotPasswordRequested value)?  forgotPasswordRequested,TResult Function( _MicrosoftSSORequested value)?  microsoftSSORequested,TResult Function( _VerifyOtpRequested value)?  verifyOtpRequested,TResult Function( _ResendOtpRequested value)?  resendOtpRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoginRequested() when loginRequested != null:
return loginRequested(_that);case _LogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case _AuthStatusChecked() when authStatusChecked != null:
return authStatusChecked(_that);case _ForgotPasswordRequested() when forgotPasswordRequested != null:
return forgotPasswordRequested(_that);case _MicrosoftSSORequested() when microsoftSSORequested != null:
return microsoftSSORequested(_that);case _VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that);case _ResendOtpRequested() when resendOtpRequested != null:
return resendOtpRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _LoginRequested value)  loginRequested,required TResult Function( _LogoutRequested value)  logoutRequested,required TResult Function( _AuthStatusChecked value)  authStatusChecked,required TResult Function( _ForgotPasswordRequested value)  forgotPasswordRequested,required TResult Function( _MicrosoftSSORequested value)  microsoftSSORequested,required TResult Function( _VerifyOtpRequested value)  verifyOtpRequested,required TResult Function( _ResendOtpRequested value)  resendOtpRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _LoginRequested():
return loginRequested(_that);case _LogoutRequested():
return logoutRequested(_that);case _AuthStatusChecked():
return authStatusChecked(_that);case _ForgotPasswordRequested():
return forgotPasswordRequested(_that);case _MicrosoftSSORequested():
return microsoftSSORequested(_that);case _VerifyOtpRequested():
return verifyOtpRequested(_that);case _ResendOtpRequested():
return resendOtpRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _LoginRequested value)?  loginRequested,TResult? Function( _LogoutRequested value)?  logoutRequested,TResult? Function( _AuthStatusChecked value)?  authStatusChecked,TResult? Function( _ForgotPasswordRequested value)?  forgotPasswordRequested,TResult? Function( _MicrosoftSSORequested value)?  microsoftSSORequested,TResult? Function( _VerifyOtpRequested value)?  verifyOtpRequested,TResult? Function( _ResendOtpRequested value)?  resendOtpRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoginRequested() when loginRequested != null:
return loginRequested(_that);case _LogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case _AuthStatusChecked() when authStatusChecked != null:
return authStatusChecked(_that);case _ForgotPasswordRequested() when forgotPasswordRequested != null:
return forgotPasswordRequested(_that);case _MicrosoftSSORequested() when microsoftSSORequested != null:
return microsoftSSORequested(_that);case _VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that);case _ResendOtpRequested() when resendOtpRequested != null:
return resendOtpRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String email,  String password)?  loginRequested,TResult Function()?  logoutRequested,TResult Function()?  authStatusChecked,TResult Function( String email)?  forgotPasswordRequested,TResult Function()?  microsoftSSORequested,TResult Function( String email,  String otp)?  verifyOtpRequested,TResult Function( String email)?  resendOtpRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoginRequested() when loginRequested != null:
return loginRequested(_that.email,_that.password);case _LogoutRequested() when logoutRequested != null:
return logoutRequested();case _AuthStatusChecked() when authStatusChecked != null:
return authStatusChecked();case _ForgotPasswordRequested() when forgotPasswordRequested != null:
return forgotPasswordRequested(_that.email);case _MicrosoftSSORequested() when microsoftSSORequested != null:
return microsoftSSORequested();case _VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that.email,_that.otp);case _ResendOtpRequested() when resendOtpRequested != null:
return resendOtpRequested(_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String email,  String password)  loginRequested,required TResult Function()  logoutRequested,required TResult Function()  authStatusChecked,required TResult Function( String email)  forgotPasswordRequested,required TResult Function()  microsoftSSORequested,required TResult Function( String email,  String otp)  verifyOtpRequested,required TResult Function( String email)  resendOtpRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _LoginRequested():
return loginRequested(_that.email,_that.password);case _LogoutRequested():
return logoutRequested();case _AuthStatusChecked():
return authStatusChecked();case _ForgotPasswordRequested():
return forgotPasswordRequested(_that.email);case _MicrosoftSSORequested():
return microsoftSSORequested();case _VerifyOtpRequested():
return verifyOtpRequested(_that.email,_that.otp);case _ResendOtpRequested():
return resendOtpRequested(_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String email,  String password)?  loginRequested,TResult? Function()?  logoutRequested,TResult? Function()?  authStatusChecked,TResult? Function( String email)?  forgotPasswordRequested,TResult? Function()?  microsoftSSORequested,TResult? Function( String email,  String otp)?  verifyOtpRequested,TResult? Function( String email)?  resendOtpRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoginRequested() when loginRequested != null:
return loginRequested(_that.email,_that.password);case _LogoutRequested() when logoutRequested != null:
return logoutRequested();case _AuthStatusChecked() when authStatusChecked != null:
return authStatusChecked();case _ForgotPasswordRequested() when forgotPasswordRequested != null:
return forgotPasswordRequested(_that.email);case _MicrosoftSSORequested() when microsoftSSORequested != null:
return microsoftSSORequested();case _VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that.email,_that.otp);case _ResendOtpRequested() when resendOtpRequested != null:
return resendOtpRequested(_that.email);case _:
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


class _LoginRequested implements AuthEvent {
  const _LoginRequested(this.email, this.password);
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginRequestedCopyWith<_LoginRequested> get copyWith => __$LoginRequestedCopyWithImpl<_LoginRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.loginRequested(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$LoginRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$LoginRequestedCopyWith(_LoginRequested value, $Res Function(_LoginRequested) _then) = __$LoginRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class __$LoginRequestedCopyWithImpl<$Res>
    implements _$LoginRequestedCopyWith<$Res> {
  __$LoginRequestedCopyWithImpl(this._self, this._then);

  final _LoginRequested _self;
  final $Res Function(_LoginRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(_LoginRequested(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
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


class _ForgotPasswordRequested implements AuthEvent {
  const _ForgotPasswordRequested(this.email);
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForgotPasswordRequestedCopyWith<_ForgotPasswordRequested> get copyWith => __$ForgotPasswordRequestedCopyWithImpl<_ForgotPasswordRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForgotPasswordRequested&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.forgotPasswordRequested(email: $email)';
}


}

/// @nodoc
abstract mixin class _$ForgotPasswordRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$ForgotPasswordRequestedCopyWith(_ForgotPasswordRequested value, $Res Function(_ForgotPasswordRequested) _then) = __$ForgotPasswordRequestedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$ForgotPasswordRequestedCopyWithImpl<$Res>
    implements _$ForgotPasswordRequestedCopyWith<$Res> {
  __$ForgotPasswordRequestedCopyWithImpl(this._self, this._then);

  final _ForgotPasswordRequested _self;
  final $Res Function(_ForgotPasswordRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_ForgotPasswordRequested(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MicrosoftSSORequested implements AuthEvent {
  const _MicrosoftSSORequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MicrosoftSSORequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.microsoftSSORequested()';
}


}




/// @nodoc


class _VerifyOtpRequested implements AuthEvent {
  const _VerifyOtpRequested(this.email, this.otp);
  

 final  String email;
 final  String otp;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpRequestedCopyWith<_VerifyOtpRequested> get copyWith => __$VerifyOtpRequestedCopyWithImpl<_VerifyOtpRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtpRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.otp, otp) || other.otp == otp));
}


@override
int get hashCode => Object.hash(runtimeType,email,otp);

@override
String toString() {
  return 'AuthEvent.verifyOtpRequested(email: $email, otp: $otp)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$VerifyOtpRequestedCopyWith(_VerifyOtpRequested value, $Res Function(_VerifyOtpRequested) _then) = __$VerifyOtpRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String otp
});




}
/// @nodoc
class __$VerifyOtpRequestedCopyWithImpl<$Res>
    implements _$VerifyOtpRequestedCopyWith<$Res> {
  __$VerifyOtpRequestedCopyWithImpl(this._self, this._then);

  final _VerifyOtpRequested _self;
  final $Res Function(_VerifyOtpRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? otp = null,}) {
  return _then(_VerifyOtpRequested(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResendOtpRequested implements AuthEvent {
  const _ResendOtpRequested(this.email);
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResendOtpRequestedCopyWith<_ResendOtpRequested> get copyWith => __$ResendOtpRequestedCopyWithImpl<_ResendOtpRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendOtpRequested&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.resendOtpRequested(email: $email)';
}


}

/// @nodoc
abstract mixin class _$ResendOtpRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$ResendOtpRequestedCopyWith(_ResendOtpRequested value, $Res Function(_ResendOtpRequested) _then) = __$ResendOtpRequestedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$ResendOtpRequestedCopyWithImpl<$Res>
    implements _$ResendOtpRequestedCopyWith<$Res> {
  __$ResendOtpRequestedCopyWithImpl(this._self, this._then);

  final _ResendOtpRequested _self;
  final $Res Function(_ResendOtpRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_ResendOtpRequested(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
