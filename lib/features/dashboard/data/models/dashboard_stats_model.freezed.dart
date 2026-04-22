// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardStatsModel {

@JsonKey(name: 'days_present') int get daysPresent;@JsonKey(name: 'leave_balance') double get leaveBalance;@JsonKey(name: 'next_holiday') String get nextHoliday;@JsonKey(name: 'next_holiday_date') String get nextHolidayDate;
/// Create a copy of DashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStatsModelCopyWith<DashboardStatsModel> get copyWith => _$DashboardStatsModelCopyWithImpl<DashboardStatsModel>(this as DashboardStatsModel, _$identity);

  /// Serializes this DashboardStatsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardStatsModel&&(identical(other.daysPresent, daysPresent) || other.daysPresent == daysPresent)&&(identical(other.leaveBalance, leaveBalance) || other.leaveBalance == leaveBalance)&&(identical(other.nextHoliday, nextHoliday) || other.nextHoliday == nextHoliday)&&(identical(other.nextHolidayDate, nextHolidayDate) || other.nextHolidayDate == nextHolidayDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,daysPresent,leaveBalance,nextHoliday,nextHolidayDate);

@override
String toString() {
  return 'DashboardStatsModel(daysPresent: $daysPresent, leaveBalance: $leaveBalance, nextHoliday: $nextHoliday, nextHolidayDate: $nextHolidayDate)';
}


}

/// @nodoc
abstract mixin class $DashboardStatsModelCopyWith<$Res>  {
  factory $DashboardStatsModelCopyWith(DashboardStatsModel value, $Res Function(DashboardStatsModel) _then) = _$DashboardStatsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'days_present') int daysPresent,@JsonKey(name: 'leave_balance') double leaveBalance,@JsonKey(name: 'next_holiday') String nextHoliday,@JsonKey(name: 'next_holiday_date') String nextHolidayDate
});




}
/// @nodoc
class _$DashboardStatsModelCopyWithImpl<$Res>
    implements $DashboardStatsModelCopyWith<$Res> {
  _$DashboardStatsModelCopyWithImpl(this._self, this._then);

  final DashboardStatsModel _self;
  final $Res Function(DashboardStatsModel) _then;

/// Create a copy of DashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? daysPresent = null,Object? leaveBalance = null,Object? nextHoliday = null,Object? nextHolidayDate = null,}) {
  return _then(_self.copyWith(
daysPresent: null == daysPresent ? _self.daysPresent : daysPresent // ignore: cast_nullable_to_non_nullable
as int,leaveBalance: null == leaveBalance ? _self.leaveBalance : leaveBalance // ignore: cast_nullable_to_non_nullable
as double,nextHoliday: null == nextHoliday ? _self.nextHoliday : nextHoliday // ignore: cast_nullable_to_non_nullable
as String,nextHolidayDate: null == nextHolidayDate ? _self.nextHolidayDate : nextHolidayDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardStatsModel].
extension DashboardStatsModelPatterns on DashboardStatsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardStatsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardStatsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardStatsModel value)  $default,){
final _that = this;
switch (_that) {
case _DashboardStatsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardStatsModel value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardStatsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'days_present')  int daysPresent, @JsonKey(name: 'leave_balance')  double leaveBalance, @JsonKey(name: 'next_holiday')  String nextHoliday, @JsonKey(name: 'next_holiday_date')  String nextHolidayDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardStatsModel() when $default != null:
return $default(_that.daysPresent,_that.leaveBalance,_that.nextHoliday,_that.nextHolidayDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'days_present')  int daysPresent, @JsonKey(name: 'leave_balance')  double leaveBalance, @JsonKey(name: 'next_holiday')  String nextHoliday, @JsonKey(name: 'next_holiday_date')  String nextHolidayDate)  $default,) {final _that = this;
switch (_that) {
case _DashboardStatsModel():
return $default(_that.daysPresent,_that.leaveBalance,_that.nextHoliday,_that.nextHolidayDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'days_present')  int daysPresent, @JsonKey(name: 'leave_balance')  double leaveBalance, @JsonKey(name: 'next_holiday')  String nextHoliday, @JsonKey(name: 'next_holiday_date')  String nextHolidayDate)?  $default,) {final _that = this;
switch (_that) {
case _DashboardStatsModel() when $default != null:
return $default(_that.daysPresent,_that.leaveBalance,_that.nextHoliday,_that.nextHolidayDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardStatsModel extends DashboardStatsModel {
  const _DashboardStatsModel({@JsonKey(name: 'days_present') required this.daysPresent, @JsonKey(name: 'leave_balance') required this.leaveBalance, @JsonKey(name: 'next_holiday') required this.nextHoliday, @JsonKey(name: 'next_holiday_date') required this.nextHolidayDate}): super._();
  factory _DashboardStatsModel.fromJson(Map<String, dynamic> json) => _$DashboardStatsModelFromJson(json);

@override@JsonKey(name: 'days_present') final  int daysPresent;
@override@JsonKey(name: 'leave_balance') final  double leaveBalance;
@override@JsonKey(name: 'next_holiday') final  String nextHoliday;
@override@JsonKey(name: 'next_holiday_date') final  String nextHolidayDate;

/// Create a copy of DashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStatsModelCopyWith<_DashboardStatsModel> get copyWith => __$DashboardStatsModelCopyWithImpl<_DashboardStatsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardStatsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardStatsModel&&(identical(other.daysPresent, daysPresent) || other.daysPresent == daysPresent)&&(identical(other.leaveBalance, leaveBalance) || other.leaveBalance == leaveBalance)&&(identical(other.nextHoliday, nextHoliday) || other.nextHoliday == nextHoliday)&&(identical(other.nextHolidayDate, nextHolidayDate) || other.nextHolidayDate == nextHolidayDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,daysPresent,leaveBalance,nextHoliday,nextHolidayDate);

@override
String toString() {
  return 'DashboardStatsModel(daysPresent: $daysPresent, leaveBalance: $leaveBalance, nextHoliday: $nextHoliday, nextHolidayDate: $nextHolidayDate)';
}


}

/// @nodoc
abstract mixin class _$DashboardStatsModelCopyWith<$Res> implements $DashboardStatsModelCopyWith<$Res> {
  factory _$DashboardStatsModelCopyWith(_DashboardStatsModel value, $Res Function(_DashboardStatsModel) _then) = __$DashboardStatsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'days_present') int daysPresent,@JsonKey(name: 'leave_balance') double leaveBalance,@JsonKey(name: 'next_holiday') String nextHoliday,@JsonKey(name: 'next_holiday_date') String nextHolidayDate
});




}
/// @nodoc
class __$DashboardStatsModelCopyWithImpl<$Res>
    implements _$DashboardStatsModelCopyWith<$Res> {
  __$DashboardStatsModelCopyWithImpl(this._self, this._then);

  final _DashboardStatsModel _self;
  final $Res Function(_DashboardStatsModel) _then;

/// Create a copy of DashboardStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? daysPresent = null,Object? leaveBalance = null,Object? nextHoliday = null,Object? nextHolidayDate = null,}) {
  return _then(_DashboardStatsModel(
daysPresent: null == daysPresent ? _self.daysPresent : daysPresent // ignore: cast_nullable_to_non_nullable
as int,leaveBalance: null == leaveBalance ? _self.leaveBalance : leaveBalance // ignore: cast_nullable_to_non_nullable
as double,nextHoliday: null == nextHoliday ? _self.nextHoliday : nextHoliday // ignore: cast_nullable_to_non_nullable
as String,nextHolidayDate: null == nextHolidayDate ? _self.nextHolidayDate : nextHolidayDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
