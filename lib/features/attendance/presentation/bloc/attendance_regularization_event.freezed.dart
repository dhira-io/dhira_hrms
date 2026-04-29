// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_regularization_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttendanceRegularizationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceRegularizationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceRegularizationEvent()';
}


}

/// @nodoc
class $AttendanceRegularizationEventCopyWith<$Res>  {
$AttendanceRegularizationEventCopyWith(AttendanceRegularizationEvent _, $Res Function(AttendanceRegularizationEvent) __);
}


/// Adds pattern-matching-related methods to [AttendanceRegularizationEvent].
extension AttendanceRegularizationEventPatterns on AttendanceRegularizationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RegularizationStarted value)?  regularizationStarted,TResult Function( DateChanged value)?  dateChanged,TResult Function( RequestTypeChanged value)?  requestTypeChanged,TResult Function( InTimeChanged value)?  inTimeChanged,TResult Function( OutTimeChanged value)?  outTimeChanged,TResult Function( RouteToHRChanged value)?  routeToHRChanged,TResult Function( ReasonChanged value)?  reasonChanged,TResult Function( UploadFileRequested value)?  uploadFileRequested,TResult Function( FileRemoved value)?  fileRemoved,TResult Function( SubmitRequested value)?  submitRequested,TResult Function( ResetRequested value)?  resetRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RegularizationStarted() when regularizationStarted != null:
return regularizationStarted(_that);case DateChanged() when dateChanged != null:
return dateChanged(_that);case RequestTypeChanged() when requestTypeChanged != null:
return requestTypeChanged(_that);case InTimeChanged() when inTimeChanged != null:
return inTimeChanged(_that);case OutTimeChanged() when outTimeChanged != null:
return outTimeChanged(_that);case RouteToHRChanged() when routeToHRChanged != null:
return routeToHRChanged(_that);case ReasonChanged() when reasonChanged != null:
return reasonChanged(_that);case UploadFileRequested() when uploadFileRequested != null:
return uploadFileRequested(_that);case FileRemoved() when fileRemoved != null:
return fileRemoved(_that);case SubmitRequested() when submitRequested != null:
return submitRequested(_that);case ResetRequested() when resetRequested != null:
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RegularizationStarted value)  regularizationStarted,required TResult Function( DateChanged value)  dateChanged,required TResult Function( RequestTypeChanged value)  requestTypeChanged,required TResult Function( InTimeChanged value)  inTimeChanged,required TResult Function( OutTimeChanged value)  outTimeChanged,required TResult Function( RouteToHRChanged value)  routeToHRChanged,required TResult Function( ReasonChanged value)  reasonChanged,required TResult Function( UploadFileRequested value)  uploadFileRequested,required TResult Function( FileRemoved value)  fileRemoved,required TResult Function( SubmitRequested value)  submitRequested,required TResult Function( ResetRequested value)  resetRequested,}){
final _that = this;
switch (_that) {
case RegularizationStarted():
return regularizationStarted(_that);case DateChanged():
return dateChanged(_that);case RequestTypeChanged():
return requestTypeChanged(_that);case InTimeChanged():
return inTimeChanged(_that);case OutTimeChanged():
return outTimeChanged(_that);case RouteToHRChanged():
return routeToHRChanged(_that);case ReasonChanged():
return reasonChanged(_that);case UploadFileRequested():
return uploadFileRequested(_that);case FileRemoved():
return fileRemoved(_that);case SubmitRequested():
return submitRequested(_that);case ResetRequested():
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RegularizationStarted value)?  regularizationStarted,TResult? Function( DateChanged value)?  dateChanged,TResult? Function( RequestTypeChanged value)?  requestTypeChanged,TResult? Function( InTimeChanged value)?  inTimeChanged,TResult? Function( OutTimeChanged value)?  outTimeChanged,TResult? Function( RouteToHRChanged value)?  routeToHRChanged,TResult? Function( ReasonChanged value)?  reasonChanged,TResult? Function( UploadFileRequested value)?  uploadFileRequested,TResult? Function( FileRemoved value)?  fileRemoved,TResult? Function( SubmitRequested value)?  submitRequested,TResult? Function( ResetRequested value)?  resetRequested,}){
final _that = this;
switch (_that) {
case RegularizationStarted() when regularizationStarted != null:
return regularizationStarted(_that);case DateChanged() when dateChanged != null:
return dateChanged(_that);case RequestTypeChanged() when requestTypeChanged != null:
return requestTypeChanged(_that);case InTimeChanged() when inTimeChanged != null:
return inTimeChanged(_that);case OutTimeChanged() when outTimeChanged != null:
return outTimeChanged(_that);case RouteToHRChanged() when routeToHRChanged != null:
return routeToHRChanged(_that);case ReasonChanged() when reasonChanged != null:
return reasonChanged(_that);case UploadFileRequested() when uploadFileRequested != null:
return uploadFileRequested(_that);case FileRemoved() when fileRemoved != null:
return fileRemoved(_that);case SubmitRequested() when submitRequested != null:
return submitRequested(_that);case ResetRequested() when resetRequested != null:
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  regularizationStarted,TResult Function( DateTime date)?  dateChanged,TResult Function( RegularizationRequestType type)?  requestTypeChanged,TResult Function( TimeOfDay? time)?  inTimeChanged,TResult Function( TimeOfDay? time)?  outTimeChanged,TResult Function( bool value)?  routeToHRChanged,TResult Function( String reason)?  reasonChanged,TResult Function( String filePath,  String fileName)?  uploadFileRequested,TResult Function()?  fileRemoved,TResult Function()?  submitRequested,TResult Function()?  resetRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RegularizationStarted() when regularizationStarted != null:
return regularizationStarted();case DateChanged() when dateChanged != null:
return dateChanged(_that.date);case RequestTypeChanged() when requestTypeChanged != null:
return requestTypeChanged(_that.type);case InTimeChanged() when inTimeChanged != null:
return inTimeChanged(_that.time);case OutTimeChanged() when outTimeChanged != null:
return outTimeChanged(_that.time);case RouteToHRChanged() when routeToHRChanged != null:
return routeToHRChanged(_that.value);case ReasonChanged() when reasonChanged != null:
return reasonChanged(_that.reason);case UploadFileRequested() when uploadFileRequested != null:
return uploadFileRequested(_that.filePath,_that.fileName);case FileRemoved() when fileRemoved != null:
return fileRemoved();case SubmitRequested() when submitRequested != null:
return submitRequested();case ResetRequested() when resetRequested != null:
return resetRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  regularizationStarted,required TResult Function( DateTime date)  dateChanged,required TResult Function( RegularizationRequestType type)  requestTypeChanged,required TResult Function( TimeOfDay? time)  inTimeChanged,required TResult Function( TimeOfDay? time)  outTimeChanged,required TResult Function( bool value)  routeToHRChanged,required TResult Function( String reason)  reasonChanged,required TResult Function( String filePath,  String fileName)  uploadFileRequested,required TResult Function()  fileRemoved,required TResult Function()  submitRequested,required TResult Function()  resetRequested,}) {final _that = this;
switch (_that) {
case RegularizationStarted():
return regularizationStarted();case DateChanged():
return dateChanged(_that.date);case RequestTypeChanged():
return requestTypeChanged(_that.type);case InTimeChanged():
return inTimeChanged(_that.time);case OutTimeChanged():
return outTimeChanged(_that.time);case RouteToHRChanged():
return routeToHRChanged(_that.value);case ReasonChanged():
return reasonChanged(_that.reason);case UploadFileRequested():
return uploadFileRequested(_that.filePath,_that.fileName);case FileRemoved():
return fileRemoved();case SubmitRequested():
return submitRequested();case ResetRequested():
return resetRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  regularizationStarted,TResult? Function( DateTime date)?  dateChanged,TResult? Function( RegularizationRequestType type)?  requestTypeChanged,TResult? Function( TimeOfDay? time)?  inTimeChanged,TResult? Function( TimeOfDay? time)?  outTimeChanged,TResult? Function( bool value)?  routeToHRChanged,TResult? Function( String reason)?  reasonChanged,TResult? Function( String filePath,  String fileName)?  uploadFileRequested,TResult? Function()?  fileRemoved,TResult? Function()?  submitRequested,TResult? Function()?  resetRequested,}) {final _that = this;
switch (_that) {
case RegularizationStarted() when regularizationStarted != null:
return regularizationStarted();case DateChanged() when dateChanged != null:
return dateChanged(_that.date);case RequestTypeChanged() when requestTypeChanged != null:
return requestTypeChanged(_that.type);case InTimeChanged() when inTimeChanged != null:
return inTimeChanged(_that.time);case OutTimeChanged() when outTimeChanged != null:
return outTimeChanged(_that.time);case RouteToHRChanged() when routeToHRChanged != null:
return routeToHRChanged(_that.value);case ReasonChanged() when reasonChanged != null:
return reasonChanged(_that.reason);case UploadFileRequested() when uploadFileRequested != null:
return uploadFileRequested(_that.filePath,_that.fileName);case FileRemoved() when fileRemoved != null:
return fileRemoved();case SubmitRequested() when submitRequested != null:
return submitRequested();case ResetRequested() when resetRequested != null:
return resetRequested();case _:
  return null;

}
}

}

/// @nodoc


class RegularizationStarted implements AttendanceRegularizationEvent {
  const RegularizationStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegularizationStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceRegularizationEvent.regularizationStarted()';
}


}




/// @nodoc


class DateChanged implements AttendanceRegularizationEvent {
  const DateChanged(this.date);
  

 final  DateTime date;

/// Create a copy of AttendanceRegularizationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DateChangedCopyWith<DateChanged> get copyWith => _$DateChangedCopyWithImpl<DateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DateChanged&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'AttendanceRegularizationEvent.dateChanged(date: $date)';
}


}

/// @nodoc
abstract mixin class $DateChangedCopyWith<$Res> implements $AttendanceRegularizationEventCopyWith<$Res> {
  factory $DateChangedCopyWith(DateChanged value, $Res Function(DateChanged) _then) = _$DateChangedCopyWithImpl;
@useResult
$Res call({
 DateTime date
});




}
/// @nodoc
class _$DateChangedCopyWithImpl<$Res>
    implements $DateChangedCopyWith<$Res> {
  _$DateChangedCopyWithImpl(this._self, this._then);

  final DateChanged _self;
  final $Res Function(DateChanged) _then;

/// Create a copy of AttendanceRegularizationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,}) {
  return _then(DateChanged(
null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class RequestTypeChanged implements AttendanceRegularizationEvent {
  const RequestTypeChanged(this.type);
  

 final  RegularizationRequestType type;

/// Create a copy of AttendanceRegularizationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestTypeChangedCopyWith<RequestTypeChanged> get copyWith => _$RequestTypeChangedCopyWithImpl<RequestTypeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestTypeChanged&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'AttendanceRegularizationEvent.requestTypeChanged(type: $type)';
}


}

/// @nodoc
abstract mixin class $RequestTypeChangedCopyWith<$Res> implements $AttendanceRegularizationEventCopyWith<$Res> {
  factory $RequestTypeChangedCopyWith(RequestTypeChanged value, $Res Function(RequestTypeChanged) _then) = _$RequestTypeChangedCopyWithImpl;
@useResult
$Res call({
 RegularizationRequestType type
});




}
/// @nodoc
class _$RequestTypeChangedCopyWithImpl<$Res>
    implements $RequestTypeChangedCopyWith<$Res> {
  _$RequestTypeChangedCopyWithImpl(this._self, this._then);

  final RequestTypeChanged _self;
  final $Res Function(RequestTypeChanged) _then;

/// Create a copy of AttendanceRegularizationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(RequestTypeChanged(
null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RegularizationRequestType,
  ));
}


}

/// @nodoc


class InTimeChanged implements AttendanceRegularizationEvent {
  const InTimeChanged(this.time);
  

 final  TimeOfDay? time;

/// Create a copy of AttendanceRegularizationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InTimeChangedCopyWith<InTimeChanged> get copyWith => _$InTimeChangedCopyWithImpl<InTimeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InTimeChanged&&(identical(other.time, time) || other.time == time));
}


@override
int get hashCode => Object.hash(runtimeType,time);

@override
String toString() {
  return 'AttendanceRegularizationEvent.inTimeChanged(time: $time)';
}


}

/// @nodoc
abstract mixin class $InTimeChangedCopyWith<$Res> implements $AttendanceRegularizationEventCopyWith<$Res> {
  factory $InTimeChangedCopyWith(InTimeChanged value, $Res Function(InTimeChanged) _then) = _$InTimeChangedCopyWithImpl;
@useResult
$Res call({
 TimeOfDay? time
});




}
/// @nodoc
class _$InTimeChangedCopyWithImpl<$Res>
    implements $InTimeChangedCopyWith<$Res> {
  _$InTimeChangedCopyWithImpl(this._self, this._then);

  final InTimeChanged _self;
  final $Res Function(InTimeChanged) _then;

/// Create a copy of AttendanceRegularizationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? time = freezed,}) {
  return _then(InTimeChanged(
freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,
  ));
}


}

/// @nodoc


class OutTimeChanged implements AttendanceRegularizationEvent {
  const OutTimeChanged(this.time);
  

 final  TimeOfDay? time;

/// Create a copy of AttendanceRegularizationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutTimeChangedCopyWith<OutTimeChanged> get copyWith => _$OutTimeChangedCopyWithImpl<OutTimeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutTimeChanged&&(identical(other.time, time) || other.time == time));
}


@override
int get hashCode => Object.hash(runtimeType,time);

@override
String toString() {
  return 'AttendanceRegularizationEvent.outTimeChanged(time: $time)';
}


}

/// @nodoc
abstract mixin class $OutTimeChangedCopyWith<$Res> implements $AttendanceRegularizationEventCopyWith<$Res> {
  factory $OutTimeChangedCopyWith(OutTimeChanged value, $Res Function(OutTimeChanged) _then) = _$OutTimeChangedCopyWithImpl;
@useResult
$Res call({
 TimeOfDay? time
});




}
/// @nodoc
class _$OutTimeChangedCopyWithImpl<$Res>
    implements $OutTimeChangedCopyWith<$Res> {
  _$OutTimeChangedCopyWithImpl(this._self, this._then);

  final OutTimeChanged _self;
  final $Res Function(OutTimeChanged) _then;

/// Create a copy of AttendanceRegularizationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? time = freezed,}) {
  return _then(OutTimeChanged(
freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,
  ));
}


}

/// @nodoc


class RouteToHRChanged implements AttendanceRegularizationEvent {
  const RouteToHRChanged(this.value);
  

 final  bool value;

/// Create a copy of AttendanceRegularizationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteToHRChangedCopyWith<RouteToHRChanged> get copyWith => _$RouteToHRChangedCopyWithImpl<RouteToHRChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteToHRChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'AttendanceRegularizationEvent.routeToHRChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class $RouteToHRChangedCopyWith<$Res> implements $AttendanceRegularizationEventCopyWith<$Res> {
  factory $RouteToHRChangedCopyWith(RouteToHRChanged value, $Res Function(RouteToHRChanged) _then) = _$RouteToHRChangedCopyWithImpl;
@useResult
$Res call({
 bool value
});




}
/// @nodoc
class _$RouteToHRChangedCopyWithImpl<$Res>
    implements $RouteToHRChangedCopyWith<$Res> {
  _$RouteToHRChangedCopyWithImpl(this._self, this._then);

  final RouteToHRChanged _self;
  final $Res Function(RouteToHRChanged) _then;

/// Create a copy of AttendanceRegularizationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(RouteToHRChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ReasonChanged implements AttendanceRegularizationEvent {
  const ReasonChanged(this.reason);
  

 final  String reason;

/// Create a copy of AttendanceRegularizationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReasonChangedCopyWith<ReasonChanged> get copyWith => _$ReasonChangedCopyWithImpl<ReasonChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReasonChanged&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'AttendanceRegularizationEvent.reasonChanged(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $ReasonChangedCopyWith<$Res> implements $AttendanceRegularizationEventCopyWith<$Res> {
  factory $ReasonChangedCopyWith(ReasonChanged value, $Res Function(ReasonChanged) _then) = _$ReasonChangedCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$ReasonChangedCopyWithImpl<$Res>
    implements $ReasonChangedCopyWith<$Res> {
  _$ReasonChangedCopyWithImpl(this._self, this._then);

  final ReasonChanged _self;
  final $Res Function(ReasonChanged) _then;

/// Create a copy of AttendanceRegularizationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(ReasonChanged(
null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UploadFileRequested implements AttendanceRegularizationEvent {
  const UploadFileRequested({required this.filePath, required this.fileName});
  

 final  String filePath;
 final  String fileName;

/// Create a copy of AttendanceRegularizationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadFileRequestedCopyWith<UploadFileRequested> get copyWith => _$UploadFileRequestedCopyWithImpl<UploadFileRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadFileRequested&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.fileName, fileName) || other.fileName == fileName));
}


@override
int get hashCode => Object.hash(runtimeType,filePath,fileName);

@override
String toString() {
  return 'AttendanceRegularizationEvent.uploadFileRequested(filePath: $filePath, fileName: $fileName)';
}


}

/// @nodoc
abstract mixin class $UploadFileRequestedCopyWith<$Res> implements $AttendanceRegularizationEventCopyWith<$Res> {
  factory $UploadFileRequestedCopyWith(UploadFileRequested value, $Res Function(UploadFileRequested) _then) = _$UploadFileRequestedCopyWithImpl;
@useResult
$Res call({
 String filePath, String fileName
});




}
/// @nodoc
class _$UploadFileRequestedCopyWithImpl<$Res>
    implements $UploadFileRequestedCopyWith<$Res> {
  _$UploadFileRequestedCopyWithImpl(this._self, this._then);

  final UploadFileRequested _self;
  final $Res Function(UploadFileRequested) _then;

/// Create a copy of AttendanceRegularizationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filePath = null,Object? fileName = null,}) {
  return _then(UploadFileRequested(
filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FileRemoved implements AttendanceRegularizationEvent {
  const FileRemoved();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileRemoved);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceRegularizationEvent.fileRemoved()';
}


}




/// @nodoc


class SubmitRequested implements AttendanceRegularizationEvent {
  const SubmitRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceRegularizationEvent.submitRequested()';
}


}




/// @nodoc


class ResetRequested implements AttendanceRegularizationEvent {
  const ResetRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceRegularizationEvent.resetRequested()';
}


}




// dart format on
