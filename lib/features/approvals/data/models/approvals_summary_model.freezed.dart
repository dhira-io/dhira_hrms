// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approvals_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApprovalsSummaryModel {

@JsonKey(name: 'leave_approvals_pending') int get leaveApprovalsPending;@JsonKey(name: 'attendance_regularization_pending') int get attendanceRegularizationPending;@JsonKey(name: 'timesheet_approvals_pending') int get timesheetApprovalsPending;@JsonKey(name: 'compensatory_leave_pending') int get compensatoryLeavePending;@JsonKey(name: 'total_all_pending') int get totalAllPending; String? get timestamp;
/// Create a copy of ApprovalsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApprovalsSummaryModelCopyWith<ApprovalsSummaryModel> get copyWith => _$ApprovalsSummaryModelCopyWithImpl<ApprovalsSummaryModel>(this as ApprovalsSummaryModel, _$identity);

  /// Serializes this ApprovalsSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApprovalsSummaryModel&&(identical(other.leaveApprovalsPending, leaveApprovalsPending) || other.leaveApprovalsPending == leaveApprovalsPending)&&(identical(other.attendanceRegularizationPending, attendanceRegularizationPending) || other.attendanceRegularizationPending == attendanceRegularizationPending)&&(identical(other.timesheetApprovalsPending, timesheetApprovalsPending) || other.timesheetApprovalsPending == timesheetApprovalsPending)&&(identical(other.compensatoryLeavePending, compensatoryLeavePending) || other.compensatoryLeavePending == compensatoryLeavePending)&&(identical(other.totalAllPending, totalAllPending) || other.totalAllPending == totalAllPending)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leaveApprovalsPending,attendanceRegularizationPending,timesheetApprovalsPending,compensatoryLeavePending,totalAllPending,timestamp);

@override
String toString() {
  return 'ApprovalsSummaryModel(leaveApprovalsPending: $leaveApprovalsPending, attendanceRegularizationPending: $attendanceRegularizationPending, timesheetApprovalsPending: $timesheetApprovalsPending, compensatoryLeavePending: $compensatoryLeavePending, totalAllPending: $totalAllPending, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $ApprovalsSummaryModelCopyWith<$Res>  {
  factory $ApprovalsSummaryModelCopyWith(ApprovalsSummaryModel value, $Res Function(ApprovalsSummaryModel) _then) = _$ApprovalsSummaryModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'leave_approvals_pending') int leaveApprovalsPending,@JsonKey(name: 'attendance_regularization_pending') int attendanceRegularizationPending,@JsonKey(name: 'timesheet_approvals_pending') int timesheetApprovalsPending,@JsonKey(name: 'compensatory_leave_pending') int compensatoryLeavePending,@JsonKey(name: 'total_all_pending') int totalAllPending, String? timestamp
});




}
/// @nodoc
class _$ApprovalsSummaryModelCopyWithImpl<$Res>
    implements $ApprovalsSummaryModelCopyWith<$Res> {
  _$ApprovalsSummaryModelCopyWithImpl(this._self, this._then);

  final ApprovalsSummaryModel _self;
  final $Res Function(ApprovalsSummaryModel) _then;

/// Create a copy of ApprovalsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leaveApprovalsPending = null,Object? attendanceRegularizationPending = null,Object? timesheetApprovalsPending = null,Object? compensatoryLeavePending = null,Object? totalAllPending = null,Object? timestamp = freezed,}) {
  return _then(_self.copyWith(
leaveApprovalsPending: null == leaveApprovalsPending ? _self.leaveApprovalsPending : leaveApprovalsPending // ignore: cast_nullable_to_non_nullable
as int,attendanceRegularizationPending: null == attendanceRegularizationPending ? _self.attendanceRegularizationPending : attendanceRegularizationPending // ignore: cast_nullable_to_non_nullable
as int,timesheetApprovalsPending: null == timesheetApprovalsPending ? _self.timesheetApprovalsPending : timesheetApprovalsPending // ignore: cast_nullable_to_non_nullable
as int,compensatoryLeavePending: null == compensatoryLeavePending ? _self.compensatoryLeavePending : compensatoryLeavePending // ignore: cast_nullable_to_non_nullable
as int,totalAllPending: null == totalAllPending ? _self.totalAllPending : totalAllPending // ignore: cast_nullable_to_non_nullable
as int,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApprovalsSummaryModel].
extension ApprovalsSummaryModelPatterns on ApprovalsSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApprovalsSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApprovalsSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApprovalsSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _ApprovalsSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApprovalsSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _ApprovalsSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'leave_approvals_pending')  int leaveApprovalsPending, @JsonKey(name: 'attendance_regularization_pending')  int attendanceRegularizationPending, @JsonKey(name: 'timesheet_approvals_pending')  int timesheetApprovalsPending, @JsonKey(name: 'compensatory_leave_pending')  int compensatoryLeavePending, @JsonKey(name: 'total_all_pending')  int totalAllPending,  String? timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApprovalsSummaryModel() when $default != null:
return $default(_that.leaveApprovalsPending,_that.attendanceRegularizationPending,_that.timesheetApprovalsPending,_that.compensatoryLeavePending,_that.totalAllPending,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'leave_approvals_pending')  int leaveApprovalsPending, @JsonKey(name: 'attendance_regularization_pending')  int attendanceRegularizationPending, @JsonKey(name: 'timesheet_approvals_pending')  int timesheetApprovalsPending, @JsonKey(name: 'compensatory_leave_pending')  int compensatoryLeavePending, @JsonKey(name: 'total_all_pending')  int totalAllPending,  String? timestamp)  $default,) {final _that = this;
switch (_that) {
case _ApprovalsSummaryModel():
return $default(_that.leaveApprovalsPending,_that.attendanceRegularizationPending,_that.timesheetApprovalsPending,_that.compensatoryLeavePending,_that.totalAllPending,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'leave_approvals_pending')  int leaveApprovalsPending, @JsonKey(name: 'attendance_regularization_pending')  int attendanceRegularizationPending, @JsonKey(name: 'timesheet_approvals_pending')  int timesheetApprovalsPending, @JsonKey(name: 'compensatory_leave_pending')  int compensatoryLeavePending, @JsonKey(name: 'total_all_pending')  int totalAllPending,  String? timestamp)?  $default,) {final _that = this;
switch (_that) {
case _ApprovalsSummaryModel() when $default != null:
return $default(_that.leaveApprovalsPending,_that.attendanceRegularizationPending,_that.timesheetApprovalsPending,_that.compensatoryLeavePending,_that.totalAllPending,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApprovalsSummaryModel extends ApprovalsSummaryModel {
  const _ApprovalsSummaryModel({@JsonKey(name: 'leave_approvals_pending') required this.leaveApprovalsPending, @JsonKey(name: 'attendance_regularization_pending') required this.attendanceRegularizationPending, @JsonKey(name: 'timesheet_approvals_pending') required this.timesheetApprovalsPending, @JsonKey(name: 'compensatory_leave_pending') required this.compensatoryLeavePending, @JsonKey(name: 'total_all_pending') required this.totalAllPending, this.timestamp}): super._();
  factory _ApprovalsSummaryModel.fromJson(Map<String, dynamic> json) => _$ApprovalsSummaryModelFromJson(json);

@override@JsonKey(name: 'leave_approvals_pending') final  int leaveApprovalsPending;
@override@JsonKey(name: 'attendance_regularization_pending') final  int attendanceRegularizationPending;
@override@JsonKey(name: 'timesheet_approvals_pending') final  int timesheetApprovalsPending;
@override@JsonKey(name: 'compensatory_leave_pending') final  int compensatoryLeavePending;
@override@JsonKey(name: 'total_all_pending') final  int totalAllPending;
@override final  String? timestamp;

/// Create a copy of ApprovalsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApprovalsSummaryModelCopyWith<_ApprovalsSummaryModel> get copyWith => __$ApprovalsSummaryModelCopyWithImpl<_ApprovalsSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApprovalsSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApprovalsSummaryModel&&(identical(other.leaveApprovalsPending, leaveApprovalsPending) || other.leaveApprovalsPending == leaveApprovalsPending)&&(identical(other.attendanceRegularizationPending, attendanceRegularizationPending) || other.attendanceRegularizationPending == attendanceRegularizationPending)&&(identical(other.timesheetApprovalsPending, timesheetApprovalsPending) || other.timesheetApprovalsPending == timesheetApprovalsPending)&&(identical(other.compensatoryLeavePending, compensatoryLeavePending) || other.compensatoryLeavePending == compensatoryLeavePending)&&(identical(other.totalAllPending, totalAllPending) || other.totalAllPending == totalAllPending)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leaveApprovalsPending,attendanceRegularizationPending,timesheetApprovalsPending,compensatoryLeavePending,totalAllPending,timestamp);

@override
String toString() {
  return 'ApprovalsSummaryModel(leaveApprovalsPending: $leaveApprovalsPending, attendanceRegularizationPending: $attendanceRegularizationPending, timesheetApprovalsPending: $timesheetApprovalsPending, compensatoryLeavePending: $compensatoryLeavePending, totalAllPending: $totalAllPending, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$ApprovalsSummaryModelCopyWith<$Res> implements $ApprovalsSummaryModelCopyWith<$Res> {
  factory _$ApprovalsSummaryModelCopyWith(_ApprovalsSummaryModel value, $Res Function(_ApprovalsSummaryModel) _then) = __$ApprovalsSummaryModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'leave_approvals_pending') int leaveApprovalsPending,@JsonKey(name: 'attendance_regularization_pending') int attendanceRegularizationPending,@JsonKey(name: 'timesheet_approvals_pending') int timesheetApprovalsPending,@JsonKey(name: 'compensatory_leave_pending') int compensatoryLeavePending,@JsonKey(name: 'total_all_pending') int totalAllPending, String? timestamp
});




}
/// @nodoc
class __$ApprovalsSummaryModelCopyWithImpl<$Res>
    implements _$ApprovalsSummaryModelCopyWith<$Res> {
  __$ApprovalsSummaryModelCopyWithImpl(this._self, this._then);

  final _ApprovalsSummaryModel _self;
  final $Res Function(_ApprovalsSummaryModel) _then;

/// Create a copy of ApprovalsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leaveApprovalsPending = null,Object? attendanceRegularizationPending = null,Object? timesheetApprovalsPending = null,Object? compensatoryLeavePending = null,Object? totalAllPending = null,Object? timestamp = freezed,}) {
  return _then(_ApprovalsSummaryModel(
leaveApprovalsPending: null == leaveApprovalsPending ? _self.leaveApprovalsPending : leaveApprovalsPending // ignore: cast_nullable_to_non_nullable
as int,attendanceRegularizationPending: null == attendanceRegularizationPending ? _self.attendanceRegularizationPending : attendanceRegularizationPending // ignore: cast_nullable_to_non_nullable
as int,timesheetApprovalsPending: null == timesheetApprovalsPending ? _self.timesheetApprovalsPending : timesheetApprovalsPending // ignore: cast_nullable_to_non_nullable
as int,compensatoryLeavePending: null == compensatoryLeavePending ? _self.compensatoryLeavePending : compensatoryLeavePending // ignore: cast_nullable_to_non_nullable
as int,totalAllPending: null == totalAllPending ? _self.totalAllPending : totalAllPending // ignore: cast_nullable_to_non_nullable
as int,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ApprovalsSummaryResponse {

 bool get success; ApprovalsSummaryModel get data;
/// Create a copy of ApprovalsSummaryResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApprovalsSummaryResponseCopyWith<ApprovalsSummaryResponse> get copyWith => _$ApprovalsSummaryResponseCopyWithImpl<ApprovalsSummaryResponse>(this as ApprovalsSummaryResponse, _$identity);

  /// Serializes this ApprovalsSummaryResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApprovalsSummaryResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,data);

@override
String toString() {
  return 'ApprovalsSummaryResponse(success: $success, data: $data)';
}


}

/// @nodoc
abstract mixin class $ApprovalsSummaryResponseCopyWith<$Res>  {
  factory $ApprovalsSummaryResponseCopyWith(ApprovalsSummaryResponse value, $Res Function(ApprovalsSummaryResponse) _then) = _$ApprovalsSummaryResponseCopyWithImpl;
@useResult
$Res call({
 bool success, ApprovalsSummaryModel data
});


$ApprovalsSummaryModelCopyWith<$Res> get data;

}
/// @nodoc
class _$ApprovalsSummaryResponseCopyWithImpl<$Res>
    implements $ApprovalsSummaryResponseCopyWith<$Res> {
  _$ApprovalsSummaryResponseCopyWithImpl(this._self, this._then);

  final ApprovalsSummaryResponse _self;
  final $Res Function(ApprovalsSummaryResponse) _then;

/// Create a copy of ApprovalsSummaryResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? data = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ApprovalsSummaryModel,
  ));
}
/// Create a copy of ApprovalsSummaryResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApprovalsSummaryModelCopyWith<$Res> get data {
  
  return $ApprovalsSummaryModelCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApprovalsSummaryResponse].
extension ApprovalsSummaryResponsePatterns on ApprovalsSummaryResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApprovalsSummaryResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApprovalsSummaryResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApprovalsSummaryResponse value)  $default,){
final _that = this;
switch (_that) {
case _ApprovalsSummaryResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApprovalsSummaryResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ApprovalsSummaryResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  ApprovalsSummaryModel data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApprovalsSummaryResponse() when $default != null:
return $default(_that.success,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  ApprovalsSummaryModel data)  $default,) {final _that = this;
switch (_that) {
case _ApprovalsSummaryResponse():
return $default(_that.success,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  ApprovalsSummaryModel data)?  $default,) {final _that = this;
switch (_that) {
case _ApprovalsSummaryResponse() when $default != null:
return $default(_that.success,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApprovalsSummaryResponse implements ApprovalsSummaryResponse {
  const _ApprovalsSummaryResponse({required this.success, required this.data});
  factory _ApprovalsSummaryResponse.fromJson(Map<String, dynamic> json) => _$ApprovalsSummaryResponseFromJson(json);

@override final  bool success;
@override final  ApprovalsSummaryModel data;

/// Create a copy of ApprovalsSummaryResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApprovalsSummaryResponseCopyWith<_ApprovalsSummaryResponse> get copyWith => __$ApprovalsSummaryResponseCopyWithImpl<_ApprovalsSummaryResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApprovalsSummaryResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApprovalsSummaryResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,data);

@override
String toString() {
  return 'ApprovalsSummaryResponse(success: $success, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ApprovalsSummaryResponseCopyWith<$Res> implements $ApprovalsSummaryResponseCopyWith<$Res> {
  factory _$ApprovalsSummaryResponseCopyWith(_ApprovalsSummaryResponse value, $Res Function(_ApprovalsSummaryResponse) _then) = __$ApprovalsSummaryResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, ApprovalsSummaryModel data
});


@override $ApprovalsSummaryModelCopyWith<$Res> get data;

}
/// @nodoc
class __$ApprovalsSummaryResponseCopyWithImpl<$Res>
    implements _$ApprovalsSummaryResponseCopyWith<$Res> {
  __$ApprovalsSummaryResponseCopyWithImpl(this._self, this._then);

  final _ApprovalsSummaryResponse _self;
  final $Res Function(_ApprovalsSummaryResponse) _then;

/// Create a copy of ApprovalsSummaryResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? data = null,}) {
  return _then(_ApprovalsSummaryResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ApprovalsSummaryModel,
  ));
}

/// Create a copy of ApprovalsSummaryResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApprovalsSummaryModelCopyWith<$Res> get data {
  
  return $ApprovalsSummaryModelCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
