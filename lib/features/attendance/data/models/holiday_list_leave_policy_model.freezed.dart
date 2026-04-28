// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'holiday_list_leave_policy_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HolidayListLeavePolicyModel {

 bool get success; String get employee;@JsonKey(name: 'employee_name') String get employeeName; String get company;@JsonKey(name: 'holiday_list') HolidayListModel get holidayList;@JsonKey(name: 'leave_policy') LeavePolicyModel get leavePolicy;
/// Create a copy of HolidayListLeavePolicyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HolidayListLeavePolicyModelCopyWith<HolidayListLeavePolicyModel> get copyWith => _$HolidayListLeavePolicyModelCopyWithImpl<HolidayListLeavePolicyModel>(this as HolidayListLeavePolicyModel, _$identity);

  /// Serializes this HolidayListLeavePolicyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HolidayListLeavePolicyModel&&(identical(other.success, success) || other.success == success)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.company, company) || other.company == company)&&(identical(other.holidayList, holidayList) || other.holidayList == holidayList)&&(identical(other.leavePolicy, leavePolicy) || other.leavePolicy == leavePolicy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,employee,employeeName,company,holidayList,leavePolicy);

@override
String toString() {
  return 'HolidayListLeavePolicyModel(success: $success, employee: $employee, employeeName: $employeeName, company: $company, holidayList: $holidayList, leavePolicy: $leavePolicy)';
}


}

/// @nodoc
abstract mixin class $HolidayListLeavePolicyModelCopyWith<$Res>  {
  factory $HolidayListLeavePolicyModelCopyWith(HolidayListLeavePolicyModel value, $Res Function(HolidayListLeavePolicyModel) _then) = _$HolidayListLeavePolicyModelCopyWithImpl;
@useResult
$Res call({
 bool success, String employee,@JsonKey(name: 'employee_name') String employeeName, String company,@JsonKey(name: 'holiday_list') HolidayListModel holidayList,@JsonKey(name: 'leave_policy') LeavePolicyModel leavePolicy
});


$HolidayListModelCopyWith<$Res> get holidayList;$LeavePolicyModelCopyWith<$Res> get leavePolicy;

}
/// @nodoc
class _$HolidayListLeavePolicyModelCopyWithImpl<$Res>
    implements $HolidayListLeavePolicyModelCopyWith<$Res> {
  _$HolidayListLeavePolicyModelCopyWithImpl(this._self, this._then);

  final HolidayListLeavePolicyModel _self;
  final $Res Function(HolidayListLeavePolicyModel) _then;

/// Create a copy of HolidayListLeavePolicyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? employee = null,Object? employeeName = null,Object? company = null,Object? holidayList = null,Object? leavePolicy = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,holidayList: null == holidayList ? _self.holidayList : holidayList // ignore: cast_nullable_to_non_nullable
as HolidayListModel,leavePolicy: null == leavePolicy ? _self.leavePolicy : leavePolicy // ignore: cast_nullable_to_non_nullable
as LeavePolicyModel,
  ));
}
/// Create a copy of HolidayListLeavePolicyModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HolidayListModelCopyWith<$Res> get holidayList {
  
  return $HolidayListModelCopyWith<$Res>(_self.holidayList, (value) {
    return _then(_self.copyWith(holidayList: value));
  });
}/// Create a copy of HolidayListLeavePolicyModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeavePolicyModelCopyWith<$Res> get leavePolicy {
  
  return $LeavePolicyModelCopyWith<$Res>(_self.leavePolicy, (value) {
    return _then(_self.copyWith(leavePolicy: value));
  });
}
}


/// Adds pattern-matching-related methods to [HolidayListLeavePolicyModel].
extension HolidayListLeavePolicyModelPatterns on HolidayListLeavePolicyModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HolidayListLeavePolicyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HolidayListLeavePolicyModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HolidayListLeavePolicyModel value)  $default,){
final _that = this;
switch (_that) {
case _HolidayListLeavePolicyModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HolidayListLeavePolicyModel value)?  $default,){
final _that = this;
switch (_that) {
case _HolidayListLeavePolicyModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String employee, @JsonKey(name: 'employee_name')  String employeeName,  String company, @JsonKey(name: 'holiday_list')  HolidayListModel holidayList, @JsonKey(name: 'leave_policy')  LeavePolicyModel leavePolicy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HolidayListLeavePolicyModel() when $default != null:
return $default(_that.success,_that.employee,_that.employeeName,_that.company,_that.holidayList,_that.leavePolicy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String employee, @JsonKey(name: 'employee_name')  String employeeName,  String company, @JsonKey(name: 'holiday_list')  HolidayListModel holidayList, @JsonKey(name: 'leave_policy')  LeavePolicyModel leavePolicy)  $default,) {final _that = this;
switch (_that) {
case _HolidayListLeavePolicyModel():
return $default(_that.success,_that.employee,_that.employeeName,_that.company,_that.holidayList,_that.leavePolicy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String employee, @JsonKey(name: 'employee_name')  String employeeName,  String company, @JsonKey(name: 'holiday_list')  HolidayListModel holidayList, @JsonKey(name: 'leave_policy')  LeavePolicyModel leavePolicy)?  $default,) {final _that = this;
switch (_that) {
case _HolidayListLeavePolicyModel() when $default != null:
return $default(_that.success,_that.employee,_that.employeeName,_that.company,_that.holidayList,_that.leavePolicy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HolidayListLeavePolicyModel extends HolidayListLeavePolicyModel {
  const _HolidayListLeavePolicyModel({required this.success, required this.employee, @JsonKey(name: 'employee_name') required this.employeeName, required this.company, @JsonKey(name: 'holiday_list') required this.holidayList, @JsonKey(name: 'leave_policy') required this.leavePolicy}): super._();
  factory _HolidayListLeavePolicyModel.fromJson(Map<String, dynamic> json) => _$HolidayListLeavePolicyModelFromJson(json);

@override final  bool success;
@override final  String employee;
@override@JsonKey(name: 'employee_name') final  String employeeName;
@override final  String company;
@override@JsonKey(name: 'holiday_list') final  HolidayListModel holidayList;
@override@JsonKey(name: 'leave_policy') final  LeavePolicyModel leavePolicy;

/// Create a copy of HolidayListLeavePolicyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HolidayListLeavePolicyModelCopyWith<_HolidayListLeavePolicyModel> get copyWith => __$HolidayListLeavePolicyModelCopyWithImpl<_HolidayListLeavePolicyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HolidayListLeavePolicyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HolidayListLeavePolicyModel&&(identical(other.success, success) || other.success == success)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.employeeName, employeeName) || other.employeeName == employeeName)&&(identical(other.company, company) || other.company == company)&&(identical(other.holidayList, holidayList) || other.holidayList == holidayList)&&(identical(other.leavePolicy, leavePolicy) || other.leavePolicy == leavePolicy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,employee,employeeName,company,holidayList,leavePolicy);

@override
String toString() {
  return 'HolidayListLeavePolicyModel(success: $success, employee: $employee, employeeName: $employeeName, company: $company, holidayList: $holidayList, leavePolicy: $leavePolicy)';
}


}

/// @nodoc
abstract mixin class _$HolidayListLeavePolicyModelCopyWith<$Res> implements $HolidayListLeavePolicyModelCopyWith<$Res> {
  factory _$HolidayListLeavePolicyModelCopyWith(_HolidayListLeavePolicyModel value, $Res Function(_HolidayListLeavePolicyModel) _then) = __$HolidayListLeavePolicyModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, String employee,@JsonKey(name: 'employee_name') String employeeName, String company,@JsonKey(name: 'holiday_list') HolidayListModel holidayList,@JsonKey(name: 'leave_policy') LeavePolicyModel leavePolicy
});


@override $HolidayListModelCopyWith<$Res> get holidayList;@override $LeavePolicyModelCopyWith<$Res> get leavePolicy;

}
/// @nodoc
class __$HolidayListLeavePolicyModelCopyWithImpl<$Res>
    implements _$HolidayListLeavePolicyModelCopyWith<$Res> {
  __$HolidayListLeavePolicyModelCopyWithImpl(this._self, this._then);

  final _HolidayListLeavePolicyModel _self;
  final $Res Function(_HolidayListLeavePolicyModel) _then;

/// Create a copy of HolidayListLeavePolicyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? employee = null,Object? employeeName = null,Object? company = null,Object? holidayList = null,Object? leavePolicy = null,}) {
  return _then(_HolidayListLeavePolicyModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,employee: null == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as String,employeeName: null == employeeName ? _self.employeeName : employeeName // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,holidayList: null == holidayList ? _self.holidayList : holidayList // ignore: cast_nullable_to_non_nullable
as HolidayListModel,leavePolicy: null == leavePolicy ? _self.leavePolicy : leavePolicy // ignore: cast_nullable_to_non_nullable
as LeavePolicyModel,
  ));
}

/// Create a copy of HolidayListLeavePolicyModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HolidayListModelCopyWith<$Res> get holidayList {
  
  return $HolidayListModelCopyWith<$Res>(_self.holidayList, (value) {
    return _then(_self.copyWith(holidayList: value));
  });
}/// Create a copy of HolidayListLeavePolicyModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeavePolicyModelCopyWith<$Res> get leavePolicy {
  
  return $LeavePolicyModelCopyWith<$Res>(_self.leavePolicy, (value) {
    return _then(_self.copyWith(leavePolicy: value));
  });
}
}


/// @nodoc
mixin _$HolidayListModel {

 String get name;@JsonKey(name: 'holiday_list_name') String get holidayListName;@JsonKey(name: 'from_date') String get fromDate;@JsonKey(name: 'to_date') String get toDate;@JsonKey(name: 'total_holidays') int get totalHolidays;@JsonKey(name: 'custom_restricted_holidays') List<RestrictedHolidayModel> get customRestrictedHolidays; List<HolidayModel> get holidays;
/// Create a copy of HolidayListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HolidayListModelCopyWith<HolidayListModel> get copyWith => _$HolidayListModelCopyWithImpl<HolidayListModel>(this as HolidayListModel, _$identity);

  /// Serializes this HolidayListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HolidayListModel&&(identical(other.name, name) || other.name == name)&&(identical(other.holidayListName, holidayListName) || other.holidayListName == holidayListName)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.totalHolidays, totalHolidays) || other.totalHolidays == totalHolidays)&&const DeepCollectionEquality().equals(other.customRestrictedHolidays, customRestrictedHolidays)&&const DeepCollectionEquality().equals(other.holidays, holidays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,holidayListName,fromDate,toDate,totalHolidays,const DeepCollectionEquality().hash(customRestrictedHolidays),const DeepCollectionEquality().hash(holidays));

@override
String toString() {
  return 'HolidayListModel(name: $name, holidayListName: $holidayListName, fromDate: $fromDate, toDate: $toDate, totalHolidays: $totalHolidays, customRestrictedHolidays: $customRestrictedHolidays, holidays: $holidays)';
}


}

/// @nodoc
abstract mixin class $HolidayListModelCopyWith<$Res>  {
  factory $HolidayListModelCopyWith(HolidayListModel value, $Res Function(HolidayListModel) _then) = _$HolidayListModelCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'holiday_list_name') String holidayListName,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate,@JsonKey(name: 'total_holidays') int totalHolidays,@JsonKey(name: 'custom_restricted_holidays') List<RestrictedHolidayModel> customRestrictedHolidays, List<HolidayModel> holidays
});




}
/// @nodoc
class _$HolidayListModelCopyWithImpl<$Res>
    implements $HolidayListModelCopyWith<$Res> {
  _$HolidayListModelCopyWithImpl(this._self, this._then);

  final HolidayListModel _self;
  final $Res Function(HolidayListModel) _then;

/// Create a copy of HolidayListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? holidayListName = null,Object? fromDate = null,Object? toDate = null,Object? totalHolidays = null,Object? customRestrictedHolidays = null,Object? holidays = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,holidayListName: null == holidayListName ? _self.holidayListName : holidayListName // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,totalHolidays: null == totalHolidays ? _self.totalHolidays : totalHolidays // ignore: cast_nullable_to_non_nullable
as int,customRestrictedHolidays: null == customRestrictedHolidays ? _self.customRestrictedHolidays : customRestrictedHolidays // ignore: cast_nullable_to_non_nullable
as List<RestrictedHolidayModel>,holidays: null == holidays ? _self.holidays : holidays // ignore: cast_nullable_to_non_nullable
as List<HolidayModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [HolidayListModel].
extension HolidayListModelPatterns on HolidayListModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HolidayListModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HolidayListModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HolidayListModel value)  $default,){
final _that = this;
switch (_that) {
case _HolidayListModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HolidayListModel value)?  $default,){
final _that = this;
switch (_that) {
case _HolidayListModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'holiday_list_name')  String holidayListName, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate, @JsonKey(name: 'total_holidays')  int totalHolidays, @JsonKey(name: 'custom_restricted_holidays')  List<RestrictedHolidayModel> customRestrictedHolidays,  List<HolidayModel> holidays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HolidayListModel() when $default != null:
return $default(_that.name,_that.holidayListName,_that.fromDate,_that.toDate,_that.totalHolidays,_that.customRestrictedHolidays,_that.holidays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'holiday_list_name')  String holidayListName, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate, @JsonKey(name: 'total_holidays')  int totalHolidays, @JsonKey(name: 'custom_restricted_holidays')  List<RestrictedHolidayModel> customRestrictedHolidays,  List<HolidayModel> holidays)  $default,) {final _that = this;
switch (_that) {
case _HolidayListModel():
return $default(_that.name,_that.holidayListName,_that.fromDate,_that.toDate,_that.totalHolidays,_that.customRestrictedHolidays,_that.holidays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'holiday_list_name')  String holidayListName, @JsonKey(name: 'from_date')  String fromDate, @JsonKey(name: 'to_date')  String toDate, @JsonKey(name: 'total_holidays')  int totalHolidays, @JsonKey(name: 'custom_restricted_holidays')  List<RestrictedHolidayModel> customRestrictedHolidays,  List<HolidayModel> holidays)?  $default,) {final _that = this;
switch (_that) {
case _HolidayListModel() when $default != null:
return $default(_that.name,_that.holidayListName,_that.fromDate,_that.toDate,_that.totalHolidays,_that.customRestrictedHolidays,_that.holidays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HolidayListModel extends HolidayListModel {
  const _HolidayListModel({required this.name, @JsonKey(name: 'holiday_list_name') required this.holidayListName, @JsonKey(name: 'from_date') required this.fromDate, @JsonKey(name: 'to_date') required this.toDate, @JsonKey(name: 'total_holidays') required this.totalHolidays, @JsonKey(name: 'custom_restricted_holidays') required final  List<RestrictedHolidayModel> customRestrictedHolidays, required final  List<HolidayModel> holidays}): _customRestrictedHolidays = customRestrictedHolidays,_holidays = holidays,super._();
  factory _HolidayListModel.fromJson(Map<String, dynamic> json) => _$HolidayListModelFromJson(json);

@override final  String name;
@override@JsonKey(name: 'holiday_list_name') final  String holidayListName;
@override@JsonKey(name: 'from_date') final  String fromDate;
@override@JsonKey(name: 'to_date') final  String toDate;
@override@JsonKey(name: 'total_holidays') final  int totalHolidays;
 final  List<RestrictedHolidayModel> _customRestrictedHolidays;
@override@JsonKey(name: 'custom_restricted_holidays') List<RestrictedHolidayModel> get customRestrictedHolidays {
  if (_customRestrictedHolidays is EqualUnmodifiableListView) return _customRestrictedHolidays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customRestrictedHolidays);
}

 final  List<HolidayModel> _holidays;
@override List<HolidayModel> get holidays {
  if (_holidays is EqualUnmodifiableListView) return _holidays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_holidays);
}


/// Create a copy of HolidayListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HolidayListModelCopyWith<_HolidayListModel> get copyWith => __$HolidayListModelCopyWithImpl<_HolidayListModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HolidayListModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HolidayListModel&&(identical(other.name, name) || other.name == name)&&(identical(other.holidayListName, holidayListName) || other.holidayListName == holidayListName)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.totalHolidays, totalHolidays) || other.totalHolidays == totalHolidays)&&const DeepCollectionEquality().equals(other._customRestrictedHolidays, _customRestrictedHolidays)&&const DeepCollectionEquality().equals(other._holidays, _holidays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,holidayListName,fromDate,toDate,totalHolidays,const DeepCollectionEquality().hash(_customRestrictedHolidays),const DeepCollectionEquality().hash(_holidays));

@override
String toString() {
  return 'HolidayListModel(name: $name, holidayListName: $holidayListName, fromDate: $fromDate, toDate: $toDate, totalHolidays: $totalHolidays, customRestrictedHolidays: $customRestrictedHolidays, holidays: $holidays)';
}


}

/// @nodoc
abstract mixin class _$HolidayListModelCopyWith<$Res> implements $HolidayListModelCopyWith<$Res> {
  factory _$HolidayListModelCopyWith(_HolidayListModel value, $Res Function(_HolidayListModel) _then) = __$HolidayListModelCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'holiday_list_name') String holidayListName,@JsonKey(name: 'from_date') String fromDate,@JsonKey(name: 'to_date') String toDate,@JsonKey(name: 'total_holidays') int totalHolidays,@JsonKey(name: 'custom_restricted_holidays') List<RestrictedHolidayModel> customRestrictedHolidays, List<HolidayModel> holidays
});




}
/// @nodoc
class __$HolidayListModelCopyWithImpl<$Res>
    implements _$HolidayListModelCopyWith<$Res> {
  __$HolidayListModelCopyWithImpl(this._self, this._then);

  final _HolidayListModel _self;
  final $Res Function(_HolidayListModel) _then;

/// Create a copy of HolidayListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? holidayListName = null,Object? fromDate = null,Object? toDate = null,Object? totalHolidays = null,Object? customRestrictedHolidays = null,Object? holidays = null,}) {
  return _then(_HolidayListModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,holidayListName: null == holidayListName ? _self.holidayListName : holidayListName // ignore: cast_nullable_to_non_nullable
as String,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String,totalHolidays: null == totalHolidays ? _self.totalHolidays : totalHolidays // ignore: cast_nullable_to_non_nullable
as int,customRestrictedHolidays: null == customRestrictedHolidays ? _self._customRestrictedHolidays : customRestrictedHolidays // ignore: cast_nullable_to_non_nullable
as List<RestrictedHolidayModel>,holidays: null == holidays ? _self._holidays : holidays // ignore: cast_nullable_to_non_nullable
as List<HolidayModel>,
  ));
}


}


/// @nodoc
mixin _$RestrictedHolidayModel {

 String get name;@JsonKey(name: 'holiday_date') String get holidayDate; String get description;
/// Create a copy of RestrictedHolidayModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestrictedHolidayModelCopyWith<RestrictedHolidayModel> get copyWith => _$RestrictedHolidayModelCopyWithImpl<RestrictedHolidayModel>(this as RestrictedHolidayModel, _$identity);

  /// Serializes this RestrictedHolidayModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestrictedHolidayModel&&(identical(other.name, name) || other.name == name)&&(identical(other.holidayDate, holidayDate) || other.holidayDate == holidayDate)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,holidayDate,description);

@override
String toString() {
  return 'RestrictedHolidayModel(name: $name, holidayDate: $holidayDate, description: $description)';
}


}

/// @nodoc
abstract mixin class $RestrictedHolidayModelCopyWith<$Res>  {
  factory $RestrictedHolidayModelCopyWith(RestrictedHolidayModel value, $Res Function(RestrictedHolidayModel) _then) = _$RestrictedHolidayModelCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'holiday_date') String holidayDate, String description
});




}
/// @nodoc
class _$RestrictedHolidayModelCopyWithImpl<$Res>
    implements $RestrictedHolidayModelCopyWith<$Res> {
  _$RestrictedHolidayModelCopyWithImpl(this._self, this._then);

  final RestrictedHolidayModel _self;
  final $Res Function(RestrictedHolidayModel) _then;

/// Create a copy of RestrictedHolidayModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? holidayDate = null,Object? description = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,holidayDate: null == holidayDate ? _self.holidayDate : holidayDate // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RestrictedHolidayModel].
extension RestrictedHolidayModelPatterns on RestrictedHolidayModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestrictedHolidayModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestrictedHolidayModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestrictedHolidayModel value)  $default,){
final _that = this;
switch (_that) {
case _RestrictedHolidayModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestrictedHolidayModel value)?  $default,){
final _that = this;
switch (_that) {
case _RestrictedHolidayModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'holiday_date')  String holidayDate,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestrictedHolidayModel() when $default != null:
return $default(_that.name,_that.holidayDate,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'holiday_date')  String holidayDate,  String description)  $default,) {final _that = this;
switch (_that) {
case _RestrictedHolidayModel():
return $default(_that.name,_that.holidayDate,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'holiday_date')  String holidayDate,  String description)?  $default,) {final _that = this;
switch (_that) {
case _RestrictedHolidayModel() when $default != null:
return $default(_that.name,_that.holidayDate,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RestrictedHolidayModel extends RestrictedHolidayModel {
  const _RestrictedHolidayModel({required this.name, @JsonKey(name: 'holiday_date') required this.holidayDate, required this.description}): super._();
  factory _RestrictedHolidayModel.fromJson(Map<String, dynamic> json) => _$RestrictedHolidayModelFromJson(json);

@override final  String name;
@override@JsonKey(name: 'holiday_date') final  String holidayDate;
@override final  String description;

/// Create a copy of RestrictedHolidayModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestrictedHolidayModelCopyWith<_RestrictedHolidayModel> get copyWith => __$RestrictedHolidayModelCopyWithImpl<_RestrictedHolidayModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestrictedHolidayModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestrictedHolidayModel&&(identical(other.name, name) || other.name == name)&&(identical(other.holidayDate, holidayDate) || other.holidayDate == holidayDate)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,holidayDate,description);

@override
String toString() {
  return 'RestrictedHolidayModel(name: $name, holidayDate: $holidayDate, description: $description)';
}


}

/// @nodoc
abstract mixin class _$RestrictedHolidayModelCopyWith<$Res> implements $RestrictedHolidayModelCopyWith<$Res> {
  factory _$RestrictedHolidayModelCopyWith(_RestrictedHolidayModel value, $Res Function(_RestrictedHolidayModel) _then) = __$RestrictedHolidayModelCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'holiday_date') String holidayDate, String description
});




}
/// @nodoc
class __$RestrictedHolidayModelCopyWithImpl<$Res>
    implements _$RestrictedHolidayModelCopyWith<$Res> {
  __$RestrictedHolidayModelCopyWithImpl(this._self, this._then);

  final _RestrictedHolidayModel _self;
  final $Res Function(_RestrictedHolidayModel) _then;

/// Create a copy of RestrictedHolidayModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? holidayDate = null,Object? description = null,}) {
  return _then(_RestrictedHolidayModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,holidayDate: null == holidayDate ? _self.holidayDate : holidayDate // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HolidayModel {

@JsonKey(name: 'holiday_date') String get holidayDate; String get description;@JsonKey(name: 'weekly_off') int get weeklyOff;
/// Create a copy of HolidayModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HolidayModelCopyWith<HolidayModel> get copyWith => _$HolidayModelCopyWithImpl<HolidayModel>(this as HolidayModel, _$identity);

  /// Serializes this HolidayModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HolidayModel&&(identical(other.holidayDate, holidayDate) || other.holidayDate == holidayDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.weeklyOff, weeklyOff) || other.weeklyOff == weeklyOff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,holidayDate,description,weeklyOff);

@override
String toString() {
  return 'HolidayModel(holidayDate: $holidayDate, description: $description, weeklyOff: $weeklyOff)';
}


}

/// @nodoc
abstract mixin class $HolidayModelCopyWith<$Res>  {
  factory $HolidayModelCopyWith(HolidayModel value, $Res Function(HolidayModel) _then) = _$HolidayModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'holiday_date') String holidayDate, String description,@JsonKey(name: 'weekly_off') int weeklyOff
});




}
/// @nodoc
class _$HolidayModelCopyWithImpl<$Res>
    implements $HolidayModelCopyWith<$Res> {
  _$HolidayModelCopyWithImpl(this._self, this._then);

  final HolidayModel _self;
  final $Res Function(HolidayModel) _then;

/// Create a copy of HolidayModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? holidayDate = null,Object? description = null,Object? weeklyOff = null,}) {
  return _then(_self.copyWith(
holidayDate: null == holidayDate ? _self.holidayDate : holidayDate // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,weeklyOff: null == weeklyOff ? _self.weeklyOff : weeklyOff // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HolidayModel].
extension HolidayModelPatterns on HolidayModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HolidayModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HolidayModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HolidayModel value)  $default,){
final _that = this;
switch (_that) {
case _HolidayModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HolidayModel value)?  $default,){
final _that = this;
switch (_that) {
case _HolidayModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'holiday_date')  String holidayDate,  String description, @JsonKey(name: 'weekly_off')  int weeklyOff)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HolidayModel() when $default != null:
return $default(_that.holidayDate,_that.description,_that.weeklyOff);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'holiday_date')  String holidayDate,  String description, @JsonKey(name: 'weekly_off')  int weeklyOff)  $default,) {final _that = this;
switch (_that) {
case _HolidayModel():
return $default(_that.holidayDate,_that.description,_that.weeklyOff);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'holiday_date')  String holidayDate,  String description, @JsonKey(name: 'weekly_off')  int weeklyOff)?  $default,) {final _that = this;
switch (_that) {
case _HolidayModel() when $default != null:
return $default(_that.holidayDate,_that.description,_that.weeklyOff);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HolidayModel extends HolidayModel {
  const _HolidayModel({@JsonKey(name: 'holiday_date') required this.holidayDate, required this.description, @JsonKey(name: 'weekly_off') required this.weeklyOff}): super._();
  factory _HolidayModel.fromJson(Map<String, dynamic> json) => _$HolidayModelFromJson(json);

@override@JsonKey(name: 'holiday_date') final  String holidayDate;
@override final  String description;
@override@JsonKey(name: 'weekly_off') final  int weeklyOff;

/// Create a copy of HolidayModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HolidayModelCopyWith<_HolidayModel> get copyWith => __$HolidayModelCopyWithImpl<_HolidayModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HolidayModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HolidayModel&&(identical(other.holidayDate, holidayDate) || other.holidayDate == holidayDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.weeklyOff, weeklyOff) || other.weeklyOff == weeklyOff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,holidayDate,description,weeklyOff);

@override
String toString() {
  return 'HolidayModel(holidayDate: $holidayDate, description: $description, weeklyOff: $weeklyOff)';
}


}

/// @nodoc
abstract mixin class _$HolidayModelCopyWith<$Res> implements $HolidayModelCopyWith<$Res> {
  factory _$HolidayModelCopyWith(_HolidayModel value, $Res Function(_HolidayModel) _then) = __$HolidayModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'holiday_date') String holidayDate, String description,@JsonKey(name: 'weekly_off') int weeklyOff
});




}
/// @nodoc
class __$HolidayModelCopyWithImpl<$Res>
    implements _$HolidayModelCopyWith<$Res> {
  __$HolidayModelCopyWithImpl(this._self, this._then);

  final _HolidayModel _self;
  final $Res Function(_HolidayModel) _then;

/// Create a copy of HolidayModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? holidayDate = null,Object? description = null,Object? weeklyOff = null,}) {
  return _then(_HolidayModel(
holidayDate: null == holidayDate ? _self.holidayDate : holidayDate // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,weeklyOff: null == weeklyOff ? _self.weeklyOff : weeklyOff // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LeavePolicyModel {

@JsonKey(name: 'file_path') String get filePath;@JsonKey(name: 'file_url') String get fileUrl;
/// Create a copy of LeavePolicyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeavePolicyModelCopyWith<LeavePolicyModel> get copyWith => _$LeavePolicyModelCopyWithImpl<LeavePolicyModel>(this as LeavePolicyModel, _$identity);

  /// Serializes this LeavePolicyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeavePolicyModel&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filePath,fileUrl);

@override
String toString() {
  return 'LeavePolicyModel(filePath: $filePath, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class $LeavePolicyModelCopyWith<$Res>  {
  factory $LeavePolicyModelCopyWith(LeavePolicyModel value, $Res Function(LeavePolicyModel) _then) = _$LeavePolicyModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'file_path') String filePath,@JsonKey(name: 'file_url') String fileUrl
});




}
/// @nodoc
class _$LeavePolicyModelCopyWithImpl<$Res>
    implements $LeavePolicyModelCopyWith<$Res> {
  _$LeavePolicyModelCopyWithImpl(this._self, this._then);

  final LeavePolicyModel _self;
  final $Res Function(LeavePolicyModel) _then;

/// Create a copy of LeavePolicyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filePath = null,Object? fileUrl = null,}) {
  return _then(_self.copyWith(
filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LeavePolicyModel].
extension LeavePolicyModelPatterns on LeavePolicyModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeavePolicyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeavePolicyModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeavePolicyModel value)  $default,){
final _that = this;
switch (_that) {
case _LeavePolicyModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeavePolicyModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeavePolicyModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'file_path')  String filePath, @JsonKey(name: 'file_url')  String fileUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeavePolicyModel() when $default != null:
return $default(_that.filePath,_that.fileUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'file_path')  String filePath, @JsonKey(name: 'file_url')  String fileUrl)  $default,) {final _that = this;
switch (_that) {
case _LeavePolicyModel():
return $default(_that.filePath,_that.fileUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'file_path')  String filePath, @JsonKey(name: 'file_url')  String fileUrl)?  $default,) {final _that = this;
switch (_that) {
case _LeavePolicyModel() when $default != null:
return $default(_that.filePath,_that.fileUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeavePolicyModel extends LeavePolicyModel {
  const _LeavePolicyModel({@JsonKey(name: 'file_path') required this.filePath, @JsonKey(name: 'file_url') required this.fileUrl}): super._();
  factory _LeavePolicyModel.fromJson(Map<String, dynamic> json) => _$LeavePolicyModelFromJson(json);

@override@JsonKey(name: 'file_path') final  String filePath;
@override@JsonKey(name: 'file_url') final  String fileUrl;

/// Create a copy of LeavePolicyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeavePolicyModelCopyWith<_LeavePolicyModel> get copyWith => __$LeavePolicyModelCopyWithImpl<_LeavePolicyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeavePolicyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeavePolicyModel&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filePath,fileUrl);

@override
String toString() {
  return 'LeavePolicyModel(filePath: $filePath, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class _$LeavePolicyModelCopyWith<$Res> implements $LeavePolicyModelCopyWith<$Res> {
  factory _$LeavePolicyModelCopyWith(_LeavePolicyModel value, $Res Function(_LeavePolicyModel) _then) = __$LeavePolicyModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'file_path') String filePath,@JsonKey(name: 'file_url') String fileUrl
});




}
/// @nodoc
class __$LeavePolicyModelCopyWithImpl<$Res>
    implements _$LeavePolicyModelCopyWith<$Res> {
  __$LeavePolicyModelCopyWithImpl(this._self, this._then);

  final _LeavePolicyModel _self;
  final $Res Function(_LeavePolicyModel) _then;

/// Create a copy of LeavePolicyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filePath = null,Object? fileUrl = null,}) {
  return _then(_LeavePolicyModel(
filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
