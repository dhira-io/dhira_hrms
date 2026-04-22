// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_statistics_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaveStatisticsModel {

 bool get success; String get employee;@JsonKey(name: 'employee_name') String get employeeName; LeavePeriodModel get period; LeaveStatsModel get statistics; LeaveDetailsModel get details;
/// Create a copy of LeaveStatisticsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveStatisticsModelCopyWith<LeaveStatisticsModel> get copyWith => _$LeaveStatisticsModelCopyWithImpl<LeaveStatisticsModel>(this as LeaveStatisticsModel, _$identity);

  /// Serializes this LeaveStatisticsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveStatisticsModel&&(identical(other.success, success) || other.success == success)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.period, period) || other.period == period)&&(identical(other.statistics, statistics) || other.statistics == statistics)&&(identical(other.details, details) || other.details == details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,employee,employeeName,period,statistics,details);

@override
String toString() {
  return 'LeaveStatisticsModel(success: $success, employee: $employee, employeeName: $employeeName, period: $period, statistics: $statistics, details: $details)';
}


}

/// @nodoc
abstract mixin class $LeaveStatisticsModelCopyWith<$Res>  {
  factory $LeaveStatisticsModelCopyWith(LeaveStatisticsModel value, $Res Function(LeaveStatisticsModel) _then) = _$LeaveStatisticsModelCopyWithImpl;
@useResult
$Res call({
 bool success, String employee,@JsonKey(name: 'employee_name') String employeeName, LeavePeriodModel period, LeaveStatsModel statistics, LeaveDetailsModel details
});


$LeavePeriodModelCopyWith<$Res> get period;$LeaveStatsModelCopyWith<$Res> get statistics;$LeaveDetailsModelCopyWith<$Res> get details;

}
/// @nodoc
class _$LeaveStatisticsModelCopyWithImpl<$Res>
    implements $LeaveStatisticsModelCopyWith<$Res> {
  _$LeaveStatisticsModelCopyWithImpl(this._self, this._then);

  final LeaveStatisticsModel _self;
  final $Res Function(LeaveStatisticsModel) _then;

/// Create a copy of LeaveStatisticsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? employee = null,Object? employeeName = null,Object? period = null,Object? statistics = null,Object? details = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as LeavePeriodModel,statistics: null == statistics ? _self.statistics : statistics // ignore: cast_nullable_to_non_nullable
as LeaveStatsModel,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as LeaveDetailsModel,
  ));
}
/// Create a copy of LeaveStatisticsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeavePeriodModelCopyWith<$Res> get period {
  
  return $LeavePeriodModelCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}/// Create a copy of LeaveStatisticsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveStatsModelCopyWith<$Res> get statistics {
  
  return $LeaveStatsModelCopyWith<$Res>(_self.statistics, (value) {
    return _then(_self.copyWith(statistics: value));
  });
}/// Create a copy of LeaveStatisticsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveDetailsModelCopyWith<$Res> get details {
  
  return $LeaveDetailsModelCopyWith<$Res>(_self.details, (value) {
    return _then(_self.copyWith(details: value));
  });
}
}


/// Adds pattern-matching-related methods to [LeaveStatisticsModel].
extension LeaveStatisticsModelPatterns on LeaveStatisticsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveStatisticsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveStatisticsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveStatisticsModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaveStatisticsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveStatisticsModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveStatisticsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String employee, @JsonKey(name: 'employee_name')  String employeeName,  LeavePeriodModel period,  LeaveStatsModel statistics,  LeaveDetailsModel details)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveStatisticsModel() when $default != null:
return $default(_that.success,_that.employee,_that.employeeName,_that.period,_that.statistics,_that.details);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String employee, @JsonKey(name: 'employee_name')  String employeeName,  LeavePeriodModel period,  LeaveStatsModel statistics,  LeaveDetailsModel details)  $default,) {final _that = this;
switch (_that) {
case _LeaveStatisticsModel():
return $default(_that.success,_that.employee,_that.employeeName,_that.period,_that.statistics,_that.details);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String employee, @JsonKey(name: 'employee_name')  String employeeName,  LeavePeriodModel period,  LeaveStatsModel statistics,  LeaveDetailsModel details)?  $default,) {final _that = this;
switch (_that) {
case _LeaveStatisticsModel() when $default != null:
return $default(_that.success,_that.employee,_that.employeeName,_that.period,_that.statistics,_that.details);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveStatisticsModel extends LeaveStatisticsModel {
  const _LeaveStatisticsModel({required this.success, required this.employee, @JsonKey(name: 'employee_name') required this.employeeName, required this.period, required this.statistics, required this.details}): super._();
  factory _LeaveStatisticsModel.fromJson(Map<String, dynamic> json) => _$LeaveStatisticsModelFromJson(json);

@override final  bool success;
@override final  String employee;
@override@JsonKey(name: 'employee_name') final  String employeeName;
@override final  LeavePeriodModel period;
@override final  LeaveStatsModel statistics;
@override final  LeaveDetailsModel details;

/// Create a copy of LeaveStatisticsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveStatisticsModelCopyWith<_LeaveStatisticsModel> get copyWith => __$LeaveStatisticsModelCopyWithImpl<_LeaveStatisticsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveStatisticsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveStatisticsModel&&(identical(other.success, success) || other.success == success)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.period, period) || other.period == period)&&(identical(other.statistics, statistics) || other.statistics == statistics)&&(identical(other.details, details) || other.details == details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,employee,employeeName,period,statistics,details);

@override
String toString() {
  return 'LeaveStatisticsModel(success: $success, employee: $employee, employeeName: $employeeName, period: $period, statistics: $statistics, details: $details)';
}


}

/// @nodoc
abstract mixin class _$LeaveStatisticsModelCopyWith<$Res> implements $LeaveStatisticsModelCopyWith<$Res> {
  factory _$LeaveStatisticsModelCopyWith(_LeaveStatisticsModel value, $Res Function(_LeaveStatisticsModel) _then) = __$LeaveStatisticsModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, String employee,@JsonKey(name: 'employee_name') String employeeName, LeavePeriodModel period, LeaveStatsModel statistics, LeaveDetailsModel details
});


@override $LeavePeriodModelCopyWith<$Res> get period;@override $LeaveStatsModelCopyWith<$Res> get statistics;@override $LeaveDetailsModelCopyWith<$Res> get details;

}
/// @nodoc
class __$LeaveStatisticsModelCopyWithImpl<$Res>
    implements _$LeaveStatisticsModelCopyWith<$Res> {
  __$LeaveStatisticsModelCopyWithImpl(this._self, this._then);

  final _LeaveStatisticsModel _self;
  final $Res Function(_LeaveStatisticsModel) _then;

/// Create a copy of LeaveStatisticsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? employee = null,Object? employeeName = null,Object? period = null,Object? statistics = null,Object? details = null,}) {
  return _then(_LeaveStatisticsModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as LeavePeriodModel,statistics: null == statistics ? _self.statistics : statistics // ignore: cast_nullable_to_non_nullable
as LeaveStatsModel,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as LeaveDetailsModel,
  ));
}

/// Create a copy of LeaveStatisticsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeavePeriodModelCopyWith<$Res> get period {
  
  return $LeavePeriodModelCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}/// Create a copy of LeaveStatisticsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveStatsModelCopyWith<$Res> get statistics {
  
  return $LeaveStatsModelCopyWith<$Res>(_self.statistics, (value) {
    return _then(_self.copyWith(statistics: value));
  });
}/// Create a copy of LeaveStatisticsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveDetailsModelCopyWith<$Res> get details {
  
  return $LeaveDetailsModelCopyWith<$Res>(_self.details, (value) {
    return _then(_self.copyWith(details: value));
  });
}
}


/// @nodoc
mixin _$LeavePeriodModel {

@JsonKey(name: 'from_date') String get fromDate;@JsonKey(name: 'to_date') String get toDate;
/// Create a copy of LeavePeriodModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeavePeriodModelCopyWith<LeavePeriodModel> get copyWith => _$LeavePeriodModelCopyWithImpl<LeavePeriodModel>(this as LeavePeriodModel, _$identity);

  /// Serializes this LeavePeriodModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeavePeriodModel&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromDate,toDate);

@override
String toString() {
  return 'LeavePeriodModel(fromDate: $fromDate, toDate: $toDate)';
}


}

/// @nodoc
abstract mixin class $LeavePeriodModelCopyWith<$Res>  {
  factory $LeavePeriodModelCopyWith(LeavePeriodModel value, $Res Function(LeavePeriodModel) _then) = _$LeavePeriodModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate
});




}
/// @nodoc
class _$LeavePeriodModelCopyWithImpl<$Res>
    implements $LeavePeriodModelCopyWith<$Res> {
  _$LeavePeriodModelCopyWithImpl(this._self, this._then);

  final LeavePeriodModel _self;
  final $Res Function(LeavePeriodModel) _then;

/// Create a copy of LeavePeriodModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromDate = null,Object? toDate = null,}) {
  return _then(_self.copyWith(
fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LeavePeriodModel].
extension LeavePeriodModelPatterns on LeavePeriodModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeavePeriodModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeavePeriodModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeavePeriodModel value)  $default,){
final _that = this;
switch (_that) {
case _LeavePeriodModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeavePeriodModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeavePeriodModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeavePeriodModel() when $default != null:
return $default(_that.fromDate,_that.toDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate)  $default,) {final _that = this;
switch (_that) {
case _LeavePeriodModel():
return $default(_that.fromDate,_that.toDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate)?  $default,) {final _that = this;
switch (_that) {
case _LeavePeriodModel() when $default != null:
return $default(_that.fromDate,_that.toDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeavePeriodModel extends LeavePeriodModel {
  const _LeavePeriodModel({@JsonKey(name: 'from_date') required this.fromDate, @JsonKey(name: 'to_date') required this.toDate}): super._();
  factory _LeavePeriodModel.fromJson(Map<String, dynamic> json) => _$LeavePeriodModelFromJson(json);

@override@JsonKey(name: 'from_date') final  String fromDate;
@override@JsonKey(name: 'to_date') final  String toDate;

/// Create a copy of LeavePeriodModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeavePeriodModelCopyWith<_LeavePeriodModel> get copyWith => __$LeavePeriodModelCopyWithImpl<_LeavePeriodModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeavePeriodModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeavePeriodModel&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromDate,toDate);

@override
String toString() {
  return 'LeavePeriodModel(fromDate: $fromDate, toDate: $toDate)';
}


}

/// @nodoc
abstract mixin class _$LeavePeriodModelCopyWith<$Res> implements $LeavePeriodModelCopyWith<$Res> {
  factory _$LeavePeriodModelCopyWith(_LeavePeriodModel value, $Res Function(_LeavePeriodModel) _then) = __$LeavePeriodModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate
});




}
/// @nodoc
class __$LeavePeriodModelCopyWithImpl<$Res>
    implements _$LeavePeriodModelCopyWith<$Res> {
  __$LeavePeriodModelCopyWithImpl(this._self, this._then);

  final _LeavePeriodModel _self;
  final $Res Function(_LeavePeriodModel) _then;

/// Create a copy of LeavePeriodModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromDate = null,Object? toDate = null,}) {
  return _then(_LeavePeriodModel(
fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LeaveStatsModel {

@JsonKey(name: 'applied_days') double get appliedDays;@JsonKey(name: 'approved_days') double get approvedDays;@JsonKey(name: 'pending_days') double get pendingDays;@JsonKey(name: 'cancelled_days') double get cancelled_days;@JsonKey(name: 'total_applications') int get totalApplications;
/// Create a copy of LeaveStatsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveStatsModelCopyWith<LeaveStatsModel> get copyWith => _$LeaveStatsModelCopyWithImpl<LeaveStatsModel>(this as LeaveStatsModel, _$identity);

  /// Serializes this LeaveStatsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveStatsModel&&(identical(other.appliedDays, appliedDays) || other.appliedDays == appliedDays)&&(identical(other.approvedDays, approvedDays) || other.approvedDays == approvedDays)&&(identical(other.pendingDays, pendingDays) || other.pendingDays == pendingDays)&&(identical(other.cancelled_days, cancelled_days) || other.cancelled_days == cancelled_days)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appliedDays,approvedDays,pendingDays,cancelled_days,totalApplications);

@override
String toString() {
  return 'LeaveStatsModel(appliedDays: $appliedDays, approvedDays: $approvedDays, pendingDays: $pendingDays, cancelled_days: $cancelled_days, totalApplications: $totalApplications)';
}


}

/// @nodoc
abstract mixin class $LeaveStatsModelCopyWith<$Res>  {
  factory $LeaveStatsModelCopyWith(LeaveStatsModel value, $Res Function(LeaveStatsModel) _then) = _$LeaveStatsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'applied_days') double appliedDays,@JsonKey(name: 'approved_days') double approvedDays,@JsonKey(name: 'pending_days') double pendingDays,@JsonKey(name: 'cancelled_days') double cancelled_days,@JsonKey(name: 'total_applications') int totalApplications
});




}
/// @nodoc
class _$LeaveStatsModelCopyWithImpl<$Res>
    implements $LeaveStatsModelCopyWith<$Res> {
  _$LeaveStatsModelCopyWithImpl(this._self, this._then);

  final LeaveStatsModel _self;
  final $Res Function(LeaveStatsModel) _then;

/// Create a copy of LeaveStatsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appliedDays = null,Object? approvedDays = null,Object? pendingDays = null,Object? cancelled_days = null,Object? totalApplications = null,}) {
  return _then(_self.copyWith(
appliedDays: null == appliedDays ? _self.appliedDays : appliedDays // ignore: cast_nullable_to_non_nullable
as double,approvedDays: null == approvedDays ? _self.approvedDays : approvedDays // ignore: cast_nullable_to_non_nullable
as double,pendingDays: null == pendingDays ? _self.pendingDays : pendingDays // ignore: cast_nullable_to_non_nullable
as double,cancelled_days: null == cancelled_days ? _self.cancelled_days : cancelled_days // ignore: cast_nullable_to_non_nullable
as double,totalApplications: null == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveStatsModel].
extension LeaveStatsModelPatterns on LeaveStatsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveStatsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveStatsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveStatsModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaveStatsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveStatsModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveStatsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'applied_days')  double appliedDays, @JsonKey(name: 'approved_days')  double approvedDays, @JsonKey(name: 'pending_days')  double pendingDays, @JsonKey(name: 'cancelled_days')  double cancelled_days, @JsonKey(name: 'total_applications')  int totalApplications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveStatsModel() when $default != null:
return $default(_that.appliedDays,_that.approvedDays,_that.pendingDays,_that.cancelled_days,_that.totalApplications);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'applied_days')  double appliedDays, @JsonKey(name: 'approved_days')  double approvedDays, @JsonKey(name: 'pending_days')  double pendingDays, @JsonKey(name: 'cancelled_days')  double cancelled_days, @JsonKey(name: 'total_applications')  int totalApplications)  $default,) {final _that = this;
switch (_that) {
case _LeaveStatsModel():
return $default(_that.appliedDays,_that.approvedDays,_that.pendingDays,_that.cancelled_days,_that.totalApplications);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'applied_days')  double appliedDays, @JsonKey(name: 'approved_days')  double approvedDays, @JsonKey(name: 'pending_days')  double pendingDays, @JsonKey(name: 'cancelled_days')  double cancelled_days, @JsonKey(name: 'total_applications')  int totalApplications)?  $default,) {final _that = this;
switch (_that) {
case _LeaveStatsModel() when $default != null:
return $default(_that.appliedDays,_that.approvedDays,_that.pendingDays,_that.cancelled_days,_that.totalApplications);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveStatsModel extends LeaveStatsModel {
  const _LeaveStatsModel({@JsonKey(name: 'applied_days') required this.appliedDays, @JsonKey(name: 'approved_days') required this.approvedDays, @JsonKey(name: 'pending_days') required this.pendingDays, @JsonKey(name: 'cancelled_days') required this.cancelled_days, @JsonKey(name: 'total_applications') required this.totalApplications}): super._();
  factory _LeaveStatsModel.fromJson(Map<String, dynamic> json) => _$LeaveStatsModelFromJson(json);

@override@JsonKey(name: 'applied_days') final  double appliedDays;
@override@JsonKey(name: 'approved_days') final  double approvedDays;
@override@JsonKey(name: 'pending_days') final  double pendingDays;
@override@JsonKey(name: 'cancelled_days') final  double cancelled_days;
@override@JsonKey(name: 'total_applications') final  int totalApplications;

/// Create a copy of LeaveStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveStatsModelCopyWith<_LeaveStatsModel> get copyWith => __$LeaveStatsModelCopyWithImpl<_LeaveStatsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveStatsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveStatsModel&&(identical(other.appliedDays, appliedDays) || other.appliedDays == appliedDays)&&(identical(other.approvedDays, approvedDays) || other.approvedDays == approvedDays)&&(identical(other.pendingDays, pendingDays) || other.pendingDays == pendingDays)&&(identical(other.cancelled_days, cancelled_days) || other.cancelled_days == cancelled_days)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appliedDays,approvedDays,pendingDays,cancelled_days,totalApplications);

@override
String toString() {
  return 'LeaveStatsModel(appliedDays: $appliedDays, approvedDays: $approvedDays, pendingDays: $pendingDays, cancelled_days: $cancelled_days, totalApplications: $totalApplications)';
}


}

/// @nodoc
abstract mixin class _$LeaveStatsModelCopyWith<$Res> implements $LeaveStatsModelCopyWith<$Res> {
  factory _$LeaveStatsModelCopyWith(_LeaveStatsModel value, $Res Function(_LeaveStatsModel) _then) = __$LeaveStatsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'applied_days') double appliedDays,@JsonKey(name: 'approved_days') double approvedDays,@JsonKey(name: 'pending_days') double pendingDays,@JsonKey(name: 'cancelled_days') double cancelled_days,@JsonKey(name: 'total_applications') int totalApplications
});




}
/// @nodoc
class __$LeaveStatsModelCopyWithImpl<$Res>
    implements _$LeaveStatsModelCopyWith<$Res> {
  __$LeaveStatsModelCopyWithImpl(this._self, this._then);

  final _LeaveStatsModel _self;
  final $Res Function(_LeaveStatsModel) _then;

/// Create a copy of LeaveStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appliedDays = null,Object? approvedDays = null,Object? pendingDays = null,Object? cancelled_days = null,Object? totalApplications = null,}) {
  return _then(_LeaveStatsModel(
appliedDays: null == appliedDays ? _self.appliedDays : appliedDays // ignore: cast_nullable_to_non_nullable
as double,approvedDays: null == approvedDays ? _self.approvedDays : approvedDays // ignore: cast_nullable_to_non_nullable
as double,pendingDays: null == pendingDays ? _self.pendingDays : pendingDays // ignore: cast_nullable_to_non_nullable
as double,cancelled_days: null == cancelled_days ? _self.cancelled_days : cancelled_days // ignore: cast_nullable_to_non_nullable
as double,totalApplications: null == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LeaveDetailsModel {

@JsonKey(name: 'applied_leaves') List<dynamic> get appliedLeaves;@JsonKey(name: 'approved_leaves') List<dynamic> get approvedLeaves;@JsonKey(name: 'pending_leaves') List<dynamic> get pendingLeaves;@JsonKey(name: 'cancelled_leaves') List<dynamic> get cancelledLeaves;
/// Create a copy of LeaveDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveDetailsModelCopyWith<LeaveDetailsModel> get copyWith => _$LeaveDetailsModelCopyWithImpl<LeaveDetailsModel>(this as LeaveDetailsModel, _$identity);

  /// Serializes this LeaveDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveDetailsModel&&const DeepCollectionEquality().equals(other.appliedLeaves, appliedLeaves)&&const DeepCollectionEquality().equals(other.approvedLeaves, approvedLeaves)&&const DeepCollectionEquality().equals(other.pendingLeaves, pendingLeaves)&&const DeepCollectionEquality().equals(other.cancelledLeaves, cancelledLeaves));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(appliedLeaves),const DeepCollectionEquality().hash(approvedLeaves),const DeepCollectionEquality().hash(pendingLeaves),const DeepCollectionEquality().hash(cancelledLeaves));

@override
String toString() {
  return 'LeaveDetailsModel(appliedLeaves: $appliedLeaves, approvedLeaves: $approvedLeaves, pendingLeaves: $pendingLeaves, cancelledLeaves: $cancelledLeaves)';
}


}

/// @nodoc
abstract mixin class $LeaveDetailsModelCopyWith<$Res>  {
  factory $LeaveDetailsModelCopyWith(LeaveDetailsModel value, $Res Function(LeaveDetailsModel) _then) = _$LeaveDetailsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'applied_leaves') List<dynamic> appliedLeaves,@JsonKey(name: 'approved_leaves') List<dynamic> approvedLeaves,@JsonKey(name: 'pending_leaves') List<dynamic> pendingLeaves,@JsonKey(name: 'cancelled_leaves') List<dynamic> cancelledLeaves
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
@pragma('vm:prefer-inline') @override $Res call({Object? appliedLeaves = null,Object? approvedLeaves = null,Object? pendingLeaves = null,Object? cancelledLeaves = null,}) {
  return _then(_self.copyWith(
appliedLeaves: null == appliedLeaves ? _self.appliedLeaves : appliedLeaves // ignore: cast_nullable_to_non_nullable
as List<dynamic>,approvedLeaves: null == approvedLeaves ? _self.approvedLeaves : approvedLeaves // ignore: cast_nullable_to_non_nullable
as List<dynamic>,pendingLeaves: null == pendingLeaves ? _self.pendingLeaves : pendingLeaves // ignore: cast_nullable_to_non_nullable
as List<dynamic>,cancelledLeaves: null == cancelledLeaves ? _self.cancelledLeaves : cancelledLeaves // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'applied_leaves')  List<dynamic> appliedLeaves, @JsonKey(name: 'approved_leaves')  List<dynamic> approvedLeaves, @JsonKey(name: 'pending_leaves')  List<dynamic> pendingLeaves, @JsonKey(name: 'cancelled_leaves')  List<dynamic> cancelledLeaves)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveDetailsModel() when $default != null:
return $default(_that.appliedLeaves,_that.approvedLeaves,_that.pendingLeaves,_that.cancelledLeaves);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'applied_leaves')  List<dynamic> appliedLeaves, @JsonKey(name: 'approved_leaves')  List<dynamic> approvedLeaves, @JsonKey(name: 'pending_leaves')  List<dynamic> pendingLeaves, @JsonKey(name: 'cancelled_leaves')  List<dynamic> cancelledLeaves)  $default,) {final _that = this;
switch (_that) {
case _LeaveDetailsModel():
return $default(_that.appliedLeaves,_that.approvedLeaves,_that.pendingLeaves,_that.cancelledLeaves);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'applied_leaves')  List<dynamic> appliedLeaves, @JsonKey(name: 'approved_leaves')  List<dynamic> approvedLeaves, @JsonKey(name: 'pending_leaves')  List<dynamic> pendingLeaves, @JsonKey(name: 'cancelled_leaves')  List<dynamic> cancelledLeaves)?  $default,) {final _that = this;
switch (_that) {
case _LeaveDetailsModel() when $default != null:
return $default(_that.appliedLeaves,_that.approvedLeaves,_that.pendingLeaves,_that.cancelledLeaves);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveDetailsModel extends LeaveDetailsModel {
  const _LeaveDetailsModel({@JsonKey(name: 'applied_leaves') required final  List<dynamic> appliedLeaves, @JsonKey(name: 'approved_leaves') required final  List<dynamic> approvedLeaves, @JsonKey(name: 'pending_leaves') required final  List<dynamic> pendingLeaves, @JsonKey(name: 'cancelled_leaves') required final  List<dynamic> cancelledLeaves}): _appliedLeaves = appliedLeaves,_approvedLeaves = approvedLeaves,_pendingLeaves = pendingLeaves,_cancelledLeaves = cancelledLeaves,super._();
  factory _LeaveDetailsModel.fromJson(Map<String, dynamic> json) => _$LeaveDetailsModelFromJson(json);

 final  List<dynamic> _appliedLeaves;
@override@JsonKey(name: 'applied_leaves') List<dynamic> get appliedLeaves {
  if (_appliedLeaves is EqualUnmodifiableListView) return _appliedLeaves;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_appliedLeaves);
}

 final  List<dynamic> _approvedLeaves;
@override@JsonKey(name: 'approved_leaves') List<dynamic> get approvedLeaves {
  if (_approvedLeaves is EqualUnmodifiableListView) return _approvedLeaves;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_approvedLeaves);
}

 final  List<dynamic> _pendingLeaves;
@override@JsonKey(name: 'pending_leaves') List<dynamic> get pendingLeaves {
  if (_pendingLeaves is EqualUnmodifiableListView) return _pendingLeaves;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingLeaves);
}

 final  List<dynamic> _cancelledLeaves;
@override@JsonKey(name: 'cancelled_leaves') List<dynamic> get cancelledLeaves {
  if (_cancelledLeaves is EqualUnmodifiableListView) return _cancelledLeaves;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cancelledLeaves);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveDetailsModel&&const DeepCollectionEquality().equals(other._appliedLeaves, _appliedLeaves)&&const DeepCollectionEquality().equals(other._approvedLeaves, _approvedLeaves)&&const DeepCollectionEquality().equals(other._pendingLeaves, _pendingLeaves)&&const DeepCollectionEquality().equals(other._cancelledLeaves, _cancelledLeaves));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_appliedLeaves),const DeepCollectionEquality().hash(_approvedLeaves),const DeepCollectionEquality().hash(_pendingLeaves),const DeepCollectionEquality().hash(_cancelledLeaves));

@override
String toString() {
  return 'LeaveDetailsModel(appliedLeaves: $appliedLeaves, approvedLeaves: $approvedLeaves, pendingLeaves: $pendingLeaves, cancelledLeaves: $cancelledLeaves)';
}


}

/// @nodoc
abstract mixin class _$LeaveDetailsModelCopyWith<$Res> implements $LeaveDetailsModelCopyWith<$Res> {
  factory _$LeaveDetailsModelCopyWith(_LeaveDetailsModel value, $Res Function(_LeaveDetailsModel) _then) = __$LeaveDetailsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'applied_leaves') List<dynamic> appliedLeaves,@JsonKey(name: 'approved_leaves') List<dynamic> approvedLeaves,@JsonKey(name: 'pending_leaves') List<dynamic> pendingLeaves,@JsonKey(name: 'cancelled_leaves') List<dynamic> cancelledLeaves
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
@override @pragma('vm:prefer-inline') $Res call({Object? appliedLeaves = null,Object? approvedLeaves = null,Object? pendingLeaves = null,Object? cancelledLeaves = null,}) {
  return _then(_LeaveDetailsModel(
appliedLeaves: null == appliedLeaves ? _self._appliedLeaves : appliedLeaves // ignore: cast_nullable_to_non_nullable
as List<dynamic>,approvedLeaves: null == approvedLeaves ? _self._approvedLeaves : approvedLeaves // ignore: cast_nullable_to_non_nullable
as List<dynamic>,pendingLeaves: null == pendingLeaves ? _self._pendingLeaves : pendingLeaves // ignore: cast_nullable_to_non_nullable
as List<dynamic>,cancelledLeaves: null == cancelledLeaves ? _self._cancelledLeaves : cancelledLeaves // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}

// dart format on
