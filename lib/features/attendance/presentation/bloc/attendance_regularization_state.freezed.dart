// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_regularization_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegularizationFormData {

 DateTime? get date; RegularizationRequestType get requestType; TimeOfDay? get inTime; TimeOfDay? get outTime; bool get routeToHR; String get reason; String? get selectedFileName; String? get uploadedFileUrl;
/// Create a copy of RegularizationFormData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegularizationFormDataCopyWith<RegularizationFormData> get copyWith => _$RegularizationFormDataCopyWithImpl<RegularizationFormData>(this as RegularizationFormData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegularizationFormData&&(identical(other.date, date) || other.date == date)&&(identical(other.requestType, requestType) || other.requestType == requestType)&&(identical(other.inTime, inTime) || other.inTime == inTime)&&(identical(other.outTime, outTime) || other.outTime == outTime)&&(identical(other.routeToHR, routeToHR) || other.routeToHR == routeToHR)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.selectedFileName, selectedFileName) || other.selectedFileName == selectedFileName)&&(identical(other.uploadedFileUrl, uploadedFileUrl) || other.uploadedFileUrl == uploadedFileUrl));
}


@override
int get hashCode => Object.hash(runtimeType,date,requestType,inTime,outTime,routeToHR,reason,selectedFileName,uploadedFileUrl);

@override
String toString() {
  return 'RegularizationFormData(date: $date, requestType: $requestType, inTime: $inTime, outTime: $outTime, routeToHR: $routeToHR, reason: $reason, selectedFileName: $selectedFileName, uploadedFileUrl: $uploadedFileUrl)';
}


}

/// @nodoc
abstract mixin class $RegularizationFormDataCopyWith<$Res>  {
  factory $RegularizationFormDataCopyWith(RegularizationFormData value, $Res Function(RegularizationFormData) _then) = _$RegularizationFormDataCopyWithImpl;
@useResult
$Res call({
 DateTime? date, RegularizationRequestType requestType, TimeOfDay? inTime, TimeOfDay? outTime, bool routeToHR, String reason, String? selectedFileName, String? uploadedFileUrl
});




}
/// @nodoc
class _$RegularizationFormDataCopyWithImpl<$Res>
    implements $RegularizationFormDataCopyWith<$Res> {
  _$RegularizationFormDataCopyWithImpl(this._self, this._then);

  final RegularizationFormData _self;
  final $Res Function(RegularizationFormData) _then;

/// Create a copy of RegularizationFormData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? requestType = null,Object? inTime = freezed,Object? outTime = freezed,Object? routeToHR = null,Object? reason = null,Object? selectedFileName = freezed,Object? uploadedFileUrl = freezed,}) {
  return _then(_self.copyWith(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,requestType: null == requestType ? _self.requestType : requestType // ignore: cast_nullable_to_non_nullable
as RegularizationRequestType,inTime: freezed == inTime ? _self.inTime : inTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,outTime: freezed == outTime ? _self.outTime : outTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,routeToHR: null == routeToHR ? _self.routeToHR : routeToHR // ignore: cast_nullable_to_non_nullable
as bool,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,selectedFileName: freezed == selectedFileName ? _self.selectedFileName : selectedFileName // ignore: cast_nullable_to_non_nullable
as String?,uploadedFileUrl: freezed == uploadedFileUrl ? _self.uploadedFileUrl : uploadedFileUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegularizationFormData].
extension RegularizationFormDataPatterns on RegularizationFormData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegularizationFormData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegularizationFormData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegularizationFormData value)  $default,){
final _that = this;
switch (_that) {
case _RegularizationFormData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegularizationFormData value)?  $default,){
final _that = this;
switch (_that) {
case _RegularizationFormData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? date,  RegularizationRequestType requestType,  TimeOfDay? inTime,  TimeOfDay? outTime,  bool routeToHR,  String reason,  String? selectedFileName,  String? uploadedFileUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegularizationFormData() when $default != null:
return $default(_that.date,_that.requestType,_that.inTime,_that.outTime,_that.routeToHR,_that.reason,_that.selectedFileName,_that.uploadedFileUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? date,  RegularizationRequestType requestType,  TimeOfDay? inTime,  TimeOfDay? outTime,  bool routeToHR,  String reason,  String? selectedFileName,  String? uploadedFileUrl)  $default,) {final _that = this;
switch (_that) {
case _RegularizationFormData():
return $default(_that.date,_that.requestType,_that.inTime,_that.outTime,_that.routeToHR,_that.reason,_that.selectedFileName,_that.uploadedFileUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? date,  RegularizationRequestType requestType,  TimeOfDay? inTime,  TimeOfDay? outTime,  bool routeToHR,  String reason,  String? selectedFileName,  String? uploadedFileUrl)?  $default,) {final _that = this;
switch (_that) {
case _RegularizationFormData() when $default != null:
return $default(_that.date,_that.requestType,_that.inTime,_that.outTime,_that.routeToHR,_that.reason,_that.selectedFileName,_that.uploadedFileUrl);case _:
  return null;

}
}

}

/// @nodoc


class _RegularizationFormData extends RegularizationFormData {
  const _RegularizationFormData({this.date, this.requestType = RegularizationRequestType.missedPunch, this.inTime, this.outTime, this.routeToHR = false, this.reason = '', this.selectedFileName, this.uploadedFileUrl}): super._();
  

@override final  DateTime? date;
@override@JsonKey() final  RegularizationRequestType requestType;
@override final  TimeOfDay? inTime;
@override final  TimeOfDay? outTime;
@override@JsonKey() final  bool routeToHR;
@override@JsonKey() final  String reason;
@override final  String? selectedFileName;
@override final  String? uploadedFileUrl;

/// Create a copy of RegularizationFormData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegularizationFormDataCopyWith<_RegularizationFormData> get copyWith => __$RegularizationFormDataCopyWithImpl<_RegularizationFormData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegularizationFormData&&(identical(other.date, date) || other.date == date)&&(identical(other.requestType, requestType) || other.requestType == requestType)&&(identical(other.inTime, inTime) || other.inTime == inTime)&&(identical(other.outTime, outTime) || other.outTime == outTime)&&(identical(other.routeToHR, routeToHR) || other.routeToHR == routeToHR)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.selectedFileName, selectedFileName) || other.selectedFileName == selectedFileName)&&(identical(other.uploadedFileUrl, uploadedFileUrl) || other.uploadedFileUrl == uploadedFileUrl));
}


@override
int get hashCode => Object.hash(runtimeType,date,requestType,inTime,outTime,routeToHR,reason,selectedFileName,uploadedFileUrl);

@override
String toString() {
  return 'RegularizationFormData(date: $date, requestType: $requestType, inTime: $inTime, outTime: $outTime, routeToHR: $routeToHR, reason: $reason, selectedFileName: $selectedFileName, uploadedFileUrl: $uploadedFileUrl)';
}


}

/// @nodoc
abstract mixin class _$RegularizationFormDataCopyWith<$Res> implements $RegularizationFormDataCopyWith<$Res> {
  factory _$RegularizationFormDataCopyWith(_RegularizationFormData value, $Res Function(_RegularizationFormData) _then) = __$RegularizationFormDataCopyWithImpl;
@override @useResult
$Res call({
 DateTime? date, RegularizationRequestType requestType, TimeOfDay? inTime, TimeOfDay? outTime, bool routeToHR, String reason, String? selectedFileName, String? uploadedFileUrl
});




}
/// @nodoc
class __$RegularizationFormDataCopyWithImpl<$Res>
    implements _$RegularizationFormDataCopyWith<$Res> {
  __$RegularizationFormDataCopyWithImpl(this._self, this._then);

  final _RegularizationFormData _self;
  final $Res Function(_RegularizationFormData) _then;

/// Create a copy of RegularizationFormData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? requestType = null,Object? inTime = freezed,Object? outTime = freezed,Object? routeToHR = null,Object? reason = null,Object? selectedFileName = freezed,Object? uploadedFileUrl = freezed,}) {
  return _then(_RegularizationFormData(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,requestType: null == requestType ? _self.requestType : requestType // ignore: cast_nullable_to_non_nullable
as RegularizationRequestType,inTime: freezed == inTime ? _self.inTime : inTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,outTime: freezed == outTime ? _self.outTime : outTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,routeToHR: null == routeToHR ? _self.routeToHR : routeToHR // ignore: cast_nullable_to_non_nullable
as bool,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,selectedFileName: freezed == selectedFileName ? _self.selectedFileName : selectedFileName // ignore: cast_nullable_to_non_nullable
as String?,uploadedFileUrl: freezed == uploadedFileUrl ? _self.uploadedFileUrl : uploadedFileUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AttendanceRegularizationState {

 RegularizationFormData get formData;
/// Create a copy of AttendanceRegularizationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceRegularizationStateCopyWith<AttendanceRegularizationState> get copyWith => _$AttendanceRegularizationStateCopyWithImpl<AttendanceRegularizationState>(this as AttendanceRegularizationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceRegularizationState&&(identical(other.formData, formData) || other.formData == formData));
}


@override
int get hashCode => Object.hash(runtimeType,formData);

@override
String toString() {
  return 'AttendanceRegularizationState(formData: $formData)';
}


}

/// @nodoc
abstract mixin class $AttendanceRegularizationStateCopyWith<$Res>  {
  factory $AttendanceRegularizationStateCopyWith(AttendanceRegularizationState value, $Res Function(AttendanceRegularizationState) _then) = _$AttendanceRegularizationStateCopyWithImpl;
@useResult
$Res call({
 RegularizationFormData formData
});


$RegularizationFormDataCopyWith<$Res> get formData;

}
/// @nodoc
class _$AttendanceRegularizationStateCopyWithImpl<$Res>
    implements $AttendanceRegularizationStateCopyWith<$Res> {
  _$AttendanceRegularizationStateCopyWithImpl(this._self, this._then);

  final AttendanceRegularizationState _self;
  final $Res Function(AttendanceRegularizationState) _then;

/// Create a copy of AttendanceRegularizationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? formData = null,}) {
  return _then(_self.copyWith(
formData: null == formData ? _self.formData : formData // ignore: cast_nullable_to_non_nullable
as RegularizationFormData,
  ));
}
/// Create a copy of AttendanceRegularizationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegularizationFormDataCopyWith<$Res> get formData {
  
  return $RegularizationFormDataCopyWith<$Res>(_self.formData, (value) {
    return _then(_self.copyWith(formData: value));
  });
}
}


/// Adds pattern-matching-related methods to [AttendanceRegularizationState].
extension AttendanceRegularizationStatePatterns on AttendanceRegularizationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Error():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( RegularizationFormData formData)?  initial,TResult Function( RegularizationFormData formData,  bool isUploading,  bool isSubmitting)?  loading,TResult Function( RegularizationFormData formData,  bool isFileUploadSuccess,  bool isSubmissionSuccess)?  success,TResult Function( RegularizationFormData formData,  String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.formData);case _Loading() when loading != null:
return loading(_that.formData,_that.isUploading,_that.isSubmitting);case _Success() when success != null:
return success(_that.formData,_that.isFileUploadSuccess,_that.isSubmissionSuccess);case _Error() when error != null:
return error(_that.formData,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( RegularizationFormData formData)  initial,required TResult Function( RegularizationFormData formData,  bool isUploading,  bool isSubmitting)  loading,required TResult Function( RegularizationFormData formData,  bool isFileUploadSuccess,  bool isSubmissionSuccess)  success,required TResult Function( RegularizationFormData formData,  String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial(_that.formData);case _Loading():
return loading(_that.formData,_that.isUploading,_that.isSubmitting);case _Success():
return success(_that.formData,_that.isFileUploadSuccess,_that.isSubmissionSuccess);case _Error():
return error(_that.formData,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( RegularizationFormData formData)?  initial,TResult? Function( RegularizationFormData formData,  bool isUploading,  bool isSubmitting)?  loading,TResult? Function( RegularizationFormData formData,  bool isFileUploadSuccess,  bool isSubmissionSuccess)?  success,TResult? Function( RegularizationFormData formData,  String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.formData);case _Loading() when loading != null:
return loading(_that.formData,_that.isUploading,_that.isSubmitting);case _Success() when success != null:
return success(_that.formData,_that.isFileUploadSuccess,_that.isSubmissionSuccess);case _Error() when error != null:
return error(_that.formData,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial extends AttendanceRegularizationState {
  const _Initial({this.formData = const RegularizationFormData()}): super._();
  

@override@JsonKey() final  RegularizationFormData formData;

/// Create a copy of AttendanceRegularizationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.formData, formData) || other.formData == formData));
}


@override
int get hashCode => Object.hash(runtimeType,formData);

@override
String toString() {
  return 'AttendanceRegularizationState.initial(formData: $formData)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $AttendanceRegularizationStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 RegularizationFormData formData
});


@override $RegularizationFormDataCopyWith<$Res> get formData;

}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of AttendanceRegularizationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? formData = null,}) {
  return _then(_Initial(
formData: null == formData ? _self.formData : formData // ignore: cast_nullable_to_non_nullable
as RegularizationFormData,
  ));
}

/// Create a copy of AttendanceRegularizationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegularizationFormDataCopyWith<$Res> get formData {
  
  return $RegularizationFormDataCopyWith<$Res>(_self.formData, (value) {
    return _then(_self.copyWith(formData: value));
  });
}
}

/// @nodoc


class _Loading extends AttendanceRegularizationState {
  const _Loading({required this.formData, this.isUploading = false, this.isSubmitting = false}): super._();
  

@override final  RegularizationFormData formData;
@JsonKey() final  bool isUploading;
@JsonKey() final  bool isSubmitting;

/// Create a copy of AttendanceRegularizationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&(identical(other.formData, formData) || other.formData == formData)&&(identical(other.isUploading, isUploading) || other.isUploading == isUploading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,formData,isUploading,isSubmitting);

@override
String toString() {
  return 'AttendanceRegularizationState.loading(formData: $formData, isUploading: $isUploading, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $AttendanceRegularizationStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@override @useResult
$Res call({
 RegularizationFormData formData, bool isUploading, bool isSubmitting
});


@override $RegularizationFormDataCopyWith<$Res> get formData;

}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of AttendanceRegularizationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? formData = null,Object? isUploading = null,Object? isSubmitting = null,}) {
  return _then(_Loading(
formData: null == formData ? _self.formData : formData // ignore: cast_nullable_to_non_nullable
as RegularizationFormData,isUploading: null == isUploading ? _self.isUploading : isUploading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AttendanceRegularizationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegularizationFormDataCopyWith<$Res> get formData {
  
  return $RegularizationFormDataCopyWith<$Res>(_self.formData, (value) {
    return _then(_self.copyWith(formData: value));
  });
}
}

/// @nodoc


class _Success extends AttendanceRegularizationState {
  const _Success({required this.formData, this.isFileUploadSuccess = false, this.isSubmissionSuccess = false}): super._();
  

@override final  RegularizationFormData formData;
@JsonKey() final  bool isFileUploadSuccess;
@JsonKey() final  bool isSubmissionSuccess;

/// Create a copy of AttendanceRegularizationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.formData, formData) || other.formData == formData)&&(identical(other.isFileUploadSuccess, isFileUploadSuccess) || other.isFileUploadSuccess == isFileUploadSuccess)&&(identical(other.isSubmissionSuccess, isSubmissionSuccess) || other.isSubmissionSuccess == isSubmissionSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,formData,isFileUploadSuccess,isSubmissionSuccess);

@override
String toString() {
  return 'AttendanceRegularizationState.success(formData: $formData, isFileUploadSuccess: $isFileUploadSuccess, isSubmissionSuccess: $isSubmissionSuccess)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $AttendanceRegularizationStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@override @useResult
$Res call({
 RegularizationFormData formData, bool isFileUploadSuccess, bool isSubmissionSuccess
});


@override $RegularizationFormDataCopyWith<$Res> get formData;

}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of AttendanceRegularizationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? formData = null,Object? isFileUploadSuccess = null,Object? isSubmissionSuccess = null,}) {
  return _then(_Success(
formData: null == formData ? _self.formData : formData // ignore: cast_nullable_to_non_nullable
as RegularizationFormData,isFileUploadSuccess: null == isFileUploadSuccess ? _self.isFileUploadSuccess : isFileUploadSuccess // ignore: cast_nullable_to_non_nullable
as bool,isSubmissionSuccess: null == isSubmissionSuccess ? _self.isSubmissionSuccess : isSubmissionSuccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AttendanceRegularizationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegularizationFormDataCopyWith<$Res> get formData {
  
  return $RegularizationFormDataCopyWith<$Res>(_self.formData, (value) {
    return _then(_self.copyWith(formData: value));
  });
}
}

/// @nodoc


class _Error extends AttendanceRegularizationState {
  const _Error({required this.formData, required this.message}): super._();
  

@override final  RegularizationFormData formData;
 final  String message;

/// Create a copy of AttendanceRegularizationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.formData, formData) || other.formData == formData)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,formData,message);

@override
String toString() {
  return 'AttendanceRegularizationState.error(formData: $formData, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $AttendanceRegularizationStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@override @useResult
$Res call({
 RegularizationFormData formData, String message
});


@override $RegularizationFormDataCopyWith<$Res> get formData;

}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of AttendanceRegularizationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? formData = null,Object? message = null,}) {
  return _then(_Error(
formData: null == formData ? _self.formData : formData // ignore: cast_nullable_to_non_nullable
as RegularizationFormData,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of AttendanceRegularizationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegularizationFormDataCopyWith<$Res> get formData {
  
  return $RegularizationFormDataCopyWith<$Res>(_self.formData, (value) {
    return _then(_self.copyWith(formData: value));
  });
}
}

// dart format on
